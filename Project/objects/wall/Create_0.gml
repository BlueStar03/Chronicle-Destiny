var xs=sprite_get_width(sprite_index)*image_xscale;
var ys=sprite_get_height(sprite_index)*image_yscale;
var zs=sprite_get_height(sprite_index)*image_zscale;

model=model_block(0,0,0,xs,ys,-zs,image_xscale,image_yscale,image_zscale);
texture=sprite_get_texture(spr_wall, image_index);
z=0