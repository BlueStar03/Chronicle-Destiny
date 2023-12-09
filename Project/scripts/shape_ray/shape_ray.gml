///@function function_name(x,[c_str])
///@description What it does
///@param x {real} what it is

function zRay(origin, direction) constructor{
	self.origin=origin;														//Vect3
	self.direction=direction;														//Vect3
	
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

	static displace_sphere = function(sphere) {
		return undefined;
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
	
}


function RaycastHitInformation() constructor {
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