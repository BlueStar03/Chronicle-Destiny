// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Camera() constructor{
	cam=camera_create();
	mode="none"
	focus=noone;
	snap=true;
	snap_sign=0;
	type="ortho"
	
	pro_mat_orthographic=matrix_build_projection_ortho(display.width/2 ,display.height/2 ,-128,32000);
	pro_mat_perspective=matrix_build_projection_perspective_fov(60, display.width/display.height,1,32000);
	pro_mat=pro_mat_orthographic
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
		dir:270+45,
		distance:128+64,
		elevation:30,
	}
	
	step=function(){
		if mode=="orbit"{
			
			var rot=input.joy_right.horizontal.current;
			orbit.dir+=rot
			orbit.dir=round(orbit.dir)
			if snap{
				if rot==0{
					
					var _c=orbit.dir
					var _a=0
					if (_c mod 45 != 0) {
							if (_c % 45 > 22.5) {
								_a += 1;
							} else {
								_a -= 1;
							}
					orbit.dir+=_a
					}
				}
			}else{
				if sign(rot)==0{
					if (orbit.dir mod 45 != 0) {
						orbit.dir+=snap_sign
					}
				}else{
					snap_sign=sign(rot)	
				}
			}
			
			
			orbit.dir=rollover(orbit.dir,0,360);
			if instance_exists(focus){
				to.x=focus.x;
				to.y=focus.y;
				to.z=focus.z;
			}
			var distance=orbit.distance;
			var dir=degtorad(-orbit.dir);
			var elevation=degtorad(orbit.elevation+90)
			from.x=to.x+(distance*sin(elevation)*cos(dir));
			from.y=to.y+(distance*sin(elevation)*sin(dir));
			from.z=to.z+(distance*cos(elevation));			
		}
	}
	
	
	draw=function(){
		draw_clear(c_cornflower)
		cam = camera_get_active();
		camera_set_view_mat(cam, matrix_build_lookat(from.x, from.y, from.z, to.x, to.y, to.z, up.x, up.y, up.z));
		camera_set_proj_mat(cam, pro_mat);
		camera_apply(cam);
	}
}