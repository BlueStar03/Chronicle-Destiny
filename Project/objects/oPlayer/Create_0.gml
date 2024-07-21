/// @description Insert description here
// You can write your code in this editor
z=0
mspd=2;
xspd=0;
yspd=0;
zspd=0;
dir=0


model = new BBMOD_Model("Data/BaseChar.bbmod").freeze();
model.Materials[@ 0] = sprite_get_texture(texBaseChar, 0);


animIdle = new BBMOD_Animation("Data/stand.bbanim");
animWalk = new BBMOD_Animation("Data/Walk.bbanim");

animationPlayer = new BBMOD_AnimationPlayer(model);

camera.focus=self;
camera.mode="orbit";