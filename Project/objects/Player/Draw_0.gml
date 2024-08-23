/// @description Insert description here
// You can write your code in this editor
gpu_set_depth(-0.1)
draw_sprite_ext(spr_player,0,x,y,1,1,dir,c_white,1);
var _s=22
new BBMOD_Matrix()
	.RotateZ(dir+90)
	.RotateX(0)
	.Scale(_s,_s,-_s)
	.Translate(x, y, z)
	.ApplyWorld();
shader_set(sh_static);
model.submit();
shader_reset();
new BBMOD_Matrix().ApplyWorld();

point.dbug_draw();
line.dbug_draw();
aabb.dbug_draw();
sphere.dbug_draw();
ray.dbug_draw();
plane.dbug_draw();
obb.dbug_draw();

