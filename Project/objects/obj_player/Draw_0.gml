//d3d_draw_block(x-8, y-8, 0, x+8, y+8, -16, sprite_get_texture(spr_wall,0), 1, 1)
//d3d_draw_capsule(x-8, y-8, -8, x+8, y+8, -24, sprite_get;_texture(spr_player,1));
d3d_draw_sphere(x,y,-8,8,sprite_get_texture(spr_player,1))
d3d_draw_floor(0,0,0,room_width,room_height,0,sprite_get_texture(spr_grid,1),room_width/32, room_height/32)