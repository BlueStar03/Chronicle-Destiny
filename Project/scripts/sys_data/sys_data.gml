function Data(reset=false)constructor{ 
	defaults=function(){
		settings={
			sys_display:{
				width:640,
				height:360,
				scale:1,
				fullscreen:false
			},
			sys_input:{
				mode:input_mode.wait,
			},
			sys_dbug:{
				on:true,
				system:true,
				tracker:true,
				level:true,
				screen:true,
				build:true,
				controls:true,
				touch:true,
				collision:true,
			}
		}
	}
	defaults();
		
	save_settings = function() {
		var settings_file = file_text_open_write("settings.sav");
		file_text_write_string(settings_file, json_stringify(settings));
		file_text_close(settings_file);
		show_debug_message("Save settings");
	}
	
	load_settings = function() {
		if (file_exists("settings.sav")) {
			var settings_file = file_text_open_read("settings.sav");
			var settings_data = file_text_read_string(settings_file);
			settings = json_parse(settings_data);
			file_text_close(settings_file);
			show_debug_message("load settings");
		}
	};
		
	delete_all = function() {
		if (file_exists("settings.sav")) {
			file_delete("settings.sav");
		}
		defaults()
		show_debug_message("delete all");
	};
		
	init = function(reset) {
		load_settings();
		if reset{delete_all();save_settings();show_debug_message("reset");}
	};

	init(reset);
}