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
function model_block() {

	// Gets argument into variables
	var x1=argument[0];
	var y1=argument[1];
	var z1=argument[2];
	var x2=argument[3];
	var y2=argument[4];
	var z2=argument[5];
	var hrepeat=argument[6];
	var vrepeat=argument[7];
	var zrepeat=argument[8];

	var vb = vertex_create_buffer();

	vertex_begin(vb, game_.vertex_format);


	//bottom
	vertex_point_add(vb,x1,y1,z1,0,0,-1,0,0);
	vertex_point_add(vb,x1,y2,z1,0,0,-1,0,vrepeat);
	vertex_point_add(vb,x2,y2,z1,0,0,-1,hrepeat,vrepeat);

	vertex_point_add(vb,x2,y2,z1,0,0,-1,hrepeat,vrepeat);
	vertex_point_add(vb,x2,y1,z1,0,0,-1,hrepeat,0);
	vertex_point_add(vb,x1,y1,z1,0,0,-1,0,0);
	//top
	vertex_point_add(vb,x1,y1,z2,0,0,1,0,0);
	vertex_point_add(vb,x2,y1,z2,0,0,1,hrepeat,0);
	vertex_point_add(vb,x2,y2,z2,0,0,1,hrepeat,vrepeat);

	vertex_point_add(vb,x2,y2,z2,0,0,1,hrepeat,vrepeat);
	vertex_point_add(vb,x1,y2,z2,0,0,1,0,vrepeat);
	vertex_point_add(vb,x1,y1,z2,0,0,1,0,0);

	//front
	vertex_point_add(vb,x1,y2,z1,0,1,0,0,0);
	vertex_point_add(vb,x1,y2,z2,0,1,0,0,zrepeat);
	vertex_point_add(vb,x2,y2,z2,0,1,0,hrepeat,zrepeat);

	vertex_point_add(vb,x2,y2,z2,0,1,0,hrepeat,zrepeat);
	vertex_point_add(vb,x2,y2,z1,0,1,0,hrepeat,0);
	vertex_point_add(vb,x1,y2,z1,0,1,0,0,0);
	//right
	vertex_point_add(vb,x2,y2,z1,1,0,0,0,0);
	vertex_point_add(vb,x2,y2,z2,1,0,0,0,zrepeat);
	vertex_point_add(vb,x2,y1,z2,1,0,0,vrepeat,zrepeat);

	vertex_point_add(vb,x2,y1,z2,1,0,0,vrepeat,zrepeat);
	vertex_point_add(vb,x2,y1,z1,1,0,0,vrepeat,0);
	vertex_point_add(vb,x2,y2,z1,1,0,0,0,0);
	//back
	vertex_point_add(vb,x2,y1,z1,0,-1,0,0,0);
	vertex_point_add(vb,x2,y1,z2,0,-1,0,0,zrepeat);
	vertex_point_add(vb,x1,y1,z2,0,-1,0,hrepeat,zrepeat);

	vertex_point_add(vb,x1,y1,z2,0,-1,0,hrepeat,zrepeat);
	vertex_point_add(vb,x1,y1,z1,0,-1,0,hrepeat,0);
	vertex_point_add(vb,x2,y1,z1,0,-1,0,0,0);
	//
	vertex_point_add(vb,x1,y1,z1,-1,0,0,0,0);
	vertex_point_add(vb,x1,y1,z2,-1,0,0,0,zrepeat);
	vertex_point_add(vb,x1,y2,z2,-1,0,0,vrepeat,zrepeat);

	vertex_point_add(vb,x1,y2,z2,-1,0,0,vrepeat,zrepeat);
	vertex_point_add(vb,x1,y2,z1,-1,0,0,vrepeat,0);
	vertex_point_add(vb,x1,y1,z1,-1,0,0,0,0);



	vertex_end(vb);
	return vb;


}