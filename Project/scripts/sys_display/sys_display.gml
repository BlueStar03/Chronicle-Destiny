function Display(w,h,s)constructor{
	width=w;
	height=h;
	scale=s;
	max_scale=1;
	fullscreen=false;
	
	init=function(){
		var _display_width=display_get_width();
		var _display_height=display_get_height();
		aspect_ratio=_display_width/_display_height;
		
		if os_browser==browser_not_a_browser{
			//makes sure the display height divides neatly into game height
			if (_display_height mod height != 0){
				var _d=round(_display_height/height);
				height=_display_height/_d;
			}
			width=round(height*aspect_ratio);
			if width & 1{ width++;}
			if height &1 {height++;}
			
			max_scale=floor(_display_width/width);
			if scale>max_scale{scale=max_scale;}
		}
		if os_browser!=browser_not_a_browser{scale=1;max_scale=1};
		
		
	}
	
	set_resolution=function(){
		surface_resize(application_surface,width,height);
		display_set_gui_size(width,height);
		window_set_size(width*scale,height*scale);
		window_set_fullscreen(false);
		window_center();
	}
	init();
	set_resolution();

}