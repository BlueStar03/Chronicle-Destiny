// Define the Input struct
function Input() constructor {
    horizontal = 0;
    vertical = 0;

    // Update function to calculate horizontal and vertical values
    function update() {
        horizontal = 0;
        vertical = 0;

        if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
            vertical = -1;
        }
        if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
            vertical = 1;
        }
        if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
            horizontal = -1;
        }
        if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
            horizontal = 1;
        }

        // Normalize the movement to prevent faster diagonal movement
        var move_length = point_distance(0, 0, horizontal, vertical);
        if (move_length > 0) {
            horizontal /= move_length;
            vertical /= move_length;
        }
    }
}
