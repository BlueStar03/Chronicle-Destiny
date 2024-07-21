/// @description Insert description here
// You can write your code in this editor
/// @desc Draw event
var _s=24
new BBMOD_Matrix()
	.RotateZ(0)
	.RotateX(0)
	.Scale(_s, _s, -_s)
	.Translate(x, y, 0)
	.ApplyWorld();




shader_set(ShAnimated);
animationPlayer.submit();
new BBMOD_Matrix().ApplyWorld();
shader_reset();
