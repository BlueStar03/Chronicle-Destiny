#macro vMAJOR 0        // Major version: Full releases and major milestones
#macro vMINOR 1        // Minor version: New features
#macro vCANARY 6       // Canary builds: Iterative, small steps
#macro VERSION "v" + string(vMAJOR) + "." + string(vMINOR) + "." + string(vCANARY)

#macro null undefined

#macro	c_random make_color_rgb(irandom(255),irandom(255),irandom(255))
#macro c_cornflowerblue #6495ed

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

gpu_set_texrepeat(true);
gpu_set_cullmode(cull_noculling);

//***************************************

#macro PLATFORM global.__platform
__platform=new Platform(); 

#macro DISPLAY global._display
_display=new Display(640,360,2);


//***********************************


#macro dbug global.__dbug
__dbug=new Dbug(); 