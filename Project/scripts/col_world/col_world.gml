///@function function_name(x,[c_str])
///@description What it does
///@param x {real} what it is

function col_world(chunk_size) constructor{
	self.chunk_size=chunk_size;
	self.chunk={ };
	
	self.bounds=undefined;
	self.shape_record={ };
	
	static dbug_draw = function(){
		self.bounds.dbug_draw();
		struct_foreach(self.chunks,function(chunk){
			self.chunks[$ chunk].dbug_draw();
		});
	}
	
	static hash_function = function (x,y,z){
		return $"{x},{y},{z}";
	}
	
	static get_bounding_chunk= function(shape){
		var shape_min = shape.get_min();
        var shape_max = shape.get_max();
        
        if (shape_min == undefined) {
            return undefined;
        }
        
        return new AABB(
            new Vector3(floored(shape_min.x / self.chunk_size), floored(shape_min.y / self.chunk_size), floored(shape_min.z / self.chunk_size)),
            new Vector3(floored(shape_max.x / self.chunk_size), floored(shape_max.y / self.chunk_size), floored(shape_max.z / self.chunk_size)),
			true
        );
	}
	
	static get_chunk=function(x,y,z){
		return self.chunks[$ self.hash_function(x, y, z)];
	}
	
	static add_chunk = function(x, y, z, chunk) {
		self.chunks[$ self.hash_function(x, y, z)] = chunk;
	};
    
	static remove_chunk = function(x, y, z) {
		variable_struct_remove(self.chunks, self.hash_function(x, y, z));
	};
	
	static contains = function(shape) {
        return self.shape_record[$ string(ptr(shape))];
    };
	
	static add= function(shape){
		var bounds = self.get_bounding_chunk(shape);

		if (bounds == undefined) {
			return;
		}

		var bounds_min = bounds.get_min();
		var bounds_max = bounds.get_max();
		
		// is the shape already in the spatial hash?
		var location = self.contains(shape);
		if (location != undefined) {
			if (location.get_min().equals(bounds_min) && location.get_max().equals(bounds_max)) {
				// shape's position is the same, there's no point
				return;
			} else {
				self.remove(shape);
			}
		}

		for (var i = bounds_min.x; i <= bounds_max.x; i++) {
			for (var j = bounds_min.y; j <= bounds_max.y; j++) {
				for (var k = bounds_min.z; k <= bounds_max.z; k++) {
					var chunk = self.get_chunk(i, j, k);

					if (chunk == undefined) {
						var coords = new Vector3(i, j, k);
						var coords_min = coords.multiply(self.chunk_size);
						var coords_max = coords.multiply(self.chunk_size).add(self.chunk_size);

						var chunk_bounds = new AABB(coords_min, coords_max,true);
						chunk = new Col_Node(chunk_bounds);
						self.add_chunk(i, j, k, chunk);

						if (self.bounds == undefined) {
							self.bounds = new AABB(coords_min, coords_max, true);
						} else {
							self.bounds = new AABB(
								self.bounds.get_min().minum(coords_min),
								self.bounds.get_max().maxum(coords_max), true
							);
						}
					}

					chunk.add(shape);

					var shape_id = string(ptr(shape));
					self.shape_record[$ shape_id] = bounds;
				}
			}
		}
	}
	
	static remove= function(shape){
		//var plane_index = array_get_index(self.planes, shape);
        //if (plane_index != -1) {
        //    array_delete(self.planes, plane_index, 1);
        //    return;
        //}
        
		var location = self.contains(shape);
		if (location == undefined) {
			return;
		}

		var bounds_min = location.get_min();
		var bounds_max = location.get_max();

		for (var i = bounds_min.x; i <= bounds_max.x; i++) {
			for (var j = bounds_min.y; j <= bounds_max.y; j++) {
				for (var k = bounds_min.z; k <= bounds_max.z; k++) {
					var chunk = self.get_chunk(i, j, k);
					chunk.remove(shape);

					if (chunk.size() == 0) {
						self.remove_chunk(i, j, k);

						// you may want to resize the bounds of the spatial hash
						// after removing an empty chunk, but i dont know if a nice
						// way to do that besides looping over every chunk from
						// scratch so I won't be doing that here
					}
				}
			}
		}

		var shape_id = string(ptr(shape));
		variable_struct_remove(self.shape_record, shape_id);
	}
	
	static check_shape= function(shape){
        //for (var i = 0; i < array_length(self.planes); i++) {
        //    if (self.planes[i].CheckObject(object))
        //        return true;
        //}

		var bounds = self.get_bounding_chunk(object);
		var bounds_min = bounds.get_min();
		var bounds_max = bounds.get_max();

		for (var i = bounds_min.x; i <= bounds_max.x; i++) {
			for (var j = bounds_min.y; j <= bounds_max.y; j++) {
				for (var k = bounds_min.z; k <= bounds_max.z; k++) {
					var chunk = self.get_chunk(i, j, k);

					if (chunk != undefined) {
						var result = chunk.check_shape(shape);
						if (result != undefined) return result;
					}
				}
			}
		}

		return undefined;
	}
	
	static check_ray= function(ray, group = 1){//------------------------------------------
        //var hit_info = new RaycastHitInformation();
        
        //for (var i = 0; i < array_length(self.planes); i++) {
        //    self.planes[i].check_ray(ray, hit_info, group);
        //}
        
		var bounds_hit_info = new RaycastHitInformation();
		self.bounds.check_ray(ray, bounds_hit_info);
        
        // if the ray does not pass through the spatial hash at all, you can
        // exit early
		if (bounds_hit_info.point == undefined) {
			if (hit_info.point == undefined) {
				return undefined;
			} else {
				return hit_info;
			}
		}

		var current_cell = ray.origin.divide(self.chunk_size).floored();

		var chunk = self.get_chunk(current_cell.x, current_cell.y, current_cell.z);
		if (chunk != undefined) {
			if (chunk.check_ray(ray, hit_info, group)) {
				return hit_info;
			}
		}

		var last_cell = bounds_hit_info.point.divide(self.chunk_size).floored();

		var dx = sign(ray.direction.x);
		var dy = sign(ray.direction.y);
		var dz = sign(ray.direction.z);
        
		if (current_cell.x == last_cell.x) dx = 0;
		if (current_cell.y == last_cell.y) dy = 0;
		if (current_cell.z == last_cell.z) dz = 0;
        
		var step_x = max(dx, 0);
		var step_y = max(dy, 0);
		var step_z = max(dz, 0);
		var next_boundary_x = (current_cell.x + step_x) * self.chunk_size;
		var next_boundary_y = (current_cell.y + step_y) * self.chunk_size;
		var next_boundary_z = (current_cell.z + step_z) * self.chunk_size;
        
		var max_x = (ray.direction.x != 0) ? ((next_boundary_x - ray.origin.x) / ray.direction.x) : infinity;
		var max_y = (ray.direction.y != 0) ? ((next_boundary_y - ray.origin.y) / ray.direction.y) : infinity;
		var max_z = (ray.direction.z != 0) ? ((next_boundary_z - ray.origin.z) / ray.direction.z) : infinity;
        
		var lookahead_x = (ray.direction.x != 0) ? floored(self.chunk_size / (ray.direction.x * dx)) : infinity;
		var lookahead_y = (ray.direction.y != 0) ? floored(self.chunk_size / (ray.direction.y * dy)) : infinity;
		var lookahead_z = (ray.direction.z != 0) ? floored(self.chunk_size / (ray.direction.z * dz)) : infinity;
        
		do {
			if (max_x < max_y) {
				if (max_x < max_z) {
					current_cell.x += dx;
					max_x += lookahead_x;
				} else {
					current_cell.z += dz;
					max_z += lookahead_z;
				}
			} else {
				if (max_y < max_z) {
					current_cell.y += dy;
					max_y += lookahead_y;
				} else {
					current_cell.z += dz;
					max_z += lookahead_z;
				}
			}

			chunk = self.get_chunk(current_cell.x, current_cell.y, current_cell.z);
			if (chunk != undefined) {
				if (chunk.check_ray(ray, hit_info, group)) {
					return hit_info;
				}
			}
		} until(current_cell.equals(last_cell));

		if (hit_info.point == undefined) {
			return undefined;
		}

		return hit_info;
	}
}
function Col_Node(bounds) constructor{
	self.bounds=bounds;
	self.shapes=[ ];

	static dbug_draw = function(){
		self.bounds.dbug_draw();
		array_foreach(self.shapes,function(shape){
			if (shape.shape[$ "dbug_draw"])
				shape.shape.dbug_draw();
		});
	};

	static add= function(shape){
		array_push(self.shapes, shape);
	};

	static remove= function(shape){
		var index=array_get_index(self.shapes,shape);
		array_delete(self.shapes, index, 1);
	};

	static size = function() {
		return array_length(self.shapes);
	};


	static check_shape= function(shape) {
		for (var i = 0; i < array_length(self.shapes); i++) {
			if (self.shapes[i].check_shape(shape))
				return self.shapes[i];
		}
		return undefined;
	};
	
	static check_ray= function(ray, hit_info, group=1){
		var hit_detected=false;
		for (var i = 0; i < array_length(self.shapes); i++) {
            if (self.shapes[i].check_ray(ray, hit_info, group))
                hit_detected = true;
        }
        return hit_detected;
	}
}