/// @func Vector3([x],[ y],[ z])
///
/// @desc A 3D vector.
///
/// @param {Real} [x] The x component. Defaults to 0.
/// @param {Real} [y] The y component. Defaults to first argument.
/// @param {Real} [z] The z component. Defaults to first argument.
function Vector3(x=0,y=x,z=x)constructor{
	self.x=x;
	self.y=y;
	self.z=z;
	
	static add = function(val) {
		if (is_numeric(val)){
			return new Vector3(x+val,y+val,z+val);
		}
		return new Vector3(x + val.x, y + val.y, z + val.z);
	}

	static subtract = function(val) {
		return new Vector3(x - val.x, y - val.y, z - val.z);
	}

	static multiply = function(val) {
		if (is_numeric(val)){
			return new Vector3(x * val, y * val, z * val);
		}
		return new Vector3(x * val.x, y * val.y, z * val.z);
	}

	static divide=function(val){
		if (is_numeric(val)){
			return new Vector3(x / val, y / val, z / val);
		}
		return new Vector3(x / val.x, y / val.y, z / val.z);
	}

	static magnitude=function(){
			return point_distance_3d(0,0,0,x,y,z);		
	}

	static distance_to=function(vec3){
		return point_distance_3d(vec3.x, vec3.y, vec3.z, x, y, z);	
	}
	
	static dot=function(vec3){
		return dot_product_3d(x, y, z, vec3.x, vec3.y, vec3.z);	
	}
	
	static cross=function(val){
		return new Vector3(y* val.z - val.y *z, z * val.x - val.z * x, x * val.y - val.x * y)
	}
	
	static equals =function(vec3) {
		return (x==vec3.x) && (y==vec3.y) &&(z==vec3.z);	
	}

	static normalize=function(){
		var mag = magnitude();
		return new Vector3(x/ mag, y/ mag, z/ mag);
	}

	static absolute = function() {
        return new Vector3(abs(x), abs(y), abs(z));
    };

	static project = function(direction) {
		var dot = dot(direction);
		var mag = direction.magnitude();
		return direction.multiply(dot / (mag * mag));
	};

	static minum = function(vec3) {
		return new Vector3(min(x, vec3.x), min(y, vec3.y), min(z, vec3.z));
	};

	static maxum = function(vec3) {
		return new Vector3(max(x, vec3.x), max(y, vec3.y), max(z, vec3.z));
	};

	static floored = function() {
		return new Vector3(floor(x), floor(y), floor(z));
	};

	static ceiled = function() {
		return new Vector3(ceil(x), ceil(y), ceil(z));
	};

	static rounded = function() {
		return new Vector3(round(x), round(y), round(z));
	};

	static to_linear_array = function() {
        return [x, y, z];
    };
	
	static get_translation_matrix = function() {
        return new Matrix4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            self.x, self.y, self.z, 1
        );
    };
	


}