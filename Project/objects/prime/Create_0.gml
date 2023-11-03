/// @description
var _c=255/2;
draw_light_define_ambient(make_color_rgb(_c,_c,_c));

draw_light_define_direction(1, -1, 0, 1, c_white);
draw_light_enable(1, true);
draw_set_lighting(false);

quit=0
tsmap=""

