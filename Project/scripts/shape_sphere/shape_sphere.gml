///@function								Sphere(position, radius)
///@description								What it does
///@param position		{struct.Vector3}			3d position of the sphere
///@param radius		{real}				radius of the sphere
function zSphere(position, radius) constructor{
	self.position=position;													//Vect3
	self.radius=radius;														//real

	static check_shape = function(shape) {
		return shape.shape.check_sphere(self);
	};

	static check_point = function(point) {
		return point.check_sphere(self);
	};

	static check_sphere = function(sphere) {
		return self.position.distance_to(sphere.position) < (self.radius + sphere.radius);
	};

	static check_aabb = function(aabb) {
		var nearest = aabb.nearest_point(self.position);
		var dist = nearest.distance_to(self.position);
		return dist < self.radius;
	};

	static check_ray = function(ray, hit_info) {
		var e = self.position.subtract(ray.origin);
		var mag_squared = power(e.magnitude(), 2);
		var r_squared = power(self.radius, 2);
		var EdotD = e.dot(ray.direction);
		var offset = r_squared - (mag_squared - (EdotD * EdotD));
		if (offset < 0) return false;

		var f = sqrt(abs(offset));
		var t = EdotD - f;
		if (mag_squared < r_squared) {
			t = EdotD + f;
		}
		var contact_point = ray.origin.add(ray.direction.multiply(t));

		hit_info.update(t, self, contact_point, contact_point.Sub(self.position).normalize());

		return true;
	};

	static check_line = function(line) {
        var nearest = line.nearest_point(self.position);
        var dist = nearest.distance_to(self.position);
        return dist < self.radius;
    };
	
	static displace_sphere = function(sphere) {
		if (!self.check_sphere(sphere)) return undefined;
	
		if (self.position.distance_to(sphere.position) == 0) return undefined;
	
		var dir = sphere.position.subtract(self.position).normalize();
		var offset = dir.multiply(sphere.radius + self.radius);
	
		return self.position.add(offset);
	};

	static nearest_point = function(vec3) {
		var dist = vec3.subtract(self.position).normalize();
		var scaled_dist = dist.multiply(self.radius);
		return scaled_dist.add(self.position);
	};

	static get_min = function() {
		return self.position.subtract(self.radius);
	};

	static get_max = function() {
		return self.position.add(self.radius);
	};

	static dbug_draw = function(segments=8){


		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);
		
		var num_vertices = 16; 
		var angle_increment = 360 / num_vertices;
		
		for (var i = 0; i <= num_vertices; i++) {
			var angle_rad = degtorad(i * angle_increment);
			var vertex_x = 0 + self.radius * cos(angle_rad);
			var vertex_y = 0 + self.radius * sin(angle_rad);
			vertex_point_add(vbuff, vertex_x, vertex_y, 0);
		}
		vertex_end(vbuff);
		matrix_set(matrix_world, matrix_build(self.position.x, self.position.y, self.position.z, -90+0, 0, camera.orbit.dir+90, 1, 1, 1));			
		vertex_submit(vbuff, pr_linestrip, -1);
		matrix_set(matrix_world, matrix_build_identity());
		vertex_delete_buffer(vbuff);
	
	}

		


// Use the vertex buffer for drawing (e.g., in a custom primitive or shader)
// Remember to free the buffer when no longer needed:
// vertex_freeze(v_buff);

// Example usage:
// draw_primitive_begin(pr_trianglestrip);
// draw_vertex_buffer(v_buff);
// draw_primitive_end();

// Note: You can adjust the number of vertices and other parameters as needed.

		
		//var _num_segments = 32; // Number of segments for the sphere		
		//var vbuff = vertex_create_buffer();
		//vertex_begin(vbuff, v_format);
		
		//for (var i = 0; i <= segments; i++) {
		//	var phi = pi * i / segments;
		//	for (var j = 0; j <= segments; j++) {
		//		var theta = 2 * pi * j / segments;

		//		var _x_pos = self.position.x + self.radius * sin(phi) * cos(theta);
		//		var _y_pos = self.position.y + self.radius * sin(phi) * sin(theta);
		//		var _z_pos = self.position.z + self.radius * cos(phi);

		//		vertex_point_add(vbuff,  _x_pos, _y_pos, _z_pos, );
		//	}
		//}
		
		//vertex_end(vbuff);
        //vertex_submit(vbuff, pr_linestrip, -1);
        //vertex_delete_buffer(vbuff);
	//}
}
