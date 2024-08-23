#macro v_format global.__v_format
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
__v_format=vertex_format_end();

function vertex_add(vbuffer,x,y,z,col=c_white,a=1,u=0,v=0,nx=0,ny=0,nz=1){
	vertex_position_3d(vbuffer,x,y,z);
	vertex_normal(vbuffer,nx,ny,nz);
	vertex_texcoord(vbuffer,u,v);
	vertex_color(vbuffer,col,a)
}




/// @desc Draw text with an outline
/// @param x The x position to draw the text
/// @param y The y position to draw the text
/// @param text The text to draw
/// @param text_color The color of the main text
/// @param outline_color The color of the outline
/// @param outline_thickness The thickness of the outline

function draw_text_with_outline(x, y, text, text_color, outline_color, outline_thickness) {
    // Draw the outline
    draw_set_color(outline_color);
    for (var ox = -outline_thickness; ox <= outline_thickness; ox += outline_thickness) {
        for (var oy = -outline_thickness; oy <= outline_thickness; oy += outline_thickness) {
            // Skip the center position (no offset)
            if (ox != 0 || oy != 0) {
                draw_text(x + ox, y + oy, text);
            }
        }
    }

    // Draw the main text
    draw_set_color(text_color);
    draw_text(x, y, text);
}



/// @function rollover(val, lo, hi)
/// @description Ensures val wraps around within the range [lo, hi).
/// @param val {Real} The value to wrap.
/// @param lo {Real} The lower bound of the range.
/// @param hi {Real} The upper bound of the range.
/// @returns {Real} The wrapped value within the range [lo, hi).

function rollover(val, lo, hi) {
    var range = hi - lo;
    var offset = (val - lo) % range;
    if (offset < 0) {
        offset += range;
    }
    return lo + offset;
}

/// @function draw_text_outline(x, y, str, c_str=c_white, c_out=c_black, out=1, q=45)
/// @description Draws text with an outlined effect.
/// @param x {Real} The x-coordinate for the text.
/// @param y {Real} The y-coordinate for the text.
/// @param str {String} The string to be drawn.
/// @param c_str {Color} The color of the main text (default is c_white).
/// @param c_out {Color} The color of the outline (default is c_black).
/// @param out {Real} The distance of the outline from the text (default is 1).
/// @param q {Real} The angle increment for drawing the outline (default is 45).

function draw_text_outline(x, y, str, c_str=c_white, c_out=c_black, out=1, q=45) {
    // Save the current drawing color
    var c_temp = draw_get_color();

    // Set the color for the outline
    draw_set_color(c_out);

    // Draw the outline
    for (var i = 0; i < 360; i += q) {
        var ox = lengthdir_x(out, i);
        var oy = lengthdir_y(out, i);
        draw_text(x + ox, y + oy, str);
    }

    // Set the color for the main text
    draw_set_color(c_str);
    draw_text(x, y, str);

    // Restore the original drawing color
    draw_set_color(c_temp);
}


/// @function spherecart_x(radius, inclination, azimuth)
/// @desc Returns the x-coordinate in Cartesian coordinates from spherical coordinates.
/// @param {real} radius - The distance from the origin.
/// @param {real} inclination - The angle from the positive z-axis (in radians).
/// @param {real} azimuth - The angle from the positive x-axis in the xy-plane (in radians).
/// @return {real} The x-coordinate.

function spherecart_x(radius, inclination, azimuth) {
    return radius * sin(inclination) * cos(azimuth);
}

/// @function spherecart_y(radius, inclination, azimuth)
/// @desc Returns the y-coordinate in Cartesian coordinates from spherical coordinates.
/// @param {real} radius - The distance from the origin.
/// @param {real} inclination - The angle from the positive z-axis (in radians).
/// @param {real} azimuth - The angle from the positive x-axis in the xy-plane (in radians).
/// @return {real} The y-coordinate.

function spherecart_y(radius, inclination, azimuth) {
    return radius * sin(inclination) * sin(azimuth);
}

/// @function spherecart_z(radius, inclination, azimuth)
/// @desc Returns the z-coordinate in Cartesian coordinates from spherical coordinates.
/// @param {real} radius - The distance from the origin.
/// @param {real} inclination - The angle from the positive z-axis (in radians).
/// @param {real} azimuth - The angle from the positive x-axis in the xy-plane (in radians).
/// @return {real} The z-coordinate.

function spherecart_z(radius, inclination, azimuth) {
    return radius * cos(inclination);
}



/// @function spherecart(radius, inclination, azimuth)
/// @desc Converts spherical coordinates to Cartesian coordinates.
/// @param {real} radius - The distance from the origin.
/// @param {real} inclination - The angle from the positive z-axis (in radians).
/// @param {real} azimuth - The angle from the positive x-axis in the xy-plane (in radians).
/// @return {struct} A struct containing x, y, and z coordinates.

function spherecart(radius, inclination, azimuth) {
    return {
        x: spherecart_x(radius, inclination, azimuth),
        y: spherecart_y(radius, inclination, azimuth),
        z: spherecart_z(radius, inclination, azimuth),
    };
}

