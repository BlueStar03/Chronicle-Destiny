function Dbug(on = true) constructor {
    on = on;
    system = {
        on: true,
        draw: function() {
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_text_outline(1, 1, "Hello, World!");
        }
    };
    
    draw = function() {
        if (system.on) {
            system.draw();
        }
    };
}
