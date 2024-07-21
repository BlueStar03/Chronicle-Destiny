
function Tmap()constructor{
	/*
	_maps[i][0]=t_id
	_maps[i][1]=visible
	_maps[i][2]=vb
	_maps[i][3]=texture
	
	*/
	_maps=[]

	room_start=function(){
		_maps=undefined		//initializes _maps as undefined, if no layer is a tilemap, this will remain unchanged
		var index=0
		var all_layers=layer_get_all()		//Gets all the layers of the room
		for (var l=0; l<array_length(all_layers);l++){		//iterates between all layers and check if it is a tile layer
			if layer_tilemap_get_id(all_layers[l])!=-1{		//Checks if the layer has a tilemap
				_maps[index][0]=all_layers[l];							//if it does, it adds the id to _maps[i][0]
				_maps[index][1]=layer_get_visible(all_layers[l])//stores if the layer is vissible at _maps[i][1]
				index++
			}
		}
		if _maps==undefined return				//shorts if _maps[0][0] is undefined
		for(var i=0;i<array_length(_maps);i++){   //iterates each tilelayer to create the vertexbuffers
			var tilelayer=_maps[i][0];				//the tile layer ID
			var tm_depth=layer_get_depth(tilelayer); // the depth of the tile. becomes the z value of the vertex
			var tilemap=layer_tilemap_get_id(tilelayer);
			
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
			
	var vb=vertex_create_buffer();
	vertex_begin(vb,v_format);
	for(var w=0;w<tm_width;w++){
		for(var h=0;h<tm_height;h++){
			var tile_data=tilemap_get(tilemap,w,h);
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
		
		
			var p1x = ts_tile_width * w;
			var p1y = ts_tile_height * h;
			var p2x = p1x + ts_tile_width;
			var p2y = p1y;
			var p3x = p1x + ts_tile_width;
			var p3y = p1y + ts_tile_height;
			var p4x = p1x;
			var p4y = p1y + ts_tile_height;

			var xx=tile_index_x
			var yy=tile_index_y
			var p1u =	 uv_left			;
			var p1v =	 uv_top				;
			var p2u =	 uv_right				;
			var p2v =	uv_top					;
			var p3u =	uv_right				;
			var p3v =	 uv_bottom				;
			var p4u =	uv_left					;
			var p4v =	 uv_bottom				;
		
		
	
			vertex_add(vb,p1x,p1y,tm_depth,,,p1u,p1v, 0,0,-1);
			vertex_add(vb,p2x,p2y,tm_depth,,,p2u,p2v, 0,0,-1);
			vertex_add(vb,p3x,p3y,tm_depth,,,p3u,p3v, 0,0,-1);
			
			vertex_add(vb,p3x,p3y,tm_depth,,,p3u,p3v, 0,0,-1);
			vertex_add(vb,p4x,p4y,tm_depth,,,p4u,p4v, 0,0,-1);
			vertex_add(vb,p1x,p1y,tm_depth,,,p1u,p1v, 0,0,-1);
		}
	}
	

	
			vertex_end(vb);
			vertex_freeze(vb)
			layer_set_visible(_maps[i][0],false)
			_maps[i][2]= vb;

		}
	}

	draw=function(){
		if _maps==undefined return
		for(var i=0; i<array_length(_maps);i++){
			if _maps[i][1]{ vertex_submit(_maps[i][2],pr_trianglelist,sprite_get_texture(tl_test_grid,0))}
		}
	}
}

//function Tilevert(tile_layer_name){
//	var tile_layer=layer_get_id(tile_layer_name)
//	var vb=vertex_create_buffer();
//	vertex_begin(vb,v_format);
	
//	vertex_add(vb,50,50,50 ,,,0,0);
//	vertex_add(vb,50,10,50 ,,,0,1);
//	vertex_add(vb,10,10,50 ,,,1,1);
													
//	vertex_add(vb,10,10,50 ,,,1,1);
//	vertex_add(vb,10,50,50 ,,,1,0);
//	vertex_add(vb,50,50,50 ,,,0,0);
	
//	vertex_end(vb);
//	vertex_freeze(vb)
//	layer_set_visible(tile_layer,false)
//	return vb
//}