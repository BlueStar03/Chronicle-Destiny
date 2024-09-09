function Plane(normal, distance) constructor {
	self.normal = normal;					// Vec3
	self.distance = distance;				// number


static get_point_on_plane = function() {
    return self.normal.Mul(self.distance);
};



static dbug_draw = function(grid_size = 64, grid_spacing = 16, col=c_white, fade_size = 16) {
    var vbuff = vertex_create_buffer();
    vertex_begin(vbuff, v_format);

    // Calculate two vectors that are perpendicular to the plane's normal
    var perp1, perp2;
    if (abs(self.normal.Y) > 0.9) {
        perp1 = new Vector3(1, 0, 0);
    } else {
        perp1 = new Vector3(0, 1, 0);
    }
    perp2 = self.normal.Cross(perp1).Normalize();
    perp1 = self.normal.Cross(perp2).Normalize();

    // Function to add a fading line segment
    var add_fading_line = function(start, finish, col, fade_size, vbuff, perp) {
        // Midpoint line (full opacity)
        vertex_add(vbuff, start.X, start.Y, start.Z, col, 1);
        vertex_add(vbuff, finish.X, finish.Y, finish.Z, col, 1);
        
        // Outer lines (fading outwards)
        var fade_start = start.Sub(perp.Mul(fade_size));
        var fade_finish = finish.Add(perp.Mul(fade_size));
        
        vertex_add(vbuff, fade_start.X, fade_start.Y, fade_start.Z, col, 0);
        vertex_add(vbuff, start.X, start.Y, start.Z, col, 1);
        
        vertex_add(vbuff, finish.X, finish.Y, finish.Z, col, 1);
        vertex_add(vbuff, fade_finish.X, fade_finish.Y, fade_finish.Z, col, 0);
    };

    // Draw the grid with fading lines
    for (var i = -grid_size; i <= grid_size; i += grid_spacing) {
        var start1 = self.normal.Mul(self.distance).Add(perp1.Mul(i)).Sub(perp2.Mul(grid_size));
        var finish1 = self.normal.Mul(self.distance).Add(perp1.Mul(i)).Add(perp2.Mul(grid_size));
        
        var start2 = self.normal.Mul(self.distance).Add(perp2.Mul(i)).Sub(perp1.Mul(grid_size));
        var finish2 = self.normal.Mul(self.distance).Add(perp2.Mul(i)).Add(perp1.Mul(grid_size));
        
        add_fading_line(start1, finish1, col, fade_size, vbuff, perp2);
        add_fading_line(start2, finish2, col, fade_size, vbuff, perp1);
    }

    vertex_end(vbuff);
    vertex_submit(vbuff, pr_linelist, -1);
    vertex_delete_buffer(vbuff);
};




}
