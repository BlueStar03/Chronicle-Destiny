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
	step=function(){
		if instance_exists(player){
			from.x=player.x;
			from.y=player.y-64
			to.x=player.x;
			to.y=player.y;
		}		
	}
	draw=function(){
		var cam = camera_get_active();
		camera_set_view_mat(cam, matrix_build_lookat(from.x, from.y, from.z, to.x, to.y, to.z, up.x, up.y, up.z));
		camera_set_proj_mat(cam, matrix_build_projection_perspective_fov(60, window_get_width() / window_get_height(), 1, 32000));
		camera_apply(cam);
	}

}