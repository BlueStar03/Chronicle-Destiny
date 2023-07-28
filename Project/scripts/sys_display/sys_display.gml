function Display() constructor{
	width=640;
	height=360;
	scale=1;
	ax=-(width/2)*scale;
	ay=-(height/2)*scale;
	init=function(){
		display_set_gui_size(width,height);
		surface_resize(application_surface,width*2,height*2)
		window_set_size(width*scale,height*scale);
		window_center();
	}
	draw=function(){
		gpu_set_blendenable(false);
		draw_surface_ext(application_surface, ax, ay, 1*scale, 1*scale, 0, c_white, 1);
		gpu_set_blendenable(true);	
	}
	init()
}