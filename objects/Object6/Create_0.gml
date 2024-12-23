/// @description Insert description here
// You can write your code in this editor
vbuffer=vertex_create_buffer();
vertex_begin(vbuffer,vertex_format);
var s=16
var t=s*2
for (var i=0;i<room_width;i+=s){
    for(var j=0;j<room_height;j+=s){
        var c_color=c_red
        if ((i%t==0 and j%t==0)or(i%t>0 and j%t>0)){
            var c_color=#003300;
        }else{
            var c_color=#006600;
        }
        vertex_point_add(vbuffer,i,j,0,0,0,0,0,0,c_color);
        vertex_point_add(vbuffer,i+s,j,0,0,0,0,0,0,c_color);
        vertex_point_add(vbuffer,i+s,j+s,0,0,0,0,0,0,c_color);
    
        vertex_point_add(vbuffer,i+s,j+s,0,0,0,0,0,0,c_color);
        vertex_point_add(vbuffer,i,j+s,0,0,0,0,0,0,c_color);
        vertex_point_add(vbuffer,i,j,0,0,0,0,0,0,c_color);
    }
}

//var x1=0;
//var y1=0;
//var x2=100;
//var y2=100;
//
//vertex_point_add(vbuffer,x1,y1,0,0,0,0,0,0)
//vertex_point_add(vbuffer,x2,y1,0,0,0,0,0,0)
//vertex_point_add(vbuffer,x2,y2,0,0,0,0,0,0)
////vertex_point_add(vbuffer,x1,y1,0,0,0,0,0,0)

vertex_end(vbuffer)