// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Dbug() constructor{
	on=true;
	system={
		on:true,
		a:"error",
		b:"error",
		c:"error",
		d:c_red,
		draw:function(){
			_sys=string(a)+"|"+string(b)+"|"+string(c)
			draw_text_outline(1,1,_sys,d);
		},
		
	}
	trace={
		on:true,
		index:0,
		index_max:10,
		lines:array_create(10,-1),
		add:function(label,value=""){
			if dbug.on and on{
				var _label=string(label);
				var _value=value==""?"":"|"+string(value);
				if index<index_max{
					lines[index]=_label+_value;
					index++
				} else{
					lines[index]="END_OF_FILE";
					index=index_max
				}
			}
		},
		draw:function(){
			if dbug.on and on{
				_trace="";
				for (var i = 0;i<index;i++){
					_trace+="\n"+string(lines[i]);
				}
				index=0;
				draw_text_outline(1,1,_trace)
			}
		},
	}
	draw=function(){
		system.draw();
		trace.draw();	
	}
}