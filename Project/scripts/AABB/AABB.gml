function AABB(point_min, point_max, min_max=true) constructor{
	if min_max{
		self.position = point_min.Add(point_max).Div(2);
		self.half_extents = point_max.Sub(point_min).Div(2).Abs();
	}else{
		self.position=point_min;					//Vect3
		self.half_extents=point_max;			//Vect3
	}
	
	
	
	static dbug_draw = function(col=c_white){

		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);
		
		vertex_add(vbuff, self.position.X-1, self.position.Y , self.position.Z ,c_white);
		vertex_add(vbuff, self.position.X+1, self.position.Y , self.position.Z ,c_white);
		vertex_add(vbuff, self.position.X, self.position.Y-1 , self.position.Z ,c_white);
		vertex_add(vbuff, self.position.X, self.position.Y+1 , self.position.Z ,c_white);
		vertex_add(vbuff, self.position.X, self.position.Y , self.position.Z-1 ,c_white);
		vertex_add(vbuff, self.position.X, self.position.Y , self.position.Z+1 ,c_white);

		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
																													
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z - self.half_extents.Z,col);
																															
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X + self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y + self.half_extents.Y, self.position.Z + self.half_extents.Z,col);
		vertex_add(vbuff, self.position.X - self.half_extents.X, self.position.Y - self.half_extents.Y, self.position.Z + self.half_extents.Z,col);

		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	}
	
}
