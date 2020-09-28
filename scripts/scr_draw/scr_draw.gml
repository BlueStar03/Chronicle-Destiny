	//Zune 480,272
	//GBA 240,160
	//GBAw 240,135
	//nhd 640,360
	//HD 1280,720
	//FHD 1920,1080
	
function Display(__width,__height,__scale) constructor{
	width=__width;
	height=__height;
	scale=__scale;
	max_scale=1;
	aspect_ratio=__width/__height;
	
	init_display=function(_width,_height,_scale){
		if _scale=-1{ _scale=scale;}
		var _display_width=display_get_width();
		var _display_height=display_get_height();
		var _aspect_ratio=_display_width/_display_height;
		
		var _platform=global.platform.type;
		
		if _platform!=platform_type.web{
			//makes sure the display height divides neatly into game height
			if (_display_height mod _height != 0){
				var _d=round(_display_height/_height);
				_height=_display_height/_d;
			}
			_width=round(_height*_aspect_ratio);
			if _width & 1{ _width++;}
			if _height &1 {_height++;}
			
			var _max_scale=floor(_display_width/_width);
			if _scale>_max_scale{_scale=_max_scale;}
		}
		if _platform!=platform_type.desktop{_scale=1;_max_scale=1;}
		width=_width;
		height=_height;
		scale=_scale;
		max_scale=_max_scale;
		aspect_ratio=_aspect_ratio;
		
	}
	
	set_resolution=function(){
		surface_resize(application_surface,width*scale,height*scale);
		display_set_gui_size(width,height);
	window_set_size(width*scale,height*scale);
	window_set_fullscreen(false);

	system.alarm[0]=1
		
	}
	
	init_display(width,height,scale);
	set_resolution();
}

function Camera() constructor{
	focus=noone;
	x=0;
	y=0;
	z=100;
	distance=100;
	pitch=90-35.264;
	direction=45;
	
	step=function(){

			direction+= game.input.horizontal_r.current*2;
			//distance += game.input.vertical_r.current;

		if direction>360{direction-=360;}
		if direction<0{direction+=360;}
		if distance<75{distance=75;}
		if distance>500{distance=500;}
	}
	draw=function(){
		draw_clear(c_cornflower);

		shader_set(shd_base);

		var camera = camera_get_active();
		if focus==noone{
			var xto = room_width;
			var yto = room_height;
			var zto = 0;
		}else{			
			var xto = focus.x;
			var yto = focus.y;
			var zto = focus;
		
		var _r=distance;
		var _i=degtorad(pitch);
		var _a=degtorad(direction);
		x=xto+(_r*sin(_i)*cos(_a));
		y=yto+(_r*sin(_i)*sin(_a));
		z=(zto+(_r*cos(_i)));
}

		//var xto = player.x;
		//var yto = player.y;
		//var zto = 0+cam_z_offset;
		var xfrom = x;
		var yfrom = y;
		var zfrom = z;

		view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);
		proj_mat=matrix_build_projection_ortho(game.display.width/2,-game.display.height/2,-1000,1000)
		//proj_mat = matrix_build_projection_perspective_fov(-60, -window_get_width() / window_get_height(), 1, 32000);
		camera_set_view_mat(camera, view_mat);
		camera_set_proj_mat(camera, proj_mat);
		camera_apply(camera);

		vertex_submit(system.model, pr_trianglelist, sprite_get_texture(spr_grid, 0));
		shader_reset();

	}
	
}