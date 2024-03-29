///@function function_name(x,[c_str])
///@description What it does
///@param x {real} what it is

function Collider(shape, reference=other.id, mask = 1, group = 1) constructor {
		self.shape = shape;
		self.reference = reference;
		self.mask = mask;                                   // what other objects can collide with me
		self.group = group;                                 // what masks i can detect collisions with

	static check_collider = function(collider) {
		if (collider == self) return false;
		if ((self.mask & collider.group) == 0) return false;
		return self.shape.check_collider(collider);
	};

	static check_ray = function(ray, hit_info, group = 1) {
		if ((self.mask & group) == 0) return false;
		return self.shape.check_ray(ray, hit_info);
	};

	static get_min = function() {
		return self.shape.get_min();
	};

	static get_max = function() {
		return self.shape.get_max();
	};
	
	static dbug_draw= function(col=c_white){
		self.shape.dbug_draw(col)	
	}
}
