// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Camera() constructor{
	mode="none";
	focus=noone;

	pro_mat=matrix_build_projection_ortho(window_get_width()/2 ,window_get_height()/2 ,-64,32000);
	
	from={
		x:0,
		y:-64,
		z:-64,
	}
	to={
		x:100,
		y:100,
		z:0,
	}
	up={
		x:0,
		y:0,
		z:1,
	}
	polar={
		orientation:270+45,
		elevation:90-30,//35.264,
		distance:128,
	}
	step=function(){
		if mode=="none"{
			if instance_exists(focus){
				from.x=focus.x;
				from.y=focus.y-64;
				from.z=focus.z+64;
			
				to.x=focus.x;
				to.y=focus.y;
				to.z=focus.z;
			}
		}
		if mode=="orbit"{
			if instance_exists(focus){
				to.x=focus.x;
				to.y=focus.y;
				to.z=focus.z;
			}
			var distance=polar.distance;
			var orientation=degtorad(-polar.orientation);
			var elevation=degtorad(polar.elevation)
			from.x=to.x+(distance*sin(elevation)*cos(orientation));
			from.y=to.y+(distance*sin(elevation)*sin(orientation));
			from.z=to.z+(distance*cos(elevation));
		}
		orientation=rollover(orientation,0,360)
	}
	draw=function(){

		var cam = camera_get_active();
camera_set_view_mat(cam, matrix_build_lookat(from.x, from.y, -from.z, to.x, to.y, -to.z, up.x, up.y, up.z));
camera_set_proj_mat(cam, pro_mat);
camera_apply(cam);


	}
}