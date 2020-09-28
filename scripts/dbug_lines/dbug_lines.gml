function Lines() constructor{
	//fields
	show=true;
	x=0;
	y=0;
	index=0;
	index_max=25;
	line=[];
	
	init_lines=function(){
		index_max=360
		index_max=floor(game.display.height/13)-2
		var i=index_max;
		repeat(i+1){
			line[i]=i;
			i--;
		}
	}
	add=function(_s){
		if index==index_max{
			line[index]="EOL"
			index=index_max
		}else{
			line[index]=_s
		index++;
		}
	}
	reset=function(){
		line=[];
		index=0;
	}
	// draw function
	draw=function(){
		var _s="\n";
		var _ll=array_length_1d(line);
		for(var _i=0;_i<_ll;_i++){
			_s+=string(line[_i])+"\n";	
		}
			draw_text_outline(x,y,_s);
		reset();	
	}
	
	init_lines();
}