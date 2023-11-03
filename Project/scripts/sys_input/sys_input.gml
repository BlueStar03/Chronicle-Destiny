#region Helper Functions

//========================================================
///@function					btn()
///@description					a virtual gamepad button 
function btn()constructor{
	previous=false;			//if the button was cative the previous step
	current=false;			//if the button is currentlu active
	pressed=false;			//if this is the first step the button is active
	released=false;			//if this is the first step the button is no longer active
	held=0;					//how long the button is active
	
	///@function				update()
	///@description				update the state of the button
	///@argument {bool} value	the current state of the button
	update=function(value){
		previous=current;
		current=value;
		pressed=(!previous and current);
		released=(previous and !current);
		held=current?held+current:0;
	}
}
//===========================================================
///@function					axs()
///@description					a virtual gamepad axis
function axs()constructor{
	previous=0;				//previous step value
	current=0;				//current step value
	
	///@function				update()
	///@description				update the state of the axis
	///@argument {real} value	the current state of the axis
	update=function(value){
		previous=current;
		current=value;
		//current=abs(value)>input.deadzone?value:0;
	}
}
//=========================================================
///@function					stck()
///@description					a virtual gamepad joystick
function stck()constructor{
	horizontal=new axs();		//horizontal axis
	vertical=new axs();			//vertical axis
	//_angle=-1;					//angle of the joystick
	//_tilt=0;						//how far the joystick is of center
	dir={
		previous:0,
		current:0,	
	}
	tilt={
		previous:0,
		current:0,	
	}
	
	///@function				update()
	///@description				update the state of the joystick
	///@argument {real} hvalue	the current state of the horizontal axis
	///@argument {real} vvalue	the current state of the vertical axis
	update=function(hvalue,vvalue){
		dir.previous=dir.current;
		tilt.previous=tilt.current
		var t=point_distance(0,0,hvalue,vvalue);
		if abs(t)>input.deadzone{
			horizontal.update(hvalue);
			vertical.update(vvalue);
			//tilt=o;
			//angle=point_direction(0,0,horizontal.current,vertical.current);
			tilt.current=point_distance(0,0,horizontal.current,vertical.current);
			dir.current=point_direction(0,0,horizontal.current,vertical.current);
		}else{
			horizontal.update(0);
			vertical.update(0);
			//tilt=0;
			//angle=-1
			tilt.current=0;
			dir.current=0;
		}
	}
}
//=================================================================
///@function					t_btn(x, y, size)
///@description					a virtual touch button
///@argument {real} x			x coord of the touch button
///@argument {real} y			y coord of the touch button
///@argument {real} size		size of the button
function t_btn(x=0,y=0,size=60)constructor{
	tid=-1;					//Touch point id being used
	on=false;				//if the touch button is active
	x1=x;					//x1 coord of the touch button
	y1=y;					//y1 coord of the touch button
	x2=x1+size;				//x2 coord of the touch button
	y2=y1+size;				//y2 coord of the touch button
	
	///@function					is_pressed(tp, x, y)
	///@description					is the touch button pressed
	///@argument {real} tp			touch point being tested
	///@argument {real} x			x coord of the touch point
	///@argument {real} y			x coord of the touch point
	is_pressed=function(tp,x,y){
		if point_in_rectangle(x,y,x1,y1,x2,y2){
			if tid==-1{
				tid=tp;	
				return true;
			}else{
				return false;
			}
		}
	}
}

///@function					t_axs(x, y, size)
///@description					a virtual touch axis
///@argument {real} x			x coord of the touch button
///@argument {real} y			y coord of the touch button
///@argument {real} size		size of the button
function t_axs(x=0,y=0,size=60):t_btn(x,y,size) constructor{
	
	x=0;
	y=0;
	x2=x1+(size*2);
	origin=false;
	origin_x=-1;
	origin_y=-1;
	horizontal=0;
	vertical=0;
	radius=60;
}

#endregion

function Input() constructor{
	mode="search";
	pid=0;
	hat=false;
	deadzone=0.2;
	
	delay_timer=30;
	delay_timer_reset=30;
	delay_to="search"
	
	#region controls
	joy_left=new stck();
	joy_right=new stck();
	//gamepad  buttons
	a=new btn();
	b=new btn();
	x=new btn();
	y=new btn();
	
	start=new btn();
	select=new btn();
	
	bumper_l=new btn();
	bumper_r=new btn();
	trigger_l=new btn();
	trigger_r=new btn();
	click_l=new btn();
	click_r=new btn();
	
	pad_up=new btn();
	pad_down=new btn();
	pad_left=new btn();
	pad_right=new btn();
	#endregion
	#region key bindings
	key={ 
		a:ord("K"),
		b:ord("L"),
		x:ord("I"),
		y:ord("O"),
		start:vk_enter,
		select:vk_backspace,

		bumper_l:ord("U"),
		bumper_r:ord("J"),
		trigger_l:ord("Y"),
		trigger_r:ord("H"),
		click_l:ord("M"),
		click_r:ord("NF"),
	
		pad_u:ord("Z"),
		pad_d:ord("X"),
		pad_l:ord("C"),
		pad_r:ord("V"),
	
	
		left_l:ord("A"),
		right_l:ord("D"),
		up_l:ord("W"),
		down_l:ord("S"),
	
		left_r:ord("Q"),
		right_r:ord("E"),
		up_r:ord("R"),
		down_r:ord("F"),
		
		//a:ord("S"),
		//b:ord("X"),
		//x:ord("D"),
		//y:ord("C"),
		//start:vk_enter,
		//select:vk_backspace,

		//bumper_l:ord("A"),
		//bumper_r:ord("Z"),
		//trigger_l:ord("W"),
		//trigger_r:ord("E"),
		//click_l:ord("F"),
		//click_r:ord("V"),
	
		//pad_u:ord("1"),
		//pad_d:ord("2"),
		//pad_l:ord("3"),
		//pad_r:ord("4"),
	
	
		//left_l:vk_left,
		//right_l:vk_right,
		//up_l:vk_up,
		//down_l:vk_down,
	
		//left_r:vk_delete,
		//right_r:vk_pagedown,
		//up_r:vk_home,
		//down_r:vk_end,
	}
	
	gp={
		horizontal_l:0,	
		vertical_l:1,
		horizontal_r:2,	
		vertical_r:3,
		
		a:12,
		b:13,
		x:14,
		y:15,
		
		start:4,
		select:5,
		
		bump_l:8,
		bump_r:9,
		trigger_l:10,
		trigger_r:11,
		click_l:6,
		click_r:7,
		
		hat:0,
		pad_u:0,
		pad_d:1,
		pad_l:2,
		pad_r:3,
		//-----------------------------
		horizontal_l:gp_axislh,	
		vertical_l:gp_axislv,
		horizontal_r:gp_axisrh,	
		vertical_r:gp_axisrv,
		
		a:gp_face1,
		b:gp_face2,
		x:gp_face3,
		y:gp_face4,
		
		start:gp_start,
		select:gp_select,
		
		bump_l:gp_shoulderl,
		bump_r:gp_shoulderr,
		trigger_l:gp_shoulderlb,
		trigger_r:gp_shoulderrb,
		click_l:gp_stickl,
		click_r:gp_stickr,
		
		hat:0,
		pad_u:gp_padu,
		pad_d:gp_padd,
		pad_l:gp_padl,
		pad_r:gp_padr,
		
		//8bitdo xinput
		//horizontal_l:0,	
		//vertical_l:1,
		//horizontal_r:3,	
		//vertical_r:4,
		
		//a:0,
		//b:1,
		//x:3,
		//y:4,
		
		//start:11,
		//select:10,
		
		//bump_l:6,
		//bump_r:7,
		//trigger_l:8,
		//trigger_r:9,
		//click_l:13,
		//click_r:14,
		
		//hat:0,
		//pad_u:0,
		//pad_d:0,
		//pad_l:0,
		//pad_r:0,
		
	}
	#endregion
	touch={
/*
+---+---------------+---------------+---+
| p |               |               | d |
+---+               |               +---+
|                   |                   |
|          j        |       b       +---|
|                   |               | m |
|                   |               +---|
|                   |                   |
|           +---------------+       +---|
|           |       r       |       | c |
+-----------+---------------+-------+---+

j - joystick: controls movement
b - button: general actions


*/
		
		size:100,
		j:{//Joystick
			state:"adaptive",// fixed dynamic adaptive
			tid:-1,
			x:0,
			y:0,
			origin:false,
			origin_x:0,
			origin_y:0,
			radius:60,//75,
			horizontal:0,
			vertical:0,
			angle:0,
			tilt:0,
		},
		b:{//button
			tid:-1,
			on:false,
		},
		p:new t_btn(),//pause
		d:new t_btn(display.width-60),
		da:new t_axs(display.width-60),

		m:new t_btn(display.width-60,(display.height/2)-30),
		c:new t_btn(display.width-60,display.height-60),
		r:new t_axs((display.width/2)-60,display.height-60),
		
		update:function(){
			//get touch ids for each function
			for (var t=0;t<2;t++){
				if device_mouse_check_button(t,mb_left){
					if !(d.tid==t or p.tid==t or b.tid==t or j.tid==t or m.tid==t or c.tid==t or r.tid==t){
						var tx=device_mouse_x_to_gui(t);
						var ty=device_mouse_y_to_gui(t);
						if p.is_pressed(t,tx,ty){}else
						if d.is_pressed(t,tx,ty){}else
						if m.is_pressed(t,tx,ty){}else
						if c.is_pressed(t,tx,ty){}else
						if r.is_pressed(t,tx,ty){}
						else

						{
							var tw=display.width/2;
							if tx<tw{
								if j.tid==-1{
									j.tid=t	
								}
							}else{
								if b.tid==-1{
									b.tid=t	
								}	
							}
						}						
					}
				}
			}
			//touch functions
			#region joystick
			if (j.tid!=-1){
				if(device_mouse_check_button(j.tid,mb_left)){
					j.x=device_mouse_x_to_gui(j.tid);
					j.y=device_mouse_y_to_gui(j.tid);
					if !j.origin{
						j.origin=true;
						j.origin_x=j.x;
						j.origin_y=j.y
					}
				}else{
					j.tid=-1;
					j.origin=-1;
					j.x=0;
					j.y=0;
					j.origin_x=0;
					j.origin_y=0;
				}
			}
			if (j.state=="fixed" and j.origin){
			  j.origin_x=100
			   j.origin_y=display.height-100
			}
			
			
			var hx=j.x-j.origin_x;
			var vy=j.y-j.origin_y;
			
			var hl=(min(abs(hx),j.radius)*sign(hx))/j.radius//make the value of 60 equal 1
	        var vl=(min(abs(vy),j.radius)*sign(vy))/j.radius
	        j.horizontal=hl
	        j.vertical=vl
	        var dd=arctan2(vl,hl)
	        var mm=(min(abs(sqrt(sqr(hl)+sqr(vl))),1))
	        j.horizontal=mm*cos(dd)
	        j.vertical=mm*sin(dd)
        
	        if(j.state=="adaptive"){
	            j.origin_x+=hx-(j.horizontal*j.radius);
	            j.origin_y+=vy-(j.vertical*j.radius)
	        }
			#endregion
			
			
			if b.tid!=-1{
				if(device_mouse_check_button(b.tid,mb_left)){
					b.on=true;
				}else{
					b.on=false;
					b.tid=-1;
				}
			}
			if p.tid!=-1{
				if(device_mouse_check_button(p.tid,mb_left)){
					p.on=true;
				}else{
					p.on=false;
					p.tid=-1;
				}
			}

			if d.tid!=-1{
				if(device_mouse_check_button(d.tid,mb_left)){
					d.on=true;
					da.x=device_mouse_x_to_gui(d.tid);
					da.y=device_mouse_y_to_gui(d.tid);
					if !da.origin{
						da.origin=true;
						da.origin_x=display.width-15;//da.x;
						da.origin_y=15;//da.y;
					}
					da.angle=point_direction(da.origin_x,da.origin_y,da.x,da.y);
					da.tilt=min((point_distance(da.origin_x,da.origin_y,da.x,da.y)/60),1);
					var ldx=lengthdir_x(da.tilt,da.angle);
					var ldy=lengthdir_y(da.tilt,da.angle);
					da.horizontal=ldx;
					da.vertical=ldy;
				}else{
					d.on=false;
					d.tid=-1;
					da.origin=-1;
					da.x=0;
					da.y=0;
					da.origin_x=0;
					da.origin_y=0;
				}
			}
			if m.tid!=-1{
				if(device_mouse_check_button(m.tid,mb_left)){
					m.on=true;
				}else{
					m.on=false;
					m.tid=-1;
				}
			}
			if c.tid!=-1{
				if(device_mouse_check_button(c.tid,mb_left)){
					c.on=true;
				}else{
					c.on=false;
					c.tid=-1;
				}
			}
			if r.tid!=-1{
				if(device_mouse_check_button(r.tid,mb_left)){
					r.on=true;
					r.x=device_mouse_x_to_gui(r.tid);
					r.y=device_mouse_y_to_gui(r.tid);
					if !r.origin{
						r.origin=true;
						r.origin_x=r.x;
						r.origin_y=r.y;
					}
				}else{
					r.on=false;
					r.tid=-1;
					r.origin=-1;
					r.x=0;
					r.y=0;
					r.origin_x=0;
					r.origin_y=0;
				}
				if r.on{
					var hx=r.x-r.origin_x;
					r.horizontal=(min(abs(hx),r.radius)*sign(hx))/r.radius;	
				}else{r.horizontal=0;}
				
			}
		}
	}//*************************
	
	
	
	

	_set_8bitdo_mappings=function(){
		gp.horizontal_l=0;
		gp.vertical_l=1;
		gp.horizontal_r=3;
		gp.vertical_r=4;
		
		gp.a=0;
		gp.b=1;
		gp.x=3;
		gp.y=4;
		
		gp.start=11;
		gp.select=10;
		
		gp.bump_l=6;
		gp.bump_r=7;
		gp.trigger_l=8;
		gp.trigger_r=9;
		gp.click_l=13;
		gp.click_r=14;
		
		gp.hat=0;
		gp.pad_u=0;
		gp.pad_d=0;
		gp.pad_l=0;
		gp.pad_r=0;
		hat=true;
	}
	_set_xinput_mappings=function(){
		gp.horizontal_l=gp_axislh;
		gp.vertical_l=gp_axislv;
		gp.horizontal_r=gp_axisrh;
		gp.vertical_r=gp_axisrv;
		
		gp.a=gp_face1;
		gp.b=gp_face2;
		gp.x=gp_face3;
		gp.y=gp_face4;
		
		gp.start=gp_start;
		gp.select=gp_select;
		
		gp.bump_l=gp_shoulderl;
		gp.bump_r=gp_shoulderr;
		gp.trigger_l=gp_shoulderlb;
		gp.trigger_r=gp_shoulderrb;
		gp.click_l=gp_stickl;
		gp.click_r=gp_stickr;
		
		gp.hat=0;
		gp.pad_u=gp_padu;
		gp.pad_d=gp_padd;
		gp.pad_l=gp_padl;
		gp.pad_r=gp_padr;
		hat=false;
	}
	_search_active=function(){
		if(keyboard_check_released(vk_anykey)){
				
				mode="keyboard"
				
			}
		var gp_num = gamepad_get_device_count();
		if device_mouse_check_button(0,mb_left){
			mode="touch"
		}
		for(var _id=0; _id<gp_num;_id++){
			if gamepad_is_connected(_id){
				var btn_num=gamepad_button_count(_id)
				for (var _v=0;_v<btn_num;_v++){
					if gamepad_button_value(_id,_v){
						mode="gamepad";
						pid=_id;
						if gamepad_get_description(_id)=="8BitDo SN30 Pro for Android" or gamepad_get_description(_id)=="8BitDo SN30 Pro for Android (Vendor: 2dc8 Product:2101)"{
							_set_8bitdo_mappings();	
						}
						break;	
					}
				}
				var axis_num=gamepad_axis_count(_id)
				for (var _v=0;_v<axis_num;_v++){
					if abs(gamepad_axis_value(_id,_v))>0.5{
						mode="gamepad";
						pid=_id;
						if gamepad_get_description(_id)=="8BitDo SN30 Pro for Android" or gamepad_get_description(_id)=="8BitDo SN30 Pro for Android (Vendor: 2dc8 Product:2101)"{
							_set_8bitdo_mappings();	
						}
						break;	
					}
				}
				var hat_num=gamepad_hat_count(_id)
				for (var _v=0;_v<hat_num;_v++){
					if (gamepad_hat_value(_id,_v)!=0){
						mode="gamepad";
						pid=_id;
						if gamepad_get_description(_id)=="8BitDo SN30 Pro for Android" or gamepad_get_description(_id)=="8BitDo SN30 Pro for Android (Vendor: 2dc8 Product:2101)"{
							_set_8bitdo_mappings();	
						}else{
							_set_xinput_mappings();	
						}
						break;	
					}
				}
			}/*else if(keyboard_check_released(vk_anykey)){
				
				mode="keyboard"
				
			}*/
		}
	}
	_get_keyboard=function(){
		
		joy_left.update(keyboard_check(key.right_l)-keyboard_check(key.left_l),keyboard_check(key.down_l)-keyboard_check(key.up_l))
		joy_right.update(keyboard_check(key.right_r)-keyboard_check(key.left_r),keyboard_check(key.down_r)-keyboard_check(key.up_r))

		
		a.update(keyboard_check(key.a));
		b.update(keyboard_check(key.b));
		x.update(keyboard_check(key.x));
		y.update(keyboard_check(key.y));
		
		start.update(keyboard_check(key.start));
		select.update(keyboard_check(key.select));
		
		bumper_l.update(keyboard_check(key.bumper_l));
		bumper_r.update(keyboard_check(key.bumper_r));
		trigger_l.update(keyboard_check(key.trigger_l));
		trigger_r.update(keyboard_check(key.trigger_r));
		click_l.update(keyboard_check(key.click_l));
		click_r.update(keyboard_check(key.click_r));
		
		pad_up.update(keyboard_check(key.pad_u));
		pad_down.update(keyboard_check(key.pad_d));
		pad_left.update(keyboard_check(key.pad_l));
		pad_right.update(keyboard_check(key.pad_r));		
	}
		
	_get_gamepad=function(){
		
		joy_left.update(gamepad_axis_value(pid, gp.horizontal_l),gamepad_axis_value(pid, gp.vertical_l))
		joy_right.update(gamepad_axis_value(pid, gp.horizontal_r),gamepad_axis_value(pid, gp.vertical_r))
		
		a.update(gamepad_button_check(pid,gp.a));
		b.update(gamepad_button_check(pid,gp.b));
		x.update(gamepad_button_check(pid,gp.x));
		y.update(gamepad_button_check(pid,gp.y));
		
		start.update(gamepad_button_check(pid,gp.start));
		select.update(gamepad_button_check(pid,gp.select));
		bumper_l.update(gamepad_button_check(pid,gp.bump_l));
		bumper_r.update(gamepad_button_check(pid,gp.bump_r));
		trigger_l.update(gamepad_button_check(pid,gp.trigger_l));
		trigger_r.update(gamepad_button_check(pid,gp.trigger_r));
		click_l.update(gamepad_button_check(pid,gp.click_l));
		click_r.update(gamepad_button_check(pid,gp.click_r));
		if hat{
			var _h=gamepad_hat_value(pid,gp.hat)
			pad_up.update(_h&1);
			pad_right.update((_h&2)>>1);
			pad_down.update((_h&4)>>2);
			pad_left.update((_h&8)>>3);
		}else{
			pad_up.update(gamepad_button_check(pid,gp.pad_u));
			pad_down.update(gamepad_button_check(pid,gp.pad_d));
			pad_left.update(gamepad_button_check(pid,gp.pad_l));
			pad_right.update(gamepad_button_check(pid,gp.pad_r));
		}
	}
	_get_touch=function(){
		
		joy_left.update(touch.j.horizontal,touch.j.vertical);
		bumper_r.update(touch.d.on);
		if touch.d.on{
			joy_right.update(touch.da.horizontal,touch.da.vertical)
		}else if !touch.d.on{
			joy_right.update(touch.r.horizontal,0);
		}
		a.update(touch.b.on);
		b.update(touch.c.on);
		x.update(touch.m.on);
		
		select.update(touch.p.on);

}
	_delay=function(){
		delay_timer--;
		if delay_timer<0{
			delay_timer=delay_timer_reset;
			mode=delay_to;
		}
	}
	update=function(){
		touch.update();
		switch mode{
			case "keyboard"	:	_get_keyboard();	break;
			case "gamepad"	:	 _get_gamepad();	break;
			case "touch"	:	_get_touch();		break;
			case "search"	:	_search_active();		break;
			case "delay"	:	_delay();		break;
		}
	}
}