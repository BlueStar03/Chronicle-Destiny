enum input_mode {
    keyboard,
    gamepad,
    touch,
    wait,
    search
}

function Input(mode=input_mode.wait) constructor {
	self.mode=mode;
	pid=0;
	
	horizontal=0
	horizontal_right=0
	vertical=0
	
	attack=new Button(ord("J"),gp_face1);
	move=new Pad(ord("D"),ord("A"),ord("S"),ord("W"),gp_axislh,gp_axislv);

	update = function() {
		switch (mode) {
			case input_mode.keyboard:  update_keyboard();break;
			case input_mode.gamepad:update_gamepad();break;
			case input_mode.touch:update_touch();break;
			case input_mode.wait:update_wait();break;
			case input_mode.search:update_search();break;
			default: update_search();
		}
	};

	update_keyboard = function() {
		//move.horizontal.update(keyboard_check(ord("D"))-keyboard_check(ord("A")));
		//move.vertical.update(keyboard_check(ord("S"))-keyboard_check(ord("W")));
		
		move.update_keyboard();
		attack.update_keyboard();
	};

	update_gamepad = function() {
		move.update_gamepad(pid);
		attack.update_gamepad(pid);
	};

	update_touch = function() {
		move.update_touch()();
		attack.update_touch();
	};

	update_wait = function(wait_time = 60) {
		static counter = wait_time;
		counter-- ; // Decrement the counter each frame
		if counter<0{counter = wait_time; mode=input_mode.search}//Reset counter and switch to search mode after the wait
	};
	
	save_mode = function() {
		data.settings.sys_input.mode = mode;
		data.save_settings();
	};

	update_search = function(search=input_mode.search) {
		var _mode=search
		if platform.class=="Web"{
			if(keyboard_check_released(vk_anykey)){	mode=input_mode.keyboard;data.settings.sys_input={mode:self.mode};data.save_settings();	return}		
			return;
		}
		//touch
		if (_mode==input_mode.keyboard or _mode==input_mode.gamepad or _mode==input_mode.touch){mode=_mode;save_mode();return}
		if device_mouse_check_button(0,mb_any){mode=input_mode.touch;save_mode();return}
		//gamepad
		var gp_num=gamepad_get_device_count();
		for(var _id=0; _id<gp_num;_id++){
			if gamepad_is_connected(_id){
				var btn_num=gamepad_button_count(_id)
				for (var _b=0;_b<btn_num;_b++){
					if gamepad_button_value(_id,_b){ mode=input_mode.gamepad;	pid=_id;save_mode();return}
				}
				var axis_num=gamepad_axis_count(_id)
				for (var _v=0;_v<axis_num;_v++){
					if abs(gamepad_axis_value(_id,_v))>0.5{mode=input_mode.gamepad;	pid=_id;save_mode();return}
				}
			}
		}
		//keyboard
		if(keyboard_check_released(vk_anykey)){	mode=input_mode.keyboard;data.settings.sys_input={mode:self.mode};data.save_settings();	return}		
	}

	
	search_mode= function(){
		mode=input_mode.wait
		save_mode()
	}
}

function Button(keybind=vk_control,gamepadbind=gp_select,toucharea_x=0,toucharea_y=0,toucharea_size=20) constructor {	
	bind={
		keyboard:keybind,
		gamepad:gamepadbind,
		touch:{x:toucharea_x,y:toucharea_y,size:toucharea_size}
	}
	
	current = false;  
	previous = false;
	pressed=false;
	released=false;
	
	get_bind=function(val){
		switch val{
			case input_mode.keyboard: return bind.keyboard; 
			case input_mode.gamepad: return bind.gamepad; 
			case input_mode.touch: return undefined;
			default: return undefined;
		}
	}
	
	set_bind=function(keybind,gamepadbind,toucharea_x,toucharea_y,toucharea_size){
		if keybind!=null{bind.keyboard=keybind;}	
		if gamepadbind!=null{bind.gamepad=keybind;}	
		if toucharea_x!=null{bind.touch.x=toucharea_x;}	
		if toucharea_y!=null{bind.touch.y=toucharea_y;}	
		if toucharea_size!=null{bind.touch.size=toucharea_size;}	
	}
	
	update = function(val) {
		previous = current;
		current = val;
		pressed=current and not previous;
		released=not current and previous;
	}
	
	update_keyboard=function(){
		update(keyboard_check_direct(bind.keyboard)	);
	}
		update_gamepad=function(pid=0){
		update(gamepad_button_check(pid,bind.gamepad)	);
	}
		update_touch=function(){
		update(false	);
	}
}

