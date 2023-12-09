///@function function_name(x,[c_str])
///@description What it does
///@param x {real} what it is

function zPoint(position) constructor{
	self.position=position;														//Vect3

	static check_shape = function(shape) {
		return shape.shape.check_point(self);
	};

	static check_point = function(point) {
		return self.position.equals(point.position);
	};

	static check_sphere = function(sphere) {
		return self.position.distance_to(sphere.position) < sphere.radius;
	};

	static check_aabb = function(aabb) {
		var box_min = aabb.get_min();
		var box_max = aabb.get_max();
		if (self.position.x < box_min.x || self.position.y < box_min.y || self.position.z < box_min.z) return false;
		if (self.position.x > box_max.x || self.position.y > box_max.y || self.position.z > box_max.z) return false;
		return true;
	};

	static check_ray = function(ray, hit_info) {
		var nearest = ray.nearest_point(self.position);
		if (nearest.distance_to(self.position) != 0) return false;

		hit_info.update(self.position.distance_to(ray.origin), self, self.position, undefined);

		return true;
	};

	static check_line = function(line) {
		var nearest = line.nearest_point(self.position);
		return (nearest.distance_to(self.position) == 0);
	};

	static displace_sphere = function(sphere) {
		if (!self.check_sphere(sphere)) return undefined;
	
		if (self.position.distance_to(sphere.position) == 0) return undefined;

		var dir = sphere.position.subtract(self.position).normalize();
		var offset = dir.multiply(sphere.radius);

		return self.position.add(offset);
	};

	static get_min = function() {
		return self.position;
	};

	static get_max = function() {
		return self.position;
	};

	static dbug_draw = function(size=4) {
		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);
	
		vertex_point_add(vbuff, self.position.x+size,	self.position.y,		self.position.z,			c_red);
		vertex_point_add(vbuff, self.position.x-size,	self.position.y,		self.position.z,			c_white);
																				
		vertex_point_add(vbuff, self.position.x,		self.position.y+size,	self.position.z,			c_green);
		vertex_point_add(vbuff, self.position.x,		self.position.y-size,	self.position.z,			c_white);
																				
		vertex_point_add(vbuff, self.position.x,		self.position.y,		self.position.z+size,		c_blue);
		vertex_point_add(vbuff, self.position.x,		self.position.y,		self.position.z-size,		c_white);
	
		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	};
}