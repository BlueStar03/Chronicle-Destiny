/// @description
	if camera.pro_mat==camera.pro_mat_orthographic{
		camera.pro_mat=camera.pro_mat_perspective
		camera.type="perspective"
	}else{
		camera.pro_mat=camera.pro_mat_orthographic;	
		camera.type="orthographic"
	}