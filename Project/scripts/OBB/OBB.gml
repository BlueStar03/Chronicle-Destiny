function OBB(position, size, orientation) constructor {
	self.position = position;				// Vec3
	self.size = size;						// Vec3
	self.orientation = orientation;			// mat3

	self.recalculate_properties();
	
	static recalculate_properties = function() {
		self.vertices = [
			self.position.add(self.orientation.x.multiply(self.size.x)).add(self.orientation.y.multiply(self.size.y)).add(self.orientation.z.multiply(self.size.z)),
			self.position.subtract(self.orientation.x.multiply(self.size.x)).add(self.orientation.y.multiply(self.size.y)).add(self.orientation.z.multiply(self.size.z)),
			self.position.add(self.orientation.x.multiply(self.size.x)).subtract(self.orientation.y.multiply(self.size.y)).add(self.orientation.z.multiply(self.size.z)),
			self.position.add(self.orientation.x.multiply(self.size.x)).add(self.orientation.y.multiply(self.size.y)).subtract(self.orientation.z.multiply(self.size.z)),
			self.position.subtract(self.orientation.x.multiply(self.size.x)).subtract(self.orientation.y.multiply(self.size.y)).subtract(self.orientation.z.multiply(self.size.z)),
			self.position.add(self.orientation.x.multiply(self.size.x)).subtract(self.orientation.y.multiply(self.size.y)).subtract(self.orientation.z.multiply(self.size.z)),
			self.position.subtract(self.orientation.x.multiply(self.size.x)).add(self.orientation.y.multiply(self.size.y)).subtract(self.orientation.z.multiply(self.size.z)),
			self.position.subtract(self.orientation.x.multiply(self.size.x)).subtract(self.orientation.y.multiply(self.size.y)).add(self.orientation.z.multiply(self.size.z)),
		];

		self.edges = [
			new Line(vertices[1], vertices[6]),
			new Line(vertices[6], vertices[4]),
			new Line(vertices[4], vertices[7]),
			new Line(vertices[7], vertices[1]),
			new Line(vertices[0], vertices[3]),
			new Line(vertices[3], vertices[5]),
			new Line(vertices[5], vertices[1]),////THis one may be wrong, it could be 5 , 2
			new Line(vertices[1], vertices[0]),////THis one may be wrong, it could be 2 , 0
			new Line(vertices[7], vertices[2]),
			new Line(vertices[1], vertices[0]),
			new Line(vertices[6], vertices[3]),
			new Line(vertices[4], vertices[5]),
		];

		self.point_min = new Vector3(infinity, infinity, infinity);
		for (var i = 0; i < array_length(self.vertices); i++) {
			self.point_min.x = min(self.point_min.x, self.vertices[i].x);
			self.point_min.y = min(self.point_min.y, self.vertices[i].y);
			self.point_min.z = min(self.point_min.z, self.vertices[i].z);
		}

		self.point_max = new Vector3(infinity, infinity, infinity);
		for (var i = 0; i < array_length(self.vertices); i++) {
			self.point_max.x = min(self.point_max.x, self.vertices[i].x);
			self.point_max.y = min(self.point_max.y, self.vertices[i].y);
			self.point_max.z = min(self.point_max.z, self.vertices[i].z);
		}

		self.imaginary_radius = self.size.magnitude();
}
	
	
	static check_collider = function(collider) {
		return collider.shape.check_obb(self);
	}
	
	static check_point=function(point){
		var dir = point.position.subtract(self.position);

		var size_array = self.size.to_linear_array();
		var orientation_array = self.orientation.to_vector_array();

		for (var i = 0; i < 3; i++){
			var axis = orientation_array[i];

			var dist = dir.dot(axis);

			if (abs(dist) > abs(size_array[i])){
				return false;
			}
		}
	}
	
	static check_sphere=function(sphere){
		//var distance = self.position.DistanceTo(sphere.position);
		var distance = point_distance_3d(self.position.x, self.position.y, self.position.z, sphere.position.x, sphere.position.y, sphere.position.z);

		if (distance > self.imaginary_radius + sphere.radius) return false;

		var nearest = self.nearest_point(sphere.position);
		//var dist = nearest.DistanceTo(sphere.position);
		var dist = point_distance_3d(nearest.x, nearest.y, nearest.z, sphere.position.x, sphere.position.y, sphere.position.z);
		return dist < sphere.radius;
	}
	
	static check_aabb=function(aabb){
		var axes = [
			new Vector3(1, 0, 0),
			new Vector3(0, 1, 0),
			new Vector3(0, 0, 1),

			self.orientation.x,
			self.orientation.y,
			self.orientation.z,
		];

		for (var i = 0; i < 3; i++) {
			for (var j = 3; j < 6; j++) {
				array_push(axes, axes[i].cross(axes[j]));
			}
		}

		for (var i = 0; i < 15; i++) {
			if (!sat_overlap_axis(self, aabb, axes[i])) {
				return false;
			}
		}

		return true;
	}
	
	static check_plane=function(plane){
		var plen = self.size.x * abs(plane.normal.dot(self.orientation.x)) +
			self.size.y * abs(plane.normal.dot(self.orientation.y)) +
			self.size.z * abs(plane.normal.dot(self.orientation.z));

		var dist = plane.normal.dot(self.position) - plane.distance;

		return abs(dist) < plen;
	}
	
	static check_line=function(line){
		var dir = line.finish.subtract(line.start).normalize();
		var ray = new Ray(line.start, dir);
		var hit_info = new Ray_Hit_Info();
		if (self.check_ray(ray, hit_info)){
			return (hit_info.distance <= line.Length());
		}
		return false;
	}
	
	static check_ray=function(ray, hit_info){
		var size_array = self.size.to_linear_array();

		var dir = self.position.subtract(ray.origin);

		var direction_dots = [
		    self.orientation.x.dot(ray.direction),
		    self.orientation.y.dot(ray.direction),
		    self.orientation.z.dot(ray.direction),
		];

		var position_dots = [
		    self.orientation.x.dot(dir),
		    self.orientation.y.dot(dir),
		    self.orientation.z.dot(dir),
		];

		var t = array_create(6, 0);

		for (var i = 0; i < 3; i++) {
		    if (direction_dots[i] == 0) {
		if ((-position_dots[i] - size_array[i]) > 0 || (-position_dots[i] + size_array[i]) < 0) {
		    return false;
		}
		direction_dots[i] = 0.0001;
		    }
    
		    t[i * 2 + 0] = (position_dots[i] + size_array[i]) / direction_dots[i];
		    t[i * 2 + 1] = (position_dots[i] - size_array[i]) / direction_dots[i];
		}

		var tmin = max(
		    min(t[0], t[1]),
		    min(t[2], t[3]),
		    min(t[4], t[5])
		);

		var tmax = min(
		    max(t[0], t[1]),
		    max(t[2], t[3]),
		    max(t[4], t[5])
		);

		if (tmax < 0) return false;
		if (tmin > tmax) return false;

		if (hit_info) {
		    var contact_distance = (tmin < 0) ? tmax : tmin;
		    var contact_normal = new Vector3(0, 0, 0);
    
		    var contact_point = ray.origin.Add(ray.direction.multiply(contact_distance));
    
		    var possible_normals = [
		self.orientation.x,
		self.orientation.x.multiply(-1),
		self.orientation.y,
		self.orientation.y.multiply(-1),
		self.orientation.z,
		self.orientation.z.multiply(-1),
		    ];
    
		    for (var i = 0; i < 6; i++) {
		if (contact_distance == t[i]) contact_normal = possible_normals[i];
		    }
    
		    hit_info.update(contact_distance, self, contact_point, contact_normal);
		}

		return true;
	}
	
	static check_obb = function(obb) {
		var axes = [
			obb.orientation.x,
			obb.orientation.y,
			obb.orientation.z,

			self.orientation.x,
			self.orientation.y,
			self.orientation.z,
		];

		for (var i = 0; i < 3; i++) {
			for (var j = 3; j < 6; j++) {
				array_push(axes, axes[i].cross(axes[j]));
			}
		}

		for (var i = 0; i < 15; i++) {
			if (!sat_overlap_axis(self, obb, axes[i])) {
				return false;
			}
		}

		return true;
	}
	
	static check_capsule = function(collider) {
		
	}
	
	//
	
	static nearest_point = function(vec3){
		var result = self.position;
		var dir = vec3.subtract(self.position);

		var size_array = self.size.to_linear_array();
		var orientation_array = self.orientation.to_vector_array();

		for (var i = 0; i < 3; i++) {
			var axis = orientation_array[i];

			var dist = dir.dot(axis);

			dist = clamp(dist, -size_array[i], size_array[i]);
			result = result.add(axis.multiply(dist));
		}

		return result;
	}
	
	static get_interval = function(axis){
		var vertices = self.get_vertices();

		var xx = axis.x;
		var yy = axis.y;
		var zz = axis.z;

		var imin = infinity;
		var imax = -infinity;

		for (var i = 0; i < 8; i++) {
			var vertex = vertices[i];
			var dot = dot_product_3d(xx, yy, zz, vertex.x, vertex.y, vertex.z);
			imin = min(imin, dot);
			imax = max(imax, dot);
		}

		return new Interval(imin, imax);
	}
	
	static get_vertices = function(){
		return self.vertices;
	}

		static get_edges = function(){
		return self.edges;
	}

		static get_min = function(){
		return self.point_min;
	}

		static get_max = function(){
		return self.point_max;
	}
	
	
	static dbug_draw = function(col=c_white) {
		var vert=get_vertices()
		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);
		vertex_point_add(vbuff, vert[1].x , vert[1].y,vert[1].z ,col);
		vertex_point_add(vbuff, vert[6].x , vert[6].y,vert[6].z ,col);
		
		vertex_point_add(vbuff, vert[6].x , vert[6].y,vert[6].z ,col);
		vertex_point_add(vbuff, vert[4].x , vert[4].y,vert[4].z ,col);
		
		vertex_point_add(vbuff, vert[4].x , vert[4].y,vert[4].z ,col);
		vertex_point_add(vbuff, vert[7].x , vert[7].y,vert[7].z ,col);
		
		vertex_point_add(vbuff, vert[7].x , vert[7].y,vert[7].z ,col);
		vertex_point_add(vbuff, vert[1].x , vert[1].y,vert[1].z ,col);
		//***********************
		vertex_point_add(vbuff, vert[0].x , vert[0].y,vert[0].z ,col);
		vertex_point_add(vbuff, vert[3].x , vert[3].y,vert[3].z ,col);
		
		vertex_point_add(vbuff, vert[3].x , vert[3].y,vert[3].z ,col);
		vertex_point_add(vbuff, vert[5].x , vert[5].y,vert[5].z ,col);
		
		vertex_point_add(vbuff, vert[5].x , vert[5].y,vert[5].z ,col);
		vertex_point_add(vbuff, vert[2].x , vert[2].y,vert[2].z ,col);
		
		vertex_point_add(vbuff, vert[2].x , vert[2].y,vert[2].z ,col);
		vertex_point_add(vbuff, vert[0].x , vert[0].y,vert[0].z ,col);
		//*********************
		vertex_point_add(vbuff, vert[7].x , vert[7].y,vert[7].z ,col);
		vertex_point_add(vbuff, vert[2].x , vert[2].y,vert[2].z ,col);
		
		vertex_point_add(vbuff, vert[1].x , vert[1].y,vert[1].z ,col);
		vertex_point_add(vbuff, vert[0].x , vert[0].y,vert[0].z ,col);
		
		vertex_point_add(vbuff, vert[6].x , vert[6].y,vert[6].z ,col);
		vertex_point_add(vbuff, vert[3].x , vert[3].y,vert[3].z ,col);
		
		vertex_point_add(vbuff, vert[4].x , vert[4].y,vert[4].z ,col);
		vertex_point_add(vbuff, vert[5].x , vert[5].y,vert[5].z ,col);
		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	}
}