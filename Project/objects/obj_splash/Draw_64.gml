var margin=20;
var _width=640;
var _height=360;
draw_set_font(fnt_default);
var label="This is a\nWork In Progress\nplease go to\nbluestar03.com\nfor comments, complaints, suggestions\nand support";
var link=" \n\n\nbluestar03.com\n\n "


draw_set_color(c_dkgrey);
draw_rectangle(0,0,_width,_height,false);
draw_set_color(c_ltgrey);
draw_rectangle(margin,margin,_width-margin,_height-margin,false);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

draw_set_font(fnt_default);
draw_set_color(c_black);
draw_text(_width/2,_height/2,label);

draw_set_color(c_blue);
draw_text(_width/2,_height/2,link);
