function Sphere(x,y,z=undefined,r=undefined)constructor{
	self.position=x;													//Vect3
	self.radius=y;														//real
	if z!=undefined and r!=undefined{
		self.position=new Vector3(x,y,z);
		self.radius=r;
	}
	
	static check_collider = function(collider) {
		return collider.shape.check_sphere(self);
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

	static check_ray = function(ray, hit_info,maxt=infinity) {
		var SPtoRO=position.subtract(ray.origin);//vector from the sphere position to the ray origin
		var RD=ray.direction.normalize();//normalized ray direction
		var t=SPtoRO.dot(RD);//distance from the ray origin to the point on the ray closest to the sphere position
		if t+radius<0 return false//if t < 0 sphere is behind ray, return false
		if t>maxt return false// if it is beyond the specified distance, stop and return false 
		var p=ray.origin.add(RD.multiply(t))// the point on the ray closest to the sphere center		
		var i=position.subtract(p).magnitude();// distance from p to SO
		if i>radius return false;// if i is greater than R, there is no collision, retun false
		var j=sqrt(power(radius,2)-(i*i))//length from P to where it intect the shpere.  Pathagora (A^2 + B^2 = c^2, j^2 + i^2= r^2 )
		var k=(t-j)// the distance to the entry intesection
		if k<0{	k=t+j}// if the distence is negative, ther is no entry, ray is inside the sphere, get distance to the exit intersection 
		
		var contact_point=ray.origin.add(RD.multiply(k))// point location is from RO, add nornilized RD scaled to k 
		hit_info.update(k, self, contact_point, contact_point.subtract(self.position).normalize());
		
		return true
	
		
		/*
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

		hit_info.update(t, self, contact_point, contact_point.subtract(self.position).normalize());

		return true;
		*/
	};

	static check_line = function(line) {
		var nearest = line.nearest_point(self.position);
		var dist = nearest.distance_to(self.position);
		return dist < self.radius;
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

	static dbug_draw = function(col=c_white){
		
		
		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);
		
		var num_vertices = 16; 
		var angle_increment = 360 / num_vertices;
		
		for (var i = 0; i <= num_vertices; i++) {
			var angle_rad = degtorad(i * angle_increment);
			var vertex_x = 0 + self.radius * cos(angle_rad);
			var vertex_y = 0 + self.radius * sin(angle_rad);
			vertex_point_add(vbuff, vertex_x, vertex_y, 0,col);
		}
		vertex_end(vbuff);
		matrix_set(matrix_world, matrix_build(self.position.x, self.position.y, self.position.z, -90+0, 0, camera.orbit.dir+90, 1, 1, 1));			
		vertex_submit(vbuff, pr_linestrip, -1);
		matrix_set(matrix_world, matrix_build_identity());
		vertex_delete_buffer(vbuff);	
	}
}