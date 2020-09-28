// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Platform() constructor{
	type=platform_type.unknown;
	color=c_error;
	compiled=code_is_compiled();
	text="unknown";
	
	init_platform = function() {
		var _platform=platform_type.unknown;
		if os_browser==browser_not_a_browser{
			switch (os_type){
				case os_windows: case os_linux: case os_macosx:  _platform=platform_type.desktop; break;
				case os_android: case os_ios: case os_winphone: _platform=platform_type.mobile; break;
				case os_xboxone: case os_switch: _platform=platform_type.console; break;
				case os_uwp: _platform=get_uwp();break;
			}
		}else{
			_platform=platform_type.web;
		}
		return _platform;
	}
	
	get_uwp=function(){
		var _uwp=platform_type.unknown;
		var _os_map=os_get_info();
		if _os_map!=-1{
			var _device=ds_map_find_value(_os_map,"device_family")	;
		}
		ds_map_destroy(_os_map);
		switch _device{
			case "Windows.Xbox": _uwp=platform_type.console; break;
			case "Windows.Mobile": _uwp=platform_type.mobile; break;
			case "Windows.Desktop": _uwp=platform_type.universal; break;
		}
		return _uwp;
	}

	get_text=function(_type){
		var _text="ERROR"
		var _color=c_error
		switch(_type){
			case platform_type.unknown:		 _text="ERROR";		 _color=c_error; break;
			case platform_type.desktop:		 _text="Desktop";	 _color=c_blue; break;
			case platform_type.universal:	 _text="UWP";		_color=c_navy;	 break;
			case platform_type.mobile:		 _text="Mobile";	 _color=c_red; break;
			case platform_type.console:		 _text="Console";	 _color=c_green; break;
			case platform_type.web:			 _text="HTML";		 _color=c_orange; break;
		}
		text=_text;
		color=_color;
	}

	type=init_platform();
	get_text(type);
	
}