enum camera_mode {
	none,
	orbit
}

function Camera() constructor {
	mode = camera_mode.none;
	focus = noone;
<<<<<<< HEAD:Project/scripts/Camera/Camera.gml
	from = {x:640/2 ,y:360*2, z: -360/2};
	to = {x:640/2 ,y:360/2, z: 0};
	up = {x:0 ,y:0, z: 1};
=======
	from = new Vector3(640/2 ,360*2, -360/2);
	to = new Vector3(640/2 ,360/2,  0);
	up = new Vector3(0 ,0,  1);
>>>>>>> parent of d5c9fa5 (collisions wip):Project/scripts/sys_camera/sys_camera.gml
	orbit = {dir: 315,distance: 315,elevation: 30};//DIST384,
	dir=point_direction(from.x, from.y, to.x, to.y);
	zoom=2
	


	//pro_mat = matrix_build_projection_perspective_fov(60/2, display.get_width() / display.get_height(), 1.0, 32000.0);
	//pro_mat = matrix_build_projection_ortho(display.get_width()/zoom , display.get_height()/zoom, -128,32000);
	
	pro_mat = matrix_build_projection_perspective_fov(60/2,window_get_width()/window_get_height(),1,32000);
<<<<<<< HEAD:Project/scripts/Camera/Camera.gml
	//pro_mat = matrix_build_projection_ortho((display.width*display.s_scale)/zoom , (display.height*display.s_scale)/zoom, -128,32000);
=======
	//pro_mat = matrix_build_projection_ortho(display.width/zoom , display.height/zoom, -128,32000);
>>>>>>> parent of d5c9fa5 (collisions wip):Project/scripts/sys_camera/sys_camera.gml

	static snap = true;
	

	update = function() {
		switch mode{
			case camera_mode.none:
				update_none();break;
			case camera_mode.orbit:
				update_orbit();break;
		}
		dir=get_direction();
		
  };
	update_none=function(){
		if (focus==noone){return;}
		if (instance_exists(focus)) {
			to.x = focus.x;
			to.y = focus.y;
			to.z = focus.z;
		}else{focus=noone;}
	}
	update_orbit=function(){
		if (focus==noone){ mode = camera_mode.none; return;}
		if (instance_exists(focus)) {
				to.x = focus.x;
				to.y = focus.y;
				to.z = focus.z;
			} else {
				focus = noone;
				mode = camera_mode.none;
			}
		orbit.dir = rollover(orbit.dir, 0, 360);
			from.x=to.x+spherecart_x(orbit.distance,degtorad(orbit.elevation+90), degtorad(-orbit.dir));
			from.y=to.y+spherecart_y(orbit.distance,degtorad(orbit.elevation+90), degtorad(-orbit.dir));
			from.z=to.z+spherecart_z(orbit.distance,degtorad(orbit.elevation+90), degtorad(-orbit.dir));
		}
	rotate_orbit=function(val){
		static snap_sign = 0;
		var rot = val;
		if abs(rot)>0.001{
			orbit.dir += rot;
		}else{
			if (orbit.dir mod 45 != 0){
				if snap{
					if (orbit.dir % 45 > 22.5) {snap_sign = +1;} else {snap_sign = -1;}
				}
				orbit.dir += snap_sign;
			}else{ 
				snap_sign = sign(rot);
			}	
		}
		orbit.dir = rollover(orbit.dir, 0, 360);
		orbit.dir = round(orbit.dir);
	}
	
get_direction = function(snap = false) {
    // Calculate the direction from 'from' to 'to' in the XY plane
    var dir = point_direction(from.x, from.y, to.x, to.y);

    // If snapping is enabled, round the direction to the nearest 45 degrees
    if (snap) {
        dir = round(dir / 45) * 45;
    }

    return rollover(dir, 0, 360); // Ensure the direction is between 0 and 360 degrees
};


	draw = function() {
		draw_clear(c_cornflowerblue); // Clear the screen to black
		var cam = camera_get_active();
		camera_set_view_mat(cam, matrix_build_lookat(from.x, from.y, from.z, to.x, to.y, to.z, up.x, up.y, up.z));
		camera_set_proj_mat(cam, pro_mat);
		camera_apply(cam);
	};
}

//camera_set_proj_mat(cam, matrix_build_projection_perspective_fov(60,window_get_width()/window_get_height(),1,32000))