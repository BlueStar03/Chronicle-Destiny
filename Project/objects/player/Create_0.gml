/// @description 
key_left=ord("A");
key_right=ord("D");
key_up=ord("W");
key_down=ord("S");

mspd=3;
dir=0;

spr=new Sprite(spr_test_stand,spr_player);

camera.focus=self
camera.mode="orbit"