function Matrix3(x1_or_array, y1, z1, x2, y2, z2, x3, y3, z3) constructor {
	if (is_array(x1_or_array)) {
		var m = x1_or_array;
		self.x = new Vector3(m[0], m[3], m[6]);
		self.y = new Vector3(m[1], m[4], m[7]);
		self.z = new Vector3(m[2], m[5], m[8]);
	} else {
		var x1 = x1_or_array;
		self.x= new Vector3(x1,x2,x3);
		self.y= new Vector3(y1,y2,y3);
		self.z= new Vector3(z1,z2,z3);
	}
	//	x	y	z
	//	x1	y1	z1
	//	x2	y2	z2
	//	x3	y3	z3
	
	static to_linear_array=function(){
		return[
			x.x,	y.x,	z.x,	
			x.y,	y.y,	z.y,	
			x.z,	y.z,	z.z,	
		];
	};
	
	static to_vector_array=function(){
		return [x,y,z];	
	};
	
	static get_rotation_matrix = function() {
		return new Matrix4(
			x.x,	x.y,	x.z,	0,
			y.x,	y.y,	y.z,	0,
			z.x,	z.y,	z.z,	0,
			0,		0,		0,		1
		);
	};
	
}