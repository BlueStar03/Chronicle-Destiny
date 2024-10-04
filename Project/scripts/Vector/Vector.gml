function Vector3(x, y = x, z = x) constructor {
    self.X = x;
    self.Y = y;
    self.Z = z;
	
	static Zero = function() { return new Vector3(0); };
	static One = function() { return new Vector3(1); };
	static Infinity = function() { return new Vector3(infinity); };
	static NegativeInfinity = function() { return new Vector3(-infinity); };
	
	static toString = function() {
		return string("({0}, {1}, {2})", self.X, self.Y, self.Z);
	};
	
	static Set = function(x, y, z) {
	    self.X = x;
	    self.Y = y;
	    self.Z = z;
	};
	
	static Clone = function() {
		return new Vector3(self.X, self.Y, self.Z);
	};
	
    static AsLinearArray = function() {
        return [self.X, self.Y, self.Z];
    };
    
    static Add = function(val) {
        if (is_numeric(val)) {
            return new Vector3(self.X + val, self.Y + val, self.Z + val);
        }
        return new Vector3(self.X + val.X, self.Y + val.Y, self.Z + val.Z);
    };
    
    static Sub = function(val) {
        if (is_numeric(val)) {
            return new Vector3(self.X - val, self.Y - val, self.Z - val);
        }
        return new Vector3(self.X - val.X, self.Y - val.Y, self.Z - val.Z);
    };
    
    static Mul = function(val) {
        if (is_numeric(val)) {
            return new Vector3(self.X * val, self.Y * val, self.Z * val);
        }
        return new Vector3(self.X * val.X, self.Y * val.Y, self.Z * val.Z);
    };
    
    static Div = function(val) {
        if (is_numeric(val)) {
            return new Vector3(self.X / val, self.Y / val, self.Z / val);
        }
        return new Vector3(self.X / val.X, self.Y / val.Y, self.Z / val.Z);
    };
    
    static Magnitude = function() {
        return point_distance_3d(0, 0, 0, self.X, self.Y, self.Z);
    };
    
    static DistanceTo = function(val) {
        return point_distance_3d(val.X, val.Y, val.Z, self.X, self.Y, self.Z);
    };
    
    static Dot = function(val) {
        return dot_product_3d(self.X, self.Y, self.Z, val.X, val.Y, val.Z);
    };
    
    static Cross = function(val) {
        return new Vector3(self.Y * val.Z - val.Y * self.Z, self.Z * val.X - val.Z * self.X, self.X * val.Y - val.X * self.Y);
    };
    
    static Equals = function(val) {
        return (self.X == val.X) && (self.Y == val.Y) && (self.Z == val.Z);
    };
    
    static Normalize = function() {
        var mag = point_distance_3d(0, 0, 0, self.X, self.Y, self.Z);
        return new Vector3(self.X / mag, self.Y / mag, self.Z / mag);
    };
    
	static Clamp = function(a, b) {
		if (is_struct(a) || is_struct(b)) {
			return new Vector3(clamp(self.X, a.x, b.x), clamp(self.Y, a.y, b.y), clamp(self.Z, a.z, b.z));
		}
		return new Vector3(clamp(self.X, a, b), clamp(self.Y, a, b), clamp(self.Z, a, b));
	};
    
    static ClampMagnitude = function(magnitude) {
        var d = point_distance_3d(0, 0, 0, self.X, self.Y, self.Z) / magnitude;
        return new Vector3(self.X / d, self.Y / d, self.Z / d);
    };
    
    static Abs = function() {
        return new Vector3(abs(self.X), abs(self.Y), abs(self.Z));
    };
    
    static Frac = function() {
        return new Vector3(abs(self.X), frac(self.Y), frac(self.Z));
    };
    
    static Project = function(direction) {
        var f = dot_product_3d(self.X, self.Y, self.Z, direction.X, direction.Y, direction.Z) / dot_product_3d(direction.X, direction.Y, direction.Z, direction.X, direction.Y, direction.Z);
        return new Vector3(direction.X * f, direction.Y * f, direction.Z * f);
    };
    
    static Min = function(val) {
		if (is_numeric(val)) {
			return new Vector3(min(self.X, val), min(self.Y, val), min(self.Z, val));
		}
        return new Vector3(min(self.X, val.X), min(self.Y, val.Y), min(self.Z, val.Z));
    };
    
    static Max = function(val) {
		if (is_numeric(val)) {
			return new Vector3(max(self.X, val), max(self.Y, val), max(self.Z, val));
		}
        return new Vector3(max(self.X, val.X), max(self.Y, val.Y), max(self.Z, val.Z));
    };
    
    static Floor = function() {
        return new Vector3(floor(self.X), floor(self.Y), floor(self.Z));
    };
    
    static Ceil = function() {
        return new Vector3(ceil(self.X), ceil(self.Y), ceil(self.Z));
    };
    
    static Round = function() {
        return new Vector3(round(self.X), round(self.Y), round(self.Z));
    };
	
	static Lerp = function(target, amount) {
		return new Vector3(lerp(self.X, target.X, amount), lerp(self.Y, target.Y, amount), lerp(self.Z, target.Z, amount));
	};
	
	static Angle = function(vec3) {
		return darccos(dot_product_3d(self.X, self.Y, self.Z, vec3.x, vec3.y, vec3.z) / (point_distance_3d(0, 0, 0, self.X, self.Y, self.Z) * point_distance_3d(0, 0, 0, vec3.x, vec3.y, vec3.z)));
	};
	
	static Approach = function(target, amount) {
        var dist = max(point_distance_3d(target.X, target.Y, target.Z, self.X, self.Y, self.Z) - amount, 0);
        var f = dist / amount;
        
        return new Vector3(
            lerp(self.X, target.X, f),
            lerp(self.Y, target.Y, f),
            lerp(self.Z, target.Z, f)
        );
	};
}