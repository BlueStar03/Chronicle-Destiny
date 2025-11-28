function Dbug() constructor{
  system={
    platform:PLATFORM.toString(),
    c_platform:c_blue,//PLATFORM.color,
    input:INPUT.toString(),
    _x:SCREEN.topleft.x+1,
    _y:SCREEN.topleft.y+1,

    update:function(){
      input=INPUT.toString();
    },
    draw:function(){
      draw_set_talign(fa_left,fa_top)
      draw_text_outline(_x,_y,platform+"|"+input,c_platform)
    },
  };
  
  level={
    draw:function(){
      draw_set_talign(fa_middle,fa_top);
      draw_text_outline(SCREEN.top.x,SCREEN.top.y,room_get_name(room)+" ("+string(instance_count)+")")
    }
  };
  
  screen={
    draw:function(){
      draw_set_talign(fa_right,fa_top);
      var c_fps=fps_real>=game_get_speed(gamespeed_fps)?c_green:c_red;
      var l1=string(fps_real)+":"+string(fps);
      var l2="\n("+string(SCREEN.width)+"X"+string(SCREEN.height)+")x"+string(SCREEN.scale);
      draw_text_outline(SCREEN.topright.x,SCREEN.topright.y,l1,c_fps);
      draw_text_outline(SCREEN.topright.x,SCREEN.topright.y,l2)
    }
  }
  
  trace = {
    on: true,
    output: "\n",
    index: 0,
    index_max: 1,
    lines: [],

    init: function () {
      draw_set_font(fnt_dbug);
      var t_height = max(1, string_height("Mouse"));
      var s_height = SCREEN.height;

      self.index_max = max(1, floor(s_height / t_height) - 2);
      self.index = 0;
      self.lines = array_create(self.index_max, undefined);
      self.output = "\n";
    },

    add: function (label=null,data=null) {
      if (label!=null) {
        if index>index_max{return};
        if index==index_max{ self.lines[self.index-1]+=" - EOL -";self.index++;};
        if self.index<self.index_max{
          var _s=string(label)
          if data!=null{_s+=" | "+string(data)}
            self.lines[self.index] = _s; self.index ++;
        }
      }
    },

    //add_coord_:function(label=null,x=null,y=null){
      //var data=null;
      //if x!=null and y!=null{data="("+string(x)+","+string(y)+")"}
        //add(label,data) 
    //},

    add_coord: function(label=null, x=null, y=null, z=null, w=null) {
      var n = 0, s = "(";
      
      if (x != null) { s += string(x); n++; }
      if (y != null) { s += (n>0?", ":"") + string(y); n++; }
      if (z != null) { s += (n>0?", ":"") + string(z); n++; }
      if (w != null) { s += (n>0?", ":"") + string(w); n++; }
  
      s += ")";
      var data = (n > 0) ? s : null;  // if no components given, behave like label-only
      add(label, data);
    },



    update: function () {
      var len = array_length(self.lines);
      if (len <= 0) { self.output = "\n"; return; }

      var end_index = clamp(self.index - 1, 0, len - 1);
      var out = "\n";

      for (var i = 0; i <= end_index; i++) {
          var v = self.lines[i];
          if (is_undefined(v)) v = "";
          var s = string(v);
          if (i == 0) out += s; else out += "\n" + s;
      }

      self.output = out;

      // reset for next frame
      self.lines = array_create(self.index_max, undefined);
      self.index = 0;
    },

    draw: function () {
        if (self.on) {
            draw_set_talign(fa_left,fa_top);
            draw_text_outline(SCREEN.topleft.x + 1, SCREEN.topleft.y+1, self.output);
        }
    }
}; trace.init();
  
  build={
    draw:function (){
      draw_set_talign(fa_left,fa_bottom)
      draw_text_outline(SCREEN.bottomleft.x+1,SCREEN.bottomleft.y-1,VERSION)
    }
  }
  
  
  
  input={
  style:0,
    _p:[
      [1,2,3,4],// 0 AREA
      [1,2],// 1 start
      [1,2],// 2 select
      [1,2],// 3 a
      [1,2],// 4 b
      [1,2],// 5 x
      [1,2],// 6 y
      [1,2],// 7 pad up
      [1,2],// 8 pad down
      [1,2],// 9 pad left
      [1,2],// 10 pad right
      [1,2],// 11 left stick
      [1,2],// 12 right stick
      [1,2],// 13 left trigger
      [1,2],// 14 right trigger
      [1,2],// 15 left bumper
      [1,2],// 16 right bbumper
      [1,2],// 17 text
    ],

    init:function(){
      // Virtual GamePad (VGP) placement
      var _size_w=80, _size_h=50    //Size of VGP
      var _x=SCREEN.bottomright.x, _y=SCREEN.bottomright.y; // Bottom Right corner
      var center_x=SCREEN.bottomright.x-(_size_w/2), center_y=SCREEN.bottomright.y-(_size_h/2) // Center of gamepad
      var nr_o=10, fr_o=25, bt_o=8 , rr_o=15, sh_o=25, sh_t=34, sh_b=40, pd_o=6    //Alingment 
      var bt_x=center_x+fr_o, bt_y=center_y // face buttons center      
      var sh_x=center_x, sh_y=center_y-sh_o                  //Shoulder Buttons Alingment
      var rs_x=center_x+nr_o,rs_y=center_y+rr_o   //Right Stick Aligment
      // Xbox or PS Style left Stick and Dpad
      if style==0{
        var pd_x=center_x-nr_o, pd_y=center_y+rr_o, ls_x=center_x-fr_o, ls_y=center_y      }    // Xbox Style
      else{
        var pd_x=center_x-fr_o, pd_y=center_y     , ls_x=center_x-nr_o, ls_y=center_y+rr_o }    // PS Style
        
      _p[0,0]=_x-_size_w;_p[0,1]=_y-_size_h; _p[0,2]=_x;_p[0,3]=_y; // AREA
       
      _p[1,0]=center_x+5; _p[1,1]=center_y;     // start
      _p[2,0]=center_x-5; _p[2,1]=center_y;     // select        
      
      _p[3,0]=bt_x;       _p[3,1]=bt_y+bt_o;    // Button A
      _p[4,0]=bt_x+bt_o;  _p[4,1]=bt_y;         // Button B
      _p[5,0]=bt_x-bt_o;  _p[5,1]=bt_y;         // Button X
      _p[6,0]=bt_x;       _p[6,1]=bt_y-bt_o;    // Button Y

      _p[7,0]=pd_x;         _p[7,1]=pd_y-pd_o;  // Pad UP
      _p[8,0]=pd_x;         _p[8,1]=pd_y+pd_o;  // Pad Down
      _p[9,0]=pd_x-pd_o;    _p[9,1]=pd_y;       // Pad Left
      _p[10,0]=pd_x+pd_o;   _p[10,1]=pd_y;      // Pad Right      
      
      _p[11,0]=sh_x-sh_b;  _p[11,1]=sh_y;       // Bumper Left
      _p[12,0]=sh_x+sh_b;  _p[12,1]=sh_y;       // Bumper Right
      _p[13,0]=sh_x-sh_t;  _p[13,1]=sh_y;       // Trigger Left
      _p[14,0]=sh_x+sh_t;  _p[14,1]=sh_y;       // Trigger Right
      
      _p[15,0]=ls_x; _p[15,1]=ls_y // Stick Left
      _p[16,0]=rs_x; _p[16,1]=rs_y      // Stick Right
      
      _p[17,0]=center_x;  _p[17,1]=center_y-sh_o; // Text
 },
    _draw_btn:function(xx,yy,btn,img){
      var sc=1;
      var cc=c_white;
      if btn.pressed{sc=1.5;cc=c_black}else if btn.released{sc=1.5}
      draw_sprite_ext(spr_vgp_dbug,img+btn.current,xx,yy,sc,sc,0,cc,1)
    },

    _draw_axs:function(xx,yy,axs,img){
      var sc=1;
      var cc=c_white;
      if axs.pressed{sc=1.5;cc=c_black}else if axs.released{sc=1.5}
      draw_sprite_ext(spr_vgp_dbug,img,xx,yy,sc,sc,0,cc,1)
      draw_sprite_ext(spr_vgp_dbug,img+1,xx,yy,axs.current,1,0,cc,1)
    },

    _draw_joystick:function(xx,yy,img,joy,click){
          _draw_btn(xx,yy,click,img-2)
          var v=6;
          xx+=joy.horizontal.current*v;
          yy+=joy.vertical.current*v;
          draw_sprite(spr_vgp_dbug,img+click.current,xx,yy)
        },


    draw:function(){
      draw_set_color(c_navy);
      draw_rectangle(_p[0,0],_p[0,1],_p[0,2],_p[0,3],false);
      draw_set_color(c_white);
      _draw_btn(_p[1,0],_p[1,1],INPUT.start,8);
      _draw_btn(_p[2,0],_p[2,1],INPUT.select,10); 
      
      
      _draw_btn(_p[3,0],_p[3,1],INPUT.a,0);
      _draw_btn(_p[4,0],_p[4,1],INPUT.b,2);
      _draw_btn(_p[5,0],_p[5,1],INPUT.x,4);
      _draw_btn(_p[6,0],_p[6,1],INPUT.y,6);
      
      _draw_btn(_p[7,0],_p[7,1],INPUT.up,12);
      _draw_btn(_p[8,0],_p[8,1],INPUT.down,14);
      _draw_btn(_p[9,0],_p[9,1],INPUT.left,16);
      _draw_btn(_p[10,0],_p[10,1],INPUT.right,18);
      
      _draw_btn(_p[11,0],_p[11,1],INPUT.bumper_l,20);
      _draw_btn(_p[12,0],_p[12,1],INPUT.bumper_r,22);
      _draw_axs(_p[13,0],_p[13,1],INPUT.trigger_l,24);
      _draw_axs(_p[14,0],_p[14,1],INPUT.trigger_r,26);

      _draw_joystick(_p[15,0],_p[15,1],30,INPUT.joy_left,INPUT.click_l)
      _draw_joystick(_p[16,0],_p[16,1],30,INPUT.joy_right,INPUT.click_r)
      
      draw_set_talign(fa_center,fa_top)
      
      draw_text(_p[17,0],_p[17,1],INPUT.gp_id)
      


    }
  }
  input.init();
  
  update=function(){
    system.update();
    trace.update();
  }
  
  draw=function(){
    draw_set_font(fnt_dbug);
    system.draw();
    level.draw();
    screen.draw();
    trace.draw();
    build.draw();
    input.draw();
  }
}