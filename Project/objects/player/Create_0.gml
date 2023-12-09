/// @description 
status="none"
sprites={
	stand:spr_test_stand,
	walk:spr_test_walk
}
spr=new Prism(sprites.stand,spr_shadow);

camera.focus=self;
camera.mode="orbit";

hspd=0;
vspd=0;
mspd=4;

dir=0;
spd=0;

key_left=ord("A");
key_right=ord("D");
key_up=ord("W");
key_down=ord("S");

//shape=new col_aabb(new Vector3(x,y,0),new Vector3(10,10,10)) 

var xs=sprite_get_width(sprite_index)*image_xscale;
var ys=sprite_get_height(sprite_index)*image_yscale;
var zs=sprite_get_height(sprite_index)*2;

c1=new Collider(	new AABB(new Vector3(x,y,z),new Vector3(x+xs,y+ys,z-zs),true))
c2=new Collider(	new Sphere(new Vector3(x,y,z-16),16))
collider=c1

//shape=new AABB(new Vector3(x,y,z),new Vector3(x+xs,y+ys,z-zs),true)


