function Sprite(sprite)constructor{
	spr=sprite;

	draw=function(x,y,z){
		matrix_set(matrix_world, matrix_build(x, y, z, -90+0, 0, camera.orbit.dir+90, 1, 1, 1));
		draw_sprite(spr,0,0,0)
		matrix_set(matrix_world, matrix_build_identity());
	}
}