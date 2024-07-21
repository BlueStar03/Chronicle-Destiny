// @function				is_same(foo, [bar])
/// @desc					check is same.
/// @arg	{real}			foo			Check.
/// @arg	{string}		[bar]		Same.
/// @return {bool}
function Display(width=640,height=360,scale=1) constructor{
	self.width=width;
	self.height=height;
	self.scale=scale;
	max_scale=1;
	
	static init=function(){
		var display_width=display_get_width();
		var display_height=display_get_height();
		var aspect_ratio=display_width/display_height;
		if os_browser==browser_not_a_browser{
			if (display_height mod height!=0){
				var d=round(display_height/height);
				height=display_height/d;
			}
			width=round(height*aspect_ratio);
			if width & 1{width++;}
			if height & 1{height++;}
			
			max_scale=floor(display_width/width);
			if scale>max_scale{scale=max_scale;}
		}else{
			scale=1;
			max_scale=1;
		}
		
		surface_resize(application_surface,width,height);
		display_set_gui_size(width,height);
		window_set_size(width*scale,height*scale);
		window_center();
	}
	static set_resolution=function(){
		surface_resize(application_surface,width,height);
		display_set_gui_size(width,height);
		window_set_size(width*scale,height*scale);
		window_set_fullscreen(false);
		window_center();
	}
	init();
}