function Plane(normal, distance) constructor {
	self.normal = normal;					// Vec3
	self.distance = distance;				// number

	static check_collider = function(collider){
		return collider.shape.check_plane(self);
	}

	static check_point = function(point){
		return point.check_plane(self);
	}

	static check_sphere = function(sphere){
		return sphere.check_plane(self);
	}

	static check_aabb = function(aabb){
		return aabb.check_plane(self);
	}

	static check_plane = function(plane){
		var cross = self.normal.cross(plane.normal);
		return (cross.magnitude() > 0) || (self.distance == plane.distance);
	}
	
	static check_ray = function(ray, hit_info){
		var DdotN = ray.direction.dot(self.normal);
		if (DdotN >= 0) return false;

		var OdotN = ray.origin.dot(self.normal);
		var t = (self.distance - OdotN) / DdotN;
		if (t < 0) return false;

		var contact_point = ray.origin.add(ray.direction.multiply(t));

		hit_info.update(t, self, contact_point, self.normal);

		return true;
	}

	static check_line = function(line){
		var dir = line.finish.subtract(line.start);
		var NdotS = self.normal.dot(line.start);
		var NdotD = self.normal.dot(dir);

		if (NdotD == 0) return false;
		var t = (self.distance - NdotS) / NdotD;
		return (t >= 0) && (t <= 1);
	}

	static check_obb = function(obb){
		return obb.check_plane(self);
	}

	static check_capsule = function(capsule){
		return capsule.check_plane(self);
	}

#region not yet triangle mesh
		static check_triangle = function(triangle){
		var side_a = self.PlaneEquation(triangle.a);
		var side_b = self.PlaneEquation(triangle.b);
		var side_c = self.PlaneEquation(triangle.c);

		if (side_a == 0 && side_b == 0 && side_c == 0){
		return true;
		}

		if (sign(side_a) == sign(side_b) && sign(side_a) == sign(side_c)){
		return false;
		}

		return true;
		}

		static check_mesh = function(mesh){
		return mesh.check_plane(self);
		}

		static check_model = function(model){
		return model.check_plane(self);
		}
#endregion
	
	static displace_sphere = function(sphere){
		if (!self.check_sphere(sphere)) return undefined;

		var nearest = self.nearest_point(sphere.position);
		var offset = self.normal.multiply(sphere.radius);

		return nearest.add(offset);
	}

	static nearest_point = function(vec3){
		var ndot = self.normal.dot(vec3);
		var dist = ndot - self.distance;
		var scaled_dist = self.normal.multiply(dist);
		return vec3.subtract(scaled_dist);
	}

	static plane_equation = function(vec3){
		// much like the dot product, this function will return:
		// - +1ish if the value is in front of the plane
		// - 0 if the value is on the plane
		// - -1ish is the value is behind the plane
		var dot = vec3.dot(self.normal);
		return dot - self.distance;
	}

	static get_min = function(){
		return undefined;
	}

	static get_max = function(){
		return undefined;
	}

	static normalize = function(){
		var mag = self.normal.magnitude();
		return new Plane(self.normal.divide(mag), self.distance / mag);
	}
	
	static dbug_draw=function(color=c_white){
		
	}
}