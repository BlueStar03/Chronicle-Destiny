/// @description 
status="none"
sprites={
	stand:spr_test_stand,
	walk:spr_test_walk
}
z=-0.1
spr=new Prism(sprites.stand);
instance_create_layer(x,y,"Instances",obj_shadow)
camera.focus=self;
camera.mode="orbit";

xspd=0;
yspd=0;
zspd=0;
mspd=4;
jspd=-5;
grav=0.25;



ground=0;
jump_key_hold=false
jump_spd=4;
jump_max=2;
jump_count=0;
jump_hold_frames=15
jump_timer=0

coll_offset=16


dir=0;
spd=0;
key_left=ord("A");
key_right=ord("D");
key_up=ord("W");
key_down=ord("S");
key_jump=vk_space;
key_jump_pressed=false

//shape=new col_aabb(new Vector3(x,y,0),new Vector3(10,10,10)) 

var xs=sprite_get_width(sprite_index)*image_xscale;
var ys=sprite_get_height(sprite_index)*image_yscale;
var zs=sprite_get_height(sprite_index)*2;

c1=new Collider(	new AABB(new Vector3(x,y,z),new Vector3(x+xs,y+ys,z-zs),true))
c2=new Collider(	new Sphere(new Vector3(x,y,z-16),16))
collider=c1

//shape=new AABB(new Vector3(x,y,z),new Vector3(x+xs,y+ys,z-zs),true)


