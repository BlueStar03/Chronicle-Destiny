function Vector3(x,y,z)constructor{
	self.x=x;
	self.y=y;
	self.z=z;
	
	static add = function(val) {
		if (is_numeric(val)){
			return new Vector3(self.x+val,self.y+v,self.z+val);
		}
		return new Vector3(self.x + val.x, self.y + val.y, self.z + val.z);
	}

	static subtract = function(val) {
		return new Vector3(self.x - val.x, self.y - val.y, self.z - val.z);
	}

	static multiply = function(val) {
		if (is_numeric(val)){
			return new Vector3(self.x * val, self.y * val, self.z * val);
		}
		return new Vector3(self.x * val.x, self.y * val.y, self.z * val.z);
	}

	static divide=function(val){
		if (is_numeric(val)){
			return new Vector3(self.x / val, self.y / val, self.z / val);
		}
		return new Vector3(self.x / val.x, self.y / val.y, self.z / val.z);
	}

	static magnitude=function(){
			return point_distance_3d(0,0,0,self.x,self.y,self.z);		
	}

	static distance_to=function(vec3){
		return point_distance_3d(vec3.x, vec3.y, vec3.z, self.x, self.y, self.z);	
	}
	
	static dot=function(vec3){
		return dot_product_3d(self.x, self.y, self.z, vec3.x, vec3.y, vec3.z);	
	}
	
	static cross=function(vec3){
		return new Vector3(self.y* vec3.z - vec3.y *vec3.z, self.z * vec3.x - vec3.z * self.x, self.x * vec3.y - vec3.x * self.y)
	}
	
	static equals =function(vec3) {
		return (self.x==vec3.x) && (self.y==vec3.y) &&(self.z==vec3.z);	
	}

	static normalize=function(){
		var mag = self.magnitude();
		return new Vector3(self.x/ mag, self.y/ mag, self.z/ mag);
	}

	static absolute = function() {
        return new Vector3(abs(self.x), abs(self.y), abs(self.z));
    };

	static project = function(direction) {
		var dot = self.dot(direction);
		var mag = direction.magnitude();
		return direction.multiply(dot / (mag * mag));
	};

	static minum = function(vec3) {
		return new Vector3(min(self.x, vec3.x), min(self.y, vec3.y), min(self.z, vec3.z));
	};

	static maxum = function(vec3) {
		return new Vector3(max(self.x, vec3.x), max(self.y, vec3.y), max(self.z, vec3.z));
	};

	static floored = function() {
		return new Vector3(floor(self.x), floor(self.y), floor(self.z));
	};

	static ceiled = function() {
		return new Vector3(ceil(self.x), ceil(self.y), ceil(self.z));
	};

	static rounded = function() {
		return new Vector3(round(self.x), round(self.y), round(self.z));
	};

	//static get_translation_matrix = function() {
	//	return new Matrix4(
	//		1, 0, 0, 0,
	//		0, 1, 0, 0,
	//		0, 0, 1, 0,
	//		self.x, self.y, self.z, 1
	//	);
	//};
}