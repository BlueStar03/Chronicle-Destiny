/// @description 
hspd=keyboard_check(key_right)-keyboard_check(key_left);
vspd=keyboard_check(key_down)-keyboard_check(key_up);

hspd*=mspd;
vspd*=mspd;

if place_meeting(x+hspd,y,obj_wall){
	while(!place_meeting(x+sign(hspd),y,obj_wall)){
		x+=sign(hspd);	
	}
	hspd=0
}
if place_meeting(x,y+vspd,obj_wall){
	while(!place_meeting(x,y+sign(vspd),obj_wall)){
		y+=sign(vspd);	
	}
	vspd=0
}

x+=hspd;
y+=vspd;

dbug.trace.add(x,y)
dbug.trace.add(camera.orbit.dir)
dbug.trace.add(camera.orbit.distance)
dbug.trace.add(camera.orbit.elevation)



var rot=keyboard_check(ord("Q"))-keyboard_check(ord("E"));
camera.orbit.dir+=rot

camera.step();
if keyboard_check_released(vk_insert){
	if gpu_get_cullmode()==cull_clockwise{
		gpu_set_cullmode(cull_counterclockwise)
	}else if gpu_get_cullmode()==cull_counterclockwise{
		gpu_set_cullmode(cull_noculling)	
	}else {
		gpu_set_cullmode(cull_clockwise)	
	}
	
}
if keyboard_check_released(vk_delete){
	if camera.pro_mat==camera.pro_mat_orthographic{
		camera.pro_mat=camera.pro_mat_perspective
	}else{
		camera.pro_mat=camera.pro_mat_orthographic;	
	}
}