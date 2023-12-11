/// @description 
draw_3d_sprite(spr_shadow,0,x,y,z,90,,,scale,scale)
//draw_sprite(spr_shadow,0,x,y)
probe.dbug_draw(col)
probes[0].dbug_draw(c_red)
probes[1].dbug_draw(c_blue)
probes[2].dbug_draw(c_green)
probes[3].dbug_draw(c_purple)
if hit_info.point!=undefined{
	var _p= new Point(hit_info.point);
	_p.dbug_draw()
	hit_info.clear()
}


