function Matrix4(x1_or_array, y1, z1, w1, x2, y2, z2, w2, x3, y3, z3, w3, x4, y4, z4, w4) constructor {
	if (is_array(x1_or_array)) {
		var m = x1_or_array;
		self.x = new Vector4(m[ 0], m[ 4], m[ 8], m[12]);
		self.y = new Vector4(m[ 1], m[ 5], m[ 9], m[13]);
		self.z = new Vector4(m[ 2], m[ 6], m[10], m[14]);
		self.w = new Vector4(m[ 3], m[ 7], m[11], m[15]);	
	}else{
		var x1=x1_or_array
		self.x= new Vector4(x1,x2,x3,x4);
		self.y= new Vector4(y1,y2,y3,y4);
		self.z= new Vector4(z1,z2,z3,z4);
		self.w= new Vector4(w1,w2,w3,w4);
	}

	
	//	x	y	z	w
	//	x1	y1	z1	w1
	//	x2	y2	z2	w2
	//	x3	y3	z3	w3
	//	x4	y4	z4	w4
	
	static to_linear_array=function(){
		return[
			x.x,	y.x,	z.x,	w.x,
			x.y,	y.y,	z.y,	w.y,
			x.z,	y.z,	z.z,	w.z,
			x.w,	y.w,	z.w,	w.w
		];
	}
	
	static to_vector_array=function(){
		return [x,y,z,w];	
	}
	
	static get_orientation_matrix = function() {
		return new Matrix3(
			x.x,	x.y,	x.z,
			y.x,	y.y,	y.z,
			z.x,	z.y,	z.z
		);
	};
}