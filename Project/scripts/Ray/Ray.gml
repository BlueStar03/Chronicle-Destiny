///@function Ray(origin, direction)
///@description What it does
///@param origin {real} what it is
///@param direction {real} what it is

function Ray(origin, direction) constructor{
	self.origin=origin;														//Vect3
	self.direction=direction;														//Vect3
	
		static dbug_draw = function(col=c_white){
		var size=1;
		var neo=self.origin.Add(direction.Normalize().Mul(64));
		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);
		
		vertex_add(vbuff, self.origin.X+size,	self.origin.Y,		self.origin.Z,			c_white);
		vertex_add(vbuff, self.origin.X-size,	self.origin.Y,		self.origin.Z,			c_white);
																								
		vertex_add(vbuff, self.origin.X,		self.origin.Y+size,	self.origin.Z,			c_white);
		vertex_add(vbuff, self.origin.X,		self.origin.Y-size,	self.origin.Z,			c_white);
																								
		vertex_add(vbuff, self.origin.X,		self.origin.Y,		self.origin.Z+size,		c_white);
		vertex_add(vbuff, self.origin.X,		self.origin.Y,		self.origin.Z-size,		c_white);
		
		
		vertex_add(vbuff, self.origin.X,		self.origin.Y,		self.origin.Z,		col);
		vertex_add(vbuff, neo.X,		neo.Y,		neo.Z,		col,0);
		
	
		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	}
	
}

function Ray_Hit_Info() constructor {
	self.shape = undefined;
	self.point = undefined;
	self.distance = infinity;
	self.normal = undefined;

	static update = function(distance, shape, point, normal){
		if (distance < self.distance){
			self.distance = distance;
			self.shape = shape;
			self.point = point;
			self.normal = normal;
		}
	}

	static clear = function(){
		self.shape = undefined;
		self.point = undefined;
		self.distance = infinity;
		self.normal = undefined;
	}
	dbug_draw(){
		self.point.dbug_draw()	
	}
}

