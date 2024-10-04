/*
function ColAABB(position, half_extents, min_max=false) constructor{
	self.Set(position, half_extents, min_max)
	
	static Set=function(position, half_extents, min_max){
		if min_max{
			self.position = position.Add(half_extents).Div(2);
			self.half_extents = half_extents.Sub(position).Div(2).Abs();
		}else{
			self.position=position;					//Vect3
			self.half_extents=half_extents;			//Vect3
		}	
		
		self.property_min = position.Sub(half_extents);
		self.property_max = position.Add(half_extents);
		self.property_radius = point_distance_3d(0, 0, 0, half_extents.X, half_extents.Y, half_extents.Z);
        
		var pmin = self.property_min;
		var pmax = self.property_max;
        
		self.property_vertices = [
			new BBMOD_Vec3(pmin.X, pmax.Y, pmax.Z),
			new BBMOD_Vec3(pmin.X, pmax.Y, pmin.Z),
			new BBMOD_Vec3(pmin.X, pmin.Y, pmax.Z),
			new BBMOD_Vec3(pmin.X, pmin.Y, pmin.Z),
			new BBMOD_Vec3(pmax.X, pmax.Y, pmax.Z),
			new BBMOD_Vec3(pmax.X, pmax.Y, pmin.Z),
			new BBMOD_Vec3(pmax.X, pmin.Y, pmax.Z),
			new BBMOD_Vec3(pmax.X, pmin.Y, pmin.Z),
		];
        
		var vertices = self.property_vertices;
        
		self.property_edges = [
			new ColLine(vertices[0], vertices[1]),
			new ColLine(vertices[0], vertices[2]),
			new ColLine(vertices[1], vertices[3]),
			new ColLine(vertices[2], vertices[3]),
			new ColLine(vertices[4], vertices[5]),
			new ColLine(vertices[4], vertices[6]),
			new ColLine(vertices[5], vertices[7]),
			new ColLine(vertices[6], vertices[7]),
			new ColLine(vertices[0], vertices[4]),
			new ColLine(vertices[1], vertices[5]),
			new ColLine(vertices[2], vertices[6]),
			new ColLine(vertices[3], vertices[7]),
		];
	}
	static CheckCollider = function(collider) {
		return collider.shape.CheckAABB(self);
	};
	
	static CheckPoint = function(point) {
		return point.CheckAABB(self);
	};
    
	static CheckSphere = function(sphere) {
		return sphere.CheckAABB(self);
	};
    
	static CheckAABB = function(aabb) {
		var box_min = self.property_min;
		var box_max = self.property_max;
		var other_min = aabb.property_min;
		var other_max = aabb.property_max;
		return ((box_min.X <= other_max.X) && (box_max.X >= other_min.X) && (box_min.Y <= other_max.Y) && (box_max.Y >= other_min.Y) && (box_min.Z <= other_max.Z) && (box_max.Z >= other_min.Z));
	};
    
	static CheckPlane = function(plane) {
		var size = self.half_extents;
		var normal = plane.normal;
		var pos = self.position;
		var anorm = normal.Abs();
		var plength = dot_product_3d(anorm.X, anorm.Y, anorm.Z, size.X, size.Y, size.Z);
		var ndot = dot_product_3d(normal.X, normal.Y, normal.Z, pos.X, pos.Y, pos.Z);
		return (abs(ndot - plane.distance) <= plength);
	};
    
	static CheckOBB = function(obb) {
		return obb.CheckAABB(self);
	};
    
	static CheckCapsule = function(capsule) {
		return capsule.CheckAABB(self);
	};
    
    static CheckRay = function(ray, hit_info = undefined) {
        var box_min = self.property_min;
        var box_max = self.property_max;
        
        var dir = ray.direction;
        var p = ray.origin;
        
        var ray_x = (dir.X == 0) ? 0.0001 : dir.X;
        var ray_y = (dir.Y == 0) ? 0.0001 : dir.Y;
        var ray_z = (dir.Z == 0) ? 0.0001 : dir.Z;
        
        var t1 = (box_min.X - p.X) / ray_x;
        var t2 = (box_max.X - p.X) / ray_x;
        var t3 = (box_min.Y - p.Y) / ray_y;
        var t4 = (box_max.Y - p.Y) / ray_y;
        var t5 = (box_min.Z - p.Z) / ray_z;
        var t6 = (box_max.Z - p.Z) / ray_z;
        
        var tmin = max(
            min(t1, t2),
            min(t3, t4),
            min(t5, t6)
        );
        var tmax = min(
            max(t1, t2),
            max(t3, t4),
            max(t5, t6)
        );
        
        if (tmax < 0) return false;
        if (tmin > tmax) return false;
        
        if (hit_info) {
            var t = tmax;
            if (tmin > 0) {
                t = tmin;
            }
            
            var tnormal;
            if (t == t1) tnormal = new Vector3(-1, 0, 0);
            if (t == t2) tnormal = new Vector3(+1, 0, 0);
            if (t == t3) tnormal = new Vector3(0, -1, 0);
            if (t == t4) tnormal = new Vector3(0, +1, 0);
            if (t == t5) tnormal = new Vector3(0, 0, -1);
            if (t == t6) tnormal = new Vector3(0, 0, +1);
            
            hit_info.Update(t, self, p.Add(dir.Mul(t)), tnormal);
        }
        
        return true;
    };
    
	static CheckLine = function(line) {
		static hit_info = new RaycastHitInformation();
		hit_info.distance = infinity;
        
		if (self.CheckRay(line.property_ray, hit_info)) {
			return (hit_info.distance <= line.property_length);
		}
		return false;
	};
    
	static DisplaceSphere = function(sphere) {
		if (!sphere.CheckAABB(self)) return undefined;
		var ps = sphere.position;
		var pa = self.position;
		if (ps.X == pa.X && ps.Y == pa.Y && ps.Z == pa.Z) return undefined;
        
		var nearest = self.NearestPoint(ps);
        
		if (ps.X == nearest.X && nearest.Y == pa.Y && nearest.Z == pa.Z) {
		    return undefined;
		}
        
		var dir = ps.Sub(nearest).Normalize();
		return nearest.Add(dir.Mul(sphere.radius));
	};
    
	static NearestPoint = function(vec3) {
		var box_min = self.property_min;
		var box_max = self.property_max;
		return new Vector3(
			clamp(vec3.X, box_min.X, box_max.X),
			clamp(vec3.Y, box_min.Y, box_max.Y),
			clamp(vec3.Z, box_min.Z, box_max.Z)
		);
	};
    
	static GetInterval = function(axis) {
		var vertices = self.property_vertices;
		var ax = axis.X;
		var ay = axis.Y;
		var az = axis.Z;
        
		var imin = infinity;
		var imax = -infinity;
        
		var i = 0;
		repeat (8) {
			var vertex = vertices[i++];
			var dot = dot_product_3d(ax, ay, az, vertex.X, vertex.Y, vertex.Z);
			imin = min(imin, dot);
			imax = max(imax, dot);
		}
        
		return { val_min: imin, val_max: imax };
	};
    
	static GetVertices = function() {
		return array_map(self.property_vertices, function(item) {
			return item.Clone();
		});
	};
    
	static GetEdges = function() {
		return array_map(self.property_edges, function(item) {
			return new ColLine(item.start, item.finish);
		});
	};
    
	static GetMin = function() {
		return self.property_min.Clone();
	};
    
	static GetMax = function() {
		return self.property_max.Clone();
	};

	//*****************************************************
	static dbug_draw = function(col=c_white){

		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);
		
		vertex_add(vbuff, self.position.X-1, self.position.Y , self.position.Z ,c_white);
		vertex_add(vbuff, self.position.X+1, self.position.Y , self.position.Z ,c_white);
		vertex_add(vbuff, self.position.X, self.position.Y-1 , self.position.Z ,c_white);
		vertex_add(vbuff, self.position.X, self.position.Y+1 , self.position.Z ,c_white);
		vertex_add(vbuff, self.position.X, self.position.Y , self.position.Z-1 ,c_white);
		vertex_add(vbuff, self.position.X, self.position.Y , self.position.Z+1 ,c_white);

		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
																													
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
																															
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z + self.half_extents.Z,col);

		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	}
	
}
*/