/// @description
camera.draw();

if tsmap!=""{
	draw_set_lighting(true);
vertex_submit(tsmap,pr_trianglelist,sprite_get_texture(tl_grid,0))
draw_set_lighting(false);
}
