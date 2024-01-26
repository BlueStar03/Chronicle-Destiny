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
	
	
	
	static dbug_draw = function(col=c_white) {
		
	}
}