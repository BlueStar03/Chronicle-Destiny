function draw_text_outline(x,y,str,c_str=c_white,c_out=c_black,out=1,q=45){
    var c_temp=draw_get_color()
    draw_set_color(c_out)
    for (var i=0;i<360;i+=q){
        var ox=lengthdir_x(out,i);
        var oy=lengthdir_y(out,i);
        draw_text(x+ox,y+oy,str)
    }
    
    draw_set_color(c_str)
    draw_text(x,y,str)
    
    draw_set_color(c_temp)
}
