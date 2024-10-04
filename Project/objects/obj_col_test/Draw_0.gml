/// @description Insert description here
// You can write your code in this editor
the_floor.dbug_draw(640,16,c_green);

point.shape.dbug_draw(c_point);

line.dbug_draw();

aabb.shape.dbug_draw(c_aabb);

sphere.dbug_draw();

ray.dbug_draw();

plane.dbug_draw();


obb.dbug_draw();

capsule.dbug_draw();

triangle.dbug_draw();




draw_set_color(c_white)
draw_set_font(fnt_default)
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(point.shape.position.X,point.shape.position.Y+16,"point");
draw_text(line.start.X,line.start.Y+16,"line");
draw_text(aabb.shape.position.X,aabb.shape.position.Y+16,"aabb");
draw_text(sphere.position.X,sphere.position.Y+16,"sphere");
draw_text(ray.origin.X, ray.origin.Y+16,"ray");
var _p=plane.get_point_on_plane();
draw_text(_p.X+32+16, _p.Y+(16*4),"plane");
draw_text(obb.position.X, obb.position.Y+16,"obb");
draw_text(capsule.line.start.X, capsule.line.start.Y+16,"capsule");
draw_text(triangle.property_center.X, triangle.property_center.Y+16,"Triangle");

