// Initialize movement variables
z = 0;           // Height or vertical position (for future use)
walk_spd = 4;    // Walking speed
dir = 0;         // Direction the player is facing or moving
mspd=4;

model = new BBMOD_Model("c1x2.bbmod").freeze();
model.Materials[@ 0] = sprite_get_texture(spr_player_uv, 0);