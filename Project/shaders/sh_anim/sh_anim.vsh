attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec2 in_TextureCoord0;
//attribute vec2 in_TextureCoord1;
//attribute vec4 in_Colour;
attribute vec4 in_TangentW; // (tangent.xyz, bitangentSign)
attribute vec4 in_BoneIndex;
attribute vec4 in_BoneWeight;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// The maximum number of bones. Must be the same as defined in BBMOD_AnimationPlayer!
#define BBMOD_MAX_BONES 128
// Bone transforms are passed to this uniform when animationPlayer.submit() is called.
uniform vec4 bbmod_Bones[2 * BBMOD_MAX_BONES];

vec3 QuaternionRotate(vec4 q, vec3 v)
{
	return (v + 2.0 * cross(q.xyz, cross(q.xyz, v) + q.w * v));
}

vec3 DualQuaternionTransform(vec4 real, vec4 dual, vec3 v)
{
	return (QuaternionRotate(real, v)
		+ 2.0 * (real.w * dual.xyz - dual.w * real.xyz + cross(real.xyz, dual.xyz)));
}

void GetBoneTransform(out vec4 real, out vec4 dual)
{
	// Source:
	// https://www.cs.utah.edu/~ladislav/kavan07skinning/kavan07skinning.pdf
	// https://www.cs.utah.edu/~ladislav/dq/dqs.cg
	ivec4 i = ivec4(in_BoneIndex) * 2, j = i + 1;

	vec4 real0 = bbmod_Bones[i.x], real1 = bbmod_Bones[i.y],
		real2 = bbmod_Bones[i.z], real3 = bbmod_Bones[i.w],
		dual0 = bbmod_Bones[j.x], dual1 = bbmod_Bones[j.y],
		dual2 = bbmod_Bones[j.z], dual3 = bbmod_Bones[j.w];

	float sign1 = (dot(real0, real1) < 0.0) ? -1.0 : 1.0,
		sign2 = (dot(real0, real2) < 0.0) ? -1.0 : 1.0,
		sign3 = (dot(real0, real3) < 0.0) ? -1.0 : 1.0;

	real1 *= sign1; dual1 *= sign1;
	real2 *= sign2; dual2 *= sign2;
	real3 *= sign3; dual3 *= sign3;

	real = real0 * in_BoneWeight.x + real1 * in_BoneWeight.y
		+ real2 * in_BoneWeight.z + real3 * in_BoneWeight.w;

	dual = dual0 * in_BoneWeight.x + dual1 * in_BoneWeight.y
		+ dual2 * in_BoneWeight.z + dual3 * in_BoneWeight.w;

	float norm = 1.0 / length(real);
	real *= norm;
	dual *= norm;
}

void main()
{
	vec4 boneReal, boneDual;
	GetBoneTransform(boneReal, boneDual);
	vec3 position = DualQuaternionTransform(boneReal, boneDual, in_Position);
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(position, 1.0);
	v_vColour = vec4(1.0); //in_Colour;
	v_vTexcoord = in_TextureCoord0;
	vec3 normal = QuaternionRotate(boneReal, in_Normal);
	vec3 tangent = QuaternionRotate(boneReal, in_TangentW.xyz);
	vec3 bitangent = cross(normal, tangent) * in_TangentW.w;
}