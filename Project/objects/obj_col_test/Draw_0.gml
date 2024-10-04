/// @description Insert description here
// You can write your code in this editor

point.dbug_draw();

line.dbug_draw();

aabb.dbug_draw();

sphere.dbug_draw();

ray.dbug_draw();

plane.dbug_draw();


obb.dbug_draw();

capsule.dbug_draw();


draw_set_color(c_white)
draw_set_font(fnt_default)
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(point.position.X,point.position.Y+16,"point");
draw_text(line.start.X,line.start.Y+16,"line");
draw_text(aabb.position.X,aabb.position.Y+16,"aabb");
draw_text(sphere.position.X,sphere.position.Y+16,"sphere");
draw_text(ray.origin.X, ray.origin.Y+16,"ray");
var _p=plane.get_point_on_plane();
draw_text(_p.X+32+16, _p.Y+(16*4),"plane");
draw_text(obb.position.X, obb.position.Y+16,"obb");
draw_text(capsule.line.start.X, capsule.line.start.Y+16,"capsule");

