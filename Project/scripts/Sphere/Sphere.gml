function Sphere(position, radius) constructor {
    self.position = position; // Vec3
    self.radius = radius;     // Scalar value representing the radius
    
    static dbug_draw = function(col_center = c_white, col_outline = c_white) {
        var vbuff = vertex_create_buffer();
        vertex_begin(vbuff, v_format);

        var num_vertices = 16; 
        var angle_increment = 360 / num_vertices;

        // Create the transformation matrix to rotate the vertices to face the camera
        var dir_x = camera.to.X - camera.from.X;
        var dir_y = camera.to.Y - camera.from.Y;
        var dir_z = camera.to.Z - camera.from.Z;
        var dir_length = sqrt(sqr(dir_x) + sqr(dir_y) + sqr(dir_z));

        dir_x /= dir_length;
        dir_y /= dir_length;
        dir_z /= dir_length;

        var rot_x = -arctan2(dir_z, sqrt(sqr(dir_x) + sqr(dir_y)));
        var rot_y = arctan2(dir_x, dir_y);

        var mat_transform = matrix_build(0, 0, 0, radtodeg(rot_x) + 90, 0, radtodeg(rot_y), 1, 1, 1);

        var prev_x, prev_y, prev_z; // Previous vertex coordinates

        // Iterate through the circle, duplicating vertices for pr_linelist
        for (var i = 0; i <= num_vertices; i++) {
            var angle_rad = degtorad(i * angle_increment);
            var vertex_x = self.radius * cos(angle_rad);
            var vertex_y = self.radius * sin(angle_rad);
            var vertex_z = 0;

            // Apply the transformation to the vertex position
            var transformed_vertex = matrix_transform_vertex(mat_transform, vertex_x, vertex_y, vertex_z);

            var transformed_x = self.position.X + transformed_vertex[0];
            var transformed_y = self.position.Y + transformed_vertex[1];
            var transformed_z = self.position.Z + transformed_vertex[2];

            // For the first vertex, we just save it to connect with the next one
            if (i > 0) {
                // Add a line segment between the previous and current vertex
                vertex_add(vbuff, prev_x, prev_y, prev_z, col_outline);
                vertex_add(vbuff, transformed_x, transformed_y, transformed_z, col_outline);
            }

            // Save the current vertex for the next iteration
            prev_x = transformed_x;
            prev_y = transformed_y;
            prev_z = transformed_z;
        }

        vertex_end(vbuff);

        // Use pr_linelist to draw each pair of vertices as a line segment
        vertex_submit(vbuff, pr_linelist, -1);

        // Delete the vertex buffer to free memory
        vertex_delete_buffer(vbuff);
    };
}
