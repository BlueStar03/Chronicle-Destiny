///@func							Sprite(sprite, [shadow], [dir_numb])
///@desc							struct for camera aware 3d isometric sprites 
///@arg		{sprite} sprite			sprite asset to be used
///@arg		{sprite} shadow			sprite asset to be used as a shadow
///@arg		{sprite} dir_numb			how many directions
function Sprite(sprite,shadow=-1,num=8)constructor{
	index=sprite;									//The sprite_index
	image=0;										//The Image_index
	sub=num;										//How many sub animations
	sub_angle=360/num								//angle defining the sub animations 
	anim_length=sprite_get_number(index)/num;		//lenght of sub aniation
	anim_frame=0;									//current frame of sub animation
	anim_speed=0.25;								//speed of sub animation
	anim_angle=0;									//which angle the sub animation is
	self.shadow=shadow;								//shadow of the sprite
	

	///@func						step(dir)
	///@desc						updates the sprite
	///@arg		{deg} dir				direction in degrees the sprite is facing
	step=function(dir){
		var zdir=rollover(dir-(camera.orbit.dir+90),0,360);
		zdir=rollover(zdir,0,360);
		anim_frame+=anim_speed;
		if anim_frame>=anim_length{anim_frame=0;}
		anim_angle=(round(zdir/sub_angle));
		image=(anim_angle*anim_length)+anim_frame;
	}//*******************************************************************************
	
	
	///@func						set_sprite(sprite)
	///@desc						changes the sprite
	///@arg		{sprite} sprite			sprite to set
	set_sprite=function(sprite){
		index=sprite;
		anim_length=sprite_get_number(index)/sub;
	}//******************************************************************************
	
	
	///@func						set_shadow(sprite)
	///@desc						changes the sprite of the shadow
	///@arg		{sprite} sprite			sprite to set
	set_shadow=function(sprite){
		shadow=sprite;	
	}//******************************************************************************
	
	
	///@func							draw(x, y, z)
	///@desc							draws the sprite as billboard
	///@arg		{real} x				x-coordinate to draw the sprite
	///@arg		{real} y				y-coordinate to draw the sprite
	///@arg		{real} z				z-coordinate to draw the sprite
	///@arg		{real} [sx]				scale-x to draw the sprite
	///@arg		{real} [sy]				scale-y to draw the sprite
	///@arg		{real} [ir]				image rotation to draw the sprite
	///@arg		{real} [cc]				color to draw the sprite
	///@arg		{real} [aa]				alpha to draw the sprite
	draw=function(x,y,z,sx=1,sy=1,ir=0,cc=c_white,aa=1){
		draw_3d_billboard(index,image,x,y,z,sx,sy,ir,cc,aa);
		if sprite_exists(obj_shadow){
			draw_3d_sprite(obj_shadow,0,x,y,z-0.1,90,0,0)
		}
	}//******************************************************************************
	
	
	///@func						draw_plane(x, y, z, [rz], [ry], [rz], [sx], [sy], [ir], [cc], [aa])
	///@desc						draws the sprite as a plane
	///@arg		{real} x				x-coordinate to draw the sprite
	///@arg		{real} y				y-coordinate to draw the sprite
	///@arg		{real} z				z-coordinate to draw the sprite
	///@arg		{deg} [rx]				rotate-x to draw the sprite
	///@arg		{deg} [ry]				rotate-y to draw the sprite
	///@arg		{deg} [rz]				rotate-z to draw the sprite
	///@arg		{real} [sx]				scale-x to draw the sprite
	///@arg		{real} [sy]				scale-y to draw the sprite
	///@arg		{deg} [ir]				image rotation to draw the sprite
	///@arg		{color} [cc]				color to draw the sprite
	///@arg		{real} [aa]				alpha to draw the sprite
	draw_plane=function(x,y,z,rx=0,ry=0,rz=0,sx=1,sy=1,ir=0,cc=c_white,aa=1){
		draw_3d_sprite(index,image,x,y,z,rx,ry,rz,sx,sy,ir,cc,aa)
	}
}
//////////////////////////////////////////////////////////////////////////////





function draw_3d_sprite(ss,ii,xx,yy,zz,rx=0,ry=0,rz=0,xs=1,ys=1,ir=0,cc=c_white,aa=1){
	matrix_set(matrix_world, matrix_build(xx, yy, zz, -90+rx, ry, rz, 1, 1, 1));
	draw_sprite_ext( ss, ii, 0, 0, xs, ys, ir, cc, aa );
	matrix_set(matrix_world, matrix_build_identity());
}



function draw_3d_billboard(ss,ii,xx,yy,zz,sx=1,sy=1,ir=0,cc=c_white,aa=1){
	matrix_set(matrix_world, matrix_build(xx, yy, zz, -90+0, 0, camera.orbit.dir+90, 1, 1, 1.25));
	draw_sprite_ext( ss, ii, 0, 0, sx, sy, ir, cc, aa );
	matrix_set(matrix_world, matrix_build_identity());
}
