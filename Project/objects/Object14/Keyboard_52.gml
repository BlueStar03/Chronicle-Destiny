/// @description
index++
if index>30{
var rr=1000
	var aa=irandom_range(0,360)
	var dd=irandom_range(-rr,rr)
	xx=lengthdir_x(dd,aa);
	yy=lengthdir_y(dd,aa);
	xx+=x;
	yy+=y;
	instance_create_layer(xx, yy, layer, choose(tree1,tree2));
	many++
}


