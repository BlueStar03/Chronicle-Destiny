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