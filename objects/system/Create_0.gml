/// @description Insert description here
// You can write your code in this editor
game.platform=new Platform();
game.display= new Display(640,360,2);
game.camera=new Camera();
game.input=new Input();
game.dbug=new Dbug();


vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
game.vertex_format = vertex_format_end();

//////////////////////////////////////////

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_texrepeat(true);
gpu_set_alphatestenable(true);

//cam_dist=50;
//cam_pitch=90-35.264;
//cam_dir=90;
//cam_height=32;
//cam_x=0;
//cam_y=0;
//cam_z=16;
//cam_z_offset=16


//floor
model = vertex_create_buffer();
vertex_begin(model, game.vertex_format);


var w=room_width;
var h=room_height;
var d=-1
var u=w/32;
var v=h/32;

vertex_add_point(model, 0, 0, d,			0, 0, 1,        0, 0,       c_white, 1);
vertex_add_point(model, w, 0, d,			0, 0, 1,        u, 0,       c_white, 1);
vertex_add_point(model, w, h, d,			0, 0, 1,        u, v,       c_white, 1);

vertex_add_point(model, w, h, d,			0, 0, 1,        u, v,       c_white, 1);
vertex_add_point(model, 0, h, d,			0, 0, 1,        0, v,       c_white, 1);
vertex_add_point(model, 0, 0, d,			0, 0, 1,        0, 0,       c_white, 1);

vertex_end(model);


///////////////////////////////////////////



//init_system();