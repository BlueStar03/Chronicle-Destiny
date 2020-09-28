/// @description 
model = vertex_create_buffer();
vertex_begin(model, game.vertex_format);
var x1=0;
var y1=0;
var z1=0;
var x2=16;
var y2=16;
var z2=16;



        #region add data to the vertex buffer
		//bottom face
        vertex_add_point(model, x1, y1, z1,			0, 0, 1,        0, 0,       c_white, 1);
        vertex_add_point(model, x2, y1, z1,			0, 0, 1,        1, 0,       c_white, 1);
        vertex_add_point(model, x2, y2, z1,			0, 0, 1,        1, 1,       c_white, 1);

        vertex_add_point(model, x2,y2, z1,          0, 0, 1,        1, 1,       c_white, 1);
        vertex_add_point(model, x1, y2, z1,			0, 0, 1,        0, 1,       c_white, 1);
        vertex_add_point(model, x1, x1, z1,			0, 0, 1,        0, 0,       c_white, 1);
		
		//back face
        vertex_add_point(model, x1, y1, z1,			0, 0, 1,        0, 0,       c_white, 1);
        vertex_add_point(model, x2, y1, z1,			0, 0, 1,        1, 0,       c_white, 1);
        vertex_add_point(model, x2, y1, z2,			0, 0, 1,        1, 1,       c_white, 1);

        vertex_add_point(model, x2,y1, z2,          0, 0, 1,        1, 1,       c_white, 1);
        vertex_add_point(model, x1, y1, z2,			0, 0, 1,        0, 1,       c_white, 1);
        vertex_add_point(model, x1, x1, z1,			0, 0, 1,        0, 0,       c_white, 1);
		
		//front face
        vertex_add_point(model, x1, y2, z1,			0, 0, 1,        0, 0,       c_white, 1);
        vertex_add_point(model, x2, y2, z1,			0, 0, 1,        1, 0,       c_white, 1);
        vertex_add_point(model, x2, y2, z2,			0, 0, 1,        1, 1,       c_white, 1);

        vertex_add_point(model, x2,y2, z2,          0, 0, 1,        1, 1,       c_white, 1);
        vertex_add_point(model, x1, y2, z2,			0, 0, 1,        0, 1,       c_white, 1);
        vertex_add_point(model, x1, x2, z1,			0, 0, 1,        0, 0,       c_white, 1);
		
		//Top Face
		vertex_add_point(model, x1, y1, z2,			0, 0, 1,        0, 0,       c_white, 1);
        vertex_add_point(model, x2, y1, z2,			0, 0, 1,        1, 0,       c_white, 1);
        vertex_add_point(model, x2, y2, z2,			0, 0, 1,        1, 1,       c_white, 1);

        vertex_add_point(model, x2,y2, z2,          0, 0, 1,        1, 1,       c_white, 1);
        vertex_add_point(model, x1, y2, z2,			0, 0, 1,        0, 1,       c_white, 1);
        vertex_add_point(model, x1, x1, z2,			0, 0, 1,        0, 0,       c_white, 1);
		
		//left Face
		vertex_add_point(model, x1, y1, z2,			0, 0, 1,        0, 0,       c_white, 1);
        vertex_add_point(model, x1, y1, z1,			0, 0, 1,        1, 0,       c_white, 1);
        vertex_add_point(model, x1, y2, z1,			0, 0, 1,        1, 1,       c_white, 1);

        vertex_add_point(model, x1,y2, z1,          0, 0, 1,        1, 1,       c_white, 1);
        vertex_add_point(model, x1, y2, z2,			0, 0, 1,        0, 1,       c_white, 1);
        vertex_add_point(model, x1, x1, z2,			0, 0, 1,        0, 0,       c_white, 1);
		
		//left Face
		vertex_add_point(model, x2, y1, z2,			0, 0, 1,        0, 0,       c_white, 1);
        vertex_add_point(model, x2, y1, z1,			0, 0, 1,        1, 0,       c_white, 1);
        vertex_add_point(model, x2, y2, z1,			0, 0, 1,        1, 1,       c_white, 1);

        vertex_add_point(model, x2,y2, z1,          0, 0, 1,        1, 1,       c_white, 1);
        vertex_add_point(model, x2, y2, z2,			0, 0, 1,        0, 1,       c_white, 1);
        vertex_add_point(model, x2, x1, z2,			0, 0, 1,        0, 0,       c_white, 1);
		
		
        #endregion



vertex_end(model);