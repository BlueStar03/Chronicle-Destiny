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

aabb=new AABB(new Vector3(x,y,z-16),new Vector3(8,8,16))

sphere=new Sphere(new Vector3(x-32,y-32,z-32),8)



