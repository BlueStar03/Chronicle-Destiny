/// @description 
hspd=keyboard_check(key_right)-keyboard_check(key_left);
vspd=keyboard_check(key_down)-keyboard_check(key_up);

//hspd*=mspd;
//vspd*=mspd;

spd= point_distance(0,0,hspd,vspd)

if spd!=0{
	dir=point_direction(0,0,hspd,vspd)
}
if abs(spd)>1{spd=1*sign(spd)}

dbug.trace.add("camera dir",camera.orbit.dir)
//var cdir=point_direction(0,0,hspd,vspd)

spd*=mspd
dir+=(camera.orbit.dir+90)

hspd=lengthdir_x(spd,dir);
vspd=lengthdir_y(spd,dir);


if place_meeting(x+hspd,y,wall){
	while(!place_meeting(x+sign(hspd),y,wall)){
		x+=sign(hspd);	
	}
	hspd=0
}
if place_meeting(x,y+vspd,wall){
	while(!place_meeting(x,y+sign(vspd),wall)){
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