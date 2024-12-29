var xspd= keyboard_check(key_right)-keyboard_check(key_left);
var yspd= keyboard_check(key_down)-keyboard_check(key_up);

hspd=xspd*mspd;
vspd=yspd*mspd;

if place_meeting(x+hspd,y,oWall){
    while(!place_meeting(x+sign(hspd),y,oWall)){
        x+=sign(hspd);	
    }
    hspd=0
}
if place_meeting(x,y+vspd,oWall){
    while(!place_meeting(x,y+sign(vspd),oWall)){
        y+=sign(vspd);	
    }
    vspd=0
}
x+=hspd;
y+=vspd;