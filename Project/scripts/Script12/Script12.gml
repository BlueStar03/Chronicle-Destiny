// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function load_obj(filename){
	var obj_file=file_text_open_read(filename);
	
	var model=vertex_create_buffer();
	vertex_begin(model,v_format)
	
	var vertex_x=ds_list_create();
	var vertex_y=ds_list_create();
	var vertex_z=ds_list_create();
	
	var vertex_nx=ds_list_create();
	var vertex_ny=ds_list_create();
	var vertex_nz=ds_list_create();
	
	var vertex_xtex=ds_list_create();
	var vertex_ytex=ds_list_create();
	
	while not file_text_eof(obj_file){
		var line=file_text_read_string(obj_file);
		file_text_readln(obj_file);
		var terms, index;
		index=0;
		terms[0]="";
		terms[string_count(line, " ")]="";
		for (var i=1;i<=string_length(line);i++){
			if (string_char_at(line, i)==" "){
				index++;
				terms[index]="";
			}else{
				terms[index]=terms[index]+string_char_at(line,i);	
			}
		}
		switch(terms[0]){
			case "v":
				ds_list_add(vertex_x,real(terms[1]));
				ds_list_add(vertex_y,real(terms[2]));
				ds_list_add(vertex_z,real(terms[3]));
				break;
			case "vt":
				ds_list_add(vertex_xtex,real(terms[1]));
				ds_list_add(vertex_ytex,real(terms[2]));
				break;
			case "vn":
				ds_list_add(vertex_nx,real(terms[1]));
				ds_list_add(vertex_ny,real(terms[2]));
				ds_list_add(vertex_nz,real(terms[3]));
				break;
			case "f":
				for(var n=1;n<=3;n++){
					var data, index;
					index=0;
					data[0]="";
					data[string_count(terms[n], "/")]="";
					for (var i=1;i<=string_length(terms[n]);i++){
						if (string_char_at(terms[n], i)=="/"){
							index++;
							data[index]="";
						}else{
							data[index]=data[index]+string_char_at(terms[n],i);	
						}
					}
					var xx=ds_list_find_value(vertex_x,real(data[0])-1);
					var yy=ds_list_find_value(vertex_y,real(data[0])-1);
					var zz=ds_list_find_value(vertex_z,real(data[0])-1);
					var xtex=ds_list_find_value(vertex_xtex,real(data[1])-1);
					var ytex=ds_list_find_value(vertex_ytex,real(data[1])-1);
					var nx=ds_list_find_value(vertex_nx,real(data[2])-1);
					var ny=ds_list_find_value(vertex_ny,real(data[2])-1);
					var nz=ds_list_find_value(vertex_nz,real(data[2])-1);
					
					vertex_position_3d(model, xx,yy,zz);
					vertex_normal(model, nx,ny,nz);
					
					vertex_texcoord(model,xtex,ytex);
					vertex_color(model,c_white,1);
				}
				break;
			
		}
	}
	vertex_end(model);
	
	ds_list_destroy(vertex_x);
	ds_list_destroy(vertex_y);
	ds_list_destroy(vertex_z);
	ds_list_destroy(vertex_nx);
	ds_list_destroy(vertex_ny);
	ds_list_destroy(vertex_nz);	
	ds_list_destroy(vertex_xtex);
	ds_list_destroy(vertex_ytex);
	
	file_text_close(obj_file);
	
	return model;

}