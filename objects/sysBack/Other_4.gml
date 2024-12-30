var _layers =layer_get_all();
var index=0
if array_length(_layers)>0{
    for (var i=0;i<array_length(_layers);i++){
        show_debug_message(layer_get_name(_layers[i]) )
        var a = layer_get_all_elements(_layers[i]);
        if array_length(a)>0{
            var l= layer_get_element_type(a[0]) == layerelementtype_tilemap
            show_debug_message(l)
            if l{
                var n=layer_get_name(_layers[i])
                var d=layer_get_id(n);
                tilemaps[index][0]=layer_get_visible(d);
                tilemaps[index][1]=tilemap_to_vertex_buffer(n);
                tilemaps[index][2]=tileset_get_texture(tilemap_get_tileset(layer_tilemap_get_id(d)))
                index++
            }
        }
    }
}