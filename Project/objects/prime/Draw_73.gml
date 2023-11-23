/// @description 
if dbug.on{
gpu_set_ztestenable(false);


gpu_set_zwriteenable(false)

			with wall{
				
				shape.dbug_draw();	
			}
with player_{
shape.dbug_draw();	
}
gpu_set_ztestenable(true);


gpu_set_zwriteenable(true)
}