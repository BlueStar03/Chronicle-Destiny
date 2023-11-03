gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

gpu_set_texrepeat(true);
gpu_set_cullmode(cull_noculling);


#macro v_format global._vertex_format
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
_vertex_format = vertex_format_end();

#macro obj_format global._obj_format
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_color();
vertex_format_add_texcoord();

_obj_format = vertex_format_end();

///@function vertex_point_add(buff,x,y,z,nx,ny,nz,u,v)
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
function vertex_point_add(buffer, xx, yy, zz, nx, ny, nz, uu, vv, col=c_white, a=1) {
	vertex_position_3d(buffer,xx,yy,zz);
	vertex_normal(buffer,nx,ny,nz);
	
	vertex_texcoord(buffer,uu,vv);
	vertex_color(buffer,col,a);
}



///@fuction draw_3d_model(model,texture,xx,yy,zz,rx=0,ry=0,rz=0,sx=1,sy=1,sz=1)
///@description Draws a model
///@param model
///@param texture
///@param xx
///@param yy
///@param zz
///@param rx
///@param ry
///@param rz
///@param sx
///@param sy
///@param sz
function draw_3d_model(model,texture,xx,yy,zz,rx=0,ry=0,rz=0,sx=1,sy=1,sz=1){
	var matrix=matrix_build(xx,yy,zz,rx,ry,rz,sx,sy,sz);
	matrix_set(matrix_world,matrix)
	vertex_submit(model, pr_trianglelist, texture);
	matrix_set(matrix_world,matrix_build_identity())
}


function model_block(x1,y1,z1,x2,y2,z2,hrepeat=1,vrepeat=1,zrepeat=1) {
	var vb = vertex_create_buffer();

	vertex_begin(vb, v_format);

	//bottom
	vertex_point_add(vb,	x1,y1,z1,	0,0,1,	0,0);
	vertex_point_add(vb,	x1,y2,z1,	0,0,1,	0,vrepeat);
	vertex_point_add(vb,	x2,y2,z1,	0,0,1,	hrepeat,vrepeat);
												
	vertex_point_add(vb,	x2,y2,z1,	0,0,1,	hrepeat,vrepeat);
	vertex_point_add(vb,	x2,y1,z1,	0,0,1,	hrepeat,0);
	vertex_point_add(vb,	x1,y1,z1,	0,0,1,	0,0);
	////top								
	vertex_point_add(vb,	x1,y1,z2,	0,0,-1,	0,0);
	vertex_point_add(vb,	x2,y1,z2,	0,0,-1,	hrepeat,0);
	vertex_point_add(vb,	x2,y2,z2,	0,0,-1,	hrepeat,vrepeat);
										
	vertex_point_add(vb,	x2,y2,z2,	0,0,-1,	hrepeat,vrepeat);
	vertex_point_add(vb,	x1,y2,z2,	0,0,-1,	0,vrepeat);
	vertex_point_add(vb,	x1,y1,z2,	0,0,-1,	0,0);
	//front								
	vertex_point_add(vb,	x1,y2,z1,	0,1,0,	0,0);
	vertex_point_add(vb,	x1,y2,z2,	0,1,0,	0,zrepeat);
	vertex_point_add(vb,	x2,y2,z2,	0,1,0,	hrepeat,zrepeat);
												
	vertex_point_add(vb,	x2,y2,z2,	0,1,0,	hrepeat,zrepeat);
	vertex_point_add(vb,	x2,y2,z1,	0,1,0,	hrepeat,0);
	vertex_point_add(vb,	x1,y2,z1,	0,1,0,	0,0);
	//right										
	vertex_point_add(vb,	x2,y2,z1,	1,0,0,	0,0);
	vertex_point_add(vb,	x2,y2,z2,	1,0,0,	0,zrepeat);
	vertex_point_add(vb,	x2,y1,z2,	1,0,0,	vrepeat,zrepeat);
												
	vertex_point_add(vb,	x2,y1,z2,	1,0,0,	vrepeat,zrepeat);
	vertex_point_add(vb,	x2,y1,z1,	1,0,0,	vrepeat,0);
	vertex_point_add(vb,	x2,y2,z1,	1,0,0,	0,0);
	//back								
	vertex_point_add(vb,	x2,y1,z1,	0,-1,0,	0,0);
	vertex_point_add(vb,	x2,y1,z2,	0,-1,0,	0,zrepeat);
	vertex_point_add(vb,	x1,y1,z2,	0,-1,0,	hrepeat,zrepeat);
												
	vertex_point_add(vb,	x1,y1,z2,	0,-1,0,	hrepeat,zrepeat);
	vertex_point_add(vb,	x1,y1,z1,	0,-1,0,	hrepeat,0);
	vertex_point_add(vb,	x2,y1,z1,	0,-1,0,	0,0);
	//											
	vertex_point_add(vb,	x1,y1,z1,	-1,0,0,	0,0);
	vertex_point_add(vb,	x1,y1,z2,	-1,0,0,	0,zrepeat);
	vertex_point_add(vb,	x1,y2,z2,	-1,0,0,	vrepeat,zrepeat);
												
	vertex_point_add(vb,	x1,y2,z2,	-1,0,0,	vrepeat,zrepeat);
	vertex_point_add(vb,	x1,y2,z1,	-1,0,0,	vrepeat,0);
	vertex_point_add(vb,	x1,y1,z1,	-1,0,0,	0,0);

	vertex_end(vb);
	vertex_freeze(vb);
	return vb;
}
