function Line(start, finish) constructor {
    self.start = start;                     // Vec3
    self.finish = finish;                   // Vec3
		
		 static Direction = function() {
        var dir_x = finish.X - start.X;
        var dir_y = finish.Y - start.Y;
        var dir_z = finish.Z - start.Z;
        var magnitude = sqrt(dir_x * dir_x + dir_y * dir_y + dir_z * dir_z);
        return new Vector3(dir_x / magnitude, dir_y / magnitude, dir_z / magnitude);
    };
    
        static Length = function() {
					        var sx = self.start.X, sy = self.start.Y, sz = self.start.Z;
        var fx = self.finish.X, fy = self.finish.Y, fz = self.finish.Z;
        return point_distance_3d(sx, sy, sz, fx, fy, fz);
    };
		

		
static dbug_draw = function(c_line=c_white, size=1, c_ext=c_red) {
    var vbuff = vertex_create_buffer();        
    vertex_begin(vbuff, v_format);
    
    // Calculate direction vectors for extending the line
    var dir_x = self.finish.X - self.start.X;
    var dir_y = self.finish.Y - self.start.Y;
    var dir_z = self.finish.Z - self.start.Z;
    
    // Normalize the direction to get the unit vector
    var magnitude = point_distance_3d(self.start.X, self.start.Y, self.start.Z, self.finish.X, self.finish.Y, self.finish.Z);
    var unit_x = dir_x / magnitude;
    var unit_y = dir_y / magnitude;
    var unit_z = dir_z / magnitude;
    
    // Extend the start and finish points
    var ext_start_x = self.start.X - unit_x * size;
    var ext_start_y = self.start.Y - unit_y * size;
    var ext_start_z = self.start.Z - unit_z * size;
    
    var ext_finish_x = self.finish.X + unit_x * size;
    var ext_finish_y = self.finish.Y + unit_y * size;
    var ext_finish_z = self.finish.Z + unit_z * size;
    
    // Add the vertices to the buffer
    vertex_add(vbuff, ext_start_x, ext_start_y, ext_start_z, c_ext);  // Extended start
    vertex_add(vbuff, self.start.X, self.start.Y, self.start.Z, c_black);  // Original start
    
    vertex_add(vbuff, self.start.X, self.start.Y, self.start.Z, c_line);  // Original start
    vertex_add(vbuff, self.finish.X, self.finish.Y, self.finish.Z, c_line);  // Original finish
    
    vertex_add(vbuff, self.finish.X, self.finish.Y, self.finish.Z, c_black);  // Original finish
    vertex_add(vbuff, ext_finish_x, ext_finish_y, ext_finish_z, c_ext);  // Extended finish

    vertex_end(vbuff);
    vertex_submit(vbuff, pr_linelist, -1);  // Use pr_linelist to draw the vertices as individual line segments
    vertex_delete_buffer(vbuff);
}




		
		
		
		
}