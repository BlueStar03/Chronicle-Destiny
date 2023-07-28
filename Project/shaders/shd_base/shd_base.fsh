varying vec2 v_vTexcoord;
varying vec4 v_vColour;



varying vec3 v_worldPosition;
varying vec3 v_worldNormal;

void main() {
    vec4 starting_color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    if (starting_color.a<0.1) discard;

    
    vec4 final_color = starting_color;
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
}