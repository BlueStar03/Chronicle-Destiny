function ColOBB(position, size, orientation) constructor {
	    self.position = undefined;
    self.size = undefined;
    self.orientation = undefined;
    self.Set(position, size, orientation);
static Set = function(position = self.position, size = self.size, orientation = self.orientation) {
        self.position = position;
        self.size = size;
        self.orientation = orientation;
		
        var ox = new Vector3(orientation[ 0], orientation[ 1], orientation[ 2]);
        var oy = new Vector3(orientation[ 4], orientation[ 5], orientation[ 6]);
        var oz = new Vector3(orientation[ 8], orientation[ 9], orientation[10]);
		self.property_orientation_array = [ox, oy, oz];
		var xs = ox.Mul(size.X);
		var ys = oy.Mul(size.Y);
		var zs = oz.Mul(size.Z);
        
        self.property_vertices = [
            position.Add(xs).Add(ys).Add(zs),
            position.Sub(xs).Add(ys).Add(zs),
            position.Add(xs).Sub(ys).Add(zs),
            position.Add(xs).Add(ys).Sub(zs),
            position.Sub(xs).Sub(ys).Sub(zs),
            position.Add(xs).Sub(ys).Sub(zs),
            position.Sub(xs).Add(ys).Sub(zs),
            position.Sub(xs).Sub(ys).Add(zs),
        ];
        
        var vertices = self.property_vertices;
        
        self.property_edges = [
            new ColLine(vertices[1], vertices[6]),
            new ColLine(vertices[6], vertices[4]),
            new ColLine(vertices[4], vertices[7]),
            new ColLine(vertices[7], vertices[1]),
            new ColLine(vertices[0], vertices[3]),
            new ColLine(vertices[3], vertices[5]),
            new ColLine(vertices[5], vertices[2]),
            new ColLine(vertices[1], vertices[0]),
            new ColLine(vertices[7], vertices[2]),
            new ColLine(vertices[2], vertices[0]),
            new ColLine(vertices[6], vertices[3]),
            new ColLine(vertices[4], vertices[5]),
        ];
        
        self.property_min = new Vector3(infinity, infinity, infinity);
        self.property_max = new Vector3(-infinity, -infinity, -infinity);
        var pmin = self.property_min;
        var pmax = self.property_max;
        for (var i = 0; i < 8; i++) {
            var vertex = vertices[i];
            pmin.X = min(pmin.X, vertex.X);
            pmin.Y = min(pmin.Y, vertex.Y);
            pmin.Z = min(pmin.Z, vertex.Z);
            pmax.X = max(pmax.X, vertex.X);
            pmax.Y = max(pmax.Y, vertex.Y);
            pmax.Z = max(pmax.Z, vertex.Z);
        }
        
        self.property_radius = point_distance_3d(size.X, size.Y, size.Z, 0, 0, 0);
    };
    
    static CheckObject = function(object) {
        return object.shape.CheckOBB(self);
    };
    
    static CheckPoint = function(point) {
        var pp = point.position;
        var po = self.position;
        if (point_distance_3d(po.X, po.Y, po.Z, pp.X, pp.Y, pp.Z) > self.property_radius) return false;
        
        var dx = pp.X - po.X, dy = pp.Y - po.Y, dz = pp.Z - po.Z;
        
        var size_array = [self.size.X, self.size.Y, self.size.Z];
        
        for (var i = 0; i < 3; i++) {
            var axis = self.property_orientation_array[i];
            if (abs(dot_product_3d(dx, dy, dz, axis.X, axis.Y, axis.Z)) > abs(size_array[i])) {
                return false;
            }
        }
        
        return true;
    };
    
    static CheckSphere = function(sphere) {
        var ps = sphere.position;
        var px = self.position.X;
        var py = self.position.Y;
        var pz = self.position.Z;
        if (point_distance_3d(px, py, pz, ps.X, ps.Y, ps.Z) > self.property_radius + sphere.radius) return false;
        
        var dx = ps.X - px, dy = ps.Y - py, dz = ps.Z - pz;
        
        static size_array = array_create(3);
        size_array[0] = self.size.X;
        size_array[1] = self.size.Y;
        size_array[2] = self.size.Z;
        
        for (var i = 0; i < 3; i++) {
            var axis = self.property_orientation_array[i];
            var dist = clamp(dot_product_3d(dx, dy, dz, axis.X, axis.Y, axis.Z), -size_array[i], size_array[i]);
            px += axis.X * dist;
            py += axis.Y * dist;
            pz += axis.Z * dist;
        }
        
        return point_distance_3d(px, py, pz, ps.X, ps.Y, ps.Z) < sphere.radius;
    };
    
    static CheckAABB = function(aabb) {
        var p1 = self.position;
        var p2 = aabb.position;
        if (point_distance_3d(p1.X, p1.Y, p1.Z, p2.X, p2.Y, p2.Z) > aabb.property_radius + self.property_radius) return false;
        
        static axes = [
            1, 0, 0,
            0, 1, 0,
            0, 0, 1,
            0, 0, 0,
            0, 0, 0,
            0, 0, 0,
            0, 0, 0,
            0, 0, 0,
            0, 0, 0,
            0, 0, 0,
            0, 0, 0,
            0, 0, 0,
            0, 0, 0,
            0, 0, 0,
            0, 0, 0
        ];
        
        var ox = self.property_orientation_array[0];
        var oy = self.property_orientation_array[1];
        var oz = self.property_orientation_array[2];
        
        axes[3 * 3 + 0] = ox.X;
        axes[3 * 3 + 1] = ox.Y;
        axes[3 * 3 + 2] = ox.Z;
        axes[4 * 3 + 0] = oy.X;
        axes[4 * 3 + 1] = oy.Y;
        axes[4 * 3 + 2] = oy.Z;
        axes[5 * 3 + 0] = oz.X;
        axes[5 * 3 + 1] = oz.Y;
        axes[5 * 3 + 2] = oz.Z;
        
        axes[6 * 3 + 1] = -ox.Z;
        axes[6 * 3 + 2] = -ox.Y;
        axes[7 * 3 + 1] = -oy.Z;
        axes[7 * 3 + 2] = -oy.Y;
        axes[8 * 3 + 1] = -oz.Z;
        axes[8 * 3 + 2] = -oz.Y;
        
        axes[9 * 3 + 0] = ox.Z;
        axes[9 * 3 + 2] = -ox.X;
        axes[10 * 3 + 0] = oy.Z;
        axes[10 * 3 + 2] = -oy.X;
        axes[11 * 3 + 0] = oz.Z;
        axes[11 * 3 + 2] = -oz.X;
        
        axes[12 + 3 + 0] = -ox.Y;
        axes[12 + 3 + 1] = ox.X;
        axes[13 + 3 + 0] = -oy.Y;
        axes[13 + 3 + 1] = oy.X;
        axes[14 + 3 + 0] = -oz.Y;
        axes[14 + 3 + 1] = oz.X;
        
        var i = 0;
        var vertices = self.property_vertices;
        var vertices_aabb = aabb.property_vertices;
        repeat (15) {
            var xx = axes[i++];
            var yy = axes[i++];
            var zz = axes[i++];
            
            var val_min_a = infinity;
            var val_max_a = -infinity;
            var val_min_b = infinity;
            var val_max_b = -infinity;
            
            var j = 0;
            repeat (8) {
                var vertex = vertices[j];
                var dot = dot_product_3d(xx, yy, zz, vertex.X, vertex.Y, vertex.Z);
                val_min_a = min(val_min_a, dot);
                val_max_a = max(val_max_a, dot);
                vertex = vertices_aabb[j++];
                dot = dot_product_3d(xx, yy, zz, vertex.X, vertex.Y, vertex.Z);
                val_min_b = min(val_min_b, dot);
                val_max_b = max(val_max_b, dot);
            }
            
            if ((val_min_b > val_max_a) || (val_min_a > val_max_b)) {
                return false;
            }
        }
        
        return true;
    };
    
    static CheckOBB = function(obb) {
        var p1 = self.position;
        var p2 = obb.position;
        
        if (point_distance_3d(p1.X, p1.Y, p1.Z, p2.X, p2.Y, p2.Z) > self.property_radius + obb.property_radius) return false;
        
        static axes = array_create(15 * 3);
        
        var ix = obb.property_orientation_array[0];
        var iy = obb.property_orientation_array[1];
        var iz = obb.property_orientation_array[2];
        var ixx = ix.X, ixy = ix.Y, ixz = ix.Z;
        var iyx = iy.X, iyy = iy.Y, iyz = iy.Z;
        var izx = iz.X, izy = iz.Y, izz = iz.Z;
        var ox = self.property_orientation_array[0];
        var oy = self.property_orientation_array[1];
        var oz = self.property_orientation_array[2];
        var oxx = ox.X, oxy = ox.Y, oxz = ox.Z;
        var oyx = oy.X, oyy = oy.Y, oyz = oy.Z;
        var ozx = oz.X, ozy = oz.Y, ozz = oz.Z;
        
        axes[0 * 3 + 0] = ixx;
        axes[0 * 3 + 1] = ixy;
        axes[0 * 3 + 2] = ixz;
        axes[1 * 3 + 0] = iyx;
        axes[1 * 3 + 1] = iyy;
        axes[1 * 3 + 2] = iyz;
        axes[2 * 3 + 0] = izx;
        axes[2 * 3 + 1] = izy;
        axes[2 * 3 + 2] = izz;
        axes[3 * 3 + 0] = oxx;
        axes[3 * 3 + 1] = oxy;
        axes[3 * 3 + 2] = oxz;
        axes[4 * 3 + 0] = oyx;
        axes[4 * 3 + 1] = oyy;
        axes[4 * 3 + 2] = oyz;
        axes[5 * 3 + 0] = ozx;
        axes[5 * 3 + 1] = ozy;
        axes[5 * 3 + 2] = ozz;
        
        axes[6 * 3 + 0] = ixy * oxz - oxy * ixz;
        axes[6 * 3 + 1] = ixz * oxx - oxz * ixx;
        axes[6 * 3 + 2] = ixx * oxy - oxx * ixy;
        axes[7 * 3 + 0] = iyy * oxz - oxy * iyz;
        axes[7 * 3 + 1] = iyz * oxx - oxz * iyx;
        axes[7 * 3 + 2] = iyx * oxy - oxx * iyy;
        axes[8 * 3 + 0] = izy * oxz - oxy * izz;
        axes[8 * 3 + 1] = izz * oxx - oxz * izx;
        axes[8 * 3 + 2] = izx * oxy - oxx * izy;
        axes[9 * 3 + 0] = ixy * oyz - oyy * ixz;
        axes[9 * 3 + 1] = ixz * oyx - oyz * ixx;
        axes[9 * 3 + 2] = ixx * oyy - oyx * ixy;
        axes[10 * 3 + 0] = iyy * oyz - oyy * iyz;
        axes[10 * 3 + 1] = iyz * oyx - oyz * iyx;
        axes[10 * 3 + 2] = iyx * oyy - oyx * iyy;
        axes[11 * 3 + 0] = izy * oyz - oyy * izz;
        axes[11 * 3 + 1] = izz * oyx - oyz * izx;
        axes[11 * 3 + 2] = izx * oyy - oyx * izy;
        axes[12 * 3 + 0] = ixy * ozz - ozy * ixz;
        axes[12 * 3 + 1] = ixz * ozx - ozz * ixx;
        axes[12 * 3 + 2] = ixx * ozy - ozx * ixy;
        axes[13 * 3 + 0] = iyy * ozz - ozy * iyz;
        axes[13 * 3 + 1] = iyz * ozx - ozz * iyx;
        axes[13 * 3 + 2] = iyx * ozy - ozx * iyy;
        axes[14 * 3 + 0] = izy * ozz - ozy * izz;
        axes[14 * 3 + 1] = izz * ozx - ozz * izx;
        axes[14 * 3 + 2] = izx * ozy - ozx * izy;
        
        var vertices = self.property_vertices;
        var vertices_obb = obb.property_vertices;
        
        var i = 0;
        repeat (15) {
            var xx = axes[i++];
            var yy = axes[i++];
            var zz = axes[i++];
            
            var val_min_a = infinity;
            var val_max_a = -infinity;
            var val_min_b = infinity;
            var val_max_b = -infinity;
            
            var j = 0;
            repeat (8) {
                var vertex = vertices[j];
                var dot = dot_product_3d(xx, yy, zz, vertex.X, vertex.Y, vertex.Z);
                val_min_a = min(val_min_a, dot);
                val_max_a = max(val_max_a, dot);
                vertex = vertices_obb[j++];
                dot = dot_product_3d(xx, yy, zz, vertex.X, vertex.Y, vertex.Z);
                val_min_b = min(val_min_b, dot);
                val_max_b = max(val_max_b, dot);
            }
            
            if ((val_min_b > val_max_a) || (val_min_a > val_max_b)) {
                return false;
            }
        }
        
        return true;
    };
    
    static CheckPlane = function(plane) {
        var normal = plane.normal;
        var nx = normal.X;
        var ny = normal.Y;
        var nz = normal.Z;
        var ox = self.property_orientation_array[0];
        var oy = self.property_orientation_array[1];
        var oz = self.property_orientation_array[2];
        var p = self.position;
        var plen =
            self.size.X * abs(dot_product_3d(nx, ny, nz, ox.X, ox.Y, ox.Z)) +
            self.size.Y * abs(dot_product_3d(nx, ny, nz, oy.X, oy.Y, oy.Z)) +
            self.size.Z * abs(dot_product_3d(nx, ny, nz, oz.X, oz.Y, oz.Z));
        
        var dist = dot_product_3d(nx, ny, nz, p.X, p.Y, p.Z) - plane.distance;
        
        return abs(dist) < plen;
    };
    
    static CheckCapsule = function(capsule) {
        return capsule.CheckOBB(self);
    };
    
    static CheckTriangle = function(triangle) {
        var p1 = self.position;
        var p2 = triangle.property_center;
        if (point_distance_3d(p1.X, p1.Y, p1.Z, p2.X, p2.Y, p2.Z) > triangle.property_radius + self.property_radius) return false;
        
        static axes = array_create(13 * 3);
        
        var ab = triangle.property_edge_ab;
        var bc = triangle.property_edge_bc;
        var ca = triangle.property_edge_ca;
        var ixx = ab.X, ixy = ab.Y, ixz = ab.Z;
        var iyx = bc.X, iyy = bc.Y, iyz = bc.Z;
        var izx = ca.X, izy = ca.Y, izz = ca.Z;
        var ox = self.property_orientation_array[0];
        var oy = self.property_orientation_array[1];
        var oz = self.property_orientation_array[2];
        var oxx = ox.X, oxy = ox.Y, oxz = ox.Z;
        var oyx = oy.X, oyy = oy.Y, oyz = oy.Z;
        var ozx = oz.X, ozy = oz.Y, ozz = oz.Z;
        var tn = triangle.property_normal;
        
        axes[0 * 3 + 0] = oxx;
        axes[0 * 3 + 1] = oxy;
        axes[0 * 3 + 2] = oxz;
        axes[1 * 3 + 0] = oyx;
        axes[1 * 3 + 1] = oyy;
        axes[1 * 3 + 2] = oyz;
        axes[2 * 3 + 0] = ozx;
        axes[2 * 3 + 1] = ozy;
        axes[2 * 3 + 2] = ozz;
        axes[3 * 3 + 0] = tn.X;
        axes[3 * 3 + 1] = tn.Y;
        axes[3 * 3 + 2] = tn.Z;
        
        axes[4 * 3 + 0] = ixy * oxz - oxy * ixz;
        axes[4 * 3 + 1] = ixz * oxx - oxz * ixx;
        axes[4 * 3 + 2] = ixx * oxy - oxx * ixy;
        axes[5 * 3 + 0] = iyy * oxz - oxy * iyz;
        axes[5 * 3 + 1] = iyz * oxx - oxz * iyx;
        axes[5 * 3 + 2] = iyx * oxy - oxx * iyy;
        axes[6 * 3 + 0] = izy * oxz - oxy * izz;
        axes[6 * 3 + 1] = izz * oxx - oxz * izx;
        axes[6 * 3 + 2] = izx * oxy - oxx * izy;
        axes[7 * 3 + 0] = ixy * oyz - oyy * ixz;
        axes[7 * 3 + 1] = ixz * oyx - oyz * ixx;
        axes[7 * 3 + 2] = ixx * oyy - oyx * ixy;
        axes[8 * 3 + 0] = iyy * oyz - oyy * iyz;
        axes[8 * 3 + 1] = iyz * oyx - oyz * iyx;
        axes[8 * 3 + 2] = iyx * oyy - oyx * iyy;
        axes[9 * 3 + 0] = izy * oyz - oyy * izz;
        axes[9 * 3 + 1] = izz * oyx - oyz * izx;
        axes[9 * 3 + 2] = izx * oyy - oyx * izy;
        axes[10 * 3 + 0] = ixy * ozz - ozy * ixz;
        axes[10 * 3 + 1] = ixz * ozx - ozz * ixx;
        axes[10 * 3 + 2] = ixx * ozy - ozx * ixy;
        axes[11 * 3 + 0] = iyy * ozz - ozy * iyz;
        axes[11 * 3 + 1] = iyz * ozx - ozz * iyx;
        axes[11 * 3 + 2] = iyx * ozy - ozx * iyy;
        axes[12 * 3 + 0] = izy * ozz - ozy * izz;
        axes[12 * 3 + 1] = izz * ozx - ozz * izx;
        axes[12 * 3 + 2] = izx * ozy - ozx * izy;
        
        var vertices = self.property_vertices;
        var tax = triangle.a.X;
        var tay = triangle.a.Y;
        var taz = triangle.a.Z;
        var tbx = triangle.b.X;
        var tby = triangle.b.Y;
        var tbz = triangle.b.Z;
        var tcx = triangle.c.X;
        var tcy = triangle.c.Y;
        var tcz = triangle.c.Z;
        
        var i = 0;
        repeat (13) {
            var xx = axes[i++];
            var yy = axes[i++];
            var zz = axes[i++];
            
            var val_min_a = infinity;
            var val_max_a = -infinity;
            
            var j = 0;
            repeat (8) {
                var vertex = vertices[j++];
                var dot = dot_product_3d(xx, yy, zz, vertex.X, vertex.Y, vertex.Z);
                val_min_a = min(val_min_a, dot);
                val_max_a = max(val_max_a, dot);
            }
            
            var ada = dot_product_3d(xx, yy, zz, tax, tay, taz);
            var adb = dot_product_3d(xx, yy, zz, tbx, tby, tbz);
            var adc = dot_product_3d(xx, yy, zz, tcx, tcy, tcz);
            var val_min_b = min(ada, adb, adc);
            var val_max_b = max(ada, adb, adc);
            
            if ((val_min_b > val_max_a) || (val_min_a > val_max_b)) {
                return false;
            }
        }
        
        return true;
    };
    
    static CheckMesh = function(mesh) {
        return mesh.CheckOBB(self);
    };
    
    static CheckModel = function(model) {
        return model.CheckOBB(self);
    };
    
    static CheckRay = function(ray, hit_info = undefined) {
        static direction_dots = array_create(3);
        static position_dots = array_create(3);
        static t = array_create(6);
        
        var rd = ray.direction;
        var p = self.position;
        var o = ray.origin;
        var size_array = [self.size.X, self.size.Y, self.size.Z];
        
        var dx = p.X - o.X, dy = p.Y - o.Y, dz = p.Z - o.Z;
        var ox = self.property_orientation_array[0];
        var oy = self.property_orientation_array[1];
        var oz = self.property_orientation_array[2];
        var rdx = rd.X, rdy = rd.Y, rdz = rd.Z;
        
        direction_dots[0] = dot_product_3d(ox.X, ox.Y, ox.Z, rdx, rdy, rdz);
        direction_dots[1] = dot_product_3d(oy.X, oy.Y, oy.Z, rdx, rdy, rdz);
        direction_dots[2] = dot_product_3d(oz.X, oz.Y, oz.Z, rdx, rdy, rdz);
        
        position_dots[0] = dot_product_3d(ox.X, ox.Y, ox.Z, dx, dy, dz);
        position_dots[1] = dot_product_3d(oy.X, oy.Y, oy.Z, dx, dy, dz);
        position_dots[2] = dot_product_3d(oz.X, oz.Y, oz.Z, dx, dy, dz);
        
        for (var i = 0; i < 3; i++) {
            var dd = direction_dots[i];
            var pd = position_dots[i];
            var s = size_array[i];
            if (dd == 0) {
                if ((-pd - s) > 0 || (-pd + s) < 0) {
                    return false;
                }
                dd = 0.0001;
            }
            
            t[i * 2 + 0] = (pd + s) / dd;
            t[i * 2 + 1] = (pd - s) / dd;
        }
        
        var tmax = min(
            max(t[0], t[1]),
            max(t[2], t[3]),
            max(t[4], t[5])
        );
        
        if (tmax < 0) return false;
		
        var tmin = max(
            min(t[0], t[1]),
            min(t[2], t[3]),
            min(t[4], t[5])
        );
        
        if (tmin > tmax) return false;
        
        if (hit_info) {
            var contact_distance = (tmin < 0) ? tmax : tmin;
            var contact_normal;
            
            var contact_point = ray.origin.Add(rd.Mul(contact_distance));
            
            for (var i = 0; i < 6; i++) {
                if (contact_distance == t[i]) {
                    switch (i) {
                        case 0: contact_normal = ox; break;
                        case 1: contact_normal = ox.Mul(-1); break;
                        case 2: contact_normal = oy; break;
                        case 3: contact_normal = oy.Mul(-1); break;
                        case 4: contact_normal = oz; break;
                        case 5: contact_normal = oz.Mul(-1); break;
                    }
                }
            }
            
            hit_info.Update(contact_distance, self, contact_point, contact_normal);
        }
        
        return true;
    };
    
    static CheckLine = function(line) {
        static hit_info = new RaycastHitInformation();
        hit_info.distance = infinity;
        
        if (self.CheckRay(line.property_ray, hit_info)) {
            return (hit_info.distance <= line.property_length);
        }
        return false;
    };
    
    static DisplaceSphere = function(sphere) {
        if (!self.CheckSphere(sphere)) return undefined;
        
        var ps = sphere.position;
        var po = self.position;
        if (ps.X == po.X && ps.Y == po.Y && ps.Z == po.Z) return undefined;
        
        var nearest = self.NearestPoint(ps);
        
        if (nearest.X == ps.X && nearest.Y == ps.Y && nearest.Z == ps.Z) {
            return undefined;
        }
        
        var dir = sphere.position.Sub(nearest).Normalize();
        return nearest.Add(dir.Mul(sphere.radius));
    };
    
    static NearestPoint = function(vec3) {
        var rx = self.position.X;
        var ry = self.position.Y;
        var rz = self.position.Z;
        var dx = vec3.X - rx, dy = vec3.Y - ry, dz = vec3.Z - rz;
        
        var size_array = [self.size.X, self.size.Y, self.size.Z];
        
        for (var i = 0; i < 3; i++) {
            var axis = self.property_orientation_array[i];
            var dist = dot_product_3d(dx, dy, dz, axis.X, axis.Y, axis.Z);
            dist = clamp(dist, -size_array[i], size_array[i]);
            rx += axis.X * dist;
            ry += axis.Y * dist;
            rz += axis.Z * dist;
        }
        
        return new Vector3(rx, ry, rz);
    };
    
    static GetInterval = function(axis) {
        var vertices = self.property_vertices;
        
        var xx = axis.X;
        var yy = axis.Y;
        var zz = axis.Z;
        
        var imin = infinity;
        var imax = -infinity;
        
        var i = 0;
        repeat (8) {
            var vertex = vertices[i++];
            var dot = dot_product_3d(xx, yy, zz, vertex.X, vertex.Y, vertex.Z);
            imin = min(imin, dot);
            imax = max(imax, dot);
        }
        
        return { val_min: imin, val_max: imax };
    };
    
    static GetVertices = function() {
        return array_map(self.property_vertices, function(item) {
			return item.Clone();
		});
    };
    
    static GetEdges = function() {
        return array_map(self.property_edges, function(item) {
			return new ColLine(item.start, item.finish);
		});
    };
    
    static GetMin = function() {
        return self.property_min.Clone();
    };
    
    static GetMax = function() {
        return self.property_max.Clone();
    };
	
static dbug_draw = function(col=c_white) {
    var vbuff = vertex_create_buffer();
    vertex_begin(vbuff, v_format);

    // Corner points of the box
    var x0 = -self.size.X;
    var x1 = self.size.X;
    var y0 = -self.size.Y;
    var y1 = self.size.Y;
    var z0 = -self.size.Z;
    var z1 = self.size.Z;

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

