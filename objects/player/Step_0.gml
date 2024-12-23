/// @description Insert description here
// You can write your code in this editor
var xspd= keyboard_check(key_right)-keyboard_check(key_left);
var yspd= keyboard_check(key_down)-keyboard_check(key_up);

hspd=xspd*mspd;
vspd=yspd*mspd;

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



