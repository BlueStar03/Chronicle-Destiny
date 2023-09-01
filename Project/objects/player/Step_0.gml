/// @description 
hspd=keyboard_check(key_right)-keyboard_check(key_left);
vspd=keyboard_check(key_down)-keyboard_check(key_up);

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


if keyboard_check_pressed(ord("1")){
	if camera.type=="fov"{
		camera.type="ortho";	
	}else{
		camera.type="fov"	
	}
}

var camrot=keyboard_check(ord("Q"))-keyboard_check(ord("E"));
camera.polar.orientation+=camrot
camera.polar.orientation=rollover(camera.polar.orientation,0,360)
dbug.trace.add(camera.polar.orientation)

var xxoff=keyboard_check(vk_insert)-keyboard_check(vk_delete);
xoff+=xxoff


var yyoff=keyboard_check(vk_home)-keyboard_check(vk_end);
yoff+=yyoff

dbug.trace.add(xoff,yoff)