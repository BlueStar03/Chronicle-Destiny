// Define the Capsule struct
function Capsule(line,radius)constructor {
    self.line=line;  // A Line struct containing start, finish, Direction(), and Length() methods
   self.radius=radius;  // Radius of the capsule

    // Method to draw the capsule wireframe
    function dbug_draw(segments = 16, color = c_white) {
        var vbuff = vertex_create_buffer();
        vertex_begin(vbuff, v_format);

        // Get the direction and length of the capsule's axis (from the Line struct)
        var dir = self.line.Direction();
        var length = self.line.Length();

        // Calculate yaw, pitch, and roll based on the axis direction
        var yaw = radtodeg(arctan2(dir.Y, dir.X));  // Rotation around the Z-axis
        var pitch = radtodeg(arcsin(-dir.Z)-(pi/2));       // Rotation around the X-axis
        var roll = 0;                               // No roll needed
				


        // Create the transformation matrix with position, rotation, and scaling
        var transform_matrix = matrix_build(self.line.start.X, self.line.start.Y, self.line.start.Z, yaw, pitch, roll, 1, 1, 1);

        // Function to apply the transformation matrix to a vertex
        function transform_vertex(tm, x, y, z) {
            var vtx = matrix_transform_vertex(tm, x, y, z);
            return new Vector3(vtx[0], vtx[1], vtx[2]);
        }

        // Draw the capsule wireframe
        var theta;

        // XY plane (z = 0) circle
        for (var i = 0; i < segments; i++) {
            theta = (i / segments) * 2 * pi;
            var next_theta = ((i + 1) / segments) * 2 * pi;

            var x1_xy = self.radius * cos(theta);
            var y1_xy = self.radius * sin(theta);
            var x2_xy = self.radius * cos(next_theta);
            var y2_xy = self.radius * sin(next_theta);

            var v1 = transform_vertex(transform_matrix, x1_xy, y1_xy, 0);
            var v2 = transform_vertex(transform_matrix, x2_xy, y2_xy, 0);

            vertex_add(vbuff, v1.X, v1.Y, v1.Z, color);
            vertex_add(vbuff, v2.X, v2.Y, v2.Z, color);
        }

        // XY plane (z = -length) circle
        for (var i = 0; i < segments; i++) {
            theta = (i / segments) * 2 * pi;
            var next_theta = ((i + 1) / segments) * 2 * pi;

            var x1_xy = self.radius * cos(theta);
            var y1_xy = self.radius * sin(theta);
            var x2_xy = self.radius * cos(next_theta);
            var y2_xy = self.radius * sin(next_theta);

            var v1 = transform_vertex(transform_matrix, x1_xy, y1_xy, -length);
            var v2 = transform_vertex(transform_matrix, x2_xy, y2_xy, -length);

            vertex_add(vbuff, v1.X, v1.Y, v1.Z, color);
            vertex_add(vbuff, v2.X, v2.Y, v2.Z, color);
        }

        // Variables to store the first and midpoint vertices for the XZ plane
        var first_x = 0, first_z = 0;
        var mid_x = 0, mid_z = 0;

        // XZ plane (y = 0) circle
        for (var i = 0; i < segments; i++) {
            theta = (i / segments) * 2 * pi;
            var next_theta = ((i + 1) / segments) * 2 * pi;

            var x1_xz = self.radius * cos(theta);
            var z1_xz = self.radius * sin(theta);
            var x2_xz = self.radius * cos(next_theta);
            var z2_xz = self.radius * sin(next_theta);

            if (i > segments / 2) {
                z1_xz -= length;
                z2_xz -= length;
            }

            // Store the first and midpoint vertices
            if (i == 0) { 
                first_x = x1_xz; 
                first_z = z1_xz; 
            }
            if (i == segments / 2) { 
                mid_x = x1_xz; 
                mid_z = z1_xz; 
            }

            var v1 = transform_vertex(transform_matrix, x1_xz, 0, z1_xz);
            var v2 = transform_vertex(transform_matrix, x2_xz, 0, z2_xz);

            vertex_add(vbuff, v1.X, v1.Y, v1.Z, color);
            vertex_add(vbuff, v2.X, v2.Y, v2.Z, color);
        }

        // Connect the first and midpoint vertices in the XZ plane
        var v1 = transform_vertex(transform_matrix, first_x, 0, first_z);
        var v2 = transform_vertex(transform_matrix, first_x, 0, first_z - length);
        vertex_add(vbuff, v1.X, v1.Y, v1.Z, color);
        vertex_add(vbuff, v2.X, v2.Y, v2.Z, color);

        var v1_mid = transform_vertex(transform_matrix, mid_x, 0, mid_z);
        var v2_mid = transform_vertex(transform_matrix, mid_x, 0, mid_z - length);
        vertex_add(vbuff, v1_mid.X, v1_mid.Y, v1_mid.Z, color);
        vertex_add(vbuff, v2_mid.X, v2_mid.Y, v2_mid.Z, color);

        // Variables to store the first and midpoint vertices for the YZ plane
        var first_y = 0, first_z_yz = 0;
        var mid_y = 0, mid_z_yz = 0;

        // YZ plane (x = 0) circle
        for (var i = 0; i < segments; i++) {
            theta = (i / segments) * 2 * pi;
            var next_theta = ((i + 1) / segments) * 2 * pi;

            var y1_yz = self.radius * cos(theta);
            var z1_yz = self.radius * sin(theta);
            var y2_yz = self.radius * cos(next_theta);
            var z2_yz = self.radius * sin(next_theta);

            if (i > segments / 2) {
                z1_yz -= length;
                z2_yz -= length;
            }

            // Store the first and midpoint vertices in the YZ plane
            if (i == 0) {
                first_y = y1_yz;
                first_z_yz = z1_yz;
            }
            if (i == segments / 2) {
                mid_y = y1_yz;
                mid_z_yz = z1_yz;
            }

            var v1 = transform_vertex(transform_matrix, 0, y1_yz, z1_yz);
            var v2 = transform_vertex(transform_matrix, 0, y2_yz, z2_yz);

            vertex_add(vbuff, v1.X, v1.Y, v1.Z, color);
            vertex_add(vbuff, v2.X, v2.Y, v2.Z, color);
        }

        // Connect the first and midpoint vertices in the YZ plane
        var v1_yz = transform_vertex(transform_matrix, 0, first_y, first_z_yz);
        var v2_yz = transform_vertex(transform_matrix, 0, first_y, first_z_yz - length);
        vertex_add(vbuff, v1_yz.X, v1_yz.Y, v1_yz.Z, color);
        vertex_add(vbuff, v2_yz.X, v2_yz.Y, v2_yz.Z, color);

        var v1_mid_yz = transform_vertex(transform_matrix, 0, mid_y, mid_z_yz);
        var v2_mid_yz = transform_vertex(transform_matrix, 0, mid_y, mid_z_yz - length);
        vertex_add(vbuff, v1_mid_yz.X, v1_mid_yz.Y, v1_mid_yz.Z, color);
        vertex_add(vbuff, v2_mid_yz.X, v2_mid_yz.Y, v2_mid_yz.Z, color);

        // Connect the top and bottom of the capsule with lines between the circles
        var v1_top = transform_vertex(transform_matrix, self.radius, 0, 0);
        var v1_bottom = transform_vertex(transform_matrix, self.radius, 0, -length);
        vertex_add(vbuff, v1_top.X, v1_top.Y, v1_top.Z, color);
        vertex_add(vbuff, v1_bottom.X, v1_bottom.Y, v1_bottom.Z, color);

        var v2_top = transform_vertex(transform_matrix, 0, self.radius, 0);
        var v2_bottom = transform_vertex(transform_matrix, 0, self.radius, -length);
        vertex_add(vbuff, v2_top.X, v2_top.Y, v2_top.Z, color);
        vertex_add(vbuff, v2_bottom.X, v2_bottom.Y, v2_bottom.Z, color);

        vertex_end(vbuff);
        vertex_submit(vbuff, pr_linelist, -1);  // Submit the vertices as a self.line list
        vertex_delete_buffer(vbuff);
    }
}
