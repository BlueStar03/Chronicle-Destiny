function ColWorldOctree(bounds, depth) constructor {
    self.bounds = bounds;
    self.depth = depth;
    
    self.contents = [];
    self.children = undefined;
    
    static Split = function() {
        var center = self.bounds.position;
        var sides = self.bounds.half_extents.Mul(0.5);
        var sx = sides.x;
        var sy = sides.y;
        var sz = sides.z;
        var d = self.depth - 1;
        
        var cx = center.x;
        var cy = center.y;
        var cz = center.z;
        
        self.children = [
            new ColWorldOctree(new ColAABB(new Vector3(cx - sx, cy + sy, cz - sz), sides), d),
            new ColWorldOctree(new ColAABB(new Vector3(cx + sx, cy + sy, cz - sz), sides), d),
            new ColWorldOctree(new ColAABB(new Vector3(cx - sx, cy + sy, cz + sz), sides), d),
            new ColWorldOctree(new ColAABB(new Vector3(cx + sx, cy + sy, cz + sz), sides), d),
            new ColWorldOctree(new ColAABB(new Vector3(cx - sx, cy - sy, cz - sz), sides), d),
            new ColWorldOctree(new ColAABB(new Vector3(cx + sx, cy - sy, cz - sz), sides), d),
            new ColWorldOctree(new ColAABB(new Vector3(cx - sx, cy - sy, cz + sz), sides), d),
            new ColWorldOctree(new ColAABB(new Vector3(cx + sx, cy - sy, cz + sz), sides), d),
        ];
        
        array_foreach(self.children, method({ contents: self.contents }, function(node) {
            array_foreach (self.contents, method({ node: node }, function(item) {
                self.node.Add(item);
            }));
        }));
    };
    
    static Add = function(object) {
        if (!object.shape.CheckAABB(self.bounds)) return;
        if (array_contains(self.contents, object)) return;
        
        array_push(self.contents, object);
        
        if (self.depth > 0) {
            if (self.children == undefined && array_length(self.contents) >= COL_MIN_TREE_DENSITY) {
                self.Split();
            }
            
            if (self.children != undefined) {
                array_foreach(self.children, method({ object: object }, function(node) {
                    node.Add(self.object);
                }));
            }
        }
    };
    
    static Remove = function(object) {
        var index = array_get_index(self.contents, object);
        if (index != -1) {
            array_delete(self.contents, index, 1);
			if (self.children != undefined) {
	            array_foreach(self.children, method({ object: object }, function(subdivision) {
	                subdivision.Remove(self.object);
	            }));
			}
        }
    };
    
    static CheckObject = function(object) {
        if (!object.shape.CheckAABB(self.bounds)) return;
        
        if (self.children == undefined) {
            var i = 0;
            repeat (array_length(self.contents)) {
                if (self.contents[i].CheckObject(object)) {
                    return self.contents[i];
                }
                i++;
            }
        } else {
            var i = 0;
            repeat (array_length(self.children)) {
                var recursive_result = self.children[i++].CheckObject(object);
                if (recursive_result != undefined) return recursive_result;
            }
        }
        
        return undefined;
    };
    
    static CheckRay = function(ray, hit_info, group = 1) {
        if (!ray.CheckAABB(self.bounds)) return;
        
        var result = false;
        if (self.children == undefined) {
            var i = 0;
            repeat (array_length(self.contents)) {
                if (self.contents[i++].CheckRay(ray, hit_info, group)) {
                    result = true;
                }
            }
        } else {
            var i = 0;
            repeat (array_length(self.children)) {
                if (self.children[i++].CheckRay(ray, hit_info, group)) {
                    result = true;
                }
            }
        }
        
        return result;
    };
    
   /* static GetObjectsInFrustum = function(frustum, output) {
        var status = self.bounds.CheckFrustum(frustum);
        
        if (status == EFrustumResults.OUTSIDE)
            return;
        
        if (status == EFrustumResults.INSIDE || self.children == undefined) {
            var output_length = array_length(output);
            var contents_length = array_length(self.contents);
            array_resize(output, output_length + contents_length);
            array_copy(output, output_length, self.contents, 0, contents_length);
            return;
        }
        
        array_foreach(self.children, method({ frustum: frustum, output: output }, function(node) {
            node.GetObjectsInFrustum(self.frustum, self.output);
        }));
    };*/
}