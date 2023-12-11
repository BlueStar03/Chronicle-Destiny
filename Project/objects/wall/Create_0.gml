c_dbug=c_random
var xs=sprite_get_width(sprite_index)*image_xscale;
var ys=sprite_get_height(sprite_index)*image_yscale;
var zs=sprite_get_height(sprite_index)*image_zscale;

model=model_block(0,0,0,xs,ys,-zs,image_xscale,image_yscale,image_zscale);
texture=sprite_get_texture(spr_wall, image_index);

collider=new Collider(new AABB(new Vector3(x,y,z),new Vector3(x+xs,y+ys,z-zs)),self)
world.add(collider)

//shape=new col_aabb(new Vector3(x,y,z),new Vector3(xs/2,ys/2,zs/2)) 
