// @function			draw_text_outline(x,y,str,[c_str],[c_out],[out],[q])
/// @desc					This function draws a string with an outline at any position within the room
/// @arg	{real}								x						The x coordinate of the drawn string.
/// @arg	{real}								y						The y coordinate of the drawn string.
/// @arg	{string}							str					The string to draw.
/// @arg	{constant.color}			[c_str]			The color for the string.
/// @arg	{constant.color}			[c_out]			The color for the outline.
/// @arg	{real}								[out]				The thickness of the outline.
/// @arg	{real}								[q]					The quality.
/// @return {bool}
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

// @function				rollover(val,lo,hi)
/// @desc					check is same.
/// @arg	{real}			val			The number to evaluate.
/// @arg	{real}			lo			The lowesr number before a rollover.
/// @arg	{real}			hi			The highest number before a rollover.
function rollover (val,lo,hi){
	var range=hi-lo;
	var offset=(val-lo)%range;
	if (offset<0){offset+=range;}
	return lo+offset;
}

#macro v_format global.__v_format
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
__v_format=vertex_format_end();

function vertex_add(vbuffer,x,y,z,col=c_white,a=1,u=0,v=0,nx=0,ny=0,nz=1){
	vertex_position_3d(vbuffer,x,y,z);
	vertex_normal(vbuffer,nx,ny,nz);
	vertex_texcoord(vbuffer,u,v);
	vertex_color(vbuffer,col,a)
}

function model_block(x1,y1,z1,x2,y2,z2,hrepeat=1,vrepeat=1,zrepeat=1){
	var vb=vertex_create_buffer();
	vertex_begin(vb,v_format);
	//bottom
	vertex_add(vb,x1,y1,z1 ,,,0,0);
	vertex_add(vb,x1,y2,z1 ,,,0,vrepeat);
	vertex_add(vb,x2,y2,z1 ,,,hrepeat,vrepeat);
													
	vertex_add(vb,x2,y2,z1 ,,,hrepeat,vrepeat);
	vertex_add(vb,x2,y1,z1 ,,,hrepeat,0);
	vertex_add(vb,x1,y1,z1 ,,,0,0);
	//top
	vertex_add(vb,x1,y1,z2 ,,,0,0);
	vertex_add(vb,x1,y2,z2 ,,,0,vrepeat);
	vertex_add(vb,x2,y2,z2 ,,,hrepeat,vrepeat);
													
	vertex_add(vb,x2,y2,z2 ,,,hrepeat,vrepeat);
	vertex_add(vb,x2,y1,z2 ,,,hrepeat,0);
	vertex_add(vb,x1,y1,z2 ,,,0,0);
	////front
	vertex_add(vb,x1,y2,z1 ,,,0,zrepeat);
	vertex_add(vb,x1,y2,z2 ,,,0,0);
	vertex_add(vb,x2,y2,z2 ,,,hrepeat,0);
													
	vertex_add(vb,x2,y2,z2 ,,,hrepeat,0);
	vertex_add(vb,x2,y2,z1 ,,,hrepeat,zrepeat);
	vertex_add(vb,x1,y2,z1 ,,,0,zrepeat);
	//Back
	vertex_add(vb,x2,y1,z1 ,,,0,zrepeat);
	vertex_add(vb,x2,y1,z2 ,,,0,0);
	vertex_add(vb,x1,y1,z2 ,,,hrepeat,0);
												
	vertex_add(vb,x1,y1,z2 ,,,hrepeat,0);
	vertex_add(vb,x1,y1,z1 ,,,hrepeat,zrepeat);
	vertex_add(vb,x2,y1,z1 ,,,0,zrepeat);
	//right
	vertex_add(vb,x2,y2,z1 ,,,0,zrepeat);
	vertex_add(vb,x2,y2,z2 ,,,0,0);
	vertex_add(vb,x2,y1,z2 ,,,vrepeat,0);
												
	vertex_add(vb,x2,y1,z2 ,,,vrepeat,0);
	vertex_add(vb,x2,y1,z1 ,,,vrepeat,zrepeat);
	vertex_add(vb,x2,y2,z1 ,,,0,zrepeat);
	//left
	vertex_add(vb,x1,y2,z1 ,,,vrepeat,zrepeat);
	vertex_add(vb,x1,y2,z2 ,,,vrepeat,0);
	vertex_add(vb,x1,y1,z2 ,,,0,0);
									
	vertex_add(vb,x1,y1,z2 ,,,0,0);
	vertex_add(vb,x1,y1,z1 ,,,0,zrepeat);
	vertex_add(vb,x1,y2,z1 ,,,vrepeat,zrepeat);
	
	
	
	vertex_end(vb);
	return vb;
}


function draw_3d_model(model,texture,xx,yy,zz,rx=0,ry=0,rz=0,sx=1,sy=1,sz=1){
	var matrix=matrix_build(xx,yy,zz,rx,ry,rz,sx,sy,sz);
	matrix_set(matrix_world,matrix)
	vertex_submit(model, pr_trianglelist, texture);
	matrix_set(matrix_world,matrix_build_identity())
}