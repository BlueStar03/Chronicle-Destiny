function Camera()constructor{
	mode="none";
	focus=noone;
	snap=true;
	snap_sign=0;
	
	from=new Vector3(0,0,-128);
	to=new Vector3(128,128,0);
	up=new Vector3(0,0,1);	
	orbit={
		dir:270+45,
		distance:power(2,8)*1.5,
		elevation:30
	}
	
	zoom=2
	//pro_mat=matrix_build_projection_perspective_fov(45/2, display.width/display.height, 1.0, 32000.0);
	pro_mat=matrix_build_projection_ortho(display.width/zoom,display.height/zoom,-100,3200)
	
	//if TILEMODE{


	//}
	

	update=function(){
		if mode=="orbit"{
			var rot=input.horizontal_right;
			orbit.dir+=rot
			orbit.dir=round(orbit.dir)
			if snap{
				if abs(rot)<0.001{
					var c=orbit.dir;
					var a=0
					if (c mod 45 != 0){
						if(c % 45>22.5){
							a+=1;
						}else{
							a-=1;
						}
					orbit.dir+=a;
					}
				}
			}else{
				if abs(rot)<0.001{
					if (orbit.dir mod 45 !=0){
						orbit.dir+=snap_sign
					}
				}else{
					snap_sign=sign(rot);
				}
			}
			orbit.dir=rollover(orbit.dir,0,360);
			if instance_exists(focus){
				to.x=focus.x;
				to.y=focus.y;
				to.z=focus.z;
			}else{
				focus=noone;
				mode="none"
			}
			var dist=orbit.distance;
			var dir=degtorad(-orbit.dir);
			var ele=degtorad(orbit.elevation+90);
			from.x=to.x+(dist*sin(ele)*cos(dir));
			from.y=to.y+(dist*sin(ele)*sin(dir));
			from.z=to.z+(dist*cos(ele));
		}else{
		if instance_exists(focus){
			var p=8
			from.x=focus.x-power(2,p);
			from.y=focus.y+power(2,p);
			from.z=focus.z-power(2,p);
			
			to.x=focus.x;
			to.y=focus.y;
			to.z=focus.z;
		}}
	}

	draw=function(){
		draw_clear(c_black);//(#6495ed)
		var cam=camera_get_active();
		camera_set_view_mat(cam, matrix_build_lookat(from.x,from.y,from.z,to.x,to.y,to.z,up.x,up.y,up.z));
		camera_set_proj_mat(cam,pro_mat);
		camera_apply(cam);
	}
}