// Initialize movement variables
z = 0;           // Height or vertical position (for future use)
walk_spd = 4;    // Walking speed
dir = 0;         // Direction the player is facing or moving
mspd=4;

model = new BBMOD_Model("char.bbmod").freeze();
model.Materials[@ 0] = sprite_get_texture(spr_UVGrid, 0);

animIdle = new BBMOD_Animation("stand.bbanim");
animWalk = new BBMOD_Animation("walk.bbanim");

animationPlayer = new BBMOD_AnimationPlayer(model);
camera.focus=self;
camera.mode=camera_mode.orbit

X=0;
Y=0;
Z=0;

//collider=new ColCollider( new ColAABB(new Vector3(x,y,-23),new Vector3(8,8,23),false),self);