/// @description 
col=c_blue
var dir=image_angle
var dx=lengthdir_x(sprite_width/2,dir)
var dy=lengthdir_y(sprite_width/2,dir)
var w=sprite_width
collider=new Collider(new Line(new Vector3(x-dx,y-dy,z-16), new Vector3(x+dx,y+dy,z-16)),self)



