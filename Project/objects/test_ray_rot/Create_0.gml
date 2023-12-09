/// @description 
col=c_blue;
var dir=image_angle
var dx=lengthdir_x(1,dir)
var dy=lengthdir_y(1,dir)
shape=new Ray(new Vector3(x,y,z-16), new Vector3(dx,dy,0));


hit_info=new Ray_Hit_Info()