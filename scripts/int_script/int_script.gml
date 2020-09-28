// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function int_script(){
	#macro null undefined
	#macro c_random make_color_rgb(irandom(255),irandom(255),irandom(255))
	#macro c_aliceblue $fff8f0
	#macro c_cornflower $ED9564
	#macro c_egyptianblue $A63410
	#macro c_error $3300ff
	#macro game global

	enum platform_type{
		unknown,
		desktop,
		universal,
		mobile,
		console,
		web
	}
	enum control_type{
		no_controls,
		keyboard,
		gamepad,
		touch
	}

}