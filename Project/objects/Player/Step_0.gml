///// @description Insert description here
//// You can write your code in this editor
//camera.from.x=100
//camera.from.x=100
//camera.from.x=100

//camera.to.x=0
//camera.to.y=0
//camera.to.z=0



// Get the player's input
var _hor = input.move.horizontal.current;
var _ver = input.move.vertical.current;

// Calculate the camera's direction in radians (negative to rotate movement relative to camera direction)
var cam_dir_rad = degtorad(-camera.dir+90);

// Rotate the movement vector by the negative of the camera direction
var _rot_hor = _hor * cos(cam_dir_rad) - _ver * sin(cam_dir_rad);
var _rot_ver = _hor * sin(cam_dir_rad) + _ver * cos(cam_dir_rad);

// Apply the movement to the player's position
x += _rot_hor * mspd;
y += _rot_ver * mspd;




var cam_rot=input.horizontal_right;



            var max_lines = floor(display.height / font_get_size(fnt_dbug)) - 1;


var qwe=20

var cr=keyboard_check(ord("Q"))-keyboard_check(ord("E"));

aabb.position.x=x;
aabb.position.y=y;



camera.rotate_orbit(cr)

dbug.tracker.add("h",input.move.horizontal.current,c_red);
dbug.tracker.add("v",input.move.vertical.current,c_red);
dbug.tracker.add("Tilt",input.move.tilt,c_red);
dbug.tracker.add("A",input.attack.current);
