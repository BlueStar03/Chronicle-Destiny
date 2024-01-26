/// @description 

if dbug.on{
shape.dbug_draw(col);
draw_set_font(fnt_min)
draw_text_outline(x,y,hit_info.distance)
if hit_info.point!=undefined{
	var _p= new Point(hit_info.point);
	_p.dbug_draw()
	hit_info.clear()
}
}