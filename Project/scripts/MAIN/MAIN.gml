#macro vMAJOR 0
#macro vMINOR 1
#macro vPATCH 0
#macro vCANARY 6
#macro VERSION "v" + string(vMAJOR) + "." + string(vMINOR) + "." + string(vPATCH)+ "." +string(vCANARY)

#macro null undefined

#macro BBMOD_MATERIAL_DEFAULT -1

#macro	c_random make_color_rgb(irandom(255),irandom(255),irandom(255))
#macro c_cornflowerblue #6495ed

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

gpu_set_texrepeat(true);
gpu_set_cullmode(cull_noculling);
<<<<<<< HEAD
=======
#endregion

#region SYSTEM
>>>>>>> parent of d5c9fa5 (collisions wip)

#macro data global.__data
__data=new Data(1); 

#macro platform global.__platform
__platform=new Platform(); 


var d_set=data.settings.sys_display
#macro display global.__display
__display=new Display(d_set.width,d_set.height,d_set.scale,d_set.fullscreen);//(480,272,1); (640,360,2);(1280,720,2);(1920,1080,2);

#macro camera global.__camera
__camera=new Camera(); 

var i_set=data.settings.sys_input
#macro input global.__input
__input=new Input(i_set.mode); 

var b_set=data.settings.sys_dbug
#macro dbug global.__dbug
__dbug=new Dbug(b_set.on,b_set.system,b_set.tracker,b_set.level,b_set.screen,b_set.build,b_set.controls,b_set.touch,b_set.collision); 



