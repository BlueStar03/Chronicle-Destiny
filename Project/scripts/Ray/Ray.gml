///@function Ray(origin, direction)
///@description What it does
///@param origin {real} what it is
///@param direction {real} what it is

function Ray(origin, direction) constructor{
	self.origin=origin;														//Vect3
	self.direction=direction;														//Vect3
	
		static dbug_draw = function(col=c_white){
		//	var s=player.collider.shape.position
		//var e=s.subtract(self.origin);dbug.trace.add("qwert",e);
		//var rdir=direction.normalize()
		//var t=e.dot(direction.normalize())
		
		//var p= origin.add(direction.normalize().multiply(t))
		
		//var i=s.subtract(p).magnitude()
		//if i<player.collider.shape.radius{
		//var j=sqrt(power(player.collider.shape.radius,2)-(i*i))
		//var t1=max(t-j,0)
		//var t2=t+j
		
		//var i1=origin.add(rdir.multiply(t1))
		//var i2=origin.add(rdir.multiply(t2))
		//}
		////
		var size=1;
		var neo=self.origin.Add(direction.Normalize().Mul(64));
		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);
		
		//vertex_point_add(vbuff, s.x,	s.y,		s.z,			c_yellow);
		//vertex_point_add(vbuff, origin.x,	origin.y,		origin.z,			c_lime);
		
		//vertex_point_add(vbuff, p.x,	p.y,		p.z,			c_orange);
		//vertex_point_add(vbuff, p.x,	p.y,		p.z-32,			c_fuchsia);
		//if (i<player.collider.shape.radius and t>0){
		//vertex_point_add(vbuff, i1.x,	i1.y,		i1.z,			c_red);
		//vertex_point_add(vbuff, i1.x,	i1.y,		i1.z-32,			c_red);
		//vertex_point_add(vbuff, i2.x,	i2.y,		i2.z,			c_blue);
		//vertex_point_add(vbuff, i2.x,	i2.y,		i2.z-32,			c_blue);
		//}
		
		//vertex_point_add(vbuff, origin.x+e.x,	origin.y+e.y,		origin.z+e.z,			c_lime);
		//vertex_point_add(vbuff, origin.x,	origin.y,		origin.z,			c_yellow);
	//////////////////////////////////////////////
		vertex_point_add(vbuff, self.origin.x+size,	self.origin.y,		self.origin.z,			c_white);
		vertex_point_add(vbuff, self.origin.x-size,	self.origin.y,		self.origin.z,			c_white);
																								
		vertex_point_add(vbuff, self.origin.x,		self.origin.y+size,	self.origin.z,			c_white);
		vertex_point_add(vbuff, self.origin.x,		self.origin.y-size,	self.origin.z,			c_white);
																								
		vertex_point_add(vbuff, self.origin.x,		self.origin.y,		self.origin.z+size,		c_white);
		vertex_point_add(vbuff, self.origin.x,		self.origin.y,		self.origin.z-size,		c_white);
		
		
		vertex_point_add(vbuff, self.origin.x,		self.origin.y,		self.origin.z,		col);
		vertex_point_add(vbuff, neo.x,		neo.y,		neo.z,		col,0);
		
	
		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	}
	
}

function Ray_Hit_Info() constructor {
	self.shape = undefined;
	self.point = undefined;
	self.distance = infinity;
	self.normal = undefined;

	static update = function(distance, shape, point, normal){
		if (distance < self.distance){
			self.distance = distance;
			self.shape = shape;
			self.point = point;
			self.normal = normal;
		}
	}

	static clear = function(){
		self.shape = undefined;
		self.point = undefined;
		self.distance = infinity;
		self.normal = undefined;
	}
	dbug_draw(){
		self.point.dbug_draw()	
	}
}


/*function Ray(origin, direction) constructor {
    self.origin = origin;                   // Vec3
    var mag = point_distance_3d(0, 0, 0, direction.x, direction.y, direction.z);
    self.direction = new Vector3(
        direction.x / mag,
        direction.y / mag,
        direction.z / mag
    );                                      // vec3
    
    static CheckPoint = function(point, hit_info) {
        return point.CheckRay(self, hit_info);
    };
    
    static CheckSphere = function(sphere, hit_info) {
        return sphere.CheckRay(self, hit_info);
    };
    
    static CheckAABB = function(aabb, hit_info) {
        return aabb.CheckRay(self, hit_info);
    };
    
    static CheckPlane = function(plane, hit_info) {
        return plane.CheckRay(self, hit_info);
    };
    
    static CheckOBB = function(obb, hit_info) {
        return obb.CheckRay(self, hit_info);
    };
    
    static CheckCapsule = function(capsule, hit_info) {
        return capsule.CheckRay(self, hit_info);
    };
    
    static CheckTriangle = function(triangle, hit_info) {
        return triangle.CheckRay(self, hit_info);
    };
    
    static CheckMesh = function(mesh, hit_info) {
        return mesh.CheckRay(self, hit_info);
    };
    
    static CheckModel = function(model, hit_info) {
        return model.CheckRay(self, hit_info);
    };
    
    static CheckRay = function(ray, hit_info = undefined) {
        return false;
    };
    
    static CheckLine = function(line, hit_info) {
        return false;
    };
    
    static DisplaceSphere = function(sphere) {
        return undefined;
    };
    
    static NearestPoint = function(vec3) {
        var origin = self.origin;
        var vx = vec3.x - origin.x;
        var vy = vec3.y - origin.y;
        var vz = vec3.z - origin.z;
        var d = self.direction;
        var t = max(dot_product_3d(vx, vy, vz, d.x, d.y, d.z), 0);
        return new Vector3(
            origin.x + d.x * t,
            origin.y + d.y * t,
            origin.z + d.z * t
        );
    };
    
    static GetMin = function() {
        return undefined;
    };
    
    static GetMax = function() {
        return undefined;
    };
}
*/