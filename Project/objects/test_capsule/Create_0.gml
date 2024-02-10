/// @description 
col=c_blue
var ex=(sprite_width/2);
var ey=(sprite_height/2);
var ez=((sprite_get_width(sprite_index)*image_zscale)/2);

collider=new Collider(new Capsule(new Vector3(x,y,z-8), new Vector3(x,y,z-32),8),self)
//shape=new AABB(new Vector3(x,y,z-16), new Vector3(16,16,16),false);


