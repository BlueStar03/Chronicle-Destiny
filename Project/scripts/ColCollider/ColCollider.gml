function ColCollider(shape, reference, mask = 1, group = 1) constructor {
    self.shape = shape;
    self.reference = reference;
    self.mask = mask;                                   // what other objects can collide with me
    self.group = group;                                 // what masks i can detect collisions with
	shape.object = self;
    
    static CheckCollider = function(collider) {
        if (collider == self) return false;
        if ((self.mask & collider.group) == 0) return false;
        return self.shape.CheckCollider(collider);
    };
    
    static CheckRay = function(ray, hit_info, group = 1) {
        if ((self.mask & group) == 0) return false;
        return self.shape.CheckRay(ray, hit_info);
    };
    
    static DisplaceSphere = function(sphere) {
        return self.shape.DisplaceSphere(sphere);
    };
    
    static GetMin = function() {
        return self.shape.point_min;
    };
    
    static GetMax = function() {
        return self.shape.point_max;
    };
		
		
}