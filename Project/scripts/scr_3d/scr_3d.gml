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

///@function vertex_point_add(buff,x,y,z,[col],[a],[u],[v],[nx],[ny],[nz])
///@description Adds a point to a vertex buffer.
///@param buffer
///@param x
///@param y
///@param z
///@param [col]
///@param [a]
///@param [u]
///@param [v]
///@param [nx]
///@param [ny]
///@param [nz]

function vertex_point_add(buffer,x,y,z,col=c_white,a=1,u=0,v=0,nx=0,ny=0,nz=1 ) {
	vertex_position_3d(buffer,x,y,z);
	vertex_normal(buffer,nx,ny,nz);	
	vertex_texcoord(buffer,u,v);
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
	vertex_point_add(vb,	x1,y1,z1,,,0,0				,	0,0,1		);
	vertex_point_add(vb,	x1,y2,z1,,,0,vrepeat		,	0,0,1		);
	vertex_point_add(vb,	x2,y2,z1,,,hrepeat,vrepeat	,	0,0,1		);
														
	vertex_point_add(vb,	x2,y2,z1,,,hrepeat,vrepeat	,	0,0,1		);
	vertex_point_add(vb,	x2,y1,z1,,,hrepeat,0		,	0,0,1		);
	vertex_point_add(vb,	x1,y1,z1,,,0,0				,	0,0,1		);
	////top												
	vertex_point_add(vb,	x1,y1,z2,,,0,0				,	0,0,-1		);
	vertex_point_add(vb,	x2,y1,z2,,,hrepeat,0		,	0,0,-1		);
	vertex_point_add(vb,	x2,y2,z2,,,hrepeat,vrepeat	,	0,0,-1		);
														
	vertex_point_add(vb,	x2,y2,z2,,,hrepeat,vrepeat	,	0,0,-1		);
	vertex_point_add(vb,	x1,y2,z2,,,0,vrepeat		,	0,0,-1		);
	vertex_point_add(vb,	x1,y1,z2,,,0,0				,	0,0,-1		);
	//front												
	vertex_point_add(vb,	x1,y2,z1,,,0,0				,	0,1,0		);
	vertex_point_add(vb,	x1,y2,z2,,,0,zrepeat		,	0,1,0		);
	vertex_point_add(vb,	x2,y2,z2,,,hrepeat,zrepeat	,	0,1,0		);
														
	vertex_point_add(vb,	x2,y2,z2,,,hrepeat,zrepeat	,	0,1,0		);
	vertex_point_add(vb,	x2,y2,z1,,,hrepeat,0		,	0,1,0		);
	vertex_point_add(vb,	x1,y2,z1,,,0,0				,	0,1,0		);
	//right							,					
	vertex_point_add(vb,	x2,y2,z1,,,0,0				,	1,0,0		);
	vertex_point_add(vb,	x2,y2,z2,,,0,zrepeat		,	1,0,0		);
	vertex_point_add(vb,	x2,y1,z2,,,vrepeat,zrepeat	,	1,0,0		);
														
	vertex_point_add(vb,	x2,y1,z2,,,vrepeat,zrepeat	,	1,0,0		);
	vertex_point_add(vb,	x2,y1,z1,,,vrepeat,0		,	1,0,0		);
	vertex_point_add(vb,	x2,y2,z1,,,0,0				,	1,0,0		);
	//back												
	vertex_point_add(vb,	x2,y1,z1,,,0,0				,	0,-1,0		);
	vertex_point_add(vb,	x2,y1,z2,,,0,zrepeat		,	0,-1,0		);
	vertex_point_add(vb,	x1,y1,z2,,,hrepeat,zrepeat	,	0,-1,0		);
														
	vertex_point_add(vb,	x1,y1,z2,,,hrepeat,zrepeat	,	0,-1,0		);
	vertex_point_add(vb,	x1,y1,z1,,,hrepeat,0		,	0,-1,0		);
	vertex_point_add(vb,	x2,y1,z1,,,0,0				,	0,-1,0		);
	//													
	vertex_point_add(vb,	x1,y1,z1,,,0,0				,	-1,0,0		);
	vertex_point_add(vb,	x1,y1,z2,,,0,zrepeat		,	-1,0,0		);
	vertex_point_add(vb,	x1,y2,z2,,,vrepeat,zrepeat	,	-1,0,0		);
												
	vertex_point_add(vb,	x1,y2,z2,,,vrepeat,zrepeat		-1,0,0,		);
	vertex_point_add(vb,	x1,y2,z1,,,vrepeat,0			-1,0,0,		);
	vertex_point_add(vb,	x1,y1,z1,,,0,0					-1,0,0,		);

	vertex_end(vb);
	vertex_freeze(vb);
	return vb;
}
