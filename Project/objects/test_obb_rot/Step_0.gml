/// @description 
zrot++
collider.shape.orientation=new Matrix4(matrix_build(0, 0, 0, 0,0,zrot, 1, 1, 1)).get_orientation_matrix()
collider.shape.recalculate_properties();
if collider.check_collider(player.collider){
	col=c_red;	
}else{
	col=c_blue;	
}



