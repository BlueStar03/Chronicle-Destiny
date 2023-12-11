/// @description 
z=0
scale=1
probes=array_create(4, 0);
probes[0]=new Ray( new Vector3(player.x, player.y,player.z-1),new Vector3(0,0,1))
probes[1]=new Ray( new Vector3(player.x, player.y,player.z-1),new Vector3(0,0,1))
probes[2]=new Ray( new Vector3(player.x, player.y,player.z-1),new Vector3(0,0,1))
probes[3]=new Ray( new Vector3(player.x, player.y,player.z-1),new Vector3(0,0,1))

probe=new Ray( new Vector3(player.x, player.y,player.z-1),new Vector3(0,0,1))
col=c_yellow


hit_info=new Ray_Hit_Info()