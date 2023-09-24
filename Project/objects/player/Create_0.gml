/// @description 
sprite=new Sprite(spr_test_stand);

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

tsmap=tilemap_to_vertex_buffer("t_ground")