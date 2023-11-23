function Dbug() constructor{
	on=true;
	//************************************************
	system={
		on:true,
		b:"In Development",
		a:"W,A,S,D - Move | Q,E Rotate Camera | 1,2 dbug toggles", 
		draw:function(){
			if on{
				//Temporary
				draw_set_halign(fa_left);
				draw_set_valign(fa_top)
				draw_text_outline(1,1,b,c_aqua,c_navy)	
			}
		}
	}
	//************************************************
	trace={
		on:true,
		index:0,
		index_max:25,
		lines:array_create(26,"Hello, World!"),
		
		add:function(label,data=""){
			if dbug.on and on{
				if index<index_max{
					var _string=string(label);
					if data!=""{
						_string+="|"+string(data)	;
					}
					lines[index]=_string;
					index++
				}else{
					index=index_max
					lines[index]="EOL"
				}
			}
		},
		
		draw:function(){
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			if on{
				var output=""
				for (var i=0;i<array_length(lines);i++){
					output+="\n"+string(lines[i])
				}
				draw_text_outline(2,2,output)
				index=0;
				array_delete(lines,0,index_max)
			}
		},
		
	}
	//************************************
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
	//*********************************************************
	screen={
		on:true,
		draw:function(){
			if on{
				var f=string(fps_real)+":"+string(fps);
				var c_fps=fps>=game_get_speed(gamespeed_fps)?c_green:c_red;
				var s="\n("+string(display_get_gui_width())+","+string(display_get_gui_height())+")x"+string(display.scale);
				draw_set_halign(fa_right);
				draw_set_valign(fa_top);
				draw_text_outline(display.width,0,f,c_white,c_fps)
				draw_text_outline(display.width,0,s);	
			}
		}
	}
	//************************************************************
	build={
		on:true,
		
		draw:function(){
			
			draw_set_valign(fa_bottom);
			draw_set_halign(fa_left);
			draw_text_outline(0,display.height,GM_version)	
		}
	}
	//*****************************************************


	//********************************************************
	draw=function(){
		draw_set_font(fnt_dbug);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		if on{
			system.draw();
			trace.draw();	
			level.draw();
			build.draw();
			screen.draw();
			
			//

		}
	}
}