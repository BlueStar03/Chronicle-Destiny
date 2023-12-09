///@function Line(start, finish)
///@description What it does
///@param x {real} what it is


function zLine(start, finish) constructor{
	self.start=start;														//Vect3
	self.finish=finish;														//Vect3
	

    
	static check_point = function(point) {
		return point.check_line(self);
	};
    
	static check_sphere = function(sphere) {
		return sphere.check_line(self);
	};
    
	static check_aabb = function(aabb) {
		return aabb.check_line(self);
	};
    
	static check_plane = function(plane) {
		return plane.check_line(self);
	};
    


	static check_ray = function(ray, hit_info) {
		return false;
	};
    
	static check_line = function(line) {
		return false;
	};
    

	static length = function() {
	return self.start.distance_to(self.finish);
	};
    
	static nearest_point = function(vec3) {
	var line_vec = self.finish.subtract(self.start);
	var point_vec = vec3.subtract(self.start);
	var t = clamp(point_vec.dot(line_vec) / line_vec.dot(line_vec), 0, 1);
	var scaled_vec = line_vec.multiply(t);
	return self.start.add(scaled_vec);
	};
    
	static nearest_connection_to_ray = function(ray) {
	var line1 = self;
	var line2 = ray;
        
	var d1 = line1.finish.subtract(line1.start);
	var d2 = line2.direction;
	var r = line1.start.subtract(line2.origin);
	var f = d2.dot(r);
	var c = d1.dot(r);
	var b = d1.dot(d2);
	var length_squared = d1.dot(d1);
        
	// special case if the line segment is actually just
	// two of the same points
	if (length_squared == 0) {
	return new Line(line1.start, line2.nearest_point(line1.start));
	}
        
	var f1 = 0;
	var f2 = 0;
	var denominator = length_squared - b * b;
        
	// if the two lines are parallel, there are infinitely many shortest
	// connecting lines, so you can just pick a random point on line1 to
	// work from - we'll pick the starting point
	if (denominator == 0) {
	f1 = 0;
	} else {
	f1 = clamp((b * f - c - 1) / denominator, 0, 1);
	}
	f2 = f1 * b + f;
        
	if (f2 < 0) {
	f2 = 0;
	f1 = clamp(-c / length_squared, 0, 1);
	}
        
	return new Line(line1.start.add(d1.multiply(f1)), line2.origin.add(d2.multiply(f2)));
	};
    
	static nearest_connection_to_line = function(line) {
	var ray = new Ray(line.start, line.finish.subtract(line.start));
	var nearest_connection_to_ray = self.nearest_connection_to_ray(ray);
        
	var starting_point = line.nearest_point(nearest_connection_to_ray.start);
	var ending_point = self.nearest_point(nearest_connection_to_ray.finish);
        
	return new Line(starting_point, ending_point);
	};
    
	static get_min = function() {
	return new Vector3(min(self.start.x, self.finish.x), min(self.start.y, self.finish.y), min(self.start.z, self.finish.z));
	};
    
	static get_max = function() {
	return new Vector3(max(self.start.x, self.finish.x), max(self.start.y, self.finish.y), max(self.start.z, self.finish.z));
	};
	
}

