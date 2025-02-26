draw_clear(c_cornflowerblue)
var camera = camera_get_active();
camera_set_view_mat(camera,matrix_build_lookat(x,y+128,-128,x,y,0,0,0,1));
camera_set_proj_mat(camera,matrix_build_projection_perspective_fov(60,window_get_width()/window_get_width(),0,3200));
camera_apply(camera);