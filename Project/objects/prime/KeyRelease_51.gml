/// @description
if os_browser==browser_not_a_browser{
	var s=display.scale
	s++
	if s>display.max_scale{s=1; }
display.scale=s
display.set_resolution();
}



