/// @func                Display(width, height, scale, fullscreen)
/// @desc                Manages the game's display settings, resolution, and scaling.
/// @param {Real}        width        The width of the game display.
/// @param {Real}        height       The height of the game display.
/// @param {Real}        scale        The scaling factor for the display.
/// @param {Bool}        fullscreen   Whether the display is in fullscreen mode.

function Display(width = 640, height = 360, scale = 1, fullscreen = false) constructor {
    self.width = width;
    self.height = height;
    self.scale = scale;
    self.fullscreen = fullscreen;
    self.max_scale = 1;
        
        top=0;
        left=0;
        bottom=0;
        right=0;
        middle=0;
        center=0;
        padding=1;
        
            // Update anchor points
    set_anchors = function() {
        top = padding;
        left = padding;
        bottom = height - padding;
        right = width - padding;
        middle = width / 2;
        center = height / 2;
    };
        set_anchors();

    /// @func get_width
    /// @desc Returns the width of the display.
    /// @return {Real}
    static get_width = function() {
        return self.width;
    };

    /// @func set_width
    /// @desc Sets the width of the display and reinitializes the display settings.
    /// @param {Real} val The new width of the display.
    static set_width = function(val) {
        if (platform.class == "Web") return;
        self.width = val;
        self.init();
    };

    /// @func get_height
    /// @desc Returns the height of the display.
    /// @return {Real}
    static get_height = function() {
        return self.height;
    };

    /// @func set_height
    /// @desc Sets the height of the display and reinitializes the display settings.
    /// @param {Real} val The new height of the display.
    static set_height = function(val) {
        if (platform.class == "Web") return;
        self.height = val;
        self.init();
    };

    /// @func get_scale
    /// @desc Returns the current scaling factor of the display.
    /// @return {Real}
    static get_scale = function() {
        return self.scale;
    };

    /// @func set_scale
    /// @desc Sets the scaling factor for the display and reinitializes the display settings.
    /// @param {Real} val The new scaling factor.
    static set_scale = function(val) {
        if (platform.class == "Web") return;
        if (is_real(val)) {
            self.scale = floor(val);
        } else {
            self.scale++;
        }
        self.scale = rollover(self.scale, 1, self.max_scale + 1);
        self.init();
    };

    /// @func get_fullscreen
    /// @desc Returns whether the display is in fullscreen mode.
    /// @return {Bool}
    static get_fullscreen = function() {
        self.fullscreen = window_get_fullscreen();
        return self.fullscreen;
    };

    /// @func set_fullscreen
    /// @desc Sets the display to fullscreen or windowed mode.
    /// @param {Bool} val The new fullscreen state.
    static set_fullscreen = function(val) {
        if (platform.class == "Web") return;
        if (is_bool(val)) {
            self.fullscreen = val;
        } else {
            self.fullscreen = !self.fullscreen;
        }
        self.apply_resolution();
    };

    /// @func set_resolution
    /// @desc Sets the width and height of the display and reinitializes the display settings.
    /// @param {Real} width  The new width of the display.
    /// @param {Real} height The new height of the display.
    static set_resolution = function(width, height) {
        if (platform.class == "Web") return;
        if (is_real(width)) self.width = floor(width);
        if (is_real(height)) self.height = floor(height);
        self.init();
    };

    /// @func set_display
    /// @desc Sets the width, height, and scale of the display and reinitializes the display settings.
    /// @param {Real} width  The new width of the display.
    /// @param {Real} height The new height of the display.
    /// @param {Real} scale  The new scale factor of the display.
    static set_display = function(width, height, scale) {
        if (platform.class == "Web") return;
        if (is_real(width)) self.width = floor(width);
        if (is_real(height)) self.height = floor(height);
        if (is_real(scale)) self.scale = floor(scale);
        self.scale = rollover(self.scale, 1, self.max_scale + 1);
        self.init();
    };

    /// @func init
    /// @desc Initializes the display settings, recalculating dimensions based on the current platform.
    static init = function() {
        var screen_width = display_get_width();
        var screen_height = display_get_height();
        var aspect_ratio = screen_width / screen_height;

        if (PLATFORM.class == "Web") {
            self.width = 640;
            self.height = 360;
            self.scale = 1;
            self.max_scale = 1;
        } else {
            if (screen_height mod self.height != 0) {
                var d = round(screen_height / self.height);
                self.height = screen_height / d;
            }
            self.width = round(self.height * aspect_ratio);
            if (self.width & 1) self.width++;
            if (self.height & 1) self.height++;
            self.max_scale = floor(screen_width / self.width);
            if (self.scale > self.max_scale) self.scale = self.max_scale;
        }
        self.apply_resolution();
    };

    /// @func apply_resolution
    /// @desc Applies the display resolution and saves the settings.
    static apply_resolution = function() {
        //DATA.settings.sys_display = { width: self.width, height: self.height, scale: self.scale, fullscreen: self.fullscreen };
        //DATA.save_settings();
        surface_resize(application_surface, self.width, self.height);
        display_set_gui_size(self.width, self.height);
        window_set_size(self.width * self.scale, self.height * self.scale);
        window_set_fullscreen(self.fullscreen);
        if (!self.fullscreen) window_center();
    };

    /// @func toString
    /// @desc Returns a string representation of the display's current settings.
    /// @return {String}
    static toString = function() {
        return $"({self.width}x{self.height})x{self.scale}\n({display_get_width()}x{display_get_height()}){self.get_fullscreen() ? "F" : "W"}";
    };

    // Initialize the display
    self.init();
}

