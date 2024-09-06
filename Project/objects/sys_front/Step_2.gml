/// @description dbug controls hold [`] key
dbug.tracker.add(keyboard_check(192))//`
if keyboard_check(192){
	if keyboard_check(vk_delete){
		if platform.class=="Desktop"{game_end();}	
	}
	if keyboard_check(vk_control){
		game_restart();
	}
	if keyboard_check(vk_shift){
		if keyboard_check_pressed(ord("1")){dbug.toggle();return}
		if keyboard_check_pressed(ord("2")){dbug.system.toggle();return}
		if keyboard_check_pressed(ord("3")){dbug.tracker.toggle();return}
		if keyboard_check_pressed(ord("4")){dbug.level.toggle();return}
		if keyboard_check_pressed(ord("5")){dbug.screen.toggle();return}
		if keyboard_check_pressed(ord("6")){dbug.build.toggle();return}
		if keyboard_check_pressed(ord("7")){dbug.controls.toggle();return}
		if keyboard_check_pressed(ord("8")){dbug.touch.toggle();return}
		if keyboard_check_pressed(ord("9")){dbug.collision.toggle();return}
	}else{
		if keyboard_check_pressed(ord("1")){input.search_mode();return}
		if keyboard_check_pressed(ord("2")){display.set_scale();return}
		if keyboard_check_pressed(ord("3")){display.set_fullscreen();return}
		if keyboard_check_pressed(ord("0")){data.init(true);return}
	}
}