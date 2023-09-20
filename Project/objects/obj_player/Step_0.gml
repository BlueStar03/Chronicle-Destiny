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

camera.step();