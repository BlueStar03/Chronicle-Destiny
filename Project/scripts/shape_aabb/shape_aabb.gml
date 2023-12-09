///@function AABB(position, half_extents, [min_max])
///@description What it does
///@param position {struct.Vector3} The center of the AABB
///@param half_extents {struct.Vector3} The half-sides of the AABB
///@param [min_max] {bool} If true, creates the AABB using min max coord

function zAABB(position, half_extents, min_max=false) constructor{
	if min_max{
		self.position = position.add(half_extents).divide(2);
		self.half_extents = half_extents.subtract(position).divide(2).absolute();
	}else{
		self.position=position;					//Vect3
		self.half_extents=half_extents			//Vect3
	}
	
	static check_shape = function(shape) {
		return shape.shape.check_aabb(self);
	};
	
	static check_point = function(point) {
		return point.check_aabb(self);
	};
	
	static check_sphere = function(sphere) {
		return sphere.check_aabb(self);
	};
	
	static check_aabb = function(aabb) {
		var box_min = self.get_min();
		var box_max = self.get_max();
		var other_min = aabb.get_min();
		var other_max = aabb.get_max();
		return ((box_min.x <= other_max.x) && (box_max.x >= other_min.x) && (box_min.y <= other_max.y) && (box_max.y >= other_min.y) && (box_min.z <= other_max.z) && (box_max.z >= other_min.z));
	};

	static check_ray = function(ray, hit_info) {
		var box_min = self.get_min();
		var box_max = self.get_max();

		var ray_x = (ray.direction.x == 0) ? 0.0001 : ray.direction.x;
		var ray_y = (ray.direction.y == 0) ? 0.0001 : ray.direction.y;
		var ray_z = (ray.direction.z == 0) ? 0.0001 : ray.direction.z;

		var t1 = (box_min.x - ray.origin.x) / ray_x;
		var t2 = (box_max.x - ray.origin.x) / ray_x;
		var t3 = (box_min.y - ray.origin.y) / ray_y;
		var t4 = (box_max.y - ray.origin.y) / ray_y;
		var t5 = (box_min.z - ray.origin.z) / ray_z;
		var t6 = (box_max.z - ray.origin.z) / ray_z;
        
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

			var t = tmax;
			if (tmin > 0) {
				t = tmin;
			}

		var contact_point = ray.origin.add(ray.direction.multiply(t));

		var tnormal;
		if (t == t1) tnormal = new Vector3(-1, 0, 0);
		if (t == t2) tnormal = new Vector3(+1, 0, 0);
		if (t == t3) tnormal = new Vector3(0, -1, 0);
		if (t == t4) tnormal = new Vector3(0, +1, 0);
		if (t == t5) tnormal = new Vector3(0, 0, -1);
		if (t == t6) tnormal = new Vector3(0, 0, +1);

		hit_info.update(t, self, contact_point, tnormal);

		return true;
	};

	static check_line = function(line) {
		var dir = line.finish.subtract(line.start).normalize();
		var ray = new Ray(line.start, dir);
		var hit_info = new RaycastHitInformation();
		if (self.CheckRay(ray, hit_info)) {
			return (hit_info.distance <= line.Length());
		}
		return false;
	};

	static displace_sphere = function(sphere) {
		if (!self.check_sphere(sphere)) return undefined;

		if (self.position.distance_to(sphere.position) == 0) return undefined;

		var nearest = self.nearest_point(sphere.position);

		if (nearest.distance_to(sphere.position) == 0) {
			return undefined;
			/*
			var dir_to_center = sphere.position.Sub(self.position).Normalize();
			var new_point = dir_to_center.Mul(self.half_extents.Magnitude());

			nearest = self.NearestPoint(new_point);
			var dir = nearest.Sub(sphere.position).Normalize();
			*/
		} else {
			var dir = sphere.position.subtract(nearest).normalize();
		}

		return nearest.add(dir.multiply(sphere.radius));
	};

	static get_min = function() {
		return self.position.subtract(self.half_extents);
	};

	static get_max = function() {
		return self.position.add(self.half_extents);
	};

	static nearest_point = function(vec3) {
		var box_min = self.get_min();
		var box_max = self.get_max();
		var xx = (vec3.x < box_min.x) ? box_min.x : vec3.x;
		var yy = (vec3.y < box_min.y) ? box_min.y : vec3.y;
		var zz = (vec3.z < box_min.z) ? box_min.z : vec3.z;
		xx = (xx > box_max.x) ? box_max.x : xx;
		yy = (yy > box_max.y) ? box_max.y : yy;
		zz = (zz > box_max.z) ? box_max.z : zz;
		return new Vector3(xx, yy, zz);
	};
	
	static dbug_draw = function() {

		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);

		vertex_point_add(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z);
		vertex_point_add(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z);
		vertex_point_add(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z);
		vertex_point_add(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z);
		vertex_point_add(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z);
		vertex_point_add(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z);
		vertex_point_add(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z);
		vertex_point_add(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z);
																															
		vertex_point_add(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z);
		vertex_point_add(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z);
		vertex_point_add(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z);
		vertex_point_add(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z);
		vertex_point_add(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z);
		vertex_point_add(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z);
		vertex_point_add(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z);
		vertex_point_add(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z);
																															
		vertex_point_add(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z);
		vertex_point_add(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z);
		vertex_point_add(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z);
		vertex_point_add(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z);
		vertex_point_add(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z);
		vertex_point_add(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z);
		vertex_point_add(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z);
		vertex_point_add(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z);

		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	};

}