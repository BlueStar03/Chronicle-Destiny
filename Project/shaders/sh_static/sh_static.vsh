attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec2 in_TextureCoord0;
//attribute vec2 in_TextureCoord1;
//attribute vec4 in_Colour;
attribute vec4 in_TangentW; // (tangent.xyz, bitangentSign)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 1.0);
	v_vColour = vec4(1.0); //in_Colour;
	v_vTexcoord = in_TextureCoord0;
	//vec3 normal = in_Normal;
	//vec3 tangent = in_TangentW.xyz;
	//vec3 bitangent = cross(normal, tangent) * in_TangentW.w;
}