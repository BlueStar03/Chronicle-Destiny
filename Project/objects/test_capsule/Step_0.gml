// @description 
t=2*pi*a/s
var start=collider.shape.line.start; 
var r=32
collider.shape.line.finish.x=start.x+r*cos(t)
collider.shape.line.finish.y=start.y+r*sin(t)
collider.shape.line.finish.z=start.z+(-r)


a++
if a>s{a=0}


if collider.check_collider(player.collider){
	col=c_red;	
}else{
	col=c_blue;	
}
dbug.trace.add(collider.shape.line.start)
dbug.trace.add(collider.shape.line.finish)
dbug.trace.add(collider.shape.radius)



