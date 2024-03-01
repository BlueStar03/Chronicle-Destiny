/// @description Insert description here
// You can write your code in this editor
var zbuff = vertex_create_buffer();
vertex_begin(zbuff,v_format);

vertex_point_add(zbuff, start.x,start.y, start.z,c_white);
vertex_point_add(zbuff, finish.x,finish.y, finish.z,c_white);

vertex_end(zbuff);
vertex_submit(zbuff, pr_linelist, -1);
vertex_delete_buffer(zbuff);


























