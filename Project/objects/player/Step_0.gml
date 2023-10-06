/// @description 
var rot=keyboard_check(ord("Q"))-keyboard_check(ord("E"));
camera.orbit.dir+=rot


hspd=keyboard_check(key_right)-keyboard_check(key_left);
vspd=keyboard_check(key_down)-keyboard_check(key_up);

spd= point_distance(0,0,hspd,vspd);
if spd!=0{
	dir=point_direction(0,0,hspd,vspd)
}
dir=rollover(dir,0,360)
if abs(spd)>1{spd=1*sign(spd)}
spd*=mspd

var cdir=dir+(camera.orbit.dir+90)

hspd=lengthdir_x(spd,cdir);
vspd=lengthdir_y(spd,cdir);


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




if spd!=0{
	spr.set_sprite(spr_test_walk);
}else{
	spr.set_sprite(sprites.stand);
}

var sdir=dir
spr.step(sdir+45+camera.orbit.dir);
dbug.trace.add(dir,cdir);
dbug.trace.add(dir,dir+cdir);
/*********************/dbug.trace.add("------------------",camera.orbit.dir);



dbug.trace.add("anim_angle",spr.anim_angle);
dbug.trace.add("anim_frame",spr.anim_frame);
dbug.trace.add("anim_length",spr.anim_length);
dbug.trace.add("anim_speed",spr.anim_speed);
dbug.trace.add("image",spr.image);
dbug.trace.add("sub",spr.sub);
dbug.trace.add("sub_angle",spr.sub_angle);

