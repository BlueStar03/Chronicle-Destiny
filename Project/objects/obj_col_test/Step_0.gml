/// @description Insert description here
// You can write your code in this editor
obb_rot++
obb_rot=rollover(obb_rot,1,365)
obb.orientation=matrix_build(0, 0, 0, obb_rot, obb_rot, obb_rot, 1, 1, 1);


