

#macro display global._display
_display=new Display(640,360,2);//(480,272,2); 240,160   480,272    (640,360,2);




#macro c_random make_color_rgb(irandom(255),irandom(255),irandom(255))
#macro c_cornflower $ed9564	

#macro camera global._camera
_camera=new Camera();

#macro input global._input
_input=new Input();



#macro dbug global._dbug
_dbug=new Dbug();

enum rainbowcolours
{
    red,
    orange,
    yellow,
    green,
    blue,
    indigo,
    violet
}