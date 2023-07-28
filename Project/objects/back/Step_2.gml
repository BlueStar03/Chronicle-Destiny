/// @description
var _ah=surface_get_height(application_surface);
var _aw=surface_get_width(application_surface);
var _dw=display.width;
var _dh=display.height;

dbug.trace.add("("+string(display.ax)+","+string(display.ay)+")");
dbug.trace.add("("+string(_aw)+","+string(_ah)+")");
dbug.trace.add("("+string(_dw)+","+string(_dh)+")");

camera.step();
dbug.step();


