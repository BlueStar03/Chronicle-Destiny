function AABB(point_min, point_max, min_max=true) constructor{
	if min_max{
		self.position = point_min.add(point_max).divide(2);
		self.half_extents = point_max.subtract(point_min).divide(2).absolute();
	}else{
		self.position=point_min;					//Vect3
		self.half_extents=point_max;			//Vect3
	}

	//METHODS
	//Collisions
	static check_collider = function(collider){
		return collider.shape.check_aabb(self);
	}
	
	static check_point = function(point){
		return point.check_aabb(self);
	}
	
	static check_sphere = function(sphere){
		return sphere.check_aabb(self);
	}
	
	static check_aabb = function(aabb){
		var box_min = self.get_min();
		var box_max = self.get_max();
		var other_min = aabb.get_min();
		var other_max = aabb.get_max();
		return ((box_min.x <= other_max.x) && (box_max.x >= other_min.x) && (box_min.y <= other_max.y) && (box_max.y >= other_min.y) && (box_min.z <= other_max.z) && (box_max.z >= other_min.z));
	}

	static check_plane = function(plane){
		var anorm = plane.normal.absolute();
		var plength = self.half_extents.dot(anorm);
		var ndot = plane.normal.dot(self.position);
		var dist = ndot - plane.distance;
		return (abs(dist) <= plength);
	}

	static check_ray = function(ray, hit_info, maxt=infinity){
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
			if (tmin > 0){
				t = tmin;
			}
			if t>maxt return false
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
	}

	static check_line = function(line){
		var dir = line.finish.subtract(line.start).normalize();
		var ray = new Ray(line.start, dir);
		var hit_info = new Ray_Hit_Info();
		if (self.check_ray(ray, hit_info)){
			return (hit_info.distance <= line.length());
		}
		return false;
	}

	static check_obb = function(obb){
		return obb.check_aabb(self);
	}
	
	static check_capsule = function(capsule){
		return capsule.check_aabb(self);
	}

	static nearest_point = function(vec3){
		var box_min = self.get_min();
		var box_max = self.get_max();
		var xx = (vec3.x < box_min.x) ? box_min.x : vec3.x;
		var yy = (vec3.y < box_min.y) ? box_min.y : vec3.y;
		var zz = (vec3.z < box_min.z) ? box_min.z : vec3.z;
		xx = (xx > box_max.x) ? box_max.x : xx;
		yy = (yy > box_max.y) ? box_max.y : yy;
		zz = (zz > box_max.z) ? box_max.z : zz;
		return new Vector3(xx, yy, zz);
	}

	static get_min = function(){
		return self.position.subtract(self.half_extents);
	}

	static get_max = function(){
		return self.position.add(self.half_extents);
	}

	static get_interval = function(axis){
		var vertices = self.get_vertices();

		var imin = axis.dot(vertices[0]);
		var imax = imin;

		for (var i = 1; i < 8; i++) {
		var dot = axis.dot(vertices[i]);
		imin = min(imin, dot);
		imax = max(imax, dot);
		}

		return new Interval(imin, imax);
	}
	
	static get_vertices = function() {
        var pmin = self.get_min();
        var pmax = self.get_max();
        
        return [
            new Vector3(pmin.x, pmax.y, pmax.z),
            new Vector3(pmin.x, pmax.y, pmin.z),
            new Vector3(pmin.x, pmin.y, pmax.z),
            new Vector3(pmin.x, pmin.y, pmin.z),
            new Vector3(pmax.x, pmax.y, pmax.z),
            new Vector3(pmax.x, pmax.y, pmin.z),
            new Vector3(pmax.x, pmin.y, pmax.z),
            new Vector3(pmax.x, pmin.y, pmin.z),
        ]
    }


 
    
    static get_edges = function() {
        var vertices = self.get_vertices();
        
        return [
            new Line(vertices[0], vertices[1]),
            new Line(vertices[0], vertices[2]),
            new Line(vertices[1], vertices[3]),
            new Line(vertices[2], vertices[3]),
            new Line(vertices[4], vertices[5]),
            new Line(vertices[4], vertices[6]),
            new Line(vertices[5], vertices[7]),
            new Line(vertices[6], vertices[7]),
            new Line(vertices[0], vertices[4]),
            new Line(vertices[1], vertices[5]),
            new Line(vertices[2], vertices[6]),
            new Line(vertices[3], vertices[7]),
        ];
    };
 


	static dbug_draw = function(col=c_white){

		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);
		
		vertex_add(vbuff, self.position.x-1, self.position.y , self.position.z ,c_white);
		vertex_add(vbuff, self.position.x+1, self.position.y , self.position.z ,c_white);
		vertex_add(vbuff, self.position.x, self.position.y-1 , self.position.z ,c_white);
		vertex_add(vbuff, self.position.x, self.position.y+1 , self.position.z ,c_white);
		vertex_add(vbuff, self.position.x, self.position.y , self.position.z-1 ,c_white);
		vertex_add(vbuff, self.position.x, self.position.y , self.position.z+1 ,c_white);

		vertex_add(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z,col);
		vertex_add(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z,col);
		vertex_add(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z,col);
		vertex_add(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z,col);
		vertex_add(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z,col);
		vertex_add(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z,col);
		vertex_add(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z,col);
		vertex_add(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z,col);
																													
		vertex_add(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z,col);
		vertex_add(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z,col);
		vertex_add(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z,col);
		vertex_add(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z,col);
		vertex_add(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z,col);
		vertex_add(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z,col);
		vertex_add(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z,col);
		vertex_add(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z,col);
																															
		vertex_add(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z,col);
		vertex_add(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z,col);
		vertex_add(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z,col);
		vertex_add(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z,col);
		vertex_add(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z,col);
		vertex_add(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z,col);
		vertex_add(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z,col);
		vertex_add(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z,col);

		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	}

}