
var zd=sprite_get_width(sprite_index) *image_zscale
var xw=sprite_get_width(sprite_index)*image_xscale
var yh=sprite_get_height(sprite_index)*image_yscale
d3d_draw_block(x, y, 0, x+xw, y+yh, -zd, sprite_get_texture(spr_wall,0), image_xscale, image_yscale,image_zscale)