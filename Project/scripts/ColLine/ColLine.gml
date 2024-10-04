function ColLine(start, finish) constructor {
	
	self.Set(start, finish);
	static Set = function(start, finish) {
		self.start = start;
		self.finish = finish;
		var sx = start.X, sy = start.Y, sz = start.Z;
		var fx = finish.X, fy = finish.Y, fz = finish.Z;
		self.property_min = new BBMOD_Vec3(min(sx, fx), min(sy, fy), min(sz, fz));
		self.property_max = new BBMOD_Vec3(max(sx, fx), max(sy, fy), max(sz, fz));
		self.property_ray = new ColRay(start, new BBMOD_Vec3(fx - sx, fy - sy, fz - sz));
		self.property_length = point_distance_3d(sx, sy, sz, fx, fy, fz);
		self.property_center = new BBMOD_Vec3(mean(sx, fx), mean(sy, fy), mean(sz, fz));
		
		
		var sx = start.X, sy = start.Y, sz = start.Z;
		var fx = finish.X, fy = finish.Y, fz = finish.Z;
		self.property_min.X = min(sx, fx);
		self.property_min.Y = min(sy, fy);
		self.property_min.Z = min(sz, fz);
		self.property_max.X = max(sx, fx);
		self.property_max.Y = max(sy, fy);
		self.property_max.Z = max(sz, fz);
		self.property_ray.origin = start;
		self.property_length = point_distance_3d(sx, sy, sz, fx, fy, fz);
		var mag = self.property_length;
		self.property_ray.direction.X = (fx - sx) / mag;
		self.property_ray.direction.Y = (fy - sy) / mag;
		self.property_ray.direction.Z = (fz - sz) / mag;
		self.property_center.X = mean(sx, fx);
		self.property_center.Y = mean(sy, fy);
		self.property_center.Z = mean(sz, fz);
	};
	
	static CheckCollider = function(collider) {
		return collider.shape.CheckLine(self);
	};
		
static CheckPoint = function(point) {
		return point.CheckLine(self);
	};
    
	static CheckSphere = function(sphere) {
		return sphere.CheckLine(self);
	};
    
	static CheckAABB = function(aabb) {
		return aabb.CheckLine(self);
	};
    
	static CheckPlane = function(plane) {
		return plane.CheckLine(self);
	};
    
	static CheckOBB = function(obb) {
		return obb.CheckLine(self);
	};
    
	static CheckCapsule = function(capsule) {
		return capsule.CheckLine(self);
	};
    
	static CheckTriangle = function(triangle) {
		return triangle.CheckLine(self);
	};
    
	static CheckMesh = function(mesh) {
		return mesh.CheckLine(self);
	};
    
	static CheckModel = function(model) {
		return model.CheckLine(self);
	};
    
	static CheckRay = function(ray, hit_info = undefined) {
		return false;
	};
    
	static CheckLine = function(line) {
		return false;
	};
    
	static DisplaceSphere = function(sphere) {
		return undefined;
	};
    
	static Length = function() {
		return self.property_length;
	};
    
	static NearestPoint = function(vec3) {
		var start = self.start;
		var finish = self.finish;
		var lvx = finish.X - start.X;
		var lvy = finish.Y - start.Y;
		var lvz = finish.Z - start.Z;
		var px = vec3.X - start.X;
		var py = vec3.Y - start.Y;
		var pz = vec3.Z - start.Z;
		var t = clamp(dot_product_3d(px, py, pz, lvx, lvy, lvz) / dot_product_3d(lvx, lvy, lvz, lvx, lvy, lvz), 0, 1);
		return new Vector3(
			start.X + lvx * t,
			start.Y + lvy * t,
			start.Z + lvz * t
		);
	};
    
	static NearestConnectionToRay = function(ray) {
		var line1 = self;
		var line2 = ray;
        
		var start = line1.start;
		var finish = line1.finish;
		var origin = line2.origin;
		var dir = line2.direction;
        
		var d1x = finish.X - start.X;
		var d1y = finish.Y - start.Y;
		var d1z = finish.Z - start.Z;
		var d2x = dir.X;
		var d2y = dir.Y;
		var d2z = dir.Z;
		var rx = start.X - origin.X;
		var ry = start.Y - origin.Y;
		var rz = start.Z - origin.Z;
        
		var f = dot_product_3d(d2x, d2y, d2z, rx, ry, rz);
		var c = dot_product_3d(d1x, d1y, d1z, rx, ry, rz);
		var b = dot_product_3d(d1x, d1y, d1z, d2y, d2z, d2z);
		var length_squared = dot_product_3d(d1x, d1y, d1z, d1x, d1y, d1z);
        
		// special case if the line segment is actually just
		// two of the same points
		if (length_squared == 0) {
			return new ColLine(start, line2.NearestPoint(start));
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
        
		return new ColLine(
			new Vector3(
				start.X + d1x * f1,
				start.Y + d1y * f1,
				start.Z + d1z * f1
			), new Vector3(
				origin.X + d2x * f2,
				origin.Y + d2y * f2,
				origin.Z + d2z * f2
			)
		);
	};
    
	static NearestConnectionToLine = function(line) {
		var nearest_connection_to_ray = self.NearestConnectionToRay(line.property_ray);
        
		var start = self.start;
		var finish = self.finish;
		var lvx = finish.X - start.X;
		var lvy = finish.Y - start.Y;
		var lvz = finish.Z - start.Z;
		var ldd = dot_product_3d(lvx, lvy, lvz, lvx, lvy, lvz);
        
		var p = nearest_connection_to_ray.start;
		var px = p.X - start.X;
		var py = p.Y - start.Y;
		var pz = p.Z - start.Z;
		var t = clamp(dot_product_3d(px, py, pz, lvx, lvy, lvz) / ldd, 0, 1);
        
		var starting_point = new Vector3(
			start.X + lvx * t,
			start.Y + lvy * t,
			start.Z + lvz * t
		);
        
		var lstart = line.start;
		p = nearest_connection_to_ray.finish;
		px = p.X - lstart.X;
		py = p.Y - lstart.Y;
		pz = p.Z - lstart.Z;
		t = clamp(dot_product_3d(px, py, pz, lvx, lvy, lvz) / ldd, 0, 1);
        
		var ending_point = new Vector3(
			lstart.X + lvx * t,
			lstart.Y + lvy * t,
			lstart.Z + lvz * t
		);
        
		return new Line(starting_point, ending_point);
	};
    
	static GetMin = function() {
		return self.property_min.Clone();
	};
    
	static GetMax = function() {
		return self.property_max.Clone();
	};

		
	static dbug_draw = function(c_line=c_white, size=1, c_ext=c_red) {
		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);

		// Calculate direction vectors for extending the line
		var dir_x = self.finish.X - self.start.X;
		var dir_y = self.finish.Y - self.start.Y;
		var dir_z = self.finish.Z - self.start.Z;

		// Normalize the direction to get the unit vector
		var magnitude = point_distance_3d(self.start.X, self.start.Y, self.start.Z, self.finish.X, self.finish.Y, self.finish.Z);
		var unit_x = dir_x / magnitude;
		var unit_y = dir_y / magnitude;
		var unit_z = dir_z / magnitude;

		// Extend the start and finish points
		var ext_start_x = self.start.X - unit_x * size;
		var ext_start_y = self.start.Y - unit_y * size;
		var ext_start_z = self.start.Z - unit_z * size;

		var ext_finish_x = self.finish.X + unit_x * size;
		var ext_finish_y = self.finish.Y + unit_y * size;
		var ext_finish_z = self.finish.Z + unit_z * size;

		// Add the vertices to the buffer
		vertex_add(vbuff, ext_start_x, ext_start_y, ext_start_z, c_ext);  // Extended start
		vertex_add(vbuff, self.start.X, self.start.Y, self.start.Z, c_black);  // Original start

		vertex_add(vbuff, self.start.X, self.start.Y, self.start.Z, c_line);  // Original start
		vertex_add(vbuff, self.finish.X, self.finish.Y, self.finish.Z, c_line);  // Original finish

		vertex_add(vbuff, self.finish.X, self.finish.Y, self.finish.Z, c_black);  // Original finish
		vertex_add(vbuff, ext_finish_x, ext_finish_y, ext_finish_z, c_ext);  // Extended finish

		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);  // Use pr_linelist to draw the vertices as individual line segments
		vertex_delete_buffer(vbuff);
	}
}