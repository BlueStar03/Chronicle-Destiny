function Input() constructor{
	mode="search";
	pid=-1
	horizontal=0;
	vertical=0;
	horizontal_right=0;
	
	search=function(){
		if keyboard_check_released(vk_anykey){mode="keyboard";}
		if device_mouse_check_button_released(0,mb_any){mode="touch";}
		var	gp_count=gamepad_get_device_count()
		for(var _id=0;_id<gp_count;_id++){
			if gamepad_is_connected(_id){
					var btn_count=gamepad_button_count(_id);
					for(var b=0;b<btn_count;b++){
						if gamepad_button_value(_id,b){
							mode="gamepad";
							pid=_id;
							break;
						}
					}
			}
		}
		
	}
	get_keyboard=function(){
		horizontal=keyboard_check(ord("D"))-keyboard_check(ord("A"));
		vertical=keyboard_check(ord("S"))-keyboard_check(ord("W"));
		horizontal_right=keyboard_check(ord("Q"))-keyboard_check(ord("E"));
	}
	get_gamepad=function(){
		horizontal=gamepad_axis_value(pid,gp_axislh);
		vertical=gamepad_axis_value(pid,gp_axislv);
		horizontal_right=gamepad_axis_value(pid,gp_axisrh);
	}
	get_touch=function(){
		
	}
	
	update=function(){
		switch mode{
			case "keyboard"	:	get_keyboard();	break;
			case "gamepad"	:	get_gamepad();	break;
			case "touch"		:	get_touch();		break;
			case "search"		:	search();		break;
			
			default	:	get_keyboard();
		}
	}

}