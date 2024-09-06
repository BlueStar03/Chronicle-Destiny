/// @function		Display([width],[height], [scale], [fullscreen])
/// @desc			This class handles display settings and resolution adjustments
/// @param {real} [width]	- The width of the display.
/// @param {real} [height]	- The height of the display.
/// @param {real} [scale]		- The scale of the display.
/// @param {real} [fullscreen]		- if the game is fullscreen or not.

function Display(width = 640, height = 360, scale = 1, fullscreen=false) constructor {
	self.width = width;
	self.height = height;
	self.scale = scale;
	self.fullscreen=fullscreen;
	max_scale = 1;
	
	static get_width=function(){
		return width	
	}
	static set_width=function(val){
		if platform.class=="Web"{return}
		width=val;
		init();
	}
	
	static get_height=function(){
		return height	
	}
	static set_height=function(val){
		if platform.class=="Web"{return}
		height=val;
		init();
	}
	
	static get_scale=function(){
		return scale	
	}
	static set_scale=function(val){
		if platform.class=="Web"{return;}
		if is_real(val){ scale=floor(val);}
		else { scale++;}
		scale=rollover(scale,1,max_scale+1);
		init();
	}
	
	
	static get_fullscreen=function(){
		fullscreen=window_get_fullscreen()
		return fullscreen	
	}
	static set_fullscreen=function(val){
		if platform.class=="Web"{return;}
		if is_bool(val){
		fullscreen=val;}else{fullscreen=!fullscreen}
		apply_resolution();
	}
	
	static set_resolution=function(width,height){
		if platform.class=="Web"{return;}
		if is_real(width){self.width=floor(width);} 
		if is_real(height){self.height=floor(height);} 
		init();
	}
	static set_display=function(width,height,scale){
		if platform.class=="Web"{return;}
		if is_real(width){self.width=floor(width);} 
		if is_real(height){self.height=floor(height);} 
		if is_real(scale){ self.scale=floor(scale);}
		self.scale=rollover(self.scale,1,max_scale+1);
		init();
	}	


//
	static init = function() {
		var screen_width = display_get_width();
		var screen_height = display_get_height();
		var aspect_ratio = screen_width / screen_height;

		if (platform.class=="Web") { self.width=640; self.height=360; self.scale = 1;	max_scale = 1;} else{
			if (screen_height mod self.height != 0) {  // is the height an integer multiple of the screen?
				var d = round(screen_height / self.height);//if not get the hight integer multiple
				self.height = screen_height / d;// recalculate the height so it is an integer multiple
			}
			self.width = round(self.height * aspect_ratio);// recalculate the width so that it matches the aspecte ratio of the screen
			if (self.width & 1) { self.width++; }
			if (self.height & 1) { self.height++; }

			max_scale = floor(screen_width / self.width);// calculate the maximum scale
			if (self.scale > max_scale) { self.scale = max_scale; } //if scale is greater than max_scale, set scale to max_scale
		} 
		apply_resolution();
	};

		
	static apply_resolution = function() {
		data.settings.sys_display={width:self.width  ,height:self.height , scale:self.scale , fullscreen:self.fullscreen};		
		data.save_settings();
		surface_resize(application_surface, self.width, self.height);
		display_set_gui_size(self.width, self.height);
		window_set_size(self.width * self.scale, self.height * self.scale);
		window_set_fullscreen(self.fullscreen);
		if (not self.fullscreen){window_center();}
	};

	init();
	
	toString = function() {
		return $"({width}x{height})x{scale}\n({display_get_width()}x{display_get_height()}){display.get_fullscreen() ? "F" : "W"}";
    };
}
