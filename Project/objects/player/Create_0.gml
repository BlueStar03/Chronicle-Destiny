/// @description 
#region olds
sprites={
	stand:spr_test_stand,
	walk:spr_test_walk
}
spr=new Prism(sprites.stand,spr_shadow);

dir=0;
spd=0;

key_left=ord("A");
key_right=ord("D");
key_up=ord("W");
key_down=ord("S");


camera.focus=self;
camera.mode="orbit";

hspd=0;
vspd=0;
mspd=4;

srot=0;
status="stand";
#endregion

#region hitboxes
#endregion

#region State Machine
enum states{
	free
}
state=noone;


player_states()

state_free=function(){
//hspd=keyboard_check(key_right)-keyboard_check(key_left);
//vspd=keyboard_check(key_down)-keyboard_check(key_up);
hspd=input.joy_left.horizontal.current;
vspd=input.joy_left.vertical.current;


var glen= point_distance(0,0,hspd,vspd);
var gdir=point_direction(0,0,hspd,vspd);
var gcam=camera.orbit.dir;
gdir+=gcam+90;
if abs(glen)>1{glen=1*sign(glen)};
//dir=rollover(dir,0,360)
//if abs(spd)>1{spd=1*sign(spd)}
//spd*=mspd

//var cdir=dir+(camera.orbit.dir+90)

hspd=lengthdir_x(glen,gdir)*mspd;
vspd=lengthdir_y(glen,gdir)*mspd;
if glen!=0{dir=gdir;}
dir=rollover(dir,0,360);

if place_meeting(x+hspd,y,wall){
	while(!place_meeting(x+sign(hspd),y,wall)){
		x+=sign(hspd);	
	}
	hspd=0;
}
if place_meeting(x,y+vspd,wall){
	while(!place_meeting(x,y+sign(vspd),wall)){
		y+=sign(vspd);	
	}
	vspd=0;
}

x+=hspd;
y+=vspd;




if glen!=0{
	spr.set_sprite(sprites.walk);
	status="walk";
}else{
	spr.set_sprite(sprites.stand);
	status="stand";
}


spr.step(dir);
	}



state=state_free
#endregion
