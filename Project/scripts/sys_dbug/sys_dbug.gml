function Dbug(on = true, system_on=true, tracker_on=true, level_on=true,screen_on=true,build_on=true,controls_on=true,touch_on=true,collision_on=true) constructor {
	self.on = on;
	self.font_height = font_get_size(fnt_dbug); // Calculate and store the font height
	
	system = {
		on: system_on,
		toggle:function(state){
			if is_bool(state){on=state;}
			else{on=!on}
			data.settings.sys_dbug.system=on;
			data.save_settings()
		},
		draw: function() {
			var _i="ERROR"
			var _im=input.mode
			if(_im==input_mode.keyboard){_i="keyboard"} else if(_im==input_mode.gamepad){_i="gamepad"} else if(_im==input_mode.touch){_i="touch"} else if(_im==input_mode.wait){_i="wait"} else if(_im==input_mode.search){_i="search"}
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_text_outline(1, 0, _i);
		}
	};

	tracker = {
		on: tracker_on,
		lines: [],  // Array to hold the lines
		max_lines: floor(display.height / font_height) - 4,  // Pre-calculate max lines		

		// Method to add a value
		add: function(label, value = undefined, c_str = c_white, c_out = c_black) {
			if not dbug.on or not on {return;}
			var entry=string(label);
			if (value!=undefined){ entry+="|"+string(value);}
			var line = {text: entry, c_str: c_str, c_out: c_out};
			if (array_length(lines) < max_lines) {
				array_push(lines, line);
			} else {
				lines[max_lines - 1] = {text: "END", c_str: c_red, c_out: c_white};  // Always ensure the last line says "END"
			}
		},
		
		toggle:function(state){
			array_resize(lines, 0);
			if is_bool(state){on=state;}
			else{on=!on}
			data.settings.sys_dbug.tracker=on;
			data.save_settings()
		},


		// Method to draw the lines on the screen
		draw: function() {
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);

			var y_offset = dbug.font_height;
			for (var i = 0; i < max_lines; i++) {
				if (i < array_length(lines)) {
					var line = lines[i];
					draw_text_outline(1, 0 + y_offset, line.text, line.c_str, line.c_out);
				}
				y_offset += dbug.font_height;  // Move down by the height of the font for the next value
			}
			// Clear the array after drawing
			array_resize(lines, 0);
		}
	};
		
	level = {
		on: level_on,
		
		toggle:function(state){
			if is_bool(state){on=state;}
			else{on=!on}
			data.settings.sys_dbug.level=on;
			data.save_settings()
		},
		draw: function() {
			var text = room_get_name(room) + " (" + string(instance_count) + ")";  // Format the room name and instance count
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			draw_text_outline(display.width / 2, 0, text);  // Draw the text centered at the top of the screen
		}
	};
	
	screen = {
		on: screen_on,
		
		toggle:function(state){
			if is_bool(state){on=state;}
			else{on=!on};
			data.settings.sys_dbug.screen=on;
			data.save_settings();
		},
		draw: function() {
			// Line 1: FPS Information
			var text_fps = string(fps_real) + ":" + string(fps);
			var c_fps = fps_real >= game_get_speed(gamespeed_fps) ? c_green : c_red;

			// Line 2: Game Size and Scale Information
			var text_game_size = "(" + string(display.width) + "x" + string(display.height) + ")x" + string(display.scale);

			// Line 3: Screen Dimensions and Fullscreen/Windowed
			var screen_mode = display.get_fullscreen() ? "F" : "W"; // Check if fullscreen or windowed
			var text_screen_size = "(" + string(display_get_width()) + "x" + string(display_get_height()) + ")" + screen_mode;

			// Draw the FPS information at the upper right corner
			draw_set_halign(fa_right);
			draw_set_valign(fa_top);
			draw_text_outline(display.width - 1, 0, text_fps, c_white, c_fps);

			// Draw the size and scale information on the next line
			draw_text_outline(display.width - 1, dbug.font_height, display, c_white, c_black);

			// Draw the screen dimensions and mode on the third line
			//draw_text_outline(display.width - 1, dbug.font_height * 2, text_screen_size, c_white, c_black);
		}
	};

	build = {
		on: build_on,
		c_compiled:platform.compiled?c_white:c_grey,
		
		
		toggle:function(state){
			if is_bool(state){on=state;}
			else{on=!on};
			data.settings.sys_dbug.build=on;
			data.save_settings();
		},
		draw: function() {
			draw_set_halign(fa_left);
			draw_set_valign(fa_bottom);
			var _time_line = date_datetime_string(GM_build_date);
			var _gm_line = "rt:" + string(GM_runtime_version);
			var _version_line = game_display_name + " " + VERSION + " | " + string(platform);
			var x_offset = 1;
			var y_offset_bottom = display.height;
			var y_offset_middle = y_offset_bottom - dbug.font_height;
			var y_offset_top = y_offset_middle - dbug.font_height;
			draw_text_outline(x_offset, y_offset_top, _gm_line, c_compiled);
			draw_text_outline(x_offset, y_offset_middle, _time_line, c_compiled);
			draw_text_outline(x_offset, y_offset_bottom, _version_line, platform.color);
		}
	};

	controls = {
		on: controls_on,
		
		toggle:function(state){
			if is_bool(state){on=state;}
			else{on=!on};
			data.settings.sys_dbug.controls=on;
			data.save_settings();
		},
		draw: function() {
			// Example controls information
			var control_info = "WASD: Move | QE: Rotate Camera ";
			var x_offset = display.width - 1;  // Small padding from the right edge
			var y_offset = display.height;  // Position at the bottom of the screen
			draw_set_halign(fa_right);
			draw_set_valign(fa_bottom);
			draw_text_outline(x_offset, y_offset, control_info, c_white, c_black);
		}
	};

	touch = {
		on: touch_on,
		toggle:function(state){
			if is_bool(state){on=state;}
			else{on=!on};
			data.settings.sys_dbug.touch=on;
			data.save_settings();
		},
		draw: function() {
					
		}
	};

	collision = {
		on: collision_on,
		toggle:function(state){
			if is_bool(state){on=state;}
			else{on=!on};
			data.settings.sys_dbug.collision=on;
			data.save_settings();
		},
		draw: function() {

		}
	};

	toggle=function(state){
		if is_bool(state){on=state;}
		else{on=!on};
			data.settings.sys_dbug.on=on;
			data.save_settings();
	};

	//DRAW
	draw = function() {
		if (on) {
			draw_set_font(fnt_dbug);
			if (system.on) { system.draw(); }
			if (tracker.on) { tracker.draw(); }
			if (level.on) { level.draw(); }
			if (screen.on) { screen.draw(); }
			if (build.on) { build.draw(); }
			if (controls.on) { controls.draw(); }
		}
	};
}
