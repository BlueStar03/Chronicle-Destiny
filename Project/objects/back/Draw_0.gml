/// @description 

camera.draw();
if false{
	vertex_submit(test_floor,pr_trianglelist,-1)//tileset_get_texture(ts_grid))
}else{
	vertex_submit(test_floor,pr_trianglelist,tileset_get_texture(tilemap_get_tileset(layer_tilemap_get_id(layer_get_id("tm_floor")))))
}

//buffer_delete(test_floor)
//test_floor=tilemap_to_vertex_buffer("tm_floor")