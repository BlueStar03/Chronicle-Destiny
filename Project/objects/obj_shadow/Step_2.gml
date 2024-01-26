/// @description 
var zoff=-.75
x=player.x;
y=player.y;

probe.origin.x=player.x;
probe.origin.y=player.y;
probe.origin.z=player.z+zoff;

probes[0].origin.x=player.x+8;
probes[0].origin.y=player.y+8;
probes[0].origin.z=player.z+zoff;

probes[1].origin.x=player.x-8;
probes[1].origin.y=player.y-8;
probes[1].origin.z=player.z+zoff;

probes[2].origin.x=player.x-8;
probes[2].origin.y=player.y+8;
probes[2].origin.z=player.z+zoff;

probes[3].origin.x=player.x+8;
probes[3].origin.y=player.y-8;
probes[3].origin.z=player.z+zoff;



with wall{
	other.probe.check_collider(self.collider, other.hit_info)
	other.probes[0].check_collider(self.collider, other.hit_info)
	other.probes[1].check_collider(self.collider, other.hit_info)
	other.probes[2].check_collider(self.collider, other.hit_info)
	other.probes[3].check_collider(self.collider, other.hit_info)
}
if hit_info.point!=undefined{
	col=c_purple
	z= hit_info.point.z;
	scale=1/(hit_info.distance)
	scale=max(scale,0.75)
	scale=min(scale,1)
}else{
	z=0;
	scale=abs(player.z)>abs(z+1)?.75:1;
	col=c_yellow
	hit_info.clear()
}
