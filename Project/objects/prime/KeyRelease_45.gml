/// @description Insert description here
// You can write your code in this editor



	if gpu_get_cullmode()==cull_clockwise{
		gpu_set_cullmode(cull_counterclockwise)
	}else if gpu_get_cullmode()==cull_counterclockwise{
		gpu_set_cullmode(cull_noculling)	
	}else {
		gpu_set_cullmode(cull_clockwise)	
	}
	