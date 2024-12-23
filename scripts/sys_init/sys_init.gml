#macro null undefined
#macro c_random make_color_rgb(irandom(255),irandom(255),irandom(255))
#macro c_cornflower $ed9564	





#macro cam global._camera

_camera=new sysCamera();


#macro vertex_format global._vertex_format
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
_vertex_format = vertex_format_end();

///@function vertex_point_add(buff,x,y,z,nx,ny,nz,u,v, col, a)
///@description Adds a point to a vertex buffer.
///@param buffer
///@param x
///@param y
///@param z
///@param nx
///@param ny
///@param nz
///@param u
///@param v
///@param col
///@param a
function vertex_point_add(buffer, xx, yy, zz, nx, ny, nz, uu, vv,col=c_white,a=1) {
    vertex_position_3d(buffer,xx,yy,zz);
    vertex_normal(buffer,nx,ny,nz); 
    vertex_texcoord(buffer,uu,vv);
    vertex_color(buffer,col,a);
}
