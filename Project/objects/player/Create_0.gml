/// @description 
key_left=ord("A");
key_right=ord("D");
key_up=ord("W");
key_down=ord("S");

/// @description 
var xs=(sprite_get_width(sprite_index)*image_xscale)/2;
var ys=(sprite_get_height(sprite_index)*image_yscale)/2;
model=model_block(-xs,-ys,0,xs,ys,-16,image_xscale,image_yscale,1);
texture=sprite_get_texture(sprite_index, 0);






camera.focus=self;
camera.mode="orbit";