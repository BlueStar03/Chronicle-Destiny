/// @description 
var _x1=150;
var _y1=150;

var _ax=_x1+(display.ax/4);
var _ay=_y1+(display.ay/4);

var _s=4

var _ah=(surface_get_height(application_surface)/_s);
var _aw=(surface_get_width(application_surface)/_s);
var _dw=display.width/_s;
var _dh=display.height/_s;



draw_set_alpha(.5)
draw_set_color(c_white);
draw_circle(display.width/2,display.height/2,3,false)

draw_set_color(c_red);
draw_rectangle(_x1,_y1,_x1+_dw,_y1+_dh,false)
draw_line(_x1,_y1,_x1+_dw,_y1+_dh)
draw_line(_x1,_y1+_dh,_x1+_dw,_y1)
draw_set_color(c_blue);
draw_rectangle(_ax,_ay,_ax+_aw,_ay+_ah,false)
draw_line(_ax,_ay,_ax+_aw,_ay+_ah)
draw_line(_ax,	_ay+_ah,	_ax+_aw,	_ay)

draw_set_alpha(1)

dbug.trace.add(string(_x1)+"|"+string(_y1)+"|"+string(_dw)+"|"+string(_dh)+"|"+string(_ax)+"|"+string(_ay)+"|"+string(_aw)+"|"+string(_ah)+"|")

dbug.draw();