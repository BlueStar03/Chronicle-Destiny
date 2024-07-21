/// @description Insert description here
// You can write your code in this editor
hspd=keyboard_check(vk_right)-keyboard_check(vk_left);
vspd=keyboard_check(vk_down)-keyboard_check(vk_up);
hspd*=mspd;
vspd*=mspd;
//calculate collisions
//Horizontal
if (place_meeting(x+hspd,y,oWall)){
	var _x=0;
	while(!place_meeting(x+_x,y,oWall)){
		_x+=sign(hspd);
	}
	hspd=_x-sign(hspd);
}
//Vertical
if (place_meeting(x,y+vspd,oWall)){
	var _y=0;
	while(!place_meeting(x,y+_y,oWall)){
		_y+=sign(vspd);	
	}
	vspd=_y-sign(vspd);
}


//apply movement
x+=hspd;
y+=vspd;


/// @desc Step event
var _anim = (hspd!=0 or vspd!=0) ? animWalk : animIdle;
animationPlayer.change(_anim, true); // true = loop the animation
animationPlayer.update(delta_time);