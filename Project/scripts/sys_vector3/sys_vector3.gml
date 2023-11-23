function Vector3(x,y,z)constructor{
	self.x=x;
	self.y=y;
	self.z=z;
	
	static add = function(val) {
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
	
	static distance_to=function(val){
		return point_distance_3d(val.x, val.y, val.z, self.x, self.y, self.z);	
	}
	
	static dot=function(val){
		return dot_product_3d(self.x, self.y, self.z, val.x, val.y, val.z);	
	}
	
	static cross=function(val){
		return new Vector3(self.y* val.z - val.y *val.z, self.z * val.x - val.z * self.x, self.x * val.y - val.x * self.y)
	}
	
	static equals =function(val) {
		return (self.x==val.x) && (self.y==val.y) &&(self.z==val.z);	
	}	
	static normilize=function(){
		var mag = self.magnitude();
		return new Vector3(self.x/ mag, self.y/ mag, self.z/ mag);
	}
	
	    static Abs = function() {
        return new Vector3(abs(self.x), abs(self.y), abs(self.z));
    };
}