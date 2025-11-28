function Screen(w=640,h=360,s=1)constructor{
  width=w;
  height=h;
  scale=s;
  max_scale=1;
  fullscreen=false;
  
  set_anchors = function () {
    var w = width;
    var h = height;
    
    half={width:w/2, height:h/2}
    third={width:w/3, height:h/3}
    quarter={width:w/4, height:h/4}
    fifth={width:w/5, height:h/5}

    var hw=half.width;
    var hh=half.height;
  
    // center
      
    center={x:hw,y:hh};

    // corners
    topleft     = { x: 0,   y: 0 };
    topright    = { x: w,   y: 0 };
    bottomleft  = { x: 0,   y: h };
    bottomright = { x: w,   y: h };

    // edge centers
    top    = { x: hw, y: 0 };
    bottom = { x: hw, y: h };
    left   = { x: 0,       y: hh };
    right  = { x: w,       y: hh };


};

  
    init=function(){
    var _display_width=display_get_width();
    var _display_height=display_get_height();
    aspect_ratio=_display_width/_display_height;
    
    if (!PLATFORM.is_web()){
      //makes sure the display height divides neatly into game height
      if (_display_height mod height != 0){
        var _d=round(_display_height/height);
        height=_display_height/_d;
      }
      width=round(height*aspect_ratio);
      if width & 1{ width++;}
      if height &1 {height++;}
      
      max_scale=floor(_display_width/width);
      if scale>max_scale{scale=max_scale;}
    }
    if !PLATFORM.is_desktop(){scale=1;max_scale=1};//
    //if platform.type=="HTML5"{scale=1;max_scale=1;/*width=640; height=360*/};//
    
  }
  
  set_resolution=function(){
    surface_resize(application_surface,width,height);
    display_set_gui_size(width,height);
    window_set_size(width*scale,height*scale);
    window_set_fullscreen(false);
    set_anchors();
    if PLATFORM.is_desktop(){
      window_center();}
  }
  init();
  set_resolution();
}