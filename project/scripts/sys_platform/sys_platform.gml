/// @description Platform struct definition
function Platform() constructor {
    // Determine the platform type
    type = (function() {
        if (os_browser == browser_not_a_browser) {
            switch (os_type) {
                case os_windows: return "Windows";
                case os_macosx: return "Mac";
                case os_linux: return "Linux";
                case os_ios: return "iOS";
                case os_android: return "Android";
                case os_tvos: return "tvOS";
                case os_ps4: return "PS4";
                case os_ps5: return "PS5";
                case os_gdk: return "Xbox One";
                case os_xboxseriesxs: return "Xbox Series X/S";
                case os_switch: return "Switch";
                case os_unknown: return "Unknown OS";
                default: return "Unknown";
            }
        } else {
            return "HTML5";
        }
    })();

    // Determine the platform class
    class = (function() {
        if (os_browser != browser_not_a_browser) {
            return "Web";
        }
        switch (os_type) {
            case os_windows: case os_macosx: case os_linux: return "Desktop";
            case os_android: case os_ios: case os_tvos: return "Mobile";
            case os_ps4: case os_ps5: case os_gdk: case os_xboxseriesxs: case os_switch: return "Console";
            default: return "Unknown";
        }
    })();

    // Determine the platform color coding
    color = (function() {
        if (os_browser != browser_not_a_browser) { 
            return c_yellow; 
        }
        switch (os_type) {
            case os_windows: case os_macosx: case os_linux: return c_aqua;
            case os_android: case os_ios: case os_tvos: return c_red;
            case os_ps4: case os_ps5: case os_gdk: case os_xboxseriesxs: case os_switch: return c_green;
            default: return c_orange;
        }
    })();

    // Check if the code is compiled
    compiled = code_is_compiled();

    // Add a toString method to return the platform type
    toString = function() {
        return class;
    };

    // Debugging Information
    debug_info = function() {
        show_debug_message("***PLATFORM DEBUG INFO***");
        show_debug_message("Type: " + type);
        show_debug_message("Class: " + class);
        show_debug_message("Color Code: " + string(color));
        show_debug_message("Compiled: " + string(compiled));
        show_debug_message("********************************");
    };

    // Automatically display platform info for debugging
    debug_info();
}
