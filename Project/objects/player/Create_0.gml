/// @description 
//draw_light_define_ambient(c_dkgrey);
//draw_set_lighting(true);
//draw_light_define_direction(1, -1, -1, -1, c_white);
//draw_light_enable(1, true);

sprites={
	stand:spr_test_stand,
	walk:spr_test_walk
}


spr=new Billboard(sprites.stand,spr_shadow);

dir=0
spd=0

key_left=ord("A");
key_right=ord("D");
key_up=ord("W");
key_down=ord("S");

z=0;

camera.focus=self;
camera.mode="orbit";

hspd=0
vspd=0
mspd=4

srot=0
status="stand"


