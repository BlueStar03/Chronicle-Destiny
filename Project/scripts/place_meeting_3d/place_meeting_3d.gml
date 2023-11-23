///@function function_name(x,[c_str])
///@description What it does
///@param x {real} what it is

function place_meeting_3d(x,y,obj){
/// scr_place_meeting_notme(x, y, obj)
/// Checks for collisions at (x, y) with the specified object, excluding the calling instance.
/// Returns true if a collision is detected with another instance, false otherwise.

var _x = x;
var _y = y;
var _obj = obj;

var shape=new col_aabb(player_.shape.position, player_.shape.half_extents);

shape.position.x=x;
shape.position.y=y;

// Iterate through all instances of the specified object
for (var _i = 0; _i < instance_number(_obj); _i++) {
    var _inst = instance_find(_obj, _i);

    // Exclude the calling instance (self)
    if (_inst.id != self){
		if shape.check_aabb(_inst.shape) {
			return true; // Collision detected
		}
	}
}

return false; // No collision found

}