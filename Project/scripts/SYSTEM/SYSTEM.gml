#macro vMAJOR 0
#macro vMINOR 1
#macro vPATCH 0
#macro vCANARY 5
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


#macro input global.___input
___input=new Input();
