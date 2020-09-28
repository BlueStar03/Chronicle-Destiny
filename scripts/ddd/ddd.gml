///@function draw_text_outline(x,y,string,[c_str],[c_out],[out],[qual])
///@description draw a string of text with an outline.
///@param x
///@param y
///@param str
///@param [c_str]
///@param [c_out]
///@param [out]
///@param [qual]
function draw_text_outline() {
	var __temp=draw_get_color();///store the current draw color
	var _x=argument[0];
	var _y=argument[1];
	var _str=argument[2];
	//
	var _c_str=argument_count>3?argument[3]:c_white;
	var _c_out=argument_count>4?argument[4]:c_black;
	var _out=argument_count>5?argument[5]:1;
	var _qual=argument_count>6?360/argument[6]:360/8;

	///outline
	var _xo=0;
	var _yo=0;

	draw_set_color(_c_out);
	for (var i=0;i<360;i+=_qual){
		_xo=lengthdir_x(_out,i);
		_yo=lengthdir_y(_out,i);
		draw_text(_x+_xo,_y+_yo,_str);
	}

	//text
	draw_set_color(_c_str)
	draw_text(_x,_y,_str)
	draw_set_color(__temp);


}
