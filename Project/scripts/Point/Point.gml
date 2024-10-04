function Point(position) constructor{
	self.position=position;				//Vector3
	
	static dbug_draw = function(c_point=c_white) {
		var size=3
		var vbuff = vertex_create_buffer();
		
		vertex_begin(vbuff, v_format);
	
		vertex_add(vbuff, self.position.X+size,	self.position.Y,		self.position.Z,			c_point);
		vertex_add(vbuff, self.position.X-size,	self.position.Y,		self.position.Z,			c_point);
																				
		vertex_add(vbuff, self.position.X,		self.position.Y+size,	self.position.Z,			c_point);
		vertex_add(vbuff, self.position.X,		self.position.Y-size,	self.position.Z,			c_point);
																			
		vertex_add(vbuff, self.position.X,		self.position.Y,		self.position.Z+size,		c_point);
		vertex_add(vbuff, self.position.X,		self.position.Y,		self.position.Z-size,		c_point);
	
		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	};
}

