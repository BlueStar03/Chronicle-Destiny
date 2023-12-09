function tilemap_to_vertex_buffer(layer_name){	
	var tilelayer = layer_get_id(layer_name);
	var tm_depth = layer_get_depth(tilelayer);
	var tilemap = layer_tilemap_get_id(tilelayer);
	
	var tm_tileset = tilemap_get_tileset(tilemap);

	var ts_info=tileset_get_info(tm_tileset);
	var ts_tile_width=ts_info.tile_width;
	var ts_tile_height=ts_info.tile_height;
	
	var ts_horizontal_count=ts_info.tile_columns;

	var ts_uvs=tileset_get_uvs(tm_tileset);
	var ts_uvs_left = ts_uvs[0];
	var ts_uvs_top = ts_uvs[1];
	var ts_uvs_right = ts_uvs[2];
	var ts_uvs_bottom = ts_uvs[3];
	
	var ts_texture=tileset_get_texture(tm_tileset);
	var ts_texel_width = texture_get_texel_width(ts_texture);
	var ts_texel_height = texture_get_texel_height(ts_texture);
	var ts_texel_tile_width = ts_texel_width * ts_tile_width;
	var ts_texel_tile_height = ts_texel_height * ts_tile_height;
	
	var ts_tile_horizontal_separator=(2 * ts_info.tile_horizontal_separator)*ts_texel_width;
	var ts_tile_vertical_separator=(2 * ts_info.tile_vertical_separator)*ts_texel_height;
	
	ts_texel_tile_width+=ts_tile_horizontal_separator;
	ts_texel_tile_height+=ts_tile_vertical_separator;
	
	var tm_width=tilemap_get_width(tilemap);
	var tm_height=tilemap_get_height(tilemap);
	
	
var vbuff=vertex_create_buffer();
vertex_begin(vbuff,v_format);

for(var i=0;i<tm_width;i++){
	for(var j=0;j<tm_height;j++){
		var tile_data=tilemap_get(tilemap,i,j);
		var tile_index=tile_get_index(tile_data);
		
		var tile_index_x=tile_index mod ts_horizontal_count;
		var tile_index_y=tile_index div ts_horizontal_count;
		
		var is_mirrored=tile_get_mirror(tile_data);
		var is_flipped=tile_get_flip(tile_data);
		var is_rotated=tile_get_rotate(tile_data);
		
		var uv_left =		ts_uvs_left + ts_texel_tile_width * tile_index_x;
		var uv_top = ts_uvs_top + ts_texel_tile_height * tile_index_y;
		var uv_right = uv_left + ts_texel_tile_width;
		var uv_bottom = uv_top + ts_texel_tile_height;
		
		if is_flipped{
			var t=uv_top;
			uv_top=uv_bottom;
			uv_bottom=t;
		}
		
		if is_mirrored{
			var t=uv_left;
			uv_left=uv_right;
			uv_right=t;
		}
		
		
		var p1x = ts_tile_width * i;
		var p1y = ts_tile_height * j;
		var p2x = p1x + ts_tile_width;
		var p2y = p1y;
		var p3x = p1x + ts_tile_width;
		var p3y = p1y + ts_tile_height;
		var p4x = p1x;
		var p4y = p1y + ts_tile_height;

		var xx=tile_index_x
		var yy=tile_index_y
		var w=ts_texel_tile_width	;
		var h=ts_texel_tile_height;		
		var p1u =	 uv_left			;
		var p1v =	 uv_top				;
		var p2u =	 uv_right				;
		var p2v =	uv_top					;
		var p3u =	uv_right				;
		var p3v =	 uv_bottom				;
		var p4u =	uv_left					;
		var p4v =	 uv_bottom				;
		
		
	
		vertex_point_add(vbuff,p1x,p1y,tm_depth,,,p1u,p1v, 0,0,-1);
		vertex_point_add(vbuff,p2x,p2y,tm_depth,,,p2u,p2v, 0,0,-1);
		vertex_point_add(vbuff,p3x,p3y,tm_depth,,,p3u,p3v, 0,0,-1);
												  		 
		vertex_point_add(vbuff,p3x,p3y,tm_depth,,,p3u,p3v, 0,0,-1);
		vertex_point_add(vbuff,p4x,p4y,tm_depth,,,p4u,p4v, 0,0,-1);
		vertex_point_add(vbuff,p1x,p1y,tm_depth,,,p1u,p1v, 0,0,-1);
	}
}


vertex_end(vbuff);
vertex_freeze(vbuff);
layer_set_visible(tilelayer,false)
return vbuff
}

