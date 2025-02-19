if (array_length(gamepads) > 0)
{
    var _h = gamepad_axis_value(gamepads[0], gp_axislh);
    var _v = gamepad_axis_value(gamepads[0], gp_axislv);
    x += _h * 4;
    y += _v * 4;
}