#macro vertex_format global._vertex_format
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
_vertex_format = vertex_format_end();

///@function vertex_point_add(buff,x,y,z,nx,ny,nz,u,v)
///@description Adds a point to a vertex buffer.
///@param buffer {Id.VertexBuffer}  Vertex Buffer to add the vertex
///@param x		{Real}								x position of the vertex
///@param y		{Real}								y position of the vertex
///@param z		{Real}								z position of the vertex
///@param nx	{Real}								x normal of the vertex
///@param ny	{Real}								y normal of the vertex
///@param nz	{Real}								z normal of the vertex
///@param u		{Real}								u coord of the vertex
///@param v		{Real}								v coord of the vertex
function vertex_point_add(buffer, xx, yy, zz, nx, ny, nz, uu, vv) {
	vertex_position_3d(buffer,xx,yy,zz);
	vertex_normal(buffer,nx,ny,nz);
	
	vertex_texcoord(buffer,uu,vv);
	vertex_color(buffer,c_white,1);
}

///@fuction model_block(x1,y1,z1,x2,y2,z2,hrepeat,vrepeat)
///@description Creates a block model 
///@param x1
///@param y1
///@param z1
///@param x2
///@param y2
///@param z2
///@param hrepeat
///@param vrepeat
///@param zrepeat
function model_block(x1,y1,z1,x2,y2,z2,hrepeat=1,vrepeat=1,zrepeat=1) {
	var vb = vertex_create_buffer();

	vertex_begin(vb, vertex_format);

	//bottom
	vertex_point_add(vb,	x1,y1,z1,	0,0,-1,	0,0);
	vertex_point_add(vb,	x1,y2,z1,	0,0,-1,	0,vrepeat);
	vertex_point_add(vb,	x2,y2,z1,	0,0,-1,	hrepeat,vrepeat);
												
	vertex_point_add(vb,	x2,y2,z1,	0,0,-1,	hrepeat,vrepeat);
	vertex_point_add(vb,	x2,y1,z1,	0,0,-1,	hrepeat,0);
	vertex_point_add(vb,	x1,y1,z1,	0,0,-1,	0,0);
	//top								
	vertex_point_add(vb,	x1,y1,z2,	0,0,1,	0,0);
	vertex_point_add(vb,	x2,y1,z2,	0,0,1,	hrepeat,0);
	vertex_point_add(vb,	x2,y2,z2,	0,0,1,	hrepeat,vrepeat);
										
	vertex_point_add(vb,	x2,y2,z2,	0,0,1,	hrepeat,vrepeat);
	vertex_point_add(vb,	x1,y2,z2,	0,0,1,	0,vrepeat);
	vertex_point_add(vb,	x1,y1,z2,	0,0,1,	0,0);
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
	return vb;
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
//function draw_3d_model(model,texture,xx,yy,zz){
//	var matrix=matrix_build(xx,yy,zz,0,0,0,1,1,1);
//	matrix_set(matrix_world,matrix)
//	vertex_submit(model, pr_trianglelist, texture);
//	matrix_set(matrix_world,matrix_build_identity())
//}




function Billboard(spr)constructor{
	sprite_index=spr_error;
	image_index=0;
	sub_animation=0;
	draw_index=0;
	image_speed=0.2;
	dir=0;
	sprite_lenght=1;
	init=function(spr){
		sprite_index=spr;
		sprite_lenght=sprite_get_number(spr);
		sub_animation=sprite_lenght/8;
	}
	step=function(dir){
		dir=dir

		
		image_index+=image_speed;
		image_index=rollover(image_index,0,sub_animation)
		
		var ldir=rollover(dir+(-cam.dir),0,365)
		var idir=rollover((round(ldir/45)-2),0,8)

		
		draw_index=floor(image_index)+(sub_animation*idir)


		
	}
	
	draw=function(x,y,z){
		draw_3d_billboard(sprite_index,draw_index,x,y,z)
	}
	init(spr);
}

