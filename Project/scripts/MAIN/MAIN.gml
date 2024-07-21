#macro BBMOD_MATERIAL_DEFAULT -1

#macro	c_random make_color_rgb(irandom(255),irandom(255),irandom(255))

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

gpu_set_texrepeat(true);
gpu_set_cullmode(cull_noculling);




#macro display global.__display
__display=new Display(640,360,1);//(480,272,1); (640,360,2);(1280,720,2);(1920,1080,2);

#macro camera global.__camera
__camera=new Camera(); 

#macro input global.__input
__input=new Input(); 

#macro tmap global.__tmap
__tmap=new Tmap();

#macro dbug global.__dbug
__dbug=new Dbug(); 


