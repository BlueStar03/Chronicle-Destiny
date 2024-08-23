/// @description Insert description here
// You can write your code in this editor
z=0;
mspd=2;
xspd=0;
yspd=0;
zspd=0;
dir=0
camera.focus=self;
camera.mode=camera_mode.orbit;
model = new BBMOD_Model("CharBase.bbmod").freeze();
model.Materials[@ 0] = sprite_get_texture(Sprite3, 0);

point=new Point(new Vector3(x,y,z))

line=new Line(new Vector3(x,y-10,z-10),new Vector3(x,y+10,z-10))

aabb=new AABB(new Vector3(x,y,z-16),new Vector3(8,8,16),false)

sphere=new Sphere(new Vector3(x-32,y-32,z-8),8)

ray=new Ray(new Vector3(50,50,-16), new Vector3(x,y,z-16))

plane=new Plane(new Vector3(0, 1, 1), 10);

obb = new OBB(new Vector3(200, 200, -16), new Vector3(8, 8, 8), matrix_build(0, 0, 0, 0, 45, 0, 1, 1, 1));




