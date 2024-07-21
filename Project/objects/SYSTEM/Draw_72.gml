/// @description draw camera
camera.draw();
tmap.draw();

if tsmap!=""{
vertex_submit(tsmap,pr_trianglelist,sprite_get_texture(tl_test_grid,0))

}


if keyboard_check_released(vk_tab){
	if os_browser==browser_not_a_browser{
		var s=display.scale
		s++
		if s>display.max_scale{s=1; }
		display.scale=s
		display.set_resolution();
	}
}