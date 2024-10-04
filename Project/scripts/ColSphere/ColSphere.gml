function ColSphere(position, radius) constructor {
	self.Set(position, radius)

	static Set = function(position = self.position, radius = self.radius) {
		self.position = position;
		self.radius = radius;
		self.property_min = position.Sub(radius);
		self.property_max = position.Add(radius);
	};	
	
	static CheckCollider = function(collider) {
		return collider.shape.CheckSphere(self);
	};

	static CheckPoint = function(point) {
        return point.CheckSphere(self);
    };
    
    static CheckSphere = function(sphere) {
        var p1 = self.position;
        var p2 = sphere.position;
        return point_distance_3d(p1.X, p1.Y, p1.Z, p2.X, p2.Y, p2.Z) < (self.radius + sphere.radius);
    };
    
    static CheckAABB = function(aabb) {
        var pa = aabb.position;
        var ps = self.position;
        if (point_distance_3d(pa.X, pa.Y, pa.Z, ps.X, ps.Y, ps.Z) > aabb.property_radius + self.radius) return false;
        
        var box_min = aabb.property_min;
        var box_max = aabb.property_max;
        var nx = clamp(ps.X, box_min.X, box_max.X);
        var ny = clamp(ps.Y, box_min.Y, box_max.Y);
        var nz = clamp(ps.Z, box_min.Z, box_max.Z);
        
        return point_distance_3d(nx, ny, nz, ps.X, ps.Y, ps.Z) < self.radius;
    };
    
    static CheckPlane = function(plane) {
        var ps = self.position;
        var dist = dot_product_3d(plane.normal.X, plane.normal.Y, plane.normal.Z, ps.X, ps.Y, ps.Z) - plane.distance;
        return point_distance_3d(
            ps.X - plane.normal.X * dist,
            ps.Y - plane.normal.Y * dist,
            ps.Z - plane.normal.Z * dist, ps.X, ps.Y, ps.Z) < self.radius;
    };
    
    static CheckOBB = function(obb) {
        return obb.CheckSphere(self);
    };
    
    static CheckCapsule = function(capsule) {
        return capsule.CheckSphere(self);
    };
    
    static CheckTriangle = function(triangle) {
        var ps = self.position;
        var nearest = triangle.NearestPoint(ps);
        return point_distance_3d(nearest.X, nearest.Y, nearest.Z, ps.X, ps.Y, ps.Z) < self.radius;
    };
    
    static CheckMesh = function(mesh) {
        return mesh.CheckSphere(self);
    };
    
    static CheckModel = function(model) {
        return model.CheckSphere(self);
    };
    
    static CheckRay = function(ray, hit_info = undefined) {
        var dir = ray.direction;
        var o = ray.origin;
        var p = self.position;
        var ex = p.X - o.X;
        var ey = p.Y - o.Y;
        var ez = p.Z - o.Z;
        var mag_squared = dot_product_3d(ex, ey, ez, ex, ey, ez);
        var r_squared = sqr(self.radius);
        var EdotD = dot_product_3d(ex, ey, ez, dir.X, dir.Y, dir.Z);
        var offset = r_squared - (mag_squared - (EdotD * EdotD));
        if (offset < 0) return false;
        
        if (hit_info) {
            var f = sqrt(abs(offset));
            var t = EdotD - f;
            if (mag_squared < r_squared) {
                t = EdotD + f;
            }
            static contact_point = new Vector3(0, 0, 0);
            contact_point.X = o.X + dir.X * t;
            contact_point.Y = o.Y + dir.Y * t;
            contact_point.Z = o.Z + dir.Z * t;
            
            //hit_info.Update(t, self, contact_point, contact_point.Sub(p).Normalize());
            hit_info.Update(contact_point.DistanceTo(ray.origin), self, contact_point, contact_point.Sub(p).Normalize());
        }
        
        return true;
    };
    
    static CheckLine = function(line) {
        var p = self.position;
        var nearest = line.NearestPoint(p);
        return point_distance_3d(nearest.X, nearest.Y, nearest.Z, p.X, p.Y, p.Z) < self.radius;
    };
    
    static DisplaceSphere = function(sphere) {
        if (!self.CheckSphere(sphere)) return undefined;
        
        var p1 = self.position;
        var p2 = sphere.position;
        if (p1.X == p2.X && p1.Y == p2.Y && p1.Z == p2.Z) return undefined;
        
        var dir = sphere.position.Sub(p1).Normalize();
        var offset = dir.Mul(sphere.radius + self.radius);
        
        return p1.Add(offset);
    };
    
    static NearestPoint = function(vec3) {
        var dist = vec3.Sub(self.position).Normalize();
        var scaled_dist = dist.Mul(self.radius);
        return scaled_dist.Add(self.position);
    };
    
    static GetMin = function() {
        return self.property_min.Clone();
    };
    
    static GetMax = function() {
        return self.property_max.Clone();
    };
    
    static CheckFrustum = function(frustum) {
        var planes = frustum.as_array;
        var is_intersecting_anything = false;
        var r = self.radius;
        var p = self.position;
        var px = p.X, py = p.Y, pz = p.Z;
        var i = 0;
        repeat (6) {
            var plane = planes[i++];
            var n = plane.normal;
            var dist = dot_product_3d(n.X, n.Y, n.Z, px, py, pz) + plane.distance;
            
            if (dist < -r)
                return EFrustumResults.OUTSIDE;
            
            if (abs(dist) < r)
                is_intersecting_anything = true;
        }
        return is_intersecting_anything ? EFrustumResults.INTERSECTING : EFrustumResults.INSIDE;
    };
		//**************************************************
    
	static dbug_draw = function(col_center = c_white, col_outline = c_white) {
		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);

		var num_vertices = 16; 
		var angle_increment = 360 / num_vertices;

		// Create the transformation matrix to rotate the vertices to face the camera
		var dir_x = camera.to.X - camera.from.X;
		var dir_y = camera.to.Y - camera.from.Y;
		var dir_z = camera.to.Z - camera.from.Z;
		var dir_length = sqrt(sqr(dir_x) + sqr(dir_y) + sqr(dir_z));

		dir_x /= dir_length;
		dir_y /= dir_length;
		dir_z /= dir_length;

		var rot_x = -arctan2(dir_z, sqrt(sqr(dir_x) + sqr(dir_y)));
		var rot_y = arctan2(dir_x, dir_y);

		var mat_transform = matrix_build(0, 0, 0, radtodeg(rot_x) + 90, 0, radtodeg(rot_y), 1, 1, 1);

		var prev_x, prev_y, prev_z; // Previous vertex coordinates

		// Iterate through the circle, duplicating vertices for pr_linelist
		for (var i = 0; i <= num_vertices; i++) {
			var angle_rad = degtorad(i * angle_increment);
			var vertex_x = self.radius * cos(angle_rad);
			var vertex_y = self.radius * sin(angle_rad);
			var vertex_z = 0;

			// Apply the transformation to the vertex position
			var transformed_vertex = matrix_transform_vertex(mat_transform, vertex_x, vertex_y, vertex_z);

			var transformed_x = self.position.X + transformed_vertex[0];
			var transformed_y = self.position.Y + transformed_vertex[1];
			var transformed_z = self.position.Z + transformed_vertex[2];

			// For the first vertex, we just save it to connect with the next one
			if (i > 0) {
			    // Add a line segment between the previous and current vertex
			    vertex_add(vbuff, prev_x, prev_y, prev_z, col_outline);
			    vertex_add(vbuff, transformed_x, transformed_y, transformed_z, col_outline);
			}

			// Save the current vertex for the next iteration
			prev_x = transformed_x;
			prev_y = transformed_y;
			prev_z = transformed_z;
		}

		vertex_end(vbuff);

		// Use pr_linelist to draw each pair of vertices as a line segment
		vertex_submit(vbuff, pr_linelist, -1);

		// Delete the vertex buffer to free memory
		vertex_delete_buffer(vbuff);
	};
}
