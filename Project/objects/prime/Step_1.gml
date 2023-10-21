/// @description keyboard shortcuts
// switch window scale scale
if keyboard_check_released(vk_tab){
	if os_browser==browser_not_a_browser{
		var s=display.scale
		s++
		if s>display.max_scale{s=1; }
		display.scale=s
		display.set_resolution();
	}
}
//toggle camera projection
if keyboard_check_released(ord("1")){
	if camera.pro_mat==camera.pro_mat_orthographic{
		camera.pro_mat=camera.pro_mat_perspective
		camera.type="perspective"
	}else{
		camera.pro_mat=camera.pro_mat_orthographic;	
		camera.type="orthographic"
	}
}
//toggle camera snap
if keyboard_check_released(ord("2")){
	camera.snap=!camera.snap
}

