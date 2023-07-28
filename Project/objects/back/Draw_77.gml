/// @description
if keyboard_check_pressed(ord("S"))
{
    surface_save(application_surface, "test.png");
}
display.draw();