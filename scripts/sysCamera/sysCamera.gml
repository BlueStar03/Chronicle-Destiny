function Camera() constructor {
    
    focus=null;
    proj_mat=matrix_build_projection_ortho(640/2,360/2,-20,3200)//matrix_build_projection_perspective_fov(60, window_get_width()/window_get_height(),1,32000)
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
            if instance_exists(focus){
                from.x=focus.x+64;
                from.y=focus.y+64;
                from.z=focus.z-64
                
                to.x=focus.x;
                to.y=focus.y;
                to.z=focus.z;
                
            }
        }
        draw=function(){
            draw_clear(c_cornflower)
            var cam=camera_get_active();
            camera_set_view_mat(cam,matrix_build_lookat(from.x, from.y, from.z, to.x, to.y, to.z, up.x,up.y,up.z));
            camera_set_proj_mat(cam, proj_mat);
            camera_apply(cam);
        }
        
    }
    
