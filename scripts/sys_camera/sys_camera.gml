function sysCamera() constructor{
    
    
    proj_mat=matrix_build_projection_ortho(640/2,360/2,-10,32000)//matrix_build_projection_perspective_fov(60, window_get_width()/window_get_height(),1,32000)
    from={
        x:0,
        y:0,
        z:-50,
    }
    to={
      x:100,
      y:100,
      z:0,
    }
    up={
        x:0,
        y:0,
        z:1,
    }
    update=function(){
        if instance_exists(player){
            from.x=player.x+64;
            from.y=player.y+64;
            from.z=-64
            
            to.x=player.x;
            to.y=player.y;
            to.z=0;
            
        }
    }
    draw=function(){
        draw_clear(c_cornflower)
        var camera=camera_get_active();
        camera_set_view_mat(camera,matrix_build_lookat(from.x, from.y, from.z, to.x, to.y, to.z, up.x,up.y,up.z));
        camera_set_proj_mat(camera, proj_mat);
        camera_apply(camera);
    }
    
}
