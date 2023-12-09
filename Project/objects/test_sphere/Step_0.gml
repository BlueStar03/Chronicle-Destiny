/// @description 
//if stat{
//	image_xscale+=0.01
//	image_yscale=image_xscale
//	if image_xscale>2{
//		stat=false	
//	}
//}else{
//	image_xscale-=0.01
//	image_yscale=image_xscale
//	if image_xscale<1{
//		stat=true	
//	}
//}
//var r=(sprite_width*image_xscale)/2
//collider.shape.radius=r;
//collider.shape.position.z=-r;
if collider.check_collider(player.collider){
	col=c_red;	
}else{
	col=c_blue;	
}



