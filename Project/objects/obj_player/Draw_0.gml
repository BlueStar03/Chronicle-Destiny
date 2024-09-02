/// @description Insert description here
// You can write your code in this editor


draw_sprite_ext(spr_player_shadow,0,x,y,1,1,dir,c_white,1);
var _s=16*2
new BBMOD_Matrix()
	.RotateZ(dir+90)
	.RotateX(0)
	.Scale(_s,_s,-_s)
	.Translate(x, y, z)
	.ApplyWorld();
//shader_set(sh_static);
//model.submit();
//shader_reset();
shader_set(sh_anim);
animationPlayer.submit();
shader_reset();
new BBMOD_Matrix().ApplyWorld();