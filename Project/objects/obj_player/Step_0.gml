// Get player input
var _hor = input.move.horizontal.current;
var _ver = input.move.vertical.current;
var _mag = point_distance(0, 0, _hor, _ver);

// Calculate the camera direction in radians
var cam_dir_rad = degtorad(-camera.dir + 90);

// Rotate the movement vector by the negative of the camera direction
var _rot_hor = _hor * cos(cam_dir_rad) - _ver * sin(cam_dir_rad);
var _rot_ver = _hor * sin(cam_dir_rad) + _ver * cos(cam_dir_rad);

// Update player direction if there's movement
if _mag > 0 {
    dir = point_direction(0, 0, _rot_hor, _rot_ver);
}

// Scale movement by walking speed
_rot_hor *= walk_spd;
_rot_ver *= walk_spd;

// Handle horizontal movement and collisions
if (place_meeting(x + _rot_hor, y, obj_wall)) {
    var _xs = sign(_rot_hor);
    while (!place_meeting(x + _xs, y, obj_wall) && _rot_hor != 0) {
        x += _xs;
        _rot_hor -= sign(_rot_hor);
    }
    _rot_hor = 0;
}

// Handle vertical movement and collisions
if (place_meeting(x, y + _rot_ver, obj_wall)) {
    var _ys = sign(_rot_ver);
    while (!place_meeting(x, y + _ys, obj_wall) && _rot_ver != 0) {
        y += _ys;
        _rot_ver -= sign(_rot_ver);
    }
    _rot_ver = 0;
}

// Apply remaining movement
x += _rot_hor;
y += _rot_ver;

// Update animation based on movement
var _anim = (_mag > 0) ? animWalk : animIdle;
animationPlayer.change(_anim, true); // Loop animation
animationPlayer.update(delta_time);

// Handle camera rotation with Q and E keys
var cr = keyboard_check(ord("Q")) - keyboard_check(ord("E"));
camera.rotate_orbit(cr * 2);
dbug.tracker.add("pos","("+string(x)+","+string(y)+","+string(z)+")");
dbug.tracker.add("dir",dir);
dbug.tracker.add(keyboard_key)

aabb.position.X=x;
aabb.position.Y=y;

X=x;
Y=y;
Z=z;