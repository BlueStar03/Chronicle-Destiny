function draw_sprite_billboard_s(sprite, subimage, xx, yy, zz) {
    shader_set(shd_billboard_s);
    matrix_set(matrix_world, matrix_build(xx, yy, zz, 0, 0, 0, 1, 1, 1));
    draw_sprite(sprite, subimage, 0, 0);
    matrix_set(matrix_world, matrix_build_identity());
    shader_reset();
}