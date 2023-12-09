/// @description 
if dbug.on{
gpu_set_ztestenable(false);


gpu_set_zwriteenable(false)

//			with wall{
				
//				shape.dbug_draw();	
//			}
//with player{
//shape.dbug_draw();	
//}
gpu_set_ztestenable(true);


gpu_set_zwriteenable(true)
}
if collider!=undefined{
collider.dbug_draw(c_fuchsia)
}