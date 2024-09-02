// Get input movement
var _hsp = input.horizontal * walk_spd;
var _vsp = input.vertical * walk_spd;

var _mag=point_distance(0, 0, input.horizontal, input.vertical);

// Update the player's direction based on movement input
if _mag > 0 {
    dir = point_direction(0, 0, _hsp, _vsp);
}

// Initialize step adjustments
var _xs = 0;
var _ys = 0;

// Check horizontal collisions
if (place_meeting(x + _hsp, y, obj_wall)) {
    _xs = sign(_hsp); // Start with the movement direction

    // Move step by step until just before the collision
    while (!place_meeting(x + _xs, y, obj_wall) && _hsp != 0) {
        x += _xs;
        _hsp -= sign(_hsp); // Decrease movement amount
    }
    _hsp = 0;  // Stop horizontal movement
}

// Check vertical collisions
if (place_meeting(x, y + _vsp, obj_wall)) {
    _ys = sign(_vsp); // Start with the movement direction

    // Move step by step until just before the collision
    while (!place_meeting(x, y + _ys, obj_wall) && _vsp != 0) {
        y += _ys;
        _vsp -= sign(_vsp); // Decrease movement amount
    }
    _vsp = 0;  // Stop vertical movement
}

// Move the player
x += _hsp;
y += _vsp;



var _anim = _mag>0 ? animWalk : animIdle;
animationPlayer.change(_anim, true); // true = loop the animation
animationPlayer.update(delta_time);