// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Capsule(start, finish, radius) constructor {
    self.line = new Line(start,finish);               // Vec3
    self.radius = radius;                       // Vec3	
	
	static check_collider = function(collider) {
		return collider.shape.check_capsule(self);
	}
	
	static check_point=function(point){
		
	}
	
	static check_sphere=function(sphere){
		
	}
	
	static check_aabb=function(aabb){
        var endcap_start = new Sphere(self.line.start, self.radius);
        if (endcap_start.check_aabb(aabb)) return true;
        
        var endcap_finish = new Sphere(self.line.finish, self.radius);
        if (endcap_finish.check_aabb(aabb)) return true;
        
        var edges = aabb.get_edges();
        
        for (var i = 0, n = array_length(edges); i < n; i++) {
            var nearest_line_to_edge = edges[i].nearest_connection_to_line(self.line);
            var start_distance = self.line.nearest_point(nearest_line_to_edge.start).distance_to(nearest_line_to_edge.start);
            if (start_distance == 0) {
                var _test_sphere = new Sphere(nearest_line_to_edge.start, self.radius);
                if (_test_sphere.check_aabb(aabb)) return true;
            } else {
                var _test_sphere = new Sphere(nearest_line_to_edge.finish, self.radius);
                if (_test_sphere.check_aabb(aabb)) return true;
            }
        }
        
        return false;
    }
	
	static check_plane=function(plane){
		
	}
	
	static check_line=function(line){
		
	}
	
	static check_ray=function(ray){
		
	}
	
	static check_obb = function(collider) {
		
	}
	static check_capsule = function(collider) {
		
	}
	
	
	
	static dbug_draw = function(col=c_white){
		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);
		
		var num_vertices = 12; 
		var angle_increment = 360 / num_vertices;
		var vertex_x=0;
		var vertex_y=0;
		var vertex_z=0;
		
		vertex_point_add(vbuff, line.start.x,line.start.y, line.start.z,col);
		vertex_z=line.start.z
		for (var i = 0; i <= num_vertices; i++){
			var angle_rad = degtorad(i * angle_increment);
			vertex_x = 0 + self.radius * cos(angle_rad)+line.start.x;
			vertex_y = 0 + self.radius * sin(angle_rad)+line.start.y;
			vertex_point_add(vbuff, vertex_x,vertex_y, vertex_z,col);
			vertex_point_add(vbuff, vertex_x,vertex_y, vertex_z,col);
		}
		vertex_x=line.start.x
		for (var i = 0; i <= num_vertices; i++){
			var angle_rad = degtorad(i * angle_increment);
			vertex_z = 0 + self.radius * cos(angle_rad)+line.start.z;
			vertex_y = 0 + self.radius * sin(angle_rad)+line.start.y;
			vertex_point_add(vbuff, vertex_x,vertex_y, vertex_z,col);
			vertex_point_add(vbuff, vertex_x,vertex_y, vertex_z,col);
		}
		vertex_y=line.start.y
		for (var i = 0; i <= num_vertices; i++){
			var angle_rad = degtorad(i * angle_increment);
			vertex_x = 0 + self.radius * cos(angle_rad)+line.start.x;
			vertex_z = 0 + self.radius * sin(angle_rad)+line.start.z;
			vertex_point_add(vbuff, vertex_x,vertex_y, vertex_z,col);
			vertex_point_add(vbuff, vertex_x,vertex_y, vertex_z,col);
		}
		vertex_point_add(vbuff, line.start.x,line.start.y, line.start.z,c_white);
		
		vertex_point_add(vbuff, line.start.x,line.start.y, line.start.z,c_white);
		vertex_point_add(vbuff, line.finish.x,line.finish.y, line.finish.z,c_white);
		
		
		vertex_point_add(vbuff, line.finish.x,line.finish.y, line.finish.z,c_white);
		//
		vertex_z=line.finish.z
		for (var i = 0; i <= num_vertices; i++){
			var angle_rad = degtorad(i * angle_increment);
			vertex_x = 0 + self.radius * cos(angle_rad)+line.finish.x;
			vertex_y = 0 + self.radius * sin(angle_rad)+line.finish.y;
			vertex_point_add(vbuff, vertex_x,vertex_y, vertex_z,col);
			vertex_point_add(vbuff, vertex_x,vertex_y, vertex_z,col);
		}
		vertex_x=line.finish.x
		for (var i = 0; i <= num_vertices; i++){
			var angle_rad = degtorad(i * angle_increment);
			vertex_z = 0 + self.radius * cos(angle_rad)+line.finish.z;
			vertex_y = 0 + self.radius * sin(angle_rad)+line.finish.y;
			vertex_point_add(vbuff, vertex_x,vertex_y, vertex_z,col);
			vertex_point_add(vbuff, vertex_x,vertex_y, vertex_z,col);
		}
		vertex_y=line.finish.y
		for (var i = 0; i <= num_vertices; i++){
			var angle_rad = degtorad(i * angle_increment);
			vertex_x = 0 + self.radius * cos(angle_rad)+line.finish.x;
			vertex_z = 0 + self.radius * sin(angle_rad)+line.finish.z;
			vertex_point_add(vbuff, vertex_x,vertex_y, vertex_z,col);
			vertex_point_add(vbuff, vertex_x,vertex_y, vertex_z,col);
		}
		vertex_point_add(vbuff, vertex_x,vertex_y, vertex_z,col);
		

		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	}
}