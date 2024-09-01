var _s=16
new BBMOD_Matrix()
	.RotateZ(0)
	.RotateX(0)
	.Scale(image_xscale*_s,image_yscale*_s,-_s)
	.Translate(x, y, z)
	.ApplyWorld();
shader_set(sh_static);
model.submit();
shader_reset();
new BBMOD_Matrix().ApplyWorld();