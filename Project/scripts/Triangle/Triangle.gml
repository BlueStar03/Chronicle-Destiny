function Triangle(a, b, c) constructor {
    self.Set(a, b, c);
    
    static Set = function(a, b, c) {
        self.a = a;
        self.b = b;
        self.c = c;
        var diffAB = b.Sub(a);
        var diffAC = c.Sub(a);
        self.property_normal = diffAB.Cross(diffAC).Normalize();
        var dist = self.property_normal.Dot(a);
        self.property_plane = new ColPlane(self.property_normal, dist);
        
        self.property_edge_ab = diffAB;
        self.property_edge_bc = c.Sub(b);
        self.property_edge_ca = a.Sub(c);
        
        self.property_center = a.Add(b).Add(c).Div(3);
        self.property_radius = self.property_center.DistanceTo(a);
        self.property_min = new Vector3(min(a.X, b.X, c.X), min(a.Y, b.Y, c.Y), min(a.Z, b.Z, c.Z));
        self.property_max = new Vector3(max(a.X, b.X, c.X), max(a.Y, b.Y, c.Y), max(a.Z, b.Z, c.Z));
    };
    
    static CheckObject = function(object) {
        return object.shape.CheckTriangle(self);
    };
    
    static CheckPoint = function(point) {
        return point.CheckTriangle(self);
    };
    
    static CheckSphere = function(sphere) {
        return sphere.CheckTriangle(self);
    };
    
    static CheckAABB = function(aabb) {
        return aabb.CheckTriangle(self);
    };
    
    static CheckPlane = function(plane) {
        return plane.CheckTriangle(self);
    };
    
    static CheckOBB = function(obb) {
        return obb.CheckTriangle(self);
    };
    
    static CheckCapsule = function(capsule) {
        return capsule.CheckTriangle(self);
    };
    
    static CheckTriangle = function(triangle) {
        static zero_vector = new Vector3(0, 0, 0);
        
        var p1 = self.property_center;
        var p2 = triangle.property_center;
        if (point_distance_3d(p1.X, p1.Y, p1.Z, p2.X, p2.Y, p2.Z) >= (self.property_radius + triangle.property_radius)) return false;
        
        // Phase 1: are each of the points of one triangle on the
        // same side of the plane of the other triangle?
        var plane_a = self.property_plane;
        var plane_b = triangle.property_plane;
        
        var a = self.a, b = self.b, c = self.c;
        var vax = a.X, vay = a.Y, vaz = a.Z;
        var vbx = b.X, vby = b.Y, vbz = b.Z;
        var vcx = c.X, vcy = c.Y, vcz = c.Z;
        
        var nxa = plane_a.normal.X, nya = plane_a.normal.Y, nza = plane_a.normal.Z;
        var d = plane_a.distance;
        var paa = dot_product_3d(nxa, nya, nza, vax, vay, vaz) - d;
        var pab = dot_product_3d(nxa, nya, nza, vbx, vby, vbz) - d;
        var pac = dot_product_3d(nxa, nya, nza, vcx, vcy, vcz) - d;
        
        if ((paa * pab) > 0 && (paa * pac) > 0) {
            return false;
        }
        
        var nxb = plane_b.normal.X, nyb = plane_b.normal.Y, nzb = plane_b.normal.Z;
        d = plane_b.distance;
        var pba = dot_product_3d(nxb, nyb, nzb, vax, vay, vaz) - d;
        var pbb = dot_product_3d(nxb, nyb, nzb, vbx, vby, vbz) - d;
        var pbc = dot_product_3d(nxb, nyb, nzb, vcx, vcy, vcz) - d;
        
        if ((pba * pbb) > 0 && (pba * pbc) > 0) {
            return false;
        }
        
        // Phase 2: are both triangles coplanar?
        if (plane_a.distance == plane_b.distance && abs(dot_product_3d(nxa, nya, nza, nxb, nyb, nzb)) == 1) {
            static test_point = new ColPoint(zero_vector);
            
            test_point.position = self.a;
            if (test_point.CheckTriangle(triangle)) return true;
            test_point.position = self.b;
            if (test_point.CheckTriangle(triangle)) return true;
            test_point.position = self.c;
            if (test_point.CheckTriangle(triangle)) return true;
            test_point.position = triangle.a;
            if (test_point.CheckTriangle(triangle)) return true;
            test_point.position = triangle.b;
            if (test_point.CheckTriangle(triangle)) return true;
            test_point.position = triangle.c;
            if (test_point.CheckTriangle(triangle)) return true;
            
            var origin = self.a;
            var norm = self.property_normal;
            var e1 = self.property_edge_ab;
            var e2 = e1.Cross(norm);
            var ox = origin.X, oy = origin.Y, oz = origin.Z;
            var e1x = e1.X, e1y = e1.Y, e1z = e1.Z;
            var e2x = e2.X, e2y = e2.Y, e2z = e2.Z;
            
            static sa = new Vector3(0, 0, 0);
            static sb = new Vector3(0, 0, 0);
            static sc = new Vector3(0, 0, 0);
            static oa = new Vector3(0, 0, 0);
            static ob = new Vector3(0, 0, 0);
            static oc = new Vector3(0, 0, 0);
            
            var dx = vax - ox;
            var dy = vay - oy;
            var dz = vaz - oz;
            sa.X = dot_product_3d(dx, dy, dz, e1x, e1y, e1z);
            sa.Y = dot_product_3d(dx, dy, dz, e2x, e2y, e2z);
            dx = vbx - ox;
            dy = vby - oy;
            dz = vbz - oz;
            sb.X = dot_product_3d(dx, dy, dz, e1x, e1y, e1z);
            sb.Y = dot_product_3d(dx, dy, dz, e2x, e2y, e2z);
            dx = vcx - ox;
            dy = vcy - oy;
            dz = vcz - oz;
            sc.X = dot_product_3d(dx, dy, dz, e1x, e1y, e1z);
            sc.Y = dot_product_3d(dx, dy, dz, e2x, e2y, e2z);
            dx = triangle.a.X - ox;
            dy = triangle.a.Y - oy;
            dz = triangle.a.Z - oz;
            oa.X = dot_product_3d(dx, dy, dz, e1x, e1y, e1z);
            oa.Y = dot_product_3d(dx, dy, dz, e2x, e2y, e2z);
            dx = triangle.b.X - ox;
            dy = triangle.b.Y - oy;
            dz = triangle.b.Z - oz;
            ob.X = dot_product_3d(dx, dy, dz, e1x, e1y, e1z);
            ob.Y = dot_product_3d(dx, dy, dz, e2x, e2y, e2z);
            dx = triangle.c.X - ox;
            dy = triangle.c.Y - oy;
            dz = triangle.c.Z - oz;
            oc.X = dot_product_3d(dx, dy, dz, e1x, e1y, e1z);
            oc.Y = dot_product_3d(dx, dy, dz, e2x, e2y, e2z);
            
            if (col_lines_intersect(sa, sb, oa, ob)) return true;
            if (col_lines_intersect(sa, sb, ob, oc)) return true;
            if (col_lines_intersect(sa, sb, oc, oa)) return true;
            if (col_lines_intersect(sb, sc, oa, ob)) return true;
            if (col_lines_intersect(sb, sc, ob, oc)) return true;
            if (col_lines_intersect(sb, sc, oc, oa)) return true;
            if (col_lines_intersect(sc, sa, oa, ob)) return true;
            if (col_lines_intersect(sc, sa, ob, oc)) return true;
            if (col_lines_intersect(sc, sa, oc, oa)) return true;
            
            return false;
        }
        
        // Phase 3: the regular SAT
        
        // edges of ourself
        var ab = self.property_edge_ab;
        var bc = self.property_edge_bc;
        var ca = self.property_edge_ca;
        var ixx = ab.X, ixy = ab.Y, ixz = ab.Z;
        var iyx = bc.X, iyy = bc.Y, iyz = bc.Z;
        var izx = ca.X, izy = ca.Y, izz = ca.Z;
        // edges of the other triangle
        var ox = triangle.property_edge_ab;
        var oy = triangle.property_edge_bc;
        var oz = triangle.property_edge_ca;
        var oxx = ox.X, oxy = ox.Y, oxz = ox.Z;
        var oyx = oy.X, oyy = oy.Y, oyz = oy.Z;
        var ozx = oz.X, ozy = oz.Y, ozz = oz.Z;
        
        static axes = array_create(11 * 3);
        
        // The normals of both triangle, plus each of the edges of 
        // triangle crossed against each of the edges of the other
        axes[0 * 3 + 0] = self.property_normal.X;
        axes[0 * 3 + 1] = self.property_normal.Y;
        axes[0 * 3 + 2] = self.property_normal.Z;
        axes[1 * 3 + 0] = triangle.property_normal.X;
        axes[1 * 3 + 1] = triangle.property_normal.Y;
        axes[1 * 3 + 2] = triangle.property_normal.Z;
        
        axes[2 * 3 + 0] = ixy * oxz - oxy * ixz;
        axes[2 * 3 + 1] = ixz * oxx - oxz * ixx;
        axes[2 * 3 + 2] = ixx * oxy - oxx * ixy;
        axes[3 * 3 + 0] = iyy * oxz - oxy * iyz;
        axes[3 * 3 + 1] = iyz * oxx - oxz * iyx;
        axes[3 * 3 + 2] = iyx * oxy - oxx * iyy;
        axes[4 * 3 + 0] = izy * oxz - oxy * izz;
        axes[4 * 3 + 1] = izz * oxx - oxz * izx;
        axes[4 * 3 + 2] = izx * oxy - oxx * izy;
        axes[5 * 3 + 0] = ixy * oyz - oyy * ixz;
        axes[5 * 3 + 1] = ixz * oyx - oyz * ixx;
        axes[5 * 3 + 2] = ixx * oyy - oyx * ixy;
        axes[6 * 3 + 0] = iyy * oyz - oyy * iyz;
        axes[6 * 3 + 1] = iyz * oyx - oyz * iyx;
        axes[6 * 3 + 2] = iyx * oyy - oyx * iyy;
        axes[7 * 3 + 0] = izy * oyz - oyy * izz;
        axes[7 * 3 + 1] = izz * oyx - oyz * izx;
        axes[7 * 3 + 2] = izx * oyy - oyx * izy;
        axes[8 * 3 + 0] = ixy * ozz - ozy * ixz;
        axes[8 * 3 + 1] = ixz * ozx - ozz * ixx;
        axes[8 * 3 + 2] = ixx * ozy - ozx * ixy;
        axes[9 * 3 + 0] = iyy * ozz - ozy * iyz;
        axes[9 * 3 + 1] = iyz * ozx - ozz * iyx;
        axes[9 * 3 + 2] = iyx * ozy - ozx * iyy;
        axes[10 * 3 + 0] = izy * ozz - ozy * izz;
        axes[10 * 3 + 1] = izz * ozx - ozz * izx;
        axes[10 * 3 + 2] = izx * ozy - ozx * izy;
        
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
        repeat (11) {
            var ax = axes[i++];
            var ay = axes[i++];
            var az = axes[i++];
            var ada = dot_product_3d(ax, ay, az, vax, vay, vaz);
            var adb = dot_product_3d(ax, ay, az, vbx, vby, vbz);
            var adc = dot_product_3d(ax, ay, az, vcx, vcy, vcz);
            var val_min_a = min(ada, adb, adc), val_max_a = max(ada, adb, adc);
            ada = dot_product_3d(ax, ay, az, tax, tay, taz);
            adb = dot_product_3d(ax, ay, az, tbx, tby, tbz);
            adc = dot_product_3d(ax, ay, az, tcx, tcy, tcz);
            var val_min_b = min(ada, adb, adc), val_max_b = max(ada, adb, adc);
            
            if ((val_min_b > val_max_a) || (val_min_a > val_max_b)) {
                return false;
            }
        }
        
        return true;
    };
    
    static CheckMesh = function(mesh) {
        return mesh.CheckTriangle(self);
    };
    
    static CheckModel = function(model) {
        return model.CheckTriangle(self);
    };
    
    static CheckRay = function(ray, hit_info = undefined) {
        static plane_hit_info = new RaycastHitInformation();
        plane_hit_info.shape = undefined;
        plane_hit_info.point = undefined;
        plane_hit_info.distance = infinity;
        plane_hit_info.normal = undefined;
        
        if (!self.property_plane.CheckRay(ray, plane_hit_info)) {
            return false;
        }
        
        var barycentric = self.Barycentric(plane_hit_info.point);
        
        if ((barycentric.X >= 0 && barycentric.X <= 1) && (barycentric.Y >= 0 && barycentric.Y <= 1) && (barycentric.Z >= 0 && barycentric.Z <= 1)) {
            if (plane_hit_info) {
                hit_info.Update(plane_hit_info.distance, self, plane_hit_info.point, plane_hit_info.normal);
            }
            return true;
        }
        
        return false;
    };
    
    static CheckLine = function(line) {
        static hit_info = new RaycastHitInformation();
        hit_info.distance = infinity;
        
        if (self.CheckRay(line.property_ray, hit_info)) {
            return (hit_info.distance <= line.property_length);
        }
        static reverse = new ColLine(new Vector3(0, 0, 0), new Vector3(0, 0, 0));
        reverse.Set(line.finish, line.start.Sub(line.finish));
        if (self.CheckRay(reverse.property_ray, hit_info)) {
            return (hit_info.distance <= reverse.property_length);
        }
        return false;
    };
    
    static DisplaceSphere = function(sphere) {
        if (!self.CheckSphere(sphere)) return undefined;
        
        var pt = self.property_center;
        var ps = sphere.position;
        var nearest = self.NearestPoint(ps);
        // you may also wish to just use the normal of the triangle in this case
        if (pt.X == ps.X && pt.Y == ps.Y && pt.Z == ps.Z) return undefined;
        
        var offset = ps.Sub(nearest).Normalize().Mul(sphere.radius);
        
        return nearest.Add(offset);
    };
    
    static GetNormal = function() {
        return self.property_normal.Clone();
    };
    
    static GetPlane = function() {
        return new ColPlane(self.property_plane.normal, self.property_plane.distance);
    };
    
    static NearestPoint = function(vec3) {
        static test_point = new ColPoint(new Vector3(0, 0, 0));
        static lineAB = new ColLine(new Vector3(0, 0, 0), new Vector3(0, 0, 0));
        static lineBC = new ColLine(new Vector3(0, 0, 0), new Vector3(0, 0, 0));
        static lineCA = new ColLine(new Vector3(0, 0, 0), new Vector3(0, 0, 0));
        
        var nearest_to_plane = self.property_plane.NearestPoint(vec3);
        
        test_point.position = nearest_to_plane;
        
        if (test_point.CheckTriangle(self)) {
            return nearest_to_plane;
        }
        
        lineAB.start = self.a;
        lineAB.finish = self.b;
        lineBC.start = self.b;
        lineBC.finish = self.c;
        lineCA.start = self.c;
        lineCA.finish = self.a;
        
        var nearest_to_ab = lineAB.NearestPoint(vec3);
        var nearest_to_bc = lineBC.NearestPoint(vec3);
        var nearest_to_ca = lineCA.NearestPoint(vec3);
        
        var vx = vec3.X, vy = vec3.Y, vz = vec3.Z;
        
        var dist_ab = point_distance_3d(vx, vy, vz, nearest_to_ab.X, nearest_to_ab.Y, nearest_to_ab.Z);
        var dist_bc = point_distance_3d(vx, vy, vz, nearest_to_bc.X, nearest_to_bc.Y, nearest_to_bc.Z);
        var dist_ca = point_distance_3d(vx, vy, vz, nearest_to_ca.X, nearest_to_ca.Y, nearest_to_ca.Z);
        
        if (dist_ab < dist_bc && dist_ab < dist_ca) {
            return nearest_to_ab;
        }
        
        if (dist_bc < dist_ca && dist_bc < dist_ab) {
            return nearest_to_bc;
        }
        
        return nearest_to_ca;
    };
    
    static Barycentric = function(vec3) {
        var pa = vec3.Sub(self.a);
        var pb = vec3.Sub(self.b);
        var pc = vec3.Sub(self.c);
        
        var ab = self.property_edge_ab;
        var ac = self.c.Sub(self.a);
        var bc = self.property_edge_bc;
        var cb = self.b.Sub(self.c);
        var ca = self.property_edge_ca;
        
        var v = ab.Sub(ab.Project(cb));
        var vdpa = dot_product_3d(v.X, v.Y, v.Z, pa.X, pa.Y, pa.Z);
        var vdab = dot_product_3d(v.X, v.Y, v.Z, ab.X, ab.Y, ab.Z);
        var a = 1 - vdpa / vdab;
        
        v = bc.Sub(bc.Project(ac));
        var vdpb = dot_product_3d(v.X, v.Y, v.Z, pb.X, pb.Y, pb.Z);
        var vdbc = dot_product_3d(v.X, v.Y, v.Z, bc.X, bc.Y, bc.Z);
        var b = 1 - vdpb / vdbc;
        
        v = ca.Sub(ca.Project(ab));
        var vdpc = dot_product_3d(v.X, v.Y, v.Z, pc.X, pc.Y, pc.Z);
        var vdca = dot_product_3d(v.X, v.Y, v.Z, ca.X, ca.Y, ca.Z);
        var c = 1 - vdpc / vdca;
        
        return new Vector3(a, b, c);
    };
    
    static GetInterval = function(axis) {
        var ax = axis.X;
        var ay = axis.Y;
        var az = axis.Z;
        var ada = dot_product_3d(ax, ay, az, self.a.X, self.a.Y, self.a.Z);
        var adb = dot_product_3d(ax, ay, az, self.b.X, self.b.Y, self.b.Z);
        var adc = dot_product_3d(ax, ay, az, self.c.X, self.c.Y, self.c.Z);
        return { val_min: min(ada, adb, adc), val_max: max(ada, adb, adc) };
    };
    
    static GetMin = function() {
        return self.property_min.Clone();
    };
    
    static GetMax = function() {
        return self.property_max.Clone();
    };
		
		static dbug_draw=function(c_col=c_white){
			var vbuff = vertex_create_buffer();
      vertex_begin(vbuff, v_format);
						vertex_add(vbuff, a.X, a.Y, a.Z, c_col);  
						vertex_add(vbuff, b.X, b.Y, b.Z, c_col); 
						 
						vertex_add(vbuff, b.X, b.Y, b.Z, c_col); 
						vertex_add(vbuff, c.X, c.Y, c.Z, c_col); 
						
						vertex_add(vbuff, c.X, c.Y, c.Z, c_col); 
						vertex_add(vbuff, a.X, a.Y, a.Z, c_col);  
			vertex_end(vbuff);
			vertex_submit(vbuff, pr_linelist, -1);
			vertex_delete_buffer(vbuff);
		}
}