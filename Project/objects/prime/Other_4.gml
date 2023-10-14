/// @description
view_camera[0]=camera.cam;
view_enabled=true;
view_visible[0]=true;

if layer_exists("t_ground"){
tsmap=tilemap_to_vertex_buffer("t_ground")
}else{
	tsmap=""	
}
