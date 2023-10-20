function Billboard(sprite,shadow=-1,num=8)constructor{
	self.sprite=sprite;					//The sprite_index
	image=0;										//The Image_index
	sub=num;										//How many sub animations
	sub_angle=360/num								//angle defining the sub animations 
	anim_length=sprite_get_number(self.sprite)/num;		//lenght of sub aniation
	anim_frame=0;									//current frame of sub animation
	anim_speed=0.25;								//speed of sub animation
	anim_angle=0;									//which angle the sub animation is
	self.shadow=shadow;								//shadow of the sprite
	
	step=function(dir){		
		anim_frame+=anim_speed;
		if anim_frame>=anim_length{anim_frame=0;}
		var zdir=rollover(dir-(camera.orbit.dir+90),0,360);
		anim_angle=(round(zdir/sub_angle));
		image=(anim_angle*anim_length)+anim_frame;
		//zdir=rollover(zdir,0,360);
		
		//
		//
		//
	}
	set_sprite=function(sprite){
		self.sprite=sprite;
		anim_length=sprite_get_number(self.sprite)/sub;	
	}

	draw=function(x,y,z,bill=true,rot=0){
		if bill{
			matrix_set(matrix_world, matrix_build(x, y, z, -90+0, 0, camera.orbit.dir+90+rot, 1, 1, 1));
			draw_sprite(sprite,image,0,0)
			matrix_set(matrix_world, matrix_build_identity());
		}else{
			matrix_set(matrix_world, matrix_build(x, y, z, -90+0, 0, 0+rot, 1, 1, 1));
			draw_sprite(sprite,image,0,0)
			matrix_set(matrix_world, matrix_build_identity());
		}
		if sprite_exists(shadow){
			draw_3d_sprite(shadow,0,x,y,z-0.1,90,0,0)
		}

	}
}