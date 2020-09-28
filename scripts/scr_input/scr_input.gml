enum vgp_type{
	button,
	axis,
}

function Vbutton(t,kb,gp) constructor{
	type=t
	previous=false;
	current=false;
	pressed=false;
	released=false;
	key=kb;
	gpad=gp;
}
//------------------------------------------------------
function Input() constructor{
	type=control_type.no_controls;
	text="ERROR"
	gp_id=0;
	can_keyboard=false;
	can_gamepad=false;
	can_touch=false;
	
	tx=0;
	ty=0;
	tp=false;
	gamepad_set_axis_deadzone(0,0.2)
	#region key binds
	//key={
	//	up_l:ord("W"),
	//	down_l:ord("S"),
	//	left_l:ord("A"),
	//	right_l:ord("D"),
	//	up_r:vk_home,
	//	down_r:vk_end,
	//	left_r:vk_delete,
	//	right_r:vk_pagedown,
		
	//	a:ord("J"),
	//	b:ord("K"),
	//	x:ord("U"),
	//	y:ord("I"),
	//	start:vk_enter,
	//	select:vk_backspace,
	//	bump_l:ord("Y"),
	//	bump_r:ord("H"),
	//	trigger_l:ord("O"),
	//	trigger_r:ord("L"),
	//	click_l:ord("N"),
	//	click_r:ord("M"),
	//	pad_u:ord("1"),
	//	pad_d:ord("2"),
	//	pad_l:ord("3"),
	//	pad_r:ord("4"),	
		
	//}
	#endregion
	
	horizontal_l=new Vbutton(vgp_type.axis,[ord("D"),ord("A")],gp_axislh);
	vertical_l=new Vbutton(vgp_type.axis,[ord("S"),ord("W")],gp_axislv);
	horizontal_r=new Vbutton(vgp_type.axis,[vk_delete,vk_pagedown],gp_axisrh);
	vertical_r=new Vbutton(vgp_type.axis,[vk_end,vk_home],gp_axisrv);
	
	a=new Vbutton(vgp_type.button,ord("J"),gp_face1)
	b=new Vbutton(vgp_type.button,ord("K"),gp_face2)
	x=new Vbutton(vgp_type.button,ord("U"),gp_face3)
	y=new Vbutton(vgp_type.button,ord("I"),gp_face4)
	
	start=new Vbutton(vgp_type.button,vk_enter,gp_start)
	select=new Vbutton(vgp_type.button,vk_backspace,gp_select)
	bump_l=new Vbutton(vgp_type.button,ord("Y"),gp_shoulderl)
	bump_r=new Vbutton(vgp_type.button,ord("H"),gp_shoulderr)
	trigger_l=new Vbutton(vgp_type.button,ord("O"),gp_shoulderlb)
	trigger_r=new Vbutton(vgp_type.button,ord("L"),gp_shoulderrb)
	click_l=new Vbutton(vgp_type.button,ord("N"),gp_stickl)
	click_r=new Vbutton(vgp_type.button,ord("M"),gp_stickr)
	pad_u=new Vbutton(vgp_type.button,ord("1"),gp_padu)
	pad_d=new Vbutton(vgp_type.button,ord("2"),gp_padd)
	pad_l=new Vbutton(vgp_type.button,ord("3"),gp_padl)
	pad_r=new Vbutton(vgp_type.button,ord("4"),gp_padr)

	
	update=function(btn){
		btn.previous=btn.current;
		
		if btn.type==vgp_type.button{
			switch game.input.type{
				case control_type.keyboard:
					btn.current=keyboard_check(btn.key);
					break;
				case control_type.gamepad:
					btn.current=gamepad_button_check(game.input.gp_id, btn.gpad);
					break;
			}
		}else if btn.type==vgp_type.axis{
			switch game.input.type{
				case control_type.keyboard:
					btn.current=keyboard_check(btn.key[0])-keyboard_check(btn.key[1]);
					break;
				case control_type.gamepad:
					btn.current=gamepad_axis_value(game.input.gp_id, btn.gpad);
					break;
			}
		}
		btn.pressed=(btn.previous==false and btn.current==true);
		btn.released=(btn.previous==true and btn.current==false);
	}

	
	step=function(){
		if type!=control_type.touch{
			update(horizontal_l);
			update(vertical_l);
			update(horizontal_r);
			update(vertical_r);
		
			update(a);
			update(b);
			update(x);
			update(y);
			update(start);
			update(select);
			update(bump_l);
			update(bump_r);
			update(trigger_l);
			update(trigger_r);
			update(click_l);
			update(click_r);
			update(pad_u);
			update(pad_d);
			update(pad_l);
			update(pad_r);
		}else{
			
		}
		var gp_num = gamepad_get_device_count();
		var gp_connect=""
		for (var i = 0; i < gp_num; i++;){
			gp_connect+=string(gamepad_is_connected(i))
	    }
		game.dbug.lines.add(gp_connect);
		game.dbug.lines.add(string(a.previous)+string(b.previous));
		game.dbug.lines.add(string(a.current)+string(b.current));
		game.dbug.lines.add(string(a.pressed)+string(b.pressed));
		game.dbug.lines.add(string(a.released)+string(b.released));
		
		game.dbug.lines.add(gamepad_is_connected(0));
		
		game.dbug.lines.add(gamepad_axis_value(0, gp_axislh));
		game.dbug.lines.add(gamepad_axis_value(0, gp_axislv));
		game.dbug.lines.add(gamepad_axis_value(0, gp_axisrh));
		game.dbug.lines.add(gamepad_axis_value(0, gp_axisrv));
		
	}
	

	_init_input=function(){
		switch game.platform.type{
			case platform_type.desktop:
			can_keyboard=true;
			can_gamepad=true;
			can_touch=false;
			type=gamepad_is_connected(0)?control_type.gamepad:control_type.keyboard; 
			break;
		case platform_type.universal:
			can_keyboard=true;
			can_gamepad=true;
			if win8_device_touchscreen_available(){
				can_touch=true;
			}else{
				can_touch=false;
			}
			can_touch=true;
			type=gamepad_is_connected(0)?control_type.gamepad:control_type.keyboard; 
			//alarm[0]=5;
			break;
		case platform_type.mobile:
			can_keyboard=false;
			can_gamepad=false;
			can_touch=true;
			type=control_type.touch;
			os_powersave_enable(false);

			break;
		case platform_type.console:
			can_keyboard=false;
			can_gamepad=true;
			can_touch=false;
			type=control_type.gamepad;
			break;
		case platform_type.web:
			can_keyboard=true;
			can_gamepad=true;
			can_touch=true;
			type=gamepad_is_connected(0)?control_type.gamepad:control_type.keyboard;
			alarm[1]=5;
			break;
		}
		
		text=input_text();	
		
	}
	input_text= function(){
		var t="err"
		switch type{
			case control_type.no_controls:
				t="none";
				break
			case control_type.keyboard:
				t="Keyboard";
				break
			case control_type.gamepad:
				t="gamepad";
				break
			case control_type.touch:
				t="touch";
				break
		}
		return t;
	}
	_init_input();

}