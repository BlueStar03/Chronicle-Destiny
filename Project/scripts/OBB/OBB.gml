function OBB(position, size, orientation) constructor {
	self.position = position;				// Vec3
	self.size = size;						// Vec3
	self.orientation = orientation;			// mat3
	
static dbug_draw = function(col=c_white) {
    var vbuff = vertex_create_buffer();
    vertex_begin(vbuff, v_format);

    // Corner points of the box
    var x0 = -size.X;
    var x1 = size.X;
    var y0 = -size.Y;
    var y1 = size.Y;
    var z0 = -size.Z;
    var z1 = size.Z;

    // Define the corners of the box
    var corners = [
        [x0, y0, z0],
        [x1, y0, z0],
        [x1, y1, z0],
        [x0, y1, z0],
        [x0, y0, z1],
        [x1, y0, z1],
        [x1, y1, z1],
        [x0, y1, z1]
    ];

    // Transform each corner using the orientation matrix
    for (var i = 0; i < 8; i++) {
        var transformed_corner = matrix_transform_vertex(orientation, corners[i][0], corners[i][1], corners[i][2]);
        // Add position to the transformed corner
        corners[i] = new Vector3(transformed_corner[0] + position.X, transformed_corner[1] + position.Y, transformed_corner[2] + position.Z);
    }

    // Draw the edges of the box
    // Bottom face
    vertex_add(vbuff, corners[0].X, corners[0].Y, corners[0].Z, col);
    vertex_add(vbuff, corners[1].X, corners[1].Y, corners[1].Z, col);
    vertex_add(vbuff, corners[1].X, corners[1].Y, corners[1].Z, col);
    vertex_add(vbuff, corners[2].X, corners[2].Y, corners[2].Z, col);
    vertex_add(vbuff, corners[2].X, corners[2].Y, corners[2].Z, col);
    vertex_add(vbuff, corners[3].X, corners[3].Y, corners[3].Z, col);
    vertex_add(vbuff, corners[3].X, corners[3].Y, corners[3].Z, col);
    vertex_add(vbuff, corners[0].X, corners[0].Y, corners[0].Z, col);

    // Top face
    vertex_add(vbuff, corners[4].X, corners[4].Y, corners[4].Z, col);
    vertex_add(vbuff, corners[5].X, corners[5].Y, corners[5].Z, col);
    vertex_add(vbuff, corners[5].X, corners[5].Y, corners[5].Z, col);
    vertex_add(vbuff, corners[6].X, corners[6].Y, corners[6].Z, col);
    vertex_add(vbuff, corners[6].X, corners[6].Y, corners[6].Z, col);
    vertex_add(vbuff, corners[7].X, corners[7].Y, corners[7].Z, col);
    vertex_add(vbuff, corners[7].X, corners[7].Y, corners[7].Z, col);
    vertex_add(vbuff, corners[4].X, corners[4].Y, corners[4].Z, col);

    // Vertical edges
    vertex_add(vbuff, corners[0].X, corners[0].Y, corners[0].Z, col);
    vertex_add(vbuff, corners[4].X, corners[4].Y, corners[4].Z, col);
    vertex_add(vbuff, corners[1].X, corners[1].Y, corners[1].Z, col);
    vertex_add(vbuff, corners[5].X, corners[5].Y, corners[5].Z, col);
    vertex_add(vbuff, corners[2].X, corners[2].Y, corners[2].Z, col);
    vertex_add(vbuff, corners[6].X, corners[6].Y, corners[6].Z, col);
    vertex_add(vbuff, corners[3].X, corners[3].Y, corners[3].Z, col);
    vertex_add(vbuff, corners[7].X, corners[7].Y, corners[7].Z, col);

    // Draw the center cross at the position
    vertex_add(vbuff, position.X - 1, position.Y, position.Z, col);
    vertex_add(vbuff, position.X + 1, position.Y, position.Z, col);
    vertex_add(vbuff, position.X, position.Y - 1, position.Z, col);
    vertex_add(vbuff, position.X, position.Y + 1, position.Z, col);
    vertex_add(vbuff, position.X, position.Y, position.Z - 1, col);
    vertex_add(vbuff, position.X, position.Y, position.Z + 1, col);

    vertex_end(vbuff);
    vertex_submit(vbuff, pr_linelist, -1);
    vertex_delete_buffer(vbuff);
};








}

