function Point(position) constructor{
	//PROPERTIES
	self.position=position;				//Vect3

	//METHODS
	//Collisions
	static check_collider = function(collider){
		return collider.shape.check_point(self);
	}

	static check_point = function(point){
		return self.position.equals(point.position);
	}

	static check_sphere = function(sphere){
		return self.position.distance_to(sphere.position) < sphere.radius;
	}
	
	static check_aabb = function(aabb){
		var box_min = aabb.get_min();
		var box_max = aabb.get_max();
		if (self.position.x < box_min.x || self.position.y < box_min.y || self.position.z < box_min.z) return false;
		if (self.position.x > box_max.x || self.position.y > box_max.y || self.position.z > box_max.z) return false;
		return true;
	}
	
	static check_plane = function(plane){
		var ndot = self.position.dot(plane.normal);
		return (ndot == plane.distance);
	}
	
	static check_line = function(line){
		var nearest = line.nearest_point(self.position);
		return (nearest.distance_to(self.position) == 0);
	}
	
	static check_ray = function(ray, hit_info){
		return false;//just dont bother
		var nearest = ray.nearest_point(self.position);
		if (nearest.distance_to(self.position) != 0) return false;

		hit_info.update(self.position.distance_to(ray.origin), self, self.position, undefined);

		return true;
	};

	static check_obb = function(obb){
		return obb.check_point(self);
	}
	
	static check_capsule = function(capsule){
		return capsule.check_point(self);
	}

	//Helpers
	static nearest_point = function(vec3) {
		return self.position;
	}

	static get_min = function() {
		return self.position;
	};

	static get_max = function() {
		return self.position;
	};

	//DBUG
	static dbug_draw = function(col=c_white) {
		var size=3
		var vbuff = vertex_create_buffer();
		
		vertex_begin(vbuff, v_format);
	
		vertex_point_add(vbuff, self.position.x+size,	self.position.y,		self.position.z,			col);
		vertex_point_add(vbuff, self.position.x-size,	self.position.y,		self.position.z,			col);
																				
		vertex_point_add(vbuff, self.position.x,		self.position.y+size,	self.position.z,			col);
		vertex_point_add(vbuff, self.position.x,		self.position.y-size,	self.position.z,			col);
																				
		vertex_point_add(vbuff, self.position.x,		self.position.y,		self.position.z+size,		col);
		vertex_point_add(vbuff, self.position.x,		self.position.y,		self.position.z-size,		col);
	
		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	};
}