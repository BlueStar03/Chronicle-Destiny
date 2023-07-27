// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Dbug() constructor{
	trace={
		on:true,
		index:0,
		line:array_create(10,-1),
		
		add:function(label,data=""){
			if on{
					var _l=string(label);

					var _d=data==""?"":"|"+string(data);
					//_d+=trace?" :"+string(_o):"";
					line[index]=_l+_d;
					index++;
				}
		},
		step:function(){
			
		},
		draw:function(){
			if on{
				var _s="";
				for (var i=0;i<index;i++){
					_s+="\n"+string(line[i])
				}
				index=0;
				draw_text_outline(1,1,_s);
			}
		},		
	}
	step=function(){
		trace.step();	
	}
	draw=function(){
		trace.draw();
	}
}