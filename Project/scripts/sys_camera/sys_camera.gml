function Camera()constructor{
	focus=noone
	from={
		x:0,
		y:0,
		z:64,
	}
	to={
		x:640,
		y:360,
		z:0,
	}
	up={
		x:0,
		y:0,
		z:-1,
	}
	polar={
		angle:90,
		inclination:45,//35.264,
		distance:128,
	}
	step=function(){
		if instance_exists(player){
			from.x=player.x;
			from.y=player.y-64
			to.x=player.x;
			to.y=player.y;
		}		
		rollover(polar.angle,0,360);
		if mode=="orbit"{
			if instance_exists(focus){
				to.x=focus.x;
				to.y=focus.y;
				to.z=focus.z;
			}
			var distance=polar.distance;
			var angle=degtorad(-polar.angle);
			var inclination=degtorad(polar.inclination+90)
			from.x=to.x+(distance*sin(inclination)*cos(angle));
			from.y=to.y+(distance*sin(inclination)*sin(angle));
			from.z=to.z+(distance*cos(inclination));
		}
	}
	draw=function(){
		var cam = camera_get_active();
		projmat= matrix_build_projection_perspective_fov(60, window_get_width() / window_get_height(), 1, 320000)
		projmatortho= matrix_build_projection_ortho( display.width , display.height, -128, 320000)
		var p=os_browser!=browser_not_a_browser?projmat:projmatortho;
		
		
		camera_set_view_mat(cam, matrix_build_lookat(from.x, from.y, -from.z, to.x, to.y, -to.z, up.x, up.y, up.z));
		camera_set_proj_mat(cam,p);
		camera_apply(cam);
	}

}