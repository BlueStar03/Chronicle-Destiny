function draw_board(sprite, subimg, x, y, z=0,dir=0, xscale=1, yscale=1,rot=0,ang=0,col=c_white, alpha=1){
			if sprite==-1{return}
			matrix_set(matrix_world, matrix_build(x, y, z, -90+0, 0, 0+dir, 1, 1, 1));
			draw_sprite_ext(sprite,subimg,0,0,xscale,yscale,rot,col,alpha)
			matrix_set(matrix_world, matrix_build_identity());
}
function draw_billboard(sprite,subimg,x,y,z=0,rot=0){
	if sprite==-1{return}
	matrix_set(matrix_world, matrix_build(x, y, z, -90+0, 0, camera.orbit.dir+90+rot, 1, 1, 1));
	draw_sprite(sprite,subimg,0,0)
	matrix_set(matrix_world, matrix_build_identity());	
}

function draw_impostor(sprite, subimg, x, y, z=0,dir=0 ){
	if sprite==-1{return}
			matrix_set(matrix_world, matrix_build(x, y, z, -90+0, 0, 0+dir, 1, 1, 1));
			draw_sprite(sprite,subimg,0,0)
			matrix_set(matrix_world, matrix_build(x, y, z, -90+0, 0, 90+dir, 1, 1, 1));
			draw_sprite(sprite,subimg,0,0)
			matrix_set(matrix_world, matrix_build_identity());
}

