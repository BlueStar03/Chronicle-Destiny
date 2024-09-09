enum camera_mode {
	none,
	orbit
}

function Camera() constructor {
	mode = camera_mode.none;
	focus = noone;
	from = new Vector3(640/2 ,360*2, -360/2);
	to = new Vector3(640/2 ,360/2,  0);
	up = new Vector3(0 ,0,  1);
	orbit = {dir: 315,distance: 315,elevation: 30};//DIST384,
	dir=point_direction(from.X, from.Y, to.X, to.Y);
	zoom=2
	

	//pro_mat = matrix_build_projection_perspective_fov(60/2, display.get_width() / display.get_height(), 1.0, 32000.0);
	//pro_mat = matrix_build_projection_ortho(display.get_width()/zoom , display.get_height()/zoom, -128,32000);
	
	pro_mat = matrix_build_projection_perspective_fov(60/2,window_get_width()/window_get_height(),1,32000);
	//pro_mat = matrix_build_projection_ortho(display.width/zoom , display.height/zoom, -128,32000);

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
			to.X = focus.X;
			to.Y = focus.Y;
			to.Z = focus.Z;
		}else{focus=noone;}
	}
	update_orbit=function(){
		if (focus==noone){ mode = camera_mode.none; return;}
		if (instance_exists(focus)) {
				to.X = focus.X;
				to.Y = focus.Y;
				to.Z = focus.Z;
			} else {
				focus = noone;
				mode = camera_mode.none;
			}
		orbit.dir = rollover(orbit.dir, 0, 360);
			from.X=to.X+spherecart_x(orbit.distance,degtorad(orbit.elevation+90), degtorad(-orbit.dir));
			from.Y=to.Y+spherecart_y(orbit.distance,degtorad(orbit.elevation+90), degtorad(-orbit.dir));
			from.Z=to.Z+spherecart_z(orbit.distance,degtorad(orbit.elevation+90), degtorad(-orbit.dir));
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
    var dir = point_direction(from.X, from.Y, to.X, to.Y);

    // If snapping is enabled, round the direction to the nearest 45 degrees
    if (snap) {
        dir = round(dir / 45) * 45;
    }

    return rollover(dir, 0, 360); // Ensure the direction is between 0 and 360 degrees
};


	draw = function() {
		draw_clear(c_cornflowerblue); // Clear the screen to black
		var cam = camera_get_active();
		camera_set_view_mat(cam, matrix_build_lookat(from.X, from.Y, from.Z, to.X, to.Y, to.Z, up.X, up.Y, up.Z));
		camera_set_proj_mat(cam, pro_mat);
		camera_apply(cam);
	};
}

//camera_set_proj_mat(cam, matrix_build_projection_perspective_fov(60,window_get_width()/window_get_height(),1,32000))