/// @description Insert description here
// You can write your code in this editor

var xx=32

var yy=32

obb_rot=45

plane=new Plane(new Vector3(0,0,-1),16)

point= new Point(new Vector3(xx*3,yy,-18));

line=new Line(new Vector3(xx*5,yy,-18),new Vector3(xx*5,yy*2,-18));

aabb= new AABB(new Vector3(xx*3,yy*3,-8),new Vector3(8,8,8),false);

sphere=new Sphere(new Vector3(xx*5,yy*3,-16),16)

ray=new Ray(new Vector3(xx*3,yy*5,-16), new Vector3(1,1,-1))



obb= new OBB(new Vector3(xx*5,yy*5,-12),new Vector3(8,8,8),matrix_build(0, 0, 0, 0, obb_rot, 0, 1, 1, 1));

cap_x=xx*3

cap_y=yy*7

cap=0

cap_dir=1

capsule=new Capsule(new Line(new Vector3(cap_x,cap_y,-8),new Vector3(cap_x+cap,cap_y+cap,-32)),8)

