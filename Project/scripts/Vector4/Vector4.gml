function Vector4(x, y, z, w) constructor {
    self.x = x;
    self.y = y;
    self.z = z;
    self.w = w;
    
 
    
    static add = function(val) {
        if (is_numeric(val)) {
            return new Vector4(x + val, y + val, z + val, w + val);
        }
        return new Vector4(x + val.x, y + val.y, z + val.z, w + val.w);
    };
    
    static subtract = function(val) {
        if (is_numeric(val)) {
            return new Vector4(x - val, y - val, z - val, w - val);
        }
        return new Vector4(x - val.x, y - val.y, z - val.z, w - val.w);
    };
    
    static multiply = function(val) {
        if (is_numeric(val)) {
            return new Vector4(x * val, y * val, z * val, w * val);
        }
        return new Vector4(x * val.x, y * val.y, z * val.z, w * val.w);
    };
    
    static divide = function(val) {
        if (is_numeric(val)) {
            return new Vector4(x / val, y / val, z / val, w / val);
        }
        return new Vector4(x / val.x, y / val.y, z / val.z, w / val.w);
    };
    
    static magnitude = function() {
        return sqrt(self.dot(self));
    };
    
    static distance_to = function(val) {
        return sqrt(sqrt(x - val.x) + sqr(y - val.y) + sqrt(z - val.z) + sqr(w - val.w));
    };
    
    static dot = function(val) {
        return x * val.x + y * val.y + z * val.z + w * val.w;
    };
    
    static equals = function(val) {
        return (x == val.x) && (y == val.y) && (z == val.z) && (w == val.w);
    };
    
    static normalize = function() {
        var mag = self.magnitude();
        return new Vector4(x / mag, y / mag, z / mag, w / mag);
    };
    
    static absolute = function() {
        return new Vector4(abs(x), abs(y), abs(z), abs(w));
    };
    
    static project = function(direction) {
        var dot = self.dot(direction);
        var mag = direction.magnitude();
        return direction.multiply(dot / (mag * mag));
    };
    
    static minum = function(vec4) {
        return new Vector4(min(x, vec4.x), min(y, vec4.y), min(z, vec4.z), min(w, vec4.w));
    };
    
    static maxum = function(vec4) {
        return new Vector4(max(x, vec4.x), max(y, vec4.y), max(z, vec4.z), max(w, vec4.w));
    };
    
    static floored = function() {
        return new Vector4(floor(x), floor(y), floor(z), floor(w));
    };
    
    static ceiled = function() {
        return new Vector4(ceil(x), ceil(y), ceil(z), ceil(w));
    };
    
    static rounded = function() {
        return new Vector4(round(x), round(y), round(z), round(w));
    };
	
	static to_linear_array = function() {
        return [x, y, z, w];
    };
    
    static get_translation_matrix = function() {
        return new Matrix4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            x, y, z, 1
        );
    };
}