function Axis(keybind_plus=vk_pageup,keybind_minus=vk_pagedown,gpadbind=gp_axisrv,touch_x=0,touch_y=0,touch_size_x=40,touch_size_y=10) constructor {
	bind={
		keyboard_plus:keybind_plus,
		keyboard_minus:keybind_minus,
		gamepad:gpadbind,
		touch:{x:touch_x, y:touch_y, size_x:touch_size_x, size_y:touch_size_y}
	}
	current = false;  // Current state of the button
	previous = false; // Previous state of the button
	
	get_bind=function(val,side=1){
		switch val{
			case input_mode.keyboard: if side>0{return bind.keyboard_plus}else{return bind.keyboard_minus}; 
			case input_mode.gamepad: return bind.gamepad; 
			case input_mode.touch: return undefined;
			default: return undefined;
		}
	}
	set_bind=function(keybind_plus,keybind_minus,gpadbind,touch_x,touch_y,touch_size_x,touch_size_y){
		if keybind_plus!=null{bind.keyboard_plus=keybind_plus;}
		if keybind_minus!=null{bind.keyboard_minus=keybind_minus;}
		if gpadbind!=null{bind.gamepad=gpadbind;}	
		if touch_x!=null{bind.touch.x=touch_x;}	
		if touch_x!=null{bind.touch.y=touch_y;}	
		if touch_size_x!=null{bind.touch.touch_size_x=touch_size_x;}	
		if touch_size_x!=null{bind.touch.touch_size_y=touch_size_y;}	
	}
	update = function(val) {
		previous = current;
		current = val;
	}
	update_keyboard=function(){
		update(keyboard_check(bind.keyboard_plus)-keyboard_check(bind.keyboard_minus));
	}
	update_gamepad=function(pid=0){
		var i=gamepad_axis_value(pid,bind.gamepad)
		if abs(i)<0.1{i=0};
		update(i);
	}
	update_touch=function(){
		update(0);
	}
	
}

function Pad(keybind_h_plus=vk_pageup,keybind_h_minus=vk_pageup,keybind_v_plus=vk_pageup,keybind_v_minus=vk_pageup,gpadbind_h=gp_axisrh,gpadbind_v=gp_axisrv,touch_x=0,touch_y=0,touch_w=50,touch_h=10) constructor {
	horizontal=new Axis(keybind_h_plus,keybind_h_minus,gpadbind_h,touch_x,touch_y,touch_w,touch_h);
	vertical=new Axis(keybind_v_plus,keybind_v_minus,gpadbind_v,touch_x,touch_y,touch_w,touch_h);
	angle=undefined;
	tilt=0;
	
	
get_bind = function(axis, mode, side) {
        if (axis) {
            return horizontal.get_bind(mode, side);
        } else {
            return vertical.get_bind(mode, side);
        }
    };
    set_bind = function(keybind_h_plus, keybind_h_minus, keybind_v_plus, keybind_v_minus, gpadbind_h, gpadbind_v, touch_x, touch_y, touch_w, touch_h) {
        horizontal.set_bind(keybind_h_plus, keybind_h_minus, gpadbind_h, touch_x, touch_y, touch_w, touch_h);
        vertical.set_bind(keybind_v_plus, keybind_v_minus, gpadbind_v, touch_x, touch_y, touch_w, touch_h);
    };
	update=function(/*hval,vval*/){
		//horizontal.update(hval);
		//vertical.update(vval);
		tilt=abs(point_distance(0,0,horizontal.current,vertical.current));
			if tilt>1{				
			horizontal.update(horizontal.current/tilt);
			vertical.update(vertical.current/tilt);
			tilt=abs(point_distance(0,0,horizontal.current,vertical.current));
		}		
		angle=(tilt>0)?point_direction(0,0,horizontal.current,vertical.current):undefined;
	}
	
	update_keyboard=function(){
		horizontal.update_keyboard();
		vertical.update_keyboard();
		update();
	}
	update_gamepad=function(pid=0){
		horizontal.update_gamepad(pid);
		vertical.update_gamepad(pid);
		update();
	}
	update_touch=function(){
		horizontal.update_touch();
		vertical.update_touch();
		update();
	}
}


