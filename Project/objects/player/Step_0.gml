/// @description 
var hspd=keyboard_check(key_right)-keyboard_check(key_left);
var vspd=keyboard_check(key_up)-keyboard_check(key_down);

hspd*=mspd;
vspd*=mspd;

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