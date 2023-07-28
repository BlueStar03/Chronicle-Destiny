#macro c_cornflower $ed9564	

#macro display global._display
_display=new Display();

#macro camera global._camera
_camera=new Camera();


#macro dbug global._dbug
_dbug=new Dbug();




gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

gpu_set_texrepeat(true)
application_surface_draw_enable(false);



