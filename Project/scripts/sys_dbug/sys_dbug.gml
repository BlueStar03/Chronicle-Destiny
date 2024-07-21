// @function				Dbug()
/// @desc					check is same.
function Dbug() constructor{
	on=true;
	system={
		on:true,
		draw:function(){
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_text_outline(1,1,input.mode)
		}
	}
	trace={
		on:true,
		index:0,
		index_max:25,
		lines:array_create(26,"a"),
		add:function(label,val=""){			
			var entry=string(label)
			if val!=""{
				entry+="|"+string(val)
			}
			lines[index]=entry;
			index++;
			if index>index_max{index=index_max;lines[index]=">>[EOL]";}	
		},
		draw:function(){
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			var _string="";
			for (var i=0;i<array_length(lines);i++){
				_string+="\n"+string(lines[i]);
			}
			draw_text_outline(1,1,_string);
			index=0;
			array_delete(lines,0,index_max)
		}
	}
	level={
		on:true,
		draw:function(){
			if on{
				var s=room_get_name(room)+"("+string(instance_count)+")";
				draw_set_halign(fa_center);
				draw_set_valign(fa_top);
				draw_text_outline(display.width/2,0,s);
			}
		}
	}
	screen={
		on:true,
		draw:function(){
			if on{
				var f=string(fps_real)+":"+string(fps);
				var c_fps=fps>=game_get_speed(gamespeed_fps)?c_green:c_red;
				var s="\n("+string(display_get_gui_width())+","+string(display_get_gui_height())+")x"+string(display.scale);
				var d="\n\n("+string(display_get_width())+","+string(display_get_height())+")"
				draw_set_halign(fa_right)
				draw_text_outline(display.width,0,f,c_white,c_fps)
				draw_text_outline(display.width,0,s);	
				draw_text_outline(display.width,0,d);	
			}
		}
	}
		build={
		on:true,
		time:date_time_string(GM_build_date),
		version:string(GM_version),
		runtime:string(GM_runtime_version),
		os:string(os_type),
		init:function(){
			if os_browser==browser_not_a_browser{
				switch(os_type){
					case os_windows: os="WINDOWS"; break;
					case os_uwp: os="UWP"; break;
					case os_operagx: os="OPERAGX"; break;
					case os_linux: os="LINUX"; break;
					case os_macosx: os="MACOSX"; break;
					case os_ios: os="IOS"; break;
					case os_tvos: os="TVOS"; break;
					case os_android: os="ANDROID"; break;
					case os_ps4: os="PS4"; break;
					case os_ps5: os="PS5"; break;
					case os_xboxone: os="XBOXONE"; break;
					case os_xboxseriesxs: os="XBOXSERIESXS"; break;
					case os_switch: os="SWITCH"; break;
					case os_unknown: os="UNKNOWN"; break;
				
					case os_ps3: os="ps3"; break;
					case os_psvita: os="psvita"; break;
					case os_win8native: os="win8native"; break;
					case os_winphone: os="winphone"; break;				
				
					default: os="ERROR";
				}
				
			}else{
				switch(os_browser){
					case browser_unknown: os="unknown_browser";break;
					case browser_ie: os="internet explorer";break;
					case browser_ie_mobile: os="internet explorer mobile";break;
					case browser_firefox: os="firefox";break;
					case browser_chrome: os="chrome";break;
					case browser_safari: os="safari";break;
					case browser_safari_mobile: os="safari mobile";break;
					case browser_opera: os="opera";break;
					case browser_tizen: os="tizen";break;
					case browser_windows_store: os="windows store";break;					
					case browser_edge: os="edge";break;					
					
					default: os="ERROR ";break;
				}
			}
		},
		draw:function(){
			if on{
				draw_set_valign(fa_bottom);
				draw_set_halign(fa_left);
				var _s=os+"\n"+time+"\n"+runtime+"\n"+version;
				draw_text_outline(0,display.height,_s)
			}
		},
	}
	build.init();
	
	draw=function(){
		draw_set_color(c_white)
		draw_set_font(fnt_dbug)
		
		
		system.draw();
		trace.draw();
		level.draw();
		screen.draw();
		build.draw();
	}
}