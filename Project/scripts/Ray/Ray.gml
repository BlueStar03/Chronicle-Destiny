///@function function_name(x,[c_str])
///@description What it does
///@param x {real} what it is

function Ray(origin, direction) constructor{
	self.origin=origin;														//Vect3
	self.direction=direction;														//Vect3
	
	static check_collider=function(collider, hit_info){
		return collider.shape.check_ray(self,hit_info);
	}
	
	static check_point = function(point, hit_info) {
		return point.check_ray(self, hit_info);
	};

	static check_sphere = function(sphere, hit_info) {
		return sphere.check_ray(self, hit_info);
	};

	static check_aabb = function(aabb, hit_info) {
		return aabb.check_ray(self, hit_info);
	};

	static check_ray = function(ray, hit_info) {
		return false;
	};

	static check_line = function(line, hit_info) {
		return false;
	};

	static nearest_point = function(vec3) {
		var diff = vec3.subtract(self.origin);
		var t = max(diff.dot(self.direction), 0);
		var scaled_dir = self.direction.multiply(t);
		return self.origin.add(scaled_dir);
	};

	static get_min = function() {
		return undefined;
	};

	static get_max = function() {
		return undefined;
	};
	
	static dbug_draw = function(col=c_white){
		var size=1;
		var neo=self.origin.add(direction.normalize().multiply(64));
		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);
	
		vertex_point_add(vbuff, self.origin.x+size,	self.origin.y,		self.origin.z,			c_white);
		vertex_point_add(vbuff, self.origin.x-size,	self.origin.y,		self.origin.z,			c_white);
																								
		vertex_point_add(vbuff, self.origin.x,		self.origin.y+size,	self.origin.z,			c_white);
		vertex_point_add(vbuff, self.origin.x,		self.origin.y-size,	self.origin.z,			c_white);
																								
		vertex_point_add(vbuff, self.origin.x,		self.origin.y,		self.origin.z+size,		c_white);
		vertex_point_add(vbuff, self.origin.x,		self.origin.y,		self.origin.z-size,		c_white);
		
		
		vertex_point_add(vbuff, self.origin.x,		self.origin.y,		self.origin.z,		col);
		vertex_point_add(vbuff, neo.x,		neo.y,		neo.z,		col,0);
		
	
		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	}
	
}


function Ray_Hit_Info() constructor {
	self.shape = undefined;
	self.point = undefined;
	self.distance = infinity;
	self.normal = undefined;
    
	static update = function(distance, shape, point, normal) {
		if (distance < self.distance) {
			self.distance = distance;
			self.shape = shape;
			self.point = point;
			self.normal = normal;
		}
	};
    
	static clear = function() {
		self.shape = undefined;
		self.point = undefined;
		self.distance = infinity;
		self.normal = undefined;
	};
}