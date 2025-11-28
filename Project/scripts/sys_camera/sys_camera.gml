enum camera_mode {
  none,
  orbit,
  free
}

function Camera() constructor {
  mode  = camera_mode.none;
  focus = noone;
  
  from = { x: 640 / 2, y: 360,     z: -360 / 2 };
  to   = { x: 640 / 2, y: 360 / 2, z: 0 };
  up   = { x: 0,       y: 0,       z: 1 };
  
  target = { 
    from : { x: 640 / 2, y: 360,     z: -360 / 2 },
    to   : { x: 640 / 2, y: 360 / 2, z: 0 },
    up   : { x: 0,       y: 0,       z: 1 }
  };
  
  offset = {
    from : { x: 0, y: 128, z: -128 },
    to   : { x: 0, y: 0,   z: 0 },
    up   : { x: 0, y: 0,   z: 1 }
  };
  
  orbit = { dir: 45, dist: 256, ele: 35.264 };
  free  = { pitch: 0, yaw: 0, roll: 0 };
  snap  = true;
	
  pro_mat = matrix_build_projection_ortho(SCREEN.width / 2, SCREEN.height / 2, 1, 32000);
	
  update = function() {
    switch (mode) {
      case camera_mode.none:  update_none();  break;
      case camera_mode.orbit: update_orbit(); break;
      case camera_mode.free:  update_free();  break;
    }
    update_to_target(); // up remains fixed, by design in this version
  };
	
  update_none = function(update_from = true) {
    if (focus == noone) { return; }
    if (instance_exists(focus)) {
      target.to.x = focus.x + offset.to.x;
      target.to.y = focus.y + offset.to.y;
      target.to.z = focus.z + offset.to.z;
      if (update_from) {
        target.from.x = focus.x + offset.from.x;
        target.from.y = focus.y + offset.from.y;
        target.from.z = focus.z + offset.from.z;
      }
    } else {
      focus = noone;
    }
  };
  
  update_orbit = function() {
    if (focus == noone) { mode = camera_mode.none; return; }
    if (!instance_exists(focus)) { focus = noone; mode = camera_mode.none; return; }

    // anchor (focus + offset)
    target.to.x = focus.x + offset.to.x;
    target.to.y = focus.y + offset.to.y;
    target.to.z = focus.z + offset.to.z;

    orbit.dir = rollover_angle(orbit.dir);
    orbit.ele = clamp(orbit.ele, -89.9, 89.9);

    var dir = degtorad(orbit.dir);
    var ele = degtorad(orbit.ele);
    var r   = orbit.dist;

    var offx = r * cos(ele) * cos(dir);
    var offy = r * cos(ele) * sin(dir);
    var offz = -r * sin(ele);

    target.from.x = target.to.x + offx;
    target.from.y = target.to.y + offy;
    target.from.z = target.to.z + offz;

    // up stays as initial {0,0,1} in this version
  };

  update_free = function() {
    if (focus == noone) { mode = camera_mode.none; return; }
    if (!instance_exists(focus)) { focus = noone; mode = camera_mode.none; return; }

    target.from.x = focus.x + offset.from.x;
    target.from.y = focus.y + offset.from.y;
    target.from.z = focus.z + offset.from.z;

    var yaw   = degtorad(free.yaw);
    var pitch = degtorad(free.pitch);

    var fx = cos(pitch) * cos(yaw);
    var fy = cos(pitch) * sin(yaw);
    var fz = -sin(pitch);

    target.to.x = target.from.x + fx;
    target.to.y = target.from.y + fy;
    target.to.z = target.from.z + fz;

    // this is currently unused by update_to_target()
    target.up.x = 0;
    target.up.y = 0;
    target.up.z = -1;
  };

  update_to_target = function(ease = 1, complete = false) {
    ease = clamp(ease, 0, 1);

    from.x = lerp(from.x, target.from.x, ease);
    from.y = lerp(from.y, target.from.y, ease);
    from.z = lerp(from.z, target.from.z, ease);
    
    to.x = lerp(to.x, target.to.x, ease);
    to.y = lerp(to.y, target.to.y, ease);
    to.z = lerp(to.z, target.to.z, ease);
    
    if (complete) {
      up.x = lerp(up.x, target.up.x, ease);
      up.y = lerp(up.y, target.up.y, ease);
      up.z = lerp(up.z, target.up.z, ease);
    }
  };

  rotate_orbit = function(val) {
    static snap_sign = 0;
    var rot = val;
    
    orbit.dir += rot;
    orbit.dir  = round(orbit.dir);
    orbit.dir  = rollover_angle(orbit.dir);

    if (snap) {
      if (abs(rot) < 0.001) {
        var c = orbit.dir;
        var a = 0;

        if (c mod 45 != 0) {
          if (c mod 45 > 22.5) {
            a += 1;
          } else {
            a -= 1;
          }
          orbit.dir += a;
        }
      }
    } else {
      if (abs(rot) < 0.001) {
        if (orbit.dir mod 45 != 0) {
          orbit.dir += snap_sign;
        }
      } else {
        snap_sign = sign(rot);
      }
    }
  };

  draw = function() {
    draw_clear(c_cornflowerblue);
    var _cam = camera_get_active();
    camera_set_view_mat(_cam, matrix_build_lookat(from.x, from.y, from.z, to.x, to.y, to.z, up.x, up.y, up.z));
    camera_set_proj_mat(_cam, pro_mat);
    camera_apply(_cam);
  };
}
