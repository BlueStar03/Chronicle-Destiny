/// @description Insert description here
// You can write your code in this editor

var xx=32

var yy=32

obb_rot=45

plane=new ColPlane(new Vector3(0,0,-1),16)

point=new ColCollider( new ColPoint(new BBMOD_Vec3(xx*3,yy,-18)),self);
c_point=c_white;

line=new ColLine(new Vector3(xx*5,yy,-18),new Vector3(xx*5,yy*2,-18));

aabb =new ColCollider(  new ColAABB(new Vector3(xx*3,yy*3,-8),new Vector3(8,8,8),false),self);
c_aabb=c_green;

sphere=new ColSphere(new Vector3(xx*5,yy*3,-16),16)

ray=new ColRay(new Vector3(xx*3,yy*5,-16), new Vector3(1,1,-1))



obb= new ColOBB(new Vector3(xx*5,yy*5,-12),new Vector3(8,8,8),matrix_build(0, 0, 0, 0, obb_rot, 0, 1, 1, 1));

cap_x=xx*3

cap_y=yy*7

cap=0

cap_dir=1

capsule=new ColCapsule(new Vector3(cap_x,cap_y,-8),new Vector3(cap_x+cap,cap_y+cap,-32),8)

triangle=new Triangle(new Vector3((xx*5)+8,yy*7,-16),new Vector3((xx*5)-8,yy*7,-16),new Vector3((xx*5),yy*7,-32))



the_floor=new ColPlane(new Vector3(0,0,-1),0)