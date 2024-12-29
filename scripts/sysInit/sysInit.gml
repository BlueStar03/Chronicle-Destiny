#macro null undefined
#macro c_random make_color_rgb(irandom(255),irandom(255),irandom(255))
#macro c_cornflower $ed9564	

#macro camera global._camera
_camera=new Camera();


gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);
gpu_set_cullmode(cull_noculling);

gpu_set_texrepeat(true)



#macro v_format global._v_format
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
_v_format = vertex_format_end();