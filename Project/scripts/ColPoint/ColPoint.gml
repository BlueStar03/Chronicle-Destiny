/// @function		Point(position)
/// @desc			A 3d Point for collisions
/// @param {Struct.BBMOD_Vec3} position	- a vect3 for the position

function ColPoint(position) constructor{
	self.Set(position);
	
	static Set = function(position) {
		self.position = position;
		self.property_min = position;
		self.property_max = position;
	};
		
	static CheckCollider = function(collider) {
		return collider.shape.CheckPoint(self);
	};
    
	static CheckPoint = function(point) {
		var p1 = self.position;
		var p2 = point.position;
		return p1.X == p2.X && p1.Y == p2.Y && p1.Z == p2.Z;
	};
    
	static CheckSphere = function(sphere) {
		var pp = self.position;
		var ps = sphere.position;
		return point_distance_3d(pp.X, pp.Y, pp.Z, ps.X, ps.Y, ps.Z) < sphere.radius;
	};
    
	static CheckAABB = function(aabb) {
		var box_min = aabb.property_min;
		var box_max = aabb.property_max;
		var p = self.position;
		if (p.X < box_min.X || p.Y < box_min.Y || p.Z < box_min.Z) return false;
		if (p.X > box_max.X || p.Y > box_max.Y || p.Z > box_max.Z) return false;
		return true;
	};
    
	static CheckPlane = function(plane) {
		var p = self.position;
		var n = plane.normal;
		return (dot_product_3d(p.X, p.Y, p.Z, n.X, n.Y, n.Z) == plane.distance);
	};
    
	static CheckOBB = function(obb) {
		return obb.CheckPoint(self);
	};
    
	static CheckCapsule = function(capsule) {
		return capsule.CheckPoint(self);
	};

	static CheckRay = function(ray, hit_info = undefined) {
		var p = self.position;
		var nearest = ray.NearestPoint(p);
		if (point_distance_3d(nearest.X, nearest.Y, nearest.Z, p.X, p.Y, p.Z) > 0) return false;
        
		if (hit_info) {
			var ro = ray.origin;
			hit_info.Update(point_distance_3d(p.X, p.Y, p.Z, ro.X, ro.X, ro.Z), self, p, undefined);
		}
        
		return true;
	};
    
	static CheckLine = function(line) {
		var p = self.position;
		var nearest = line.NearestPoint(p);
			return nearest.X == p.X && nearest.Y == p.Y && nearest.Z == p.Z;
	};
	
	static DisplaceSphere = function(sphere) {
		var pp = self.position;
		var ps = sphere.position;
		var d = point_distance_3d(pp.x, pp.y, pp.z, ps.x, ps.y, ps.z);
		if (d == 0 || d > sphere.radius) return undefined;
        
		return pp.Add(ps.Sub(pp).Normalize().Mul(sphere.radius));
	};
    
    
    static GetMin = function() {
        return self.position.Clone();
    };
    
    static GetMax = function() {
        return self.position.Clone();
    };
    
	//******************************************************
	static dbug_draw = function(c_point=c_white) {
		var size=3
		var vbuff = vertex_create_buffer();
		
		vertex_begin(vbuff, v_format);
	
		vertex_add(vbuff, self.position.X+size,	self.position.Y,		self.position.Z,			c_point);
		vertex_add(vbuff, self.position.X-size,	self.position.Y,		self.position.Z,			c_point);
																				
		vertex_add(vbuff, self.position.X,		self.position.Y+size,	self.position.Z,			c_point);
		vertex_add(vbuff, self.position.X,		self.position.Y-size,	self.position.Z,			c_point);
																			
		vertex_add(vbuff, self.position.X,		self.position.Y,		self.position.Z+size,		c_point);
		vertex_add(vbuff, self.position.X,		self.position.Y,		self.position.Z-size,		c_point);
	
		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	};
}

