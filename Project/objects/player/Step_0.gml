/// @description 
hspd=keyboard_check(key_right)-keyboard_check(key_left);
vspd=keyboard_check(key_down)-keyboard_check(key_up);


var glen= point_distance(0,0,hspd,vspd);
var gdir=point_direction(0,0,hspd,vspd);
var gcam=camera.orbit.dir;
gdir+=gcam+90

//dir=rollover(dir,0,360)
//if abs(spd)>1{spd=1*sign(spd)}
//spd*=mspd

//var cdir=dir+(camera.orbit.dir+90)

hspd=lengthdir_x(glen,gdir)*mspd;
vspd=lengthdir_y(glen,gdir)*mspd;
if glen!=0{dir=gdir;}
dir=rollover(dir,0,360)

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

var rot=keyboard_check(ord("Q"))-keyboard_check(ord("E"));
camera.orbit.dir+=rot


if glen!=0{
	spr.set_sprite(spr_test_walk);
}else{
	spr.set_sprite(sprites.stand);
}


spr.step(dir);

dbug.trace.add(camera.orbit.dir mod 45)

if rot==0{
	var _c=camera.orbit.dir
	var _a=0
	if (_c mod 45 != 0) {
		//_c = round(_c / 45) * 45;
		if (_c % 45 > 22.5) {
			_a += 1;
		} else {
			_a -= 1;
		}
		camera.orbit.dir+=_a
	}

}