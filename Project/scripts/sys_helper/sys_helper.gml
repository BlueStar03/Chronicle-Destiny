///@function draw_text_outline(x,y,string,[c_str],[c_out],[out],[qual])
///@description draw a string of text with an outline.
///@param x
///@param y
///@param str
///@param [c_str]
///@param [c_out]
///@param [out]
///@param [qual]
function draw_text_outline(x,y,str,c_str=c_white,c_out=c_black,out=1,q=45){
	var _temp=draw_get_color();	
	var _xo=0;
	var _yo=0;
	
	draw_set_color(c_out);
	for (var i=0;i<360;i+=q){
		_xo=lengthdir_x(out,i);
		_yo=lengthdir_y(out,i);
		draw_text(x+_xo,y+_yo,str);
	}

	//text
	draw_set_color(c_str)
	draw_text(x,y,str)
	draw_set_color(_temp);	
}
function draw_text_outline_ext(x,y,str,sep,w,c_str=c_white,c_out=c_black,out=1,q=45){
	var _temp=draw_get_color();
	var _xo=0;
	var _yo=0;
	
	draw_set_color(c_out);
	for (var i=0;i<360;i+=q){
		_xo=lengthdir_x(out,i);
		_yo=lengthdir_y(out,i);
		draw_text_ext(x+_xo,y+_yo,str,sep,w);
	}

	//text
	draw_set_color(c_str)
	draw_text_ext(x,y,str,sep,w)
	draw_set_color(_temp);
}


///@function rollover(data,lo,hi)
///@description Will wrap the the value between hi and lo
///@param value
///@param lo
///@param hi
function rollover(value, lo, hi) {
	var range = hi - lo;
	var offset = (value - lo) % range;
	if (offset < 0) offset += range;
	return lo + offset;
	//var diff=hi-lo
	//value-=lo
	//value+=diff
	//value%=diff
	//value+=lo
	//return value
	//Ai
}