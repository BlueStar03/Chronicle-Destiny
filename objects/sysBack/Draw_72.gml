camera.draw();

if layer_exists("TestTiles"){
vertex_submit(tilemap_vb, pr_trianglelist, tileset_get_texture(ts_testgrid));

}