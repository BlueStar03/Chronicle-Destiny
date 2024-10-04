function ColRay(origin, direction) constructor {
    self.origin = origin;                   // Vec3
    var mag = point_distance_3d(0, 0, 0, direction.X, direction.Y, direction.Z);
    self.direction = new Vector3(
        direction.X / mag,
        direction.Y / mag,
        direction.Z / mag
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
        var vx = vec3.X - origin.X;
        var vy = vec3.Y - origin.Y;
        var vz = vec3.Z - origin.Z;
        var d = self.direction;
        var t = max(dot_product_3d(vx, vy, vz, d.X, d.Y, d.Z), 0);
        return new Vector3(
            origin.X + d.X * t,
            origin.Y + d.Y * t,
            origin.Z + d.Z * t
        );
    };
    
    static GetMin = function() {
        return undefined;
    };
    
    static GetMax = function() {
        return undefined;
    };

static dbug_draw = function(col=c_white){
		var size=1;
		var neo=self.origin.Add(direction.Normalize().Mul(64));
		var vbuff = vertex_create_buffer();
		vertex_begin(vbuff, v_format);
		
		vertex_add(vbuff, self.origin.X+size,	self.origin.Y,		self.origin.Z,			c_white);
		vertex_add(vbuff, self.origin.X-size,	self.origin.Y,		self.origin.Z,			c_white);
																								
		vertex_add(vbuff, self.origin.X,		self.origin.Y+size,	self.origin.Z,			c_white);
		vertex_add(vbuff, self.origin.X,		self.origin.Y-size,	self.origin.Z,			c_white);
																								
		vertex_add(vbuff, self.origin.X,		self.origin.Y,		self.origin.Z+size,		c_white);
		vertex_add(vbuff, self.origin.X,		self.origin.Y,		self.origin.Z-size,		c_white);
		
		
		vertex_add(vbuff, self.origin.X,		self.origin.Y,		self.origin.Z,		col);
		vertex_add(vbuff, neo.X,		neo.Y,		neo.Z,		col,0);
		
	
		vertex_end(vbuff);
		vertex_submit(vbuff, pr_linelist, -1);
		vertex_delete_buffer(vbuff);
	}		
		
}											//Vect3
	
		
	


function Col_Ray_Hit_Info() constructor {
    self.shape = undefined;
    self.point = undefined;
    self.distance = infinity;
    self.normal = undefined;
    
    static Update = function(distance, shape, point, normal) {
        if (distance < self.distance) {
            self.distance = distance;
            self.shape = shape;
            self.point = point;
            self.normal = normal;
        }
    };
    
    static Clear = function() {
        self.shape = undefined;
        self.point = undefined;
        self.distance = infinity;
        self.normal = undefined;
    };
}