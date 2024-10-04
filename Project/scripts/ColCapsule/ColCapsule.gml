// Define the Capsule struct
function ColCapsule(start, finish, radius)constructor {
    self.line = undefined;
    self.radius = 0;
    self.Set(start, finish, radius);
    
    static Set = function(start = self.line.start, finish = self.line.finish, radius = self.radius) {
        if (self.line) {
            self.line.Set(start, finish);
        } else {
            self.line = new ColLine(start, finish);
        }
        var line = self.line;
        self.radius = radius;
        self.property_center = line.property_center;
        self.property_radius = line.property_length / 2 + radius;
				var _radius=new BBMOD_Vec3(radius)
        self.property_min = line.property_min.Sub(_radius);
        self.property_max = line.property_min.Add(_radius);
    };
    
    static CheckObject = function(object) {
        return object.shape.CheckCapsule(self);
    };
    
    static CheckPoint = function(point) {
        var nearest = self.line.NearestPoint(point.position);
        var dist = nearest.DistanceTo(point.position);
        
        return dist < self.radius;
    };
    
    static CheckSphere = function(sphere) {
        var nearest = self.line.NearestPoint(sphere.position);
        var dist = nearest.DistanceTo(sphere.position);
        
        return dist < (self.radius + sphere.radius);
    };
    
    static CheckAABB = function(aabb) {
        var p1 = self.property_center;
        var p2 = aabb.position;
        if (point_distance_3d(p1.X, p1.Y, p1.Z, p2.X, p2.Y, p2.Z) >= (self.property_radius + aabb.property_radius)) return false;
        
        var r = self.radius;
        var line = self.line;
        var line_start = self.line.start;
        var line_finish = self.line.finish;
        var box_min = aabb.property_min;
        var box_max = aabb.property_max;
        var bmnx = box_min.X;
        var bmny = box_min.Y;
        var bmnz = box_min.Z;
        var bmxx = box_max.X;
        var bmxy = box_max.Y;
        var bmxz = box_max.Z;
        var lvx = line_finish.X - line_start.X;
        var lvy = line_finish.Y - line_start.Y;
        var lvz = line_finish.Z - line_start.Z;
        var lsx = line_start.X;
        var lsy = line_start.Y;
        var lsz = line_start.Z;
        var ldd = dot_product_3d(lvx, lvy, lvz, lvx, lvy, lvz);
        
        var nx = clamp(line_start.X, bmnx, bmxx);
        var ny = clamp(line_start.Y, bmny, bmxy);
        var nz = clamp(line_start.Z, bmnz, bmxz);
        if (point_distance_3d(nx, ny, nz, line_start.X, line_start.Y, line_start.Z) < r) return true;
        
        nx = clamp(line_finish.X, bmnx, bmxx);
        ny = clamp(line_finish.Y, bmny, bmxy);
        nz = clamp(line_finish.Z, bmnz, bmxz);
        if (point_distance_3d(nx, ny, nz, line_finish.X, line_finish.Y, line_finish.Z) < r) return true;
        
        var edges = aabb.property_edges;
        
        var i = 0;
        repeat (12) {
            var nearest_line_to_edge = edges[i++].NearestConnectionToLine(line);
            var nearest_start = nearest_line_to_edge.start;
            
            var px = nearest_start.X - lsx;
            var py = nearest_start.Y - lsy;
            var pz = nearest_start.Z - lsz;
            var t = clamp(dot_product_3d(px, py, pz, lvx, lvy, lvz) / ldd , 0, 1);
            
            var p = (lsx + lvx * t == nearest_start.X && lsy + lvy * t == nearest_start.Y && lsz + lvz * t == nearest_start.Z) ? nearest_line_to_edge.start : nearest_line_to_edge.finish;
            
            nx = clamp(p.X, bmnx, bmxx);
            ny = clamp(p.Y, bmny, bmxy);
            nz = clamp(p.Z, bmnz, bmxz);
            
            if (point_distance_3d(nx, ny, nz, p.X, p.Y, p.Z) < r) return true;
        }
        
        return false;
    };
    
    static CheckPlane = function(plane) {
        var start = self.line.start;
        var nearest = plane.NearestPoint(start);
        if (point_distance_3d(nearest.X, nearest.Y, nearest.Z, start.X, start.Y, start.Z) < self.radius) return true;
        
        var finish = self.line.finish;
        nearest = plane.NearestPoint(finish);
        if (point_distance_3d(nearest.X, nearest.Y, nearest.Z, finish.X, finish.Y, finish.Z) < self.radius) return true;
        
        return self.line.CheckPlane(plane);
    };
    
    static CheckOBB = function(obb) {
        var p1 = self.property_center;
        var p2 = obb.position;
        if (point_distance_3d(p1.X, p1.Y, p1.Z, p2.X, p2.Y, p2.Z) >= (self.property_radius + obb.property_radius)) return false;
        
        var obb_position = obb.position;
		var obb_orientation = obb.property_orientation_array;
        var obb_size_array = [obb.size.X, obb.size.Y, obb.size.Z];
        
        var r = self.radius;
        var line = self.line;
        var p = line.start;
		
        var nx = obb_position.X, ny = obb_position.Y, nz = obb_position.Z;
        var dx = p.X - nx, dy = p.Y - ny, dz = p.Z - nz;
        
        for (var i = 0; i < 3; i++) {
            var axis = obb_orientation[i];
            var dist = dot_product_3d(dx, dy, dz, axis.X, axis.Y, axis.Z);
            dist = clamp(dist, -obb_size_array[i], obb_size_array[i]);
            nx += axis.X * dist;
            ny += axis.Y * dist;
            nz += axis.Z * dist;
        }
        
        if (point_distance_3d(nx, ny, nz, p.X, p.Y, p.Z) < r) return true;
        p = line.finish;
        
        nx = obb_position.X;
		ny = obb_position.Y;
		nz = obb_position.Z;
        dx = p.X - nx;
		dy = p.Y - ny;
		dz = p.Z - nz;
        
        for (var i = 0; i < 3; i++) {
            var axis = obb_orientation[i];
            var dist = dot_product_3d(dx, dy, dz, axis.X, axis.Y, axis.Z);
            dist = clamp(dist, -obb_size_array[i], obb_size_array[i]);
            nx += axis.X * dist;
            ny += axis.Y * dist;
            nz += axis.Z * dist;
        }
        
        if (point_distance_3d(nx, ny, nz, p.X, p.Y, p.Z) < r) return true;
        
        var edges = obb.property_edges;
        
        var i = 0;
        repeat (12) {
            var nearest_line_to_edge = edges[i++].NearestConnectionToLine(line);
            var nearest_start = nearest_line_to_edge.start;
            var nearest_self = line.NearestPoint(nearest_start);
            
            p = (nearest_self.X == nearest_start.X && nearest_self.Y == nearest_start.Y && nearest_self.Z == nearest_start.Z) ? nearest_line_to_edge.start : nearest_line_to_edge.finish;
            
            nx = obb_position.X;
			ny = obb_position.Y;
			nz = obb_position.Z;
            dx = p.X - nx;
			dy = p.Y - ny;
			dz = p.Z - nz;
            
            for (var j = 0; j < 3; j++) {
                var axis = obb.property_orientation_array[j];
                var dist = dot_product_3d(dx, dy, dz, axis.X, axis.Y, axis.Z);
                dist = clamp(dist, -obb_size_array[j], obb_size_array[j]);
                nx += axis.X * dist;
                ny += axis.Y * dist;
                nz += axis.Z * dist;
            }
            
            if (point_distance_3d(nx, ny, nz, p.X, p.Y, p.Z) < r) return true;
        }
        
        return false;
    };
    
    static CheckCapsule = function(capsule) {
        var p1 = self.property_center;
        var p2 = capsule.property_center;
        if (point_distance_3d(p1.X, p1.Y, p1.Z, p2.X, p2.Y, p2.Z) >= (self.property_radius + capsule.property_radius)) return false;
        
        var connecting_line = self.line.NearestConnectionToLine(capsule.line);
        return connecting_line.property_length < (self.radius + capsule.radius);
    };
    
    static CheckTriangle = function(triangle) {
        var p1 = self.property_center;
        var p2 = triangle.property_center;
        if (point_distance_3d(p1.X, p1.Y, p1.Z, p2.X, p2.Y, p2.Z) >= (self.property_radius + triangle.property_radius)) return false;
        
        var line = self.line;
        var target = triangle.NearestPoint(line.start);
        var nearest = line.NearestPoint(target);
        if (point_distance_3d(nearest.X, nearest.Y, nearest.Z, target.X, target.Y, target.Z) < self.radius) return true;
        
        target = triangle.NearestPoint(line.finish);
        nearest = line.NearestPoint(target);
        if (point_distance_3d(nearest.X, nearest.Y, nearest.Z, target.X, target.Y, target.Z) < self.radius) return true;
        
        return false;
    };
    
    static CheckMesh = function(mesh) {
        return mesh.CheckCapsule(self);
    };
    
    static CheckModel = function(model) {
        return model.CheckCapsule(self);
    };
    
    static CheckRay = function(ray, hit_info = undefined) {
        var center = self.property_center;
        var nearest = ray.NearestPoint(center);
        if (point_distance_3d(nearest.X, nearest.Y, nearest.Z, center.X, center.Y, center.Z) >= self.property_radius) return false;
        
        var line = self.line;
        var cd = line.property_ray.direction.Mul(line.Length());
        var rd = ray.direction;
        var ro = ray.origin;
        var oa = ro.Sub(line.start);
        
        var baba = dot_product_3d(cd.X, cd.Y, cd.Z, cd.X, cd.Y, cd.Z);
        var bard = dot_product_3d(cd.X, cd.Y, cd.Z, rd.X, rd.Y, rd.Z);
        var baoa = dot_product_3d(cd.X, cd.Y, cd.Z, oa.X, oa.Y, oa.Z);
        var rdoa = dot_product_3d(rd.X, rd.Y, rd.Z, oa.X, oa.Y, oa.Z);
        var oaoa = dot_product_3d(oa.X, oa.Y, oa.Z, oa.X, oa.Y, oa.Z);
        
        var a = baba - sqr(bard);
        var b = baba * rdoa - baoa * bard;
        var c = baba * oaoa - sqr(baoa) - sqr(self.radius) * baba;
        var h = sqr(b) - a * c;
        
        if (h > 0) {
            var t = (-b - sqrt(h)) / a;
            var why = baoa + t * bard;
            
            if (why > 0 && why < baba) {
                if (hit_info) {
                    var contact_point = ro.Add(rd.Mul(t));
                    var nearest_inner_point = line.NearestPoint(contact_point);
                    var contact_normal = contact_point.Sub(nearest_inner_point).Normalize();
                    hit_info.Update(t, self, contact_point, contact_normal);
                }
                return true;
            }
            
            var oc = (why <= 0) ? oa : ro.Sub(line.finish);
            b = dot_product_3d(rd.X, rd.Y, rd.Z, oc.X, oc.Y, oc.Z);
            c = dot_product_3d(oc.X, oc.Y, oc.Z, oc.X, oc.Y, oc.Z) - sqr(self.radius);
            h = sqr(b) - c;
            
            if (h > 0) {
                if (hit_info) {
                    t = -b - sqrt(h);
                    var contact_point = ro.Add(rd.Mul(t));
                    var nearest_inner_point = line.NearestPoint(contact_point);
                    var contact_normal = contact_point.Sub(nearest_inner_point).Normalize();
                    hit_info.Update(t, self, contact_point, contact_normal);
                }
                return true;
            }
        }
        
        return false;
    };
    
    static CheckLine = function(line) {
        var closest_line = self.line.NearestConnectionToLine(line);
        return closest_line.property_length < self.radius;
    };
    
    static DisplaceSphere = function(sphere) {
        if (!self.CheckSphere(sphere)) return undefined;
        
        var ps = sphere.position;
        var nearest = self.line.NearestPoint(ps);
        
        if (ps.X == nearest.X && ps.Y == nearest.Y && ps.Z == nearest.Z) return undefined;
        
        var dir = ps.Sub(nearest).Normalize();
        var offset = dir.Mul(sphere.radius + self.radius);
        
        return nearest.Add(offset);
    };
    
    static GetMin = function() {
        return self.property_min.Clone();
    };
    
    static GetMax = function() {
        return self.property_max.Clone();
    };
	 
	 
	 
	 
	 

    // Method to draw the capsule wireframe
    function dbug_draw(segments = 16, color = c_white) {
        var vbuff = vertex_create_buffer();
        vertex_begin(vbuff, v_format);

        // Get the direction and length of the capsule's axis (from the Line struct)
        var dir = self.line.property_ray.direction;
        var length = self.line.Length();

        // Calculate yaw, pitch, and roll based on the axis direction
        var yaw = radtodeg(arctan2(dir.Y, dir.X));  // Rotation around the Z-axis
        var pitch = radtodeg(arcsin(-dir.Z)-(pi/2));       // Rotation around the X-axis
        var roll = 0;                               // No roll needed
				


        // Create the transformation matrix with position, rotation, and scaling
        var transform_matrix = matrix_build(self.line.start.X, self.line.start.Y, self.line.start.Z, yaw, pitch, roll, 1, 1, 1);

        // Function to apply the transformation matrix to a vertex
        function transform_vertex(tm, x, y, z) {
            var vtx = matrix_transform_vertex(tm, x, y, z);
            return new Vector3(vtx[0], vtx[1], vtx[2]);
        }

        // Draw the capsule wireframe
        var theta;

        // XY plane (z = 0) circle
        for (var i = 0; i < segments; i++) {
            theta = (i / segments) * 2 * pi;
            var next_theta = ((i + 1) / segments) * 2 * pi;

            var x1_xy = self.radius * cos(theta);
            var y1_xy = self.radius * sin(theta);
            var x2_xy = self.radius * cos(next_theta);
            var y2_xy = self.radius * sin(next_theta);

            var v1 = transform_vertex(transform_matrix, x1_xy, y1_xy, 0);
            var v2 = transform_vertex(transform_matrix, x2_xy, y2_xy, 0);

            vertex_add(vbuff, v1.X, v1.Y, v1.Z, color);
            vertex_add(vbuff, v2.X, v2.Y, v2.Z, color);
        }

        // XY plane (z = -length) circle
        for (var i = 0; i < segments; i++) {
            theta = (i / segments) * 2 * pi;
            var next_theta = ((i + 1) / segments) * 2 * pi;

            var x1_xy = self.radius * cos(theta);
            var y1_xy = self.radius * sin(theta);
            var x2_xy = self.radius * cos(next_theta);
            var y2_xy = self.radius * sin(next_theta);

            var v1 = transform_vertex(transform_matrix, x1_xy, y1_xy, -length);
            var v2 = transform_vertex(transform_matrix, x2_xy, y2_xy, -length);

            vertex_add(vbuff, v1.X, v1.Y, v1.Z, color);
            vertex_add(vbuff, v2.X, v2.Y, v2.Z, color);
        }

        // Variables to store the first and midpoint vertices for the XZ plane
        var first_x = 0, first_z = 0;
        var mid_x = 0, mid_z = 0;

        // XZ plane (y = 0) circle
        for (var i = 0; i < segments; i++) {
            theta = (i / segments) * 2 * pi;
            var next_theta = ((i + 1) / segments) * 2 * pi;

            var x1_xz = self.radius * cos(theta);
            var z1_xz = self.radius * sin(theta);
            var x2_xz = self.radius * cos(next_theta);
            var z2_xz = self.radius * sin(next_theta);

            if (i > segments / 2) {
                z1_xz -= length;
                z2_xz -= length;
            }

            // Store the first and midpoint vertices
            if (i == 0) { 
                first_x = x1_xz; 
                first_z = z1_xz; 
            }
            if (i == segments / 2) { 
                mid_x = x1_xz; 
                mid_z = z1_xz; 
            }

            var v1 = transform_vertex(transform_matrix, x1_xz, 0, z1_xz);
            var v2 = transform_vertex(transform_matrix, x2_xz, 0, z2_xz);

            vertex_add(vbuff, v1.X, v1.Y, v1.Z, color);
            vertex_add(vbuff, v2.X, v2.Y, v2.Z, color);
        }

        // Connect the first and midpoint vertices in the XZ plane
        var v1 = transform_vertex(transform_matrix, first_x, 0, first_z);
        var v2 = transform_vertex(transform_matrix, first_x, 0, first_z - length);
        vertex_add(vbuff, v1.X, v1.Y, v1.Z, color);
        vertex_add(vbuff, v2.X, v2.Y, v2.Z, color);

        var v1_mid = transform_vertex(transform_matrix, mid_x, 0, mid_z);
        var v2_mid = transform_vertex(transform_matrix, mid_x, 0, mid_z - length);
        vertex_add(vbuff, v1_mid.X, v1_mid.Y, v1_mid.Z, color);
        vertex_add(vbuff, v2_mid.X, v2_mid.Y, v2_mid.Z, color);

        // Variables to store the first and midpoint vertices for the YZ plane
        var first_y = 0, first_z_yz = 0;
        var mid_y = 0, mid_z_yz = 0;

        // YZ plane (x = 0) circle
        for (var i = 0; i < segments; i++) {
            theta = (i / segments) * 2 * pi;
            var next_theta = ((i + 1) / segments) * 2 * pi;

            var y1_yz = self.radius * cos(theta);
            var z1_yz = self.radius * sin(theta);
            var y2_yz = self.radius * cos(next_theta);
            var z2_yz = self.radius * sin(next_theta);

            if (i > segments / 2) {
                z1_yz -= length;
                z2_yz -= length;
            }

            // Store the first and midpoint vertices in the YZ plane
            if (i == 0) {
                first_y = y1_yz;
                first_z_yz = z1_yz;
            }
            if (i == segments / 2) {
                mid_y = y1_yz;
                mid_z_yz = z1_yz;
            }

            var v1 = transform_vertex(transform_matrix, 0, y1_yz, z1_yz);
            var v2 = transform_vertex(transform_matrix, 0, y2_yz, z2_yz);

            vertex_add(vbuff, v1.X, v1.Y, v1.Z, color);
            vertex_add(vbuff, v2.X, v2.Y, v2.Z, color);
        }

        // Connect the first and midpoint vertices in the YZ plane
        var v1_yz = transform_vertex(transform_matrix, 0, first_y, first_z_yz);
        var v2_yz = transform_vertex(transform_matrix, 0, first_y, first_z_yz - length);
        vertex_add(vbuff, v1_yz.X, v1_yz.Y, v1_yz.Z, color);
        vertex_add(vbuff, v2_yz.X, v2_yz.Y, v2_yz.Z, color);

        var v1_mid_yz = transform_vertex(transform_matrix, 0, mid_y, mid_z_yz);
        var v2_mid_yz = transform_vertex(transform_matrix, 0, mid_y, mid_z_yz - length);
        vertex_add(vbuff, v1_mid_yz.X, v1_mid_yz.Y, v1_mid_yz.Z, color);
        vertex_add(vbuff, v2_mid_yz.X, v2_mid_yz.Y, v2_mid_yz.Z, color);

        // Connect the top and bottom of the capsule with lines between the circles
        var v1_top = transform_vertex(transform_matrix, self.radius, 0, 0);
        var v1_bottom = transform_vertex(transform_matrix, self.radius, 0, -length);
        vertex_add(vbuff, v1_top.X, v1_top.Y, v1_top.Z, color);
        vertex_add(vbuff, v1_bottom.X, v1_bottom.Y, v1_bottom.Z, color);

        var v2_top = transform_vertex(transform_matrix, 0, self.radius, 0);
        var v2_bottom = transform_vertex(transform_matrix, 0, self.radius, -length);
        vertex_add(vbuff, v2_top.X, v2_top.Y, v2_top.Z, color);
        vertex_add(vbuff, v2_bottom.X, v2_bottom.Y, v2_bottom.Z, color);

        vertex_end(vbuff);
        vertex_submit(vbuff, pr_linelist, -1);  // Submit the vertices as a self.line list
        vertex_delete_buffer(vbuff);
    }
}
