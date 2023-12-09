key_jump_pressed=keyboard_check_pressed(key_jump)

xspd=(keyboard_check(key_right)-keyboard_check(key_left));
yspd=(keyboard_check(key_down)-keyboard_check(key_up));

var glen= point_distance(0,0,xspd,yspd);
var gdir=point_direction(0,0,xspd,yspd);
var gcam=camera.orbit.dir;
gdir+=gcam+90;
if abs(glen)>1{glen=1*sign(glen)};


//dir=rollover(dir,0,360)
//if abs(spd)>1{spd=1*sign(spd)}
//spd*=mspd

//var cdir=dir+(camera.orbit.dir+90)

xspd=lengthdir_x(glen,gdir)*mspd;
yspd=lengthdir_y(glen,gdir)*mspd;
if glen!=0{dir=gdir;}
dir=rollover(dir,0,360);

zspd+=grav
var zo=z-coll_offset
if key_jump_pressed{
	zspd=jspd	
}
collider.shape.position.x=x+xspd;
collider.shape.position.y=y;
collider.shape.position.z=zo;

with wall{
	if collider.check_collider(other.collider){
		other.xspd=0;

	}
}
collider.shape.position.x=x
collider.shape.position.y=y+yspd;
collider.shape.position.z=zo;

with wall{
	if collider.check_collider(other.collider){

		other.yspd=0;
	}
}
collider.shape.position.x=x
collider.shape.position.y=y;
collider.shape.position.z=zo+zspd;

with wall{
	if collider.check_collider(other.collider){

		other.zspd=0;
	}
}




if z+zspd>0{
	zspd=0	
}



x+=xspd;
y+=yspd;
z+=zspd;

collider.shape.position.x=x;
collider.shape.position.y=y;
collider.shape.position.z=zo;

/// @description 

/*
mspd=keyboard_check(vk_shift)?0.5:4;
hspd=input.move[0]
vspd=input.move[1]

jump_key_pressed=keyboard_check_pressed(vk_space);
jump_key_hold=keyboard_check(vk_space);

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

collider.shape.position.x=x+hspd;
collider.shape.position.y=y;

with wall{
	if collider.check_collider(other.collider){
		other.hspd=0;

	}
}

collider.shape.position.x=x
collider.shape.position.y=y+vspd;

with wall{
	if collider.check_collider(other.collider){

		other.vspd=0;
	}
}

//JUMP
if collider.check_collider(prime.collider){
		
}

if jump_key_pressed and jump_count<jump_max{
	jump_count++;
	jump_timer=jump_hold_frames;
}
if not jump_key_hold{jump_timer=0}
if jump_timer>0{
	zspd=-jump_spd;
	jump_timer--
}


//var colx=false
//var coly=false

//with wall{
//	player_.shape.position.x+=player_.hspd;
//	if shape.check_aabb(player_.shape){colx=true;}
//	player_.shape.position.x=player_.x
//	player_.shape.position.y+=player_.vspd;
	
//	//dbug.trace.add( shape.check_aabb(player_.shape));
//	if shape.check_aabb(player_.shape){coly=true;}
//	player_.shape.position.y=player_.y;
	
//}
//if colx{hspd=0;}
//if coly{vspd=0;}

//if place_meeting_3d(x+hspd,y,wall){
//	while(!place_meeting_3d(x+sign(hspd),y,wall)){
//		x+=sign(hspd);	
//	}
//	hspd=0;
//}
//if place_meeting_3d(x,y+vspd,wall){
//	while(!place_meeting_3d(x,y+sign(vspd),wall)){
//		y+=sign(vspd);	
//	}
//	vspd=0;
//}

x+=hspd;
y+=vspd;
z+=zspd;

collider.shape.position.x=x;
collider.shape.position.y=y;
collider.shape.position.z=z-coll_offset;

//sphere.position.x=x;
//sphere.position.y=y;

if glen!=0{
	spr.set_sprite(sprites.walk);
	status="walk";
}else{
	spr.set_sprite(sprites.stand);
	status="stand";
}


spr.step(dir);
*/