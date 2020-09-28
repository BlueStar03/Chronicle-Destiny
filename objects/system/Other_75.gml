/// @description gp_connect == "gamepad lost"

if ds_map_find_value(async_load, "event_type") == "gamepad discovered" {
    game.input.type=gamepad_is_connected(0)?control_type.gamepad:control_type.keyboard;
	game.input.text=game.input.input_text();
	game.input.gp_id=ds_map_find_value(async_load, "pad_index")
}else if ds_map_find_value(async_load, "event_type") == "gamepad lost" {
	    game.input.type=gamepad_is_connected(0)?control_type.gamepad:control_type.keyboard;
	game.input.text=game.input.input_text();
}