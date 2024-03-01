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
		var start=line.start;
		var finish=line.finish;
		var dist=finish.subtract(start).magnitude()
		var normal=finish.subtract(start).normalize();
		var rot=new Vector3(radtodeg(arcsin(normal.y)),
							radtodeg(arctan2(normal.x, normal.z)),
							0)
		
		var V3=0
		
		#region axises

				var vbuff = vertex_create_buffer();
		vertex_begin(vbuff,v_format);
		vertex_point_add(vbuff, 0,0, dist,c_white);
		vertex_point_add(vbuff, 0,0, 0,c_white);
		

		#endregion
		
		
		var seg=8
		var angle_inc=tau/seg
		
	
		var _col=c_magenta
		for (var i=0;i<seg+1;i++){			
			var angle=i*angle_inc;
			var pos=new Vector3(0+radius*cos(angle),
								0,
								-(0+radius*sin(angle)));			
			if i=0{V3=pos;}
			if (i<=seg/2){vertex_point_add(vbuff, pos.x,pos.y, pos.z,col);}
			if (i>=seg/2){vertex_point_add(vbuff, pos.x,pos.y, pos.z+dist,col);}
			if i>seg-1{vertex_point_add(vbuff, V3.x,V3.y, V3.z,col);}
		}
		
		for (var i=0;i<seg+1;i++){			
			var angle=i*angle_inc;
			var pos=new Vector3(0,
								0+radius*cos(angle),
								-(0+radius*sin(angle)));			
			if i=0{V3=pos;}
			if (i<=seg/2){vertex_point_add(vbuff, pos.x,pos.y, pos.z,col);}
			if (i>=seg/2){vertex_point_add(vbuff, pos.x,pos.y, pos.z+dist,col);}
			if i>seg-1{vertex_point_add(vbuff, V3.x,V3.y, V3.z,col);}
		}

		vertex_end(vbuff);
		matrix_set(matrix_world, matrix_build(start.x, start.y, start.z, -rot.x,-rot.y, 0, 1, 1, 1));	
		vertex_submit(vbuff, pr_linestrip, -1);
		matrix_set(matrix_world, matrix_build_identity());
		vertex_delete_buffer(vbuff);
	}
}
