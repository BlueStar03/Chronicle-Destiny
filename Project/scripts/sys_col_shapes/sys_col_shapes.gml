function col_point(position) constructor{
	self.position=position;														//Vect3
}

function col_sphere(position, radius) constructor{
	self.position=position;														//Vect3
	self.radius=radius;														//Vect3
}

function col_aabb(position, half_extents) constructor{
	self.position=position;														//Vect3
	self.half_extents=half_extents														//Vect3
}

function col_plane(normal, distance) constructor{
	self.normal=normal;														//Vect3
	self.distance=distance;														//number
}

function col_ray(origin, direction) constructor{
	self.origin=origin;														//Vect3
	self.direction=direction;														//Vect3
}

function col_line(start, finish) constructor{
	self.start=start;														//Vect3
	self.finish=finish;														//Vect3
}

