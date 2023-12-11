/// @description
view_camera[0]=camera.cam;
view_enabled=true;
view_visible[0]=true;

if layer_exists("t_ground"){
tsmap=tilemap_to_vertex_buffer("t_ground")
}else{
	tsmap=""	
}

if room==rm_test{
	fl=instance_create_layer(0,0,"Instances",wall,
	{
		z:16,
		image_xscale:room_width/16,
		image_yscale:room_height/16,
		visible:false,
	});
}