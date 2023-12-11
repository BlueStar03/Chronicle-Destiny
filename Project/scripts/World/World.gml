function World()constructor{
	self.contents = [];
	
	static add = function(collider){
			array_push(self.contents, collider);
	}
	
	static remove = function(collider) {
        var index = array_get_index(self.contents, collider);
        if (index != -1) {
            array_delete(self.contents, index, 1);
		}
	}
	
	static check_collider=function(collider){
		for (var i = 0; i < array_length(self.contents); i++) {
                if (self.contents[i].check_collider(collider)) {
                    return self.contents[i];
                }
            }	return undefined
	}
}
#region spatial hash code
/*
function World(chunk_size) constructor {
    self.chunk_size = chunk_size;
    self.chunks = { };
    
    self.bounds = undefined;
    self.object_record = { };
    
    self.planes = [];
    
    static dbug_draw = function() {
        self.bounds.dbug_draw();
        struct_foreach(self.chunks, function(chunk) {
            self.chunks[$ chunk].dbug_draw();
        });
    };
    
    static hash_function = function(x, y, z) {
        return $"{x},{y},{z}";
    };
    
    static get_bounding_chunk = function(collider) {
        var collider = collider.get_min();
        var collider_max = collider.get_max();
        
        if (object_min == undefined) {
            return undefined;
        }
        return new AABB(
			new Vector3(floor(object_min.x / self.chunk_size), floor(object_min.y / self.chunk_size), floor(object_min.z / self.chunk_size)),
            new Vector3(floor(object_max.x / self.chunk_size), floor(object_max.y / self.chunk_size), floor(object_max.z / self.chunk_size))
       
		) 
		
        //return NewColAABBFromMinMax(
        //    new Vector3(floor(object_min.x / self.chunk_size), floor(object_min.y / self.chunk_size), floor(object_min.z / self.chunk_size)),
        //    new Vector3(floor(object_max.x / self.chunk_size), floor(object_max.y / self.chunk_size), floor(object_max.z / self.chunk_size))
        //);
    };
    
    static get_chunk = function(x, y, z) {
        return self.chunks[$ self.hash_function(x, y, z)];
    };
    
    static add_chunk = function(x, y, z, chunk) {
        self.chunks[$ self.hash_function(x, y, z)] = chunk;
    };
    
    static remove_chunk = function(x, y, z) {
        variable_struct_remove(self.chunks, self.hash_function(x, y, z));
    };
    
    static contains = function(collider) {
        return self.collider_record[$ string(ptr(collider))];
    };
    
    static add = function(collider) {
        var bounds = self.get_bounding_chunk(collider);
        
        if (bounds == undefined) {
            if (array_get_index(self.planes, collider) == -1) {
                array_push(self.planes, collider);
            }
            return;
        }
        
        var bounds_min = bounds.get_min();
        var bounds_max = bounds.get_max();
        
        // is the collider already in the spatial hash?
        var location = self.contains(collider);
        if (location != undefined) {
            if (location.get_min().equals(bounds_min) && location.get_max().equals(bounds_max)) {
                // collider's position is the same, there's no point
                return;
            } else {
                self.remove(collider);
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
                        
                        var chunk_bounds = new AABB(coords_min, coords_max);
                        chunk = new ColSpatialHashNode(chunk_bounds);
                        self.add_chunk(i, j, k, chunk);
                        
                        if (self.bounds == undefined) {
                            self.bounds = new AABB(coords_min, coords_max);
                        } else {
                            self.bounds = new AABB(
                                self.bounds.get_min().minum(coords_min),
                                self.bounds.get_max().maxum(coords_max)
                            );
                        }
                    }
                    
                    chunk.add(collider);
                    
                    var object_id = string(ptr(collider));
                    self.collider_record[$ object_id] = bounds;
                }
            }
        }
    };
    
    static remove = function(collider) {
        var plane_index = array_get_index(self.planes, collider);
        if (plane_index != -1) {
            array_delete(self.planes, plane_index, 1);
            return;
        }
        
        var location = self.Contains(collider);
        if (location == undefined) {
            return;
        }
        
        var bounds_min = location.get_min();
        var bounds_max = location.get_max();
        
        for (var i = bounds_min.x; i <= bounds_max.x; i++) {
            for (var j = bounds_min.y; j <= bounds_max.y; j++) {
                for (var k = bounds_min.z; k <= bounds_max.z; k++) {
                    var chunk = self.get_chunk(i, j, k);
                    chunk.remove(collider);
                    
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
        
        var collider_id = string(ptr(collider));
        variable_struct_remove(self.collider_record, collider_id);
    };
    
    static check_collider = function(collider) {
        for (var i = 0; i < array_length(self.planes); i++) {
            if (self.planes[i].check_collider(collider))
                return true;
        }
        
        var bounds = self.get_bounding_chunk(collider);
        var bounds_min = bounds.get_min();
        var bounds_max = bounds.get_max();
        
        for (var i = bounds_min.x; i <= bounds_max.x; i++) {
            for (var j = bounds_min.y; j <= bounds_max.y; j++) {
                for (var k = bounds_min.z; k <= bounds_max.z; k++) {
                    var chunk = self.get_chunk(i, j, k);
                    
                    if (chunk != undefined) {
                        var result = chunk.check_collider(collider);
                        if (result != undefined) return result;
                    }
                }
            }
        }
        
        return undefined;
    };
    
    // https://github.com/prime31/Nez/blob/master/Nez.Portable/Physics/SpatialHash.cs
    static check_ray = function(ray, group = 1) {
        var hit_info = new RaycastHitInformation();
        
        for (var i = 0; i < array_length(self.planes); i++) {
            self.planes[i].check_ray(ray, hit_info, group);
        }
        
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
        
        var lookahead_x = (ray.direction.x != 0) ? floor(self.chunk_size / (ray.direction.x * dx)) : infinity;
        var lookahead_y = (ray.direction.y != 0) ? floor(self.chunk_size / (ray.direction.y * dy)) : infinity;
        var lookahead_z = (ray.direction.z != 0) ? floor(self.chunk_size / (ray.direction.z * dz)) : infinity;
        
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
    };
    
    //static DisplaceSphere = function(sphere_object, attempts = 5) {
    //    var current_position = sphere_object.shape.position;
        
    //    repeat (attempts) {
    //        var collided_with = self.check_collider(sphere_object);
    //        if (collided_with == undefined) break;
            
    //        var displaced_position = collided_with.DisplaceSphere(sphere_object.shape);
    //        if (displaced_position == undefined) break;
            
    //        sphere_object.shape.position = displaced_position;
    //    }
        
    //    var displaced_position = sphere_object.shape.position;
    //    sphere_object.shape.position = current_position;
        
    //    if (current_position == displaced_position) return undefined;
        
    //    return displaced_position;
    //};
}

function ColSpatialHashNode(bounds) constructor {
    self.bounds = bounds;
    self.objects = [];
    
    static DebugDraw = function() {
        self.bounds.DebugDraw();
        /*array_foreach(self.objects, function(collider) {
            if (collider.shape[$ "DebugDraw"])
                collider.shape.DebugDraw();
        });*//*
    };
    
    static Add = function(collider) {
        array_push(self.objects, collider);
    };
    
    static Remove = function(collider) {
        var index = array_get_index(self.objects, collider);
        array_delete(self.objects, index, 1);
    };
    
    static Size = function() {
        return array_length(self.objects);
    };
    
    static check_collider = function(collider) {
        for (var i = 0; i < array_length(self.objects); i++) {
            if (self.objects[i].check_collider(collider))
                return self.colliders[i];
        }
        return undefined;
    };
    
    static check_ray = function(ray, hit_info, group = 1) {
        var hit_detected = false;
        for (var i = 0; i < array_length(self.objects); i++) {
            if (self.objects[i].check_ray(ray, hit_info, group))
                hit_detected = true;
        }
        return hit_detected;
    };
}
*/

#endregion