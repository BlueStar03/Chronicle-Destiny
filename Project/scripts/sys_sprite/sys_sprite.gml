function Sprite(sprite)constructor{
	self.sprite=sprite;
	spr=sprite;

	draw=function(x,y,z,bill=true){
		if bill{
			matrix_set(matrix_world, matrix_build(x, y, z, -90+0, 0, camera.orbit.dir+90, 1, 1, 1));
			draw_sprite(sprite,0,0,0)
			matrix_set(matrix_world, matrix_build_identity());
		}else{
			matrix_set(matrix_world, matrix_build(x, y, z, -90+0, 0, 0, 1, 1, 1));
			draw_sprite(sprite,0,0,0)
			matrix_set(matrix_world, matrix_build_identity());
		}

	}
}