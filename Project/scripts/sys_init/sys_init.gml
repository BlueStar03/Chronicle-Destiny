#macro camera global._camera
_camera=new Camera();

#macro dbug global._dbug
_dbug=new Dbug();

#macro xoff global._xoff
_xoff=0;

#macro yoff global._yoff
_yoff=0;


gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

gpu_set_texrepeat(true);
gpu_set_cullmode(cull_counterclockwise)