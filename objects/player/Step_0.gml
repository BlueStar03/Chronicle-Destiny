/// @description 
//if gamepad_is_connected(0){
//	var g_len=point_distance(0,0,gamepad_axis_value(0, gp_axislh),gamepad_axis_value(0, gp_axislv))
//	var g_dir= abs(g_len)<0.1?0:point_direction(0,0,gamepad_axis_value(0, gp_axislh),gamepad_axis_value(0, gp_axislv))
	
//	var c_dir=point_direction(player.x,player.y,game.camera.x,game.camera.y);
//	var n_dir=g_dir+(c_dir-270);
//	hspd=lengthdir_x(g_len,n_dir);
//	vspd=lengthdir_y(g_len,n_dir);
//	////rot_z=-(game.cam_dir-90)
//	////hspd = gamepad_axis_value(0, gp_axislh);
//	////vspd = gamepad_axis_value(0, gp_axislv);
//}else{
//	var _hspd=keyboard_check(ord("D"))-keyboard_check(ord("A"));
//	var _vspd=keyboard_check(ord("S"))-keyboard_check(ord("W"));
//	var _len=(point_distance(0,0,_hspd,_vspd)==0)?0:1;
//	var _dir=point_direction(0,0,_hspd,_vspd)
	
//	var c_dir=point_direction(player.x,player.y,game.camera.x,game.camera.y);
//	var n_dir=_dir+(c_dir-270);
//	hspd=lengthdir_x(_len,n_dir);
//	vspd=lengthdir_y(_len,n_dir);
	
//}
var _hspd=game.input.horizontal_l.current;
var _vspd=game.input.vertical_l.current;
var _len=point_distance(0,0,_hspd,_vspd)
var _dir=point_direction(0,0,_hspd,_vspd)

//_dir+=-game.camera.direction;

var c_dir=point_direction(player.x,player.y,game.camera.x,game.camera.y);
var n_dir=_dir+(c_dir-270);
hspd=lengthdir_x(_len,n_dir);
vspd=lengthdir_y(_len,n_dir);

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
