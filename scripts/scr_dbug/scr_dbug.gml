// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Dbug() constructor{
	show={
		info:true,
		lines:true,
		console:true,
		sys:true,
		screen:true,
		screen_info:true,
		vgp:true,		
	}
	
	lines=new Lines();
	c_fps=fps_real>game_get_speed(gamespeed_fps)?c_green:c_red;
	text=1
	

	
	
	
	step=function(){
		c_fps=fps_real>game_get_speed(gamespeed_fps)?c_green:c_red;
		text++;
		if text>1000{text=0;}
	}
	
	draw=function(){
		draw_set_font(fnt_dbug);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		if show.info{
			var _info=game.platform.text+"|"+game.input.text;
			var _c=game.platform.compiled?c_black:c_silver;
			draw_text_outline(0,0,_info,game.platform.color,_c)
		}
		if show.lines{
			lines.draw();
		}
		if show.console{
			
		}
		if show.sys{
			var _x=game.display.width/2
			var _y=1
			draw_set_halign(fa_center)
			draw_text_outline(_x,_y,room_get_name(room))
		}
		if show.screen{
			_y=1;
			_x=game.display.width;
			draw_set_halign(fa_right);
			draw_text_outline(_x,_y,fps,c_white,c_fps);
			draw_text_outline(_x,_y,"\n"+string(fps_real),c_white,c_fps);
		}
		if show.vgp{
			var ww=60;
			var hh=35;
			var xx=game.display.width-ww;
			var yy=game.display.height-hh;
			
			#region Background
			draw_set_alpha(0.75);
			draw_set_color(c_black);
			draw_rectangle(xx-ww,yy-hh+5,xx+ww,yy+hh,false);
			draw_set_alpha(1);
			#endregion
			
			_draw_button(xx+10,yy,game.input.start,0)
			_draw_button(xx-10,yy,game.input.select,2)
			xx+=42
			_draw_button(xx,yy+10,game.input.a,4)
			_draw_button(xx+10,yy,game.input.b,6)
			_draw_button(xx-10,yy,game.input.x,8)
			_draw_button(xx,yy-10,game.input.y,10)
			xx-=64
			yy+=24
			_draw_button(xx,yy-7,game.input.pad_u,12)
			_draw_button(xx,yy+7,game.input.pad_d,14)
			_draw_button(xx-7,yy,game.input.pad_l,16)
			_draw_button(xx+7,yy,game.input.pad_r,18)
			xx+=22//=game.display.width-ww;
			yy-=54
			_draw_button(xx-45,yy,game.input.bump_l,24)
			_draw_button(xx+45,yy,game.input.bump_r,24)
			_draw_button(xx-57,yy,game.input.trigger_l,26)
			_draw_button(xx+57,yy,game.input.trigger_r,26)
			yy+=30
			_draw_button(xx-42,yy,game.input.click_l,20)
			_draw_button(xx+22,yy+24,game.input.click_r,20)
			
			_draw_joystick(xx-42,yy,game.input.horizontal_l,game.input.vertical_l,22);
			_draw_joystick(xx+22,yy+24,game.input.horizontal_r,game.input.vertical_r,22);			
		}
	}
	
	_draw_button=function(_x,_y,_btn,spi){
		var i=spi;
		if _btn.current{ i+=1;}
		var s=1
		if _btn.pressed{ s=0.75;}else if _btn.released{ s=2;}
				
		draw_sprite_ext(spr_dbug_gamepad,i,_x,_y,s,s,0,c_white,1)
	}
	_draw_joystick=function(_x,_y,_h,_v,spi){
		var i=spi;
		var _xx=_h.current*8;
		var _yy=_v.current*8;
		//if _btn.current{ i+=1;}
		var s=1
		//if _btn.pressed{ s=0.75;}else if _btn.released{ s=2;}
				
		draw_sprite_ext(spr_dbug_gamepad,i,_x+_xx,_y+_yy,s,s,0,c_white,1)
	}

}