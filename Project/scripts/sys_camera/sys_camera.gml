// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Camera() constructor{
	focus=noone;
	
	pro_mat=matrix_build_projection_ortho(window_get_width()/2 ,window_get_height()/2 ,-128,32000);
	from={
		x:0,
		y:0,
		z:400,
	}
	to={
		x:640,
		y:360,
		z:0,
	}
	up={
		x:0,
		y:0,
		z:1,
	}
	
	orbit={
		angle:0,
		distance:32,
		elevation:45,
	}
	
	step=function(){
		if instance_exists(focus){
			from.x=focus.x+32;
			from.y=focus.y+32;
			from.z=focus.z-32;
			
			to.x=focus.x;
			to.y=focus.y;
			to.z=focus.z
		}
	}
	draw=function(){
		draw_clear(c_cornflower)
var cam = camera_get_active();
camera_set_view_mat(cam, matrix_build_lookat(from.x, from.y, from.z, to.x, to.y, to.z, up.x, up.y, up.z));
camera_set_proj_mat(cam, pro_mat);
camera_apply(cam);

	}
}