function Point(position) constructor{
	self.position=position;														//Vect3
	
	static check_point = function(point) {
		return self.position.equals(point.position);
	};
	
	static check_sphere = function(sphere) {
		return self.position.distance_to(sphere.position) < sphere.radius;
	};
	
	static check_aabb = function(aabb) {
		var box_min = aabb.get_min();
		var box_max = aabb.get_max();
		if (self.position.x < box_min.x || self.position.y < box_min.y || self.position.z < box_min.z) return false;
		if (self.position.x > box_max.x || self.position.y > box_max.y || self.position.z > box_max.z) return false;
		return true;
	};
	
	static check_plane = function(plane) {
		var ndot = self.position.dot(plane.normal);
		return (ndot == plane.distance);
    };
}

function Sphere(position, radius) constructor{
	self.position=position;														//Vect3
	self.radius=radius;														//Vect3
}

function col_aabb(position, half_extents, min_max=false) constructor{
	if min_max{
		self.position = position.add(half_extents).divide(2);
		self.half_extents = half_extents.subtract(position).divide(2).Abs();
	}else{
		self.position=position;					//Vect3
		self.half_extents=half_extents			//Vect3
	}
    static dbug_draw = function() {
        static vertex_add_point = function(vbuff, x, y, z, colour) {
            vertex_position_3d(vbuff, x, y, z);
            vertex_normal(vbuff, 0, 0, 1);
            vertex_texcoord(vbuff, 0, 0);
            vertex_colour(vbuff, colour, 1);
        };
        
        var vbuff = vertex_create_buffer();
        vertex_begin(vbuff, v_format);
        
        vertex_add_point(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z, c_white);
        																																			
        vertex_add_point(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z - self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z - self.half_extents.z, c_white);
        																																			 
        vertex_add_point(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x + self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x + self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x - self.half_extents.x, self.position.y + self.half_extents.y, self.position.z + self.half_extents.z, c_white);
        vertex_add_point(vbuff, self.position.x - self.half_extents.x, self.position.y - self.half_extents.y, self.position.z + self.half_extents.z, c_white);
        
        
        vertex_end(vbuff);
		draw_set_color(c_white)
        vertex_submit(vbuff, pr_linelist, -1);
        vertex_delete_buffer(vbuff);
    };
    

    
    static check_aabb = function(aabb) {
        var box_min = self.GetMin();
        var box_max = self.GetMax();
        var other_min = aabb.GetMin();
        var other_max = aabb.GetMax();
        return ((box_min.x <= other_max.x) && (box_max.x >= other_min.x) && (box_min.y <= other_max.y) && (box_max.y >= other_min.y) && (box_min.z <= other_max.z) && (box_max.z >= other_min.z));
    };
    
    
    static GetMin = function() {
        return self.position.subtract(self.half_extents);
    };
    
    static GetMax = function() {
        return self.position.add(self.half_extents);
    };
    
    static NearestPoint = function(vec3) {
        var box_min = self.GetMin();
        var box_max = self.GetMax();
        var xx = (vec3.x < box_min.x) ? box_min.x : vec3.x;
        var yy = (vec3.y < box_min.y) ? box_min.y : vec3.y;
        var zz = (vec3.z < box_min.z) ? box_min.z : vec3.z;
        xx = (xx > box_max.x) ? box_max.x : xx;
        yy = (yy > box_max.y) ? box_max.y : yy;
        zz = (zz > box_max.z) ? box_max.z : zz;
        return new Vector3(xx, yy, zz);
    };
    
    static CheckAABBSAT = function(aabb) {
        var axes = [
            new Vector3(1, 0, 0),
            new Vector3(0, 1, 0),
            new Vector3(0, 0, 1),
        ];
        
        for (var i = 0; i < 3; i++) {
            if (!col_overlap_axis(self, aabb, axes[i])) {
                return false;
            }
        }
        
        return true;
    };
    
    static GetInterval = function(axis) {
        var vertices = self.GetVertices();
        
        var imin = axis.Dot(vertices[0]);
        var imax = imin;
        
        for (var i = 1; i < 8; i++) {
            var dot = axis.Dot(vertices[i]);
            imin = min(imin, dot);
            imax = max(imax, dot);
        }
        
        return new ColInterval(imin, imax);
    };
    
    static GetVertices = function() {
        var pmin = self.GetMin();
        var pmax = self.GetMax();
        
        return [
            new Vector3(pmin.x, pmax.y, pmax.z),
            new Vector3(pmin.x, pmax.y, pmin.z),
            new Vector3(pmin.x, pmin.y, pmax.z),
            new Vector3(pmin.x, pmin.y, pmin.z),
            new Vector3(pmax.x, pmax.y, pmax.z),
            new Vector3(pmax.x, pmax.y, pmin.z),
            new Vector3(pmax.x, pmin.y, pmax.z),
            new Vector3(pmax.x, pmin.y, pmin.z),
        ]
    };
    
    static GetEdges = function() {
        var vertices = self.GetVertices();
        
        return [
            new ColLine(vertices[0], vertices[1]),
            new ColLine(vertices[0], vertices[2]),
            new ColLine(vertices[1], vertices[3]),
            new ColLine(vertices[2], vertices[3]),
            new ColLine(vertices[4], vertices[5]),
            new ColLine(vertices[4], vertices[6]),
            new ColLine(vertices[5], vertices[7]),
            new ColLine(vertices[6], vertices[7]),
            new ColLine(vertices[0], vertices[4]),
            new ColLine(vertices[1], vertices[5]),
            new ColLine(vertices[2], vertices[6]),
            new ColLine(vertices[3], vertices[7]),
        ];
    };
    
}

function Plane(normal, distance) constructor{
	self.normal=normal;														//Vect3
	self.distance=distance;														//number
}

function Ray(origin, direction) constructor{
	self.origin=origin;														//Vect3
	self.direction=direction;														//Vect3
}

function Line(start, finish) constructor{
	self.start=start;														//Vect3
	self.finish=finish;														//Vect3
}

