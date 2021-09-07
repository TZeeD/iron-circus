Shader "IMI/Amplify/ExplosionClouds" {
	Properties {
		_Tex_gradient ("Tex_gradient", 2D) = "white" {}
		_Emissive_intensity ("Emissive_intensity", Float) = 0
		_Deformation_scale ("Deformation_scale", Range(0, 10)) = 1
		_min ("min", Float) = 0
		_max ("max", Float) = 1
		_Deformation_TimeOffset ("Deformation_TimeOffset", Range(0, 1)) = 0
		_fx_skill_mine_cloud_tex ("fx_skill_mine_cloud_tex", 2D) = "white" {}
		_TextureSample1 ("Texture Sample 1", 2D) = "white" {}
		[HideInInspector] _tex4coord ("", 2D) = "white" {}
		[HideInInspector] _texcoord ("", 2D) = "white" {}
		[HideInInspector] __dirty ("", Float) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 32129
			Program "vp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat15 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat15 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat15 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat15 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat15 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat15 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat11;
					vec3 u_xlat13;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat13.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat13.xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat13.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat13.xyz = (bool(u_xlatb33)) ? u_xlat13.xyz : vs_TEXCOORD3.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat13.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat33, u_xlat23);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat33 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat23 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat23 = u_xlat23 + u_xlat23;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat23)) + (-u_xlat0.xyz);
					    u_xlat4.xyz = vec3(u_xlat33) * _LightColor0.xyz;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat13.xyz);
					    u_xlat23 = u_xlat33 + u_xlat33;
					    u_xlat0.xyz = u_xlat13.xyz * (-vec3(u_xlat23)) + u_xlat0.xyz;
					    u_xlat23 = dot(u_xlat13.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat33 = u_xlat33;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat5.y = (-u_xlat33) + 1.0;
					    u_xlat5.zw = u_xlat5.xy * u_xlat5.xy;
					    u_xlat0.xy = u_xlat5.xy * u_xlat5.xw;
					    u_xlat0.xy = u_xlat5.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat5 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat5.x * 0.639999986;
					    u_xlat0.xzw = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat13.xyz = vec3(u_xlat23) * u_xlat4.xyz;
					    u_xlat11 = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat3.xyz = vec3(u_xlat11) * u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat0.xzw * u_xlat13.xyz + u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat13;
					vec3 u_xlat15;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat37 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat37 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat15.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat15.xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat15.xyz;
					        u_xlat15.xyz = u_xlat15.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat15.xyz = (bool(u_xlatb37)) ? u_xlat15.xyz : vs_TEXCOORD3.xyz;
					        u_xlat15.xyz = u_xlat15.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat15.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat37, u_xlat26);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat37 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlat26 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat26 = u_xlat26 + u_xlat26;
					    u_xlat15.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat26)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat37) * _LightColor0.xyz;
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = log2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat8.xyz = vec3(u_xlat26) * u_xlat15.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat26 = min(u_xlat9.z, u_xlat26);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, 6.0);
					        u_xlat26 = u_xlat8.w + -1.0;
					        u_xlat26 = unity_SpecCube1_HDR.w * u_xlat26 + 1.0;
					        u_xlat26 = log2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.y;
					        u_xlat26 = exp2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xyz;
					    u_xlat13.xyz = u_xlat7.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat13.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec3 u_xlat15;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat37 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat37 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat15.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat15.xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat15.xyz;
					        u_xlat15.xyz = u_xlat15.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat15.xyz = (bool(u_xlatb37)) ? u_xlat15.xyz : vs_TEXCOORD3.xyz;
					        u_xlat15.xyz = u_xlat15.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat15.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat37, u_xlat26);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat37 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlat26 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat26 = u_xlat26 + u_xlat26;
					    u_xlat15.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat26)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat37) * _LightColor0.xyz;
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = log2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat8.xyz = vec3(u_xlat26) * u_xlat15.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat26 = min(u_xlat9.z, u_xlat26);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, 6.0);
					        u_xlat26 = u_xlat8.w + -1.0;
					        u_xlat26 = unity_SpecCube1_HDR.w * u_xlat26 + 1.0;
					        u_xlat26 = log2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.y;
					        u_xlat26 = exp2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat24 * u_xlat24;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat24 = u_xlat24 * u_xlat13;
					    u_xlat24 = u_xlat12.x * u_xlat24 + 1.0;
					    u_xlat13 = -abs(u_xlat36) + 1.0;
					    u_xlat25 = u_xlat13 * u_xlat13;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat13 = u_xlat13 * u_xlat25;
					    u_xlat12.x = u_xlat12.x * u_xlat13 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24;
					    u_xlat24 = abs(u_xlat36) + u_xlat1.x;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat12.y = u_xlat24 * 0.999999881;
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat1.xzw = u_xlat12.xxx * u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat5.xyz * u_xlat12.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat26 = u_xlat0.x * u_xlat0.x;
					    u_xlat26 = u_xlat26 * u_xlat26;
					    u_xlat0.x = u_xlat0.x * u_xlat26;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat7.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat36 = u_xlat13 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(u_xlat36) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					float u_xlat12;
					vec3 u_xlat14;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat40;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat36 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat36 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlatb36 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb36){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat14.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat14.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat14.xyz;
					        u_xlat14.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat14.xyz;
					        u_xlat14.xyz = u_xlat14.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat14.xyz = (bool(u_xlatb25)) ? u_xlat14.xyz : vs_TEXCOORD3.xyz;
					        u_xlat14.xyz = u_xlat14.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat14.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat14.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat25, u_xlat14.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat14.x = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat14.x = u_xlat14.x + u_xlat14.x;
					    u_xlat14.xyz = vs_TEXCOORD2.xyz * (-u_xlat14.xxx) + (-u_xlat0.xyz);
					    u_xlat4.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    if(u_xlatb36){
					        u_xlatb36 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb36)) ? u_xlat5.xyz : vs_TEXCOORD3.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat36 = u_xlat5.y * 0.25;
					        u_xlat25 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat40 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat36 = max(u_xlat36, u_xlat25);
					        u_xlat5.x = min(u_xlat40, u_xlat36);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD2.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5.xyz = u_xlat6.xyz + vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb36 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb36){
					        u_xlat36 = dot(u_xlat14.xyz, u_xlat14.xyz);
					        u_xlat36 = inversesqrt(u_xlat36);
					        u_xlat6.xyz = vec3(u_xlat36) * u_xlat14.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat36 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat36 = min(u_xlat7.z, u_xlat36);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat36) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat14.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat36 = u_xlat6.w + -1.0;
					    u_xlat36 = unity_SpecCube0_HDR.w * u_xlat36 + 1.0;
					    u_xlat36 = log2(u_xlat36);
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.y;
					    u_xlat36 = exp2(u_xlat36);
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat36);
					    u_xlatb25 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb25){
					        u_xlatb25 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb25){
					            u_xlat25 = dot(u_xlat14.xyz, u_xlat14.xyz);
					            u_xlat25 = inversesqrt(u_xlat25);
					            u_xlat8.xyz = vec3(u_xlat25) * u_xlat14.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat25 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat25 = min(u_xlat9.z, u_xlat25);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat14.xyz = u_xlat8.xyz * vec3(u_xlat25) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat14.xyz, 6.0);
					        u_xlat25 = u_xlat8.w + -1.0;
					        u_xlat25 = unity_SpecCube1_HDR.w * u_xlat25 + 1.0;
					        u_xlat25 = log2(u_xlat25);
					        u_xlat25 = u_xlat25 * unity_SpecCube1_HDR.y;
					        u_xlat25 = exp2(u_xlat25);
					        u_xlat25 = u_xlat25 * unity_SpecCube1_HDR.x;
					        u_xlat14.xyz = u_xlat8.xyz * vec3(u_xlat25);
					        u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + (-u_xlat14.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat14.xyz;
					    }
					    u_xlat36 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat14.xyz = vec3(u_xlat36) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat14.xyz);
					    u_xlat25 = u_xlat36 + u_xlat36;
					    u_xlat0.xyz = u_xlat14.xyz * (-vec3(u_xlat25)) + u_xlat0.xyz;
					    u_xlat25 = dot(u_xlat14.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat36 = u_xlat36;
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat6.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat6.y = (-u_xlat36) + 1.0;
					    u_xlat6.zw = u_xlat6.xy * u_xlat6.xy;
					    u_xlat0.xy = u_xlat6.xy * u_xlat6.xw;
					    u_xlat0.xy = u_xlat6.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat6 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.xzw = u_xlat6.xxx * vec3(0.639999986, 0.639999986, 0.639999986) + u_xlat3.xyz;
					    u_xlat14.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat12 = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat7.xyz;
					    u_xlat3.xyz = u_xlat5.xyz * u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xzw * u_xlat14.xyz + u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat14;
					vec3 u_xlat16;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat39;
					float u_xlat40;
					bool u_xlatb40;
					float u_xlat44;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat40 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat40 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat16.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat16.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat16.xyz;
					        u_xlat16.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat16.xyz;
					        u_xlat16.xyz = u_xlat16.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat16.xyz = (bool(u_xlatb28)) ? u_xlat16.xyz : vs_TEXCOORD3.xyz;
					        u_xlat16.xyz = u_xlat16.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat16.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat28 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat16.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat28, u_xlat16.x);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat28 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat16.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat16.x = u_xlat16.x + u_xlat16.x;
					    u_xlat16.xyz = vs_TEXCOORD2.xyz * (-u_xlat16.xxx) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD3.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat28 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat44 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat28);
					        u_xlat6.x = min(u_xlat44, u_xlat40);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD2.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat7, u_xlat9);
					        u_xlat7.y = dot(u_xlat8, u_xlat9);
					        u_xlat7.z = dot(u_xlat6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD2.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD4.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat16.xyz, u_xlat16.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat16.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat16.xyz;
					    }
					    u_xlat7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 6.0);
					    u_xlat40 = u_xlat7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat40 + 1.0;
					    u_xlat40 = log2(u_xlat40);
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.y;
					    u_xlat40 = exp2(u_xlat40);
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat7.xyz * vec3(u_xlat40);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat16.xyz, u_xlat16.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat9.xyz = vec3(u_xlat28) * u_xlat16.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat28 = min(u_xlat10.z, u_xlat28);
					            u_xlat10.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat16.xyz = u_xlat9.xyz * vec3(u_xlat28) + u_xlat10.xyz;
					        }
					        u_xlat9 = textureLod(unity_SpecCube1, u_xlat16.xyz, 6.0);
					        u_xlat28 = u_xlat9.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat16.xyz = u_xlat9.xyz * vec3(u_xlat28);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat7.xyz + (-u_xlat16.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat16.xyz;
					    }
					    u_xlat40 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat16.xyz = vec3(u_xlat40) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat16.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat16.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xyz;
					    u_xlat14.xyz = u_xlat4.xyz * u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + u_xlat14.xyz;
					    u_xlat14.xyz = u_xlat8.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat39 = (-u_xlat1.x) + 1.0;
					    u_xlat39 = u_xlat39 * u_xlat39;
					    u_xlat39 = u_xlat39 * u_xlat39;
					    u_xlat39 = u_xlat39 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat14.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat16;
					float u_xlat26;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat39;
					float u_xlat40;
					bool u_xlatb40;
					float u_xlat44;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat40 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat40 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat16.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat16.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat16.xyz;
					        u_xlat16.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat16.xyz;
					        u_xlat16.xyz = u_xlat16.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat16.xyz = (bool(u_xlatb28)) ? u_xlat16.xyz : vs_TEXCOORD3.xyz;
					        u_xlat16.xyz = u_xlat16.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat16.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat28 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat16.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat28, u_xlat16.x);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat28 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat16.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat16.x = u_xlat16.x + u_xlat16.x;
					    u_xlat16.xyz = vs_TEXCOORD2.xyz * (-u_xlat16.xxx) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD3.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat28 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat44 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat28);
					        u_xlat6.x = min(u_xlat44, u_xlat40);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD2.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat7, u_xlat9);
					        u_xlat7.y = dot(u_xlat8, u_xlat9);
					        u_xlat7.z = dot(u_xlat6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD2.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD4.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat16.xyz, u_xlat16.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat16.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat16.xyz;
					    }
					    u_xlat7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 6.0);
					    u_xlat40 = u_xlat7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat40 + 1.0;
					    u_xlat40 = log2(u_xlat40);
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.y;
					    u_xlat40 = exp2(u_xlat40);
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat7.xyz * vec3(u_xlat40);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat16.xyz, u_xlat16.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat9.xyz = vec3(u_xlat28) * u_xlat16.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat28 = min(u_xlat10.z, u_xlat28);
					            u_xlat10.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat16.xyz = u_xlat9.xyz * vec3(u_xlat28) + u_xlat10.xyz;
					        }
					        u_xlat9 = textureLod(unity_SpecCube1, u_xlat16.xyz, 6.0);
					        u_xlat28 = u_xlat9.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat16.xyz = u_xlat9.xyz * vec3(u_xlat28);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat7.xyz + (-u_xlat16.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat16.xyz;
					    }
					    u_xlat40 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat16.xyz = vec3(u_xlat40) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat16.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat16.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat13.x = u_xlat13.x + -0.5;
					    u_xlat26 = (-u_xlat1.x) + 1.0;
					    u_xlat14 = u_xlat26 * u_xlat26;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat26 = u_xlat26 * u_xlat14;
					    u_xlat26 = u_xlat13.x * u_xlat26 + 1.0;
					    u_xlat14 = -abs(u_xlat39) + 1.0;
					    u_xlat27 = u_xlat14 * u_xlat14;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat14 = u_xlat14 * u_xlat27;
					    u_xlat13.x = u_xlat13.x * u_xlat14 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26;
					    u_xlat26 = abs(u_xlat39) + u_xlat1.x;
					    u_xlat26 = u_xlat26 + 9.99999975e-06;
					    u_xlat26 = 0.5 / u_xlat26;
					    u_xlat13.y = u_xlat26 * 0.999999881;
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat1.xzw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat13.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat13.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat39 = u_xlat14 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(u_xlat39) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat11;
					vec3 u_xlat13;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat4.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat13.xyz);
					    u_xlat23 = u_xlat33 + u_xlat33;
					    u_xlat0.xyz = u_xlat13.xyz * (-vec3(u_xlat23)) + u_xlat0.xyz;
					    u_xlat23 = dot(u_xlat13.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat33 = u_xlat33;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat5.y = (-u_xlat33) + 1.0;
					    u_xlat5.zw = u_xlat5.xy * u_xlat5.xy;
					    u_xlat0.xy = u_xlat5.xy * u_xlat5.xw;
					    u_xlat0.xy = u_xlat5.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat5 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.xzw = u_xlat5.xxx * vec3(0.639999986, 0.639999986, 0.639999986) + u_xlat3.xyz;
					    u_xlat13.xyz = vec3(u_xlat23) * _LightColor0.xyz;
					    u_xlat11 = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat5.xyz = vec3(u_xlat11) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xzw * u_xlat13.xyz + u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat13;
					vec3 u_xlat15;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat37 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat37 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat37 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat37 = u_xlat37 + u_xlat37;
					    u_xlat15.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat37)) + (-u_xlat1.xyz);
					    u_xlat5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat37 = log2(u_xlat5.w);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.x;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat37);
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = log2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat8.xyz = vec3(u_xlat26) * u_xlat15.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat26 = min(u_xlat9.z, u_xlat26);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, 6.0);
					        u_xlat26 = u_xlat8.w + -1.0;
					        u_xlat26 = unity_SpecCube1_HDR.w * u_xlat26 + 1.0;
					        u_xlat26 = log2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.y;
					        u_xlat26 = exp2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat13.xyz = u_xlat4.xyz * u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat13.xyz;
					    u_xlat13.xyz = u_xlat7.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat36 = (-u_xlat1.x) + 1.0;
					    u_xlat36 = u_xlat36 * u_xlat36;
					    u_xlat36 = u_xlat36 * u_xlat36;
					    u_xlat36 = u_xlat36 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat13.xyz * vec3(u_xlat36) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec3 u_xlat15;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat36;
					float u_xlat37;
					float u_xlat41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat37 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat37 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat37 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat37 = u_xlat37 + u_xlat37;
					    u_xlat15.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat37)) + (-u_xlat1.xyz);
					    u_xlat5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat37 = log2(u_xlat5.w);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.x;
					    u_xlatb26 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb26){
					        u_xlat26 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat26 = inversesqrt(u_xlat26);
					        u_xlat6.xyz = vec3(u_xlat26) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat26 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat26 = min(u_xlat7.z, u_xlat26);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat26) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat26 = u_xlat6.w + -1.0;
					    u_xlat26 = unity_SpecCube0_HDR.w * u_xlat26 + 1.0;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * unity_SpecCube0_HDR.y;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat26 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat26);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat8.xyz = u_xlat15.xyz * vec3(u_xlat41);
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat41 = min(u_xlat9.z, u_xlat41);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat41) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, 6.0);
					        u_xlat15.x = u_xlat8.w + -1.0;
					        u_xlat15.x = unity_SpecCube1_HDR.w * u_xlat15.x + 1.0;
					        u_xlat15.x = log2(u_xlat15.x);
					        u_xlat15.x = u_xlat15.x * unity_SpecCube1_HDR.y;
					        u_xlat15.x = exp2(u_xlat15.x);
					        u_xlat15.x = u_xlat15.x * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * u_xlat15.xxx;
					        u_xlat6.xyz = vec3(u_xlat26) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat26 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat26 = inversesqrt(u_xlat26);
					    u_xlat15.xyz = vec3(u_xlat26) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat24 * u_xlat24;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat24 = u_xlat24 * u_xlat13;
					    u_xlat24 = u_xlat12.x * u_xlat24 + 1.0;
					    u_xlat13 = -abs(u_xlat36) + 1.0;
					    u_xlat25 = u_xlat13 * u_xlat13;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat13 = u_xlat13 * u_xlat25;
					    u_xlat12.x = u_xlat12.x * u_xlat13 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24;
					    u_xlat24 = abs(u_xlat36) + u_xlat1.x;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat12.y = u_xlat24 * 0.999999881;
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat15.xyz = u_xlat12.xxx * _LightColor0.xyz;
					    u_xlat1.xzw = vec3(u_xlat37) * u_xlat5.xyz + u_xlat15.xyz;
					    u_xlat12.xyz = u_xlat12.yyy * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat26 = u_xlat0.x * u_xlat0.x;
					    u_xlat26 = u_xlat26 * u_xlat26;
					    u_xlat0.x = u_xlat0.x * u_xlat26;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat7.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat36 = u_xlat13 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(u_xlat36) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat11;
					vec3 u_xlat13;
					float u_xlat15;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb33)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat33 = max(u_xlat33, u_xlat23);
					        u_xlat4.x = min(u_xlat15, u_xlat33);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD2.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4 = vs_TEXCOORD2.yzzx * vs_TEXCOORD2.xyzz;
					    u_xlat6.x = dot(unity_SHBr, u_xlat4);
					    u_xlat6.y = dot(unity_SHBg, u_xlat4);
					    u_xlat6.z = dot(unity_SHBb, u_xlat4);
					    u_xlat33 = vs_TEXCOORD2.y * vs_TEXCOORD2.y;
					    u_xlat33 = vs_TEXCOORD2.x * vs_TEXCOORD2.x + (-u_xlat33);
					    u_xlat4.xyz = unity_SHC.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat5.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = vec3(u_xlat33) * u_xlat5.xyz + u_xlat4.xyz;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat13.xyz);
					    u_xlat23 = u_xlat33 + u_xlat33;
					    u_xlat0.xyz = u_xlat13.xyz * (-vec3(u_xlat23)) + u_xlat0.xyz;
					    u_xlat23 = dot(u_xlat13.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat33 = u_xlat33;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat5.y = (-u_xlat33) + 1.0;
					    u_xlat5.zw = u_xlat5.xy * u_xlat5.xy;
					    u_xlat0.xy = u_xlat5.xy * u_xlat5.xw;
					    u_xlat0.xy = u_xlat5.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat5 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.xzw = u_xlat5.xxx * vec3(0.639999986, 0.639999986, 0.639999986) + u_xlat3.xyz;
					    u_xlat13.xyz = vec3(u_xlat23) * _LightColor0.xyz;
					    u_xlat11 = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat5.xyz = vec3(u_xlat11) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xzw * u_xlat13.xyz + u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat13;
					vec3 u_xlat15;
					float u_xlat17;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat37 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat37 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat37 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat37 = u_xlat37 + u_xlat37;
					    u_xlat15.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat37)) + (-u_xlat1.xyz);
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD3.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat17 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat26);
					        u_xlat5.x = min(u_xlat17, u_xlat37);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD2.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5 = vs_TEXCOORD2.yzzx * vs_TEXCOORD2.xyzz;
					    u_xlat7.x = dot(unity_SHBr, u_xlat5);
					    u_xlat7.y = dot(unity_SHBg, u_xlat5);
					    u_xlat7.z = dot(unity_SHBb, u_xlat5);
					    u_xlat37 = vs_TEXCOORD2.y * vs_TEXCOORD2.y;
					    u_xlat37 = vs_TEXCOORD2.x * vs_TEXCOORD2.x + (-u_xlat37);
					    u_xlat5.xyz = unity_SHC.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat6.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat37 = log2(u_xlat6.w);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.x;
					    u_xlat5.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat5.xyz;
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = log2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat8.xyz = vec3(u_xlat26) * u_xlat15.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat26 = min(u_xlat9.z, u_xlat26);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, 6.0);
					        u_xlat26 = u_xlat8.w + -1.0;
					        u_xlat26 = unity_SpecCube1_HDR.w * u_xlat26 + 1.0;
					        u_xlat26 = log2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.y;
					        u_xlat26 = exp2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat13.xyz = u_xlat4.xyz * u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat13.xyz;
					    u_xlat13.xyz = u_xlat7.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat36 = (-u_xlat1.x) + 1.0;
					    u_xlat36 = u_xlat36 * u_xlat36;
					    u_xlat36 = u_xlat36 * u_xlat36;
					    u_xlat36 = u_xlat36 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat13.xyz * vec3(u_xlat36) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec3 u_xlat15;
					float u_xlat17;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat37 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat37 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat37 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat37 = u_xlat37 + u_xlat37;
					    u_xlat15.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat37)) + (-u_xlat1.xyz);
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD3.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat17 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat26);
					        u_xlat5.x = min(u_xlat17, u_xlat37);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD2.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5 = vs_TEXCOORD2.yzzx * vs_TEXCOORD2.xyzz;
					    u_xlat7.x = dot(unity_SHBr, u_xlat5);
					    u_xlat7.y = dot(unity_SHBg, u_xlat5);
					    u_xlat7.z = dot(unity_SHBb, u_xlat5);
					    u_xlat37 = vs_TEXCOORD2.y * vs_TEXCOORD2.y;
					    u_xlat37 = vs_TEXCOORD2.x * vs_TEXCOORD2.x + (-u_xlat37);
					    u_xlat5.xyz = unity_SHC.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat6.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat37 = log2(u_xlat6.w);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.x;
					    u_xlat5.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat5.xyz;
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = log2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat8.xyz = vec3(u_xlat26) * u_xlat15.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat26 = min(u_xlat9.z, u_xlat26);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, 6.0);
					        u_xlat26 = u_xlat8.w + -1.0;
					        u_xlat26 = unity_SpecCube1_HDR.w * u_xlat26 + 1.0;
					        u_xlat26 = log2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.y;
					        u_xlat26 = exp2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat24 * u_xlat24;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat24 = u_xlat24 * u_xlat13;
					    u_xlat24 = u_xlat12.x * u_xlat24 + 1.0;
					    u_xlat13 = -abs(u_xlat36) + 1.0;
					    u_xlat25 = u_xlat13 * u_xlat13;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat13 = u_xlat13 * u_xlat25;
					    u_xlat12.x = u_xlat12.x * u_xlat13 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24;
					    u_xlat24 = abs(u_xlat36) + u_xlat1.x;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat12.y = u_xlat24 * 0.999999881;
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat1.xzw = _LightColor0.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat12.yyy * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat26 = u_xlat0.x * u_xlat0.x;
					    u_xlat26 = u_xlat26 * u_xlat26;
					    u_xlat0.x = u_xlat0.x * u_xlat26;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat7.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat36 = u_xlat13 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(u_xlat36) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat11;
					vec3 u_xlat13;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat4.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat13.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat11 = u_xlat0.x * u_xlat0.x;
					    u_xlat11 = u_xlat0.x * u_xlat11;
					    u_xlat0.x = u_xlat0.x * u_xlat11;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					vec3 u_xlat13;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat4.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat13.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat6.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					vec3 u_xlat13;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat4.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat13.xyz, u_xlat0.xyz);
					    u_xlat11.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat23 = u_xlat0.x * u_xlat0.x;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat0.x = u_xlat0.x * u_xlat23;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat11;
					vec3 u_xlat13;
					float u_xlat15;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb33)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat33 = max(u_xlat33, u_xlat23);
					        u_xlat4.x = min(u_xlat15, u_xlat33);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD2.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4 = vs_TEXCOORD2.yzzx * vs_TEXCOORD2.xyzz;
					    u_xlat6.x = dot(unity_SHBr, u_xlat4);
					    u_xlat6.y = dot(unity_SHBg, u_xlat4);
					    u_xlat6.z = dot(unity_SHBb, u_xlat4);
					    u_xlat33 = vs_TEXCOORD2.y * vs_TEXCOORD2.y;
					    u_xlat33 = vs_TEXCOORD2.x * vs_TEXCOORD2.x + (-u_xlat33);
					    u_xlat4.xyz = unity_SHC.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat5.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = vec3(u_xlat33) * u_xlat5.xyz + u_xlat4.xyz;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat13.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat11 = u_xlat0.x * u_xlat0.x;
					    u_xlat11 = u_xlat0.x * u_xlat11;
					    u_xlat0.x = u_xlat0.x * u_xlat11;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					vec3 u_xlat13;
					float u_xlat15;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb33)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat33 = max(u_xlat33, u_xlat23);
					        u_xlat4.x = min(u_xlat15, u_xlat33);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD2.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4 = vs_TEXCOORD2.yzzx * vs_TEXCOORD2.xyzz;
					    u_xlat6.x = dot(unity_SHBr, u_xlat4);
					    u_xlat6.y = dot(unity_SHBg, u_xlat4);
					    u_xlat6.z = dot(unity_SHBb, u_xlat4);
					    u_xlat33 = vs_TEXCOORD2.y * vs_TEXCOORD2.y;
					    u_xlat33 = vs_TEXCOORD2.x * vs_TEXCOORD2.x + (-u_xlat33);
					    u_xlat4.xyz = unity_SHC.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat5.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = vec3(u_xlat33) * u_xlat5.xyz + u_xlat4.xyz;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat13.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat6.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					vec3 u_xlat13;
					float u_xlat15;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb33)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat33 = max(u_xlat33, u_xlat23);
					        u_xlat4.x = min(u_xlat15, u_xlat33);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD2.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4 = vs_TEXCOORD2.yzzx * vs_TEXCOORD2.xyzz;
					    u_xlat6.x = dot(unity_SHBr, u_xlat4);
					    u_xlat6.y = dot(unity_SHBg, u_xlat4);
					    u_xlat6.z = dot(unity_SHBb, u_xlat4);
					    u_xlat33 = vs_TEXCOORD2.y * vs_TEXCOORD2.y;
					    u_xlat33 = vs_TEXCOORD2.x * vs_TEXCOORD2.x + (-u_xlat33);
					    u_xlat4.xyz = unity_SHC.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat5.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = vec3(u_xlat33) * u_xlat5.xyz + u_xlat4.xyz;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat13.xyz, u_xlat0.xyz);
					    u_xlat11.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat23 = u_xlat0.x * u_xlat0.x;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat0.x = u_xlat0.x * u_xlat23;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat11;
					vec3 u_xlat13;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat13.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat13.xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat13.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat13.xyz = (bool(u_xlatb33)) ? u_xlat13.xyz : vs_TEXCOORD3.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat13.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat33, u_xlat23);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat33 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat23 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat23 = u_xlat23 + u_xlat23;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat23)) + (-u_xlat0.xyz);
					    u_xlat4.xyz = vec3(u_xlat33) * _LightColor0.xyz;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat13.xyz);
					    u_xlat23 = u_xlat33 + u_xlat33;
					    u_xlat0.xyz = u_xlat13.xyz * (-vec3(u_xlat23)) + u_xlat0.xyz;
					    u_xlat23 = dot(u_xlat13.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat33 = u_xlat33;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat5.y = (-u_xlat33) + 1.0;
					    u_xlat5.zw = u_xlat5.xy * u_xlat5.xy;
					    u_xlat0.xy = u_xlat5.xy * u_xlat5.xw;
					    u_xlat0.xy = u_xlat5.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat5 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat5.x * 0.639999986;
					    u_xlat0.xzw = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat13.xyz = vec3(u_xlat23) * u_xlat4.xyz;
					    u_xlat11 = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat3.xyz = vec3(u_xlat11) * u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat0.xzw * u_xlat13.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat13;
					vec3 u_xlat15;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat37 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat37 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat15.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat15.xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat15.xyz;
					        u_xlat15.xyz = u_xlat15.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat15.xyz = (bool(u_xlatb37)) ? u_xlat15.xyz : vs_TEXCOORD3.xyz;
					        u_xlat15.xyz = u_xlat15.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat15.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat37, u_xlat26);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat37 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlat26 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat26 = u_xlat26 + u_xlat26;
					    u_xlat15.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat26)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat37) * _LightColor0.xyz;
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = log2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat8.xyz = vec3(u_xlat26) * u_xlat15.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat26 = min(u_xlat9.z, u_xlat26);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, 6.0);
					        u_xlat26 = u_xlat8.w + -1.0;
					        u_xlat26 = unity_SpecCube1_HDR.w * u_xlat26 + 1.0;
					        u_xlat26 = log2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.y;
					        u_xlat26 = exp2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xyz;
					    u_xlat13.xyz = u_xlat7.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat13.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    u_xlat36 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat36 = (-u_xlat36) + 1.0;
					    u_xlat36 = u_xlat36 * _ProjectionParams.z;
					    u_xlat36 = max(u_xlat36, 0.0);
					    u_xlat36 = u_xlat36 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec3 u_xlat15;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat37 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat37 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat15.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat15.xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat15.xyz;
					        u_xlat15.xyz = u_xlat15.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat15.xyz = (bool(u_xlatb37)) ? u_xlat15.xyz : vs_TEXCOORD3.xyz;
					        u_xlat15.xyz = u_xlat15.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat15.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat37, u_xlat26);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat37 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlat26 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat26 = u_xlat26 + u_xlat26;
					    u_xlat15.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat26)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat37) * _LightColor0.xyz;
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = log2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat8.xyz = vec3(u_xlat26) * u_xlat15.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat26 = min(u_xlat9.z, u_xlat26);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, 6.0);
					        u_xlat26 = u_xlat8.w + -1.0;
					        u_xlat26 = unity_SpecCube1_HDR.w * u_xlat26 + 1.0;
					        u_xlat26 = log2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.y;
					        u_xlat26 = exp2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat24 * u_xlat24;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat24 = u_xlat24 * u_xlat13;
					    u_xlat24 = u_xlat12.x * u_xlat24 + 1.0;
					    u_xlat13 = -abs(u_xlat36) + 1.0;
					    u_xlat25 = u_xlat13 * u_xlat13;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat13 = u_xlat13 * u_xlat25;
					    u_xlat12.x = u_xlat12.x * u_xlat13 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24;
					    u_xlat24 = abs(u_xlat36) + u_xlat1.x;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat12.y = u_xlat24 * 0.999999881;
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat1.xzw = u_xlat12.xxx * u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat5.xyz * u_xlat12.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat26 = u_xlat0.x * u_xlat0.x;
					    u_xlat26 = u_xlat26 * u_xlat26;
					    u_xlat0.x = u_xlat0.x * u_xlat26;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat7.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat36 = u_xlat13 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(u_xlat36) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    u_xlat36 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat36 = (-u_xlat36) + 1.0;
					    u_xlat36 = u_xlat36 * _ProjectionParams.z;
					    u_xlat36 = max(u_xlat36, 0.0);
					    u_xlat36 = u_xlat36 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					float u_xlat12;
					vec3 u_xlat14;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat40;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat36 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat36 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlatb36 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb36){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat14.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat14.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat14.xyz;
					        u_xlat14.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat14.xyz;
					        u_xlat14.xyz = u_xlat14.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat14.xyz = (bool(u_xlatb25)) ? u_xlat14.xyz : vs_TEXCOORD3.xyz;
					        u_xlat14.xyz = u_xlat14.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat14.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat14.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat25, u_xlat14.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat14.x = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat14.x = u_xlat14.x + u_xlat14.x;
					    u_xlat14.xyz = vs_TEXCOORD2.xyz * (-u_xlat14.xxx) + (-u_xlat0.xyz);
					    u_xlat4.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    if(u_xlatb36){
					        u_xlatb36 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb36)) ? u_xlat5.xyz : vs_TEXCOORD3.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat36 = u_xlat5.y * 0.25;
					        u_xlat25 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat40 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat36 = max(u_xlat36, u_xlat25);
					        u_xlat5.x = min(u_xlat40, u_xlat36);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD2.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5.xyz = u_xlat6.xyz + vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb36 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb36){
					        u_xlat36 = dot(u_xlat14.xyz, u_xlat14.xyz);
					        u_xlat36 = inversesqrt(u_xlat36);
					        u_xlat6.xyz = vec3(u_xlat36) * u_xlat14.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat36 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat36 = min(u_xlat7.z, u_xlat36);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat36) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat14.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat36 = u_xlat6.w + -1.0;
					    u_xlat36 = unity_SpecCube0_HDR.w * u_xlat36 + 1.0;
					    u_xlat36 = log2(u_xlat36);
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.y;
					    u_xlat36 = exp2(u_xlat36);
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat36);
					    u_xlatb25 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb25){
					        u_xlatb25 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb25){
					            u_xlat25 = dot(u_xlat14.xyz, u_xlat14.xyz);
					            u_xlat25 = inversesqrt(u_xlat25);
					            u_xlat8.xyz = vec3(u_xlat25) * u_xlat14.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat25 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat25 = min(u_xlat9.z, u_xlat25);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat14.xyz = u_xlat8.xyz * vec3(u_xlat25) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat14.xyz, 6.0);
					        u_xlat25 = u_xlat8.w + -1.0;
					        u_xlat25 = unity_SpecCube1_HDR.w * u_xlat25 + 1.0;
					        u_xlat25 = log2(u_xlat25);
					        u_xlat25 = u_xlat25 * unity_SpecCube1_HDR.y;
					        u_xlat25 = exp2(u_xlat25);
					        u_xlat25 = u_xlat25 * unity_SpecCube1_HDR.x;
					        u_xlat14.xyz = u_xlat8.xyz * vec3(u_xlat25);
					        u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + (-u_xlat14.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat14.xyz;
					    }
					    u_xlat36 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat14.xyz = vec3(u_xlat36) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat14.xyz);
					    u_xlat25 = u_xlat36 + u_xlat36;
					    u_xlat0.xyz = u_xlat14.xyz * (-vec3(u_xlat25)) + u_xlat0.xyz;
					    u_xlat25 = dot(u_xlat14.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat36 = u_xlat36;
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat6.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat6.y = (-u_xlat36) + 1.0;
					    u_xlat6.zw = u_xlat6.xy * u_xlat6.xy;
					    u_xlat0.xy = u_xlat6.xy * u_xlat6.xw;
					    u_xlat0.xy = u_xlat6.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat6 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.xzw = u_xlat6.xxx * vec3(0.639999986, 0.639999986, 0.639999986) + u_xlat3.xyz;
					    u_xlat14.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat12 = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat7.xyz;
					    u_xlat3.xyz = u_xlat5.xyz * u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xzw * u_xlat14.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat36 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat36 = (-u_xlat36) + 1.0;
					    u_xlat36 = u_xlat36 * _ProjectionParams.z;
					    u_xlat36 = max(u_xlat36, 0.0);
					    u_xlat36 = u_xlat36 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat14;
					vec3 u_xlat16;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat39;
					float u_xlat40;
					bool u_xlatb40;
					float u_xlat44;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat40 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat40 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat16.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat16.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat16.xyz;
					        u_xlat16.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat16.xyz;
					        u_xlat16.xyz = u_xlat16.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat16.xyz = (bool(u_xlatb28)) ? u_xlat16.xyz : vs_TEXCOORD3.xyz;
					        u_xlat16.xyz = u_xlat16.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat16.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat28 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat16.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat28, u_xlat16.x);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat28 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat16.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat16.x = u_xlat16.x + u_xlat16.x;
					    u_xlat16.xyz = vs_TEXCOORD2.xyz * (-u_xlat16.xxx) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD3.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat28 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat44 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat28);
					        u_xlat6.x = min(u_xlat44, u_xlat40);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD2.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat7, u_xlat9);
					        u_xlat7.y = dot(u_xlat8, u_xlat9);
					        u_xlat7.z = dot(u_xlat6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD2.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD4.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat16.xyz, u_xlat16.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat16.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat16.xyz;
					    }
					    u_xlat7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 6.0);
					    u_xlat40 = u_xlat7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat40 + 1.0;
					    u_xlat40 = log2(u_xlat40);
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.y;
					    u_xlat40 = exp2(u_xlat40);
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat7.xyz * vec3(u_xlat40);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat16.xyz, u_xlat16.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat9.xyz = vec3(u_xlat28) * u_xlat16.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat28 = min(u_xlat10.z, u_xlat28);
					            u_xlat10.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat16.xyz = u_xlat9.xyz * vec3(u_xlat28) + u_xlat10.xyz;
					        }
					        u_xlat9 = textureLod(unity_SpecCube1, u_xlat16.xyz, 6.0);
					        u_xlat28 = u_xlat9.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat16.xyz = u_xlat9.xyz * vec3(u_xlat28);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat7.xyz + (-u_xlat16.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat16.xyz;
					    }
					    u_xlat40 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat16.xyz = vec3(u_xlat40) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat16.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat16.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xyz;
					    u_xlat14.xyz = u_xlat4.xyz * u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + u_xlat14.xyz;
					    u_xlat14.xyz = u_xlat8.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat39 = (-u_xlat1.x) + 1.0;
					    u_xlat39 = u_xlat39 * u_xlat39;
					    u_xlat39 = u_xlat39 * u_xlat39;
					    u_xlat39 = u_xlat39 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat14.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat16;
					float u_xlat26;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat39;
					float u_xlat40;
					bool u_xlatb40;
					float u_xlat44;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat40 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat40 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat16.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat16.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat16.xyz;
					        u_xlat16.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat16.xyz;
					        u_xlat16.xyz = u_xlat16.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat16.xyz = (bool(u_xlatb28)) ? u_xlat16.xyz : vs_TEXCOORD3.xyz;
					        u_xlat16.xyz = u_xlat16.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat16.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat28 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat16.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat28, u_xlat16.x);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat28 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat16.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat16.x = u_xlat16.x + u_xlat16.x;
					    u_xlat16.xyz = vs_TEXCOORD2.xyz * (-u_xlat16.xxx) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD3.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat28 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat44 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat28);
					        u_xlat6.x = min(u_xlat44, u_xlat40);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD2.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat7, u_xlat9);
					        u_xlat7.y = dot(u_xlat8, u_xlat9);
					        u_xlat7.z = dot(u_xlat6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD2.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD4.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat16.xyz, u_xlat16.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat16.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat16.xyz;
					    }
					    u_xlat7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 6.0);
					    u_xlat40 = u_xlat7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat40 + 1.0;
					    u_xlat40 = log2(u_xlat40);
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.y;
					    u_xlat40 = exp2(u_xlat40);
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat7.xyz * vec3(u_xlat40);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat16.xyz, u_xlat16.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat9.xyz = vec3(u_xlat28) * u_xlat16.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat28 = min(u_xlat10.z, u_xlat28);
					            u_xlat10.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat16.xyz = u_xlat9.xyz * vec3(u_xlat28) + u_xlat10.xyz;
					        }
					        u_xlat9 = textureLod(unity_SpecCube1, u_xlat16.xyz, 6.0);
					        u_xlat28 = u_xlat9.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat16.xyz = u_xlat9.xyz * vec3(u_xlat28);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat7.xyz + (-u_xlat16.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat16.xyz;
					    }
					    u_xlat40 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat16.xyz = vec3(u_xlat40) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat16.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat16.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat13.x = u_xlat13.x + -0.5;
					    u_xlat26 = (-u_xlat1.x) + 1.0;
					    u_xlat14 = u_xlat26 * u_xlat26;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat26 = u_xlat26 * u_xlat14;
					    u_xlat26 = u_xlat13.x * u_xlat26 + 1.0;
					    u_xlat14 = -abs(u_xlat39) + 1.0;
					    u_xlat27 = u_xlat14 * u_xlat14;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat14 = u_xlat14 * u_xlat27;
					    u_xlat13.x = u_xlat13.x * u_xlat14 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26;
					    u_xlat26 = abs(u_xlat39) + u_xlat1.x;
					    u_xlat26 = u_xlat26 + 9.99999975e-06;
					    u_xlat26 = 0.5 / u_xlat26;
					    u_xlat13.y = u_xlat26 * 0.999999881;
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat1.xzw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat13.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat13.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat8.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat39 = u_xlat14 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(u_xlat39) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat11;
					vec3 u_xlat13;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat4.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat13.xyz);
					    u_xlat23 = u_xlat33 + u_xlat33;
					    u_xlat0.xyz = u_xlat13.xyz * (-vec3(u_xlat23)) + u_xlat0.xyz;
					    u_xlat23 = dot(u_xlat13.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat33 = u_xlat33;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat5.y = (-u_xlat33) + 1.0;
					    u_xlat5.zw = u_xlat5.xy * u_xlat5.xy;
					    u_xlat0.xy = u_xlat5.xy * u_xlat5.xw;
					    u_xlat0.xy = u_xlat5.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat5 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.xzw = u_xlat5.xxx * vec3(0.639999986, 0.639999986, 0.639999986) + u_xlat3.xyz;
					    u_xlat13.xyz = vec3(u_xlat23) * _LightColor0.xyz;
					    u_xlat11 = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat5.xyz = vec3(u_xlat11) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xzw * u_xlat13.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat13;
					vec3 u_xlat15;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat37 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat37 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat37 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat37 = u_xlat37 + u_xlat37;
					    u_xlat15.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat37)) + (-u_xlat1.xyz);
					    u_xlat5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat37 = log2(u_xlat5.w);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.x;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat37);
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = log2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat8.xyz = vec3(u_xlat26) * u_xlat15.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat26 = min(u_xlat9.z, u_xlat26);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, 6.0);
					        u_xlat26 = u_xlat8.w + -1.0;
					        u_xlat26 = unity_SpecCube1_HDR.w * u_xlat26 + 1.0;
					        u_xlat26 = log2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.y;
					        u_xlat26 = exp2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat13.xyz = u_xlat4.xyz * u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat13.xyz;
					    u_xlat13.xyz = u_xlat7.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat36 = (-u_xlat1.x) + 1.0;
					    u_xlat36 = u_xlat36 * u_xlat36;
					    u_xlat36 = u_xlat36 * u_xlat36;
					    u_xlat36 = u_xlat36 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat13.xyz * vec3(u_xlat36) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    u_xlat36 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat36 = (-u_xlat36) + 1.0;
					    u_xlat36 = u_xlat36 * _ProjectionParams.z;
					    u_xlat36 = max(u_xlat36, 0.0);
					    u_xlat36 = u_xlat36 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec3 u_xlat15;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat36;
					float u_xlat37;
					float u_xlat41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat37 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat37 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat37 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat37 = u_xlat37 + u_xlat37;
					    u_xlat15.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat37)) + (-u_xlat1.xyz);
					    u_xlat5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat37 = log2(u_xlat5.w);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.x;
					    u_xlatb26 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb26){
					        u_xlat26 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat26 = inversesqrt(u_xlat26);
					        u_xlat6.xyz = vec3(u_xlat26) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat26 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat26 = min(u_xlat7.z, u_xlat26);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat26) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat26 = u_xlat6.w + -1.0;
					    u_xlat26 = unity_SpecCube0_HDR.w * u_xlat26 + 1.0;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * unity_SpecCube0_HDR.y;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat26 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat26);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat8.xyz = u_xlat15.xyz * vec3(u_xlat41);
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat41 = min(u_xlat9.z, u_xlat41);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat41) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, 6.0);
					        u_xlat15.x = u_xlat8.w + -1.0;
					        u_xlat15.x = unity_SpecCube1_HDR.w * u_xlat15.x + 1.0;
					        u_xlat15.x = log2(u_xlat15.x);
					        u_xlat15.x = u_xlat15.x * unity_SpecCube1_HDR.y;
					        u_xlat15.x = exp2(u_xlat15.x);
					        u_xlat15.x = u_xlat15.x * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * u_xlat15.xxx;
					        u_xlat6.xyz = vec3(u_xlat26) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat26 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat26 = inversesqrt(u_xlat26);
					    u_xlat15.xyz = vec3(u_xlat26) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat24 * u_xlat24;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat24 = u_xlat24 * u_xlat13;
					    u_xlat24 = u_xlat12.x * u_xlat24 + 1.0;
					    u_xlat13 = -abs(u_xlat36) + 1.0;
					    u_xlat25 = u_xlat13 * u_xlat13;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat13 = u_xlat13 * u_xlat25;
					    u_xlat12.x = u_xlat12.x * u_xlat13 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24;
					    u_xlat24 = abs(u_xlat36) + u_xlat1.x;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat12.y = u_xlat24 * 0.999999881;
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat15.xyz = u_xlat12.xxx * _LightColor0.xyz;
					    u_xlat1.xzw = vec3(u_xlat37) * u_xlat5.xyz + u_xlat15.xyz;
					    u_xlat12.xyz = u_xlat12.yyy * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat26 = u_xlat0.x * u_xlat0.x;
					    u_xlat26 = u_xlat26 * u_xlat26;
					    u_xlat0.x = u_xlat0.x * u_xlat26;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat7.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat36 = u_xlat13 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(u_xlat36) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    u_xlat36 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat36 = (-u_xlat36) + 1.0;
					    u_xlat36 = u_xlat36 * _ProjectionParams.z;
					    u_xlat36 = max(u_xlat36, 0.0);
					    u_xlat36 = u_xlat36 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat11;
					vec3 u_xlat13;
					float u_xlat15;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb33)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat33 = max(u_xlat33, u_xlat23);
					        u_xlat4.x = min(u_xlat15, u_xlat33);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD2.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4 = vs_TEXCOORD2.yzzx * vs_TEXCOORD2.xyzz;
					    u_xlat6.x = dot(unity_SHBr, u_xlat4);
					    u_xlat6.y = dot(unity_SHBg, u_xlat4);
					    u_xlat6.z = dot(unity_SHBb, u_xlat4);
					    u_xlat33 = vs_TEXCOORD2.y * vs_TEXCOORD2.y;
					    u_xlat33 = vs_TEXCOORD2.x * vs_TEXCOORD2.x + (-u_xlat33);
					    u_xlat4.xyz = unity_SHC.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat5.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = vec3(u_xlat33) * u_xlat5.xyz + u_xlat4.xyz;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat13.xyz);
					    u_xlat23 = u_xlat33 + u_xlat33;
					    u_xlat0.xyz = u_xlat13.xyz * (-vec3(u_xlat23)) + u_xlat0.xyz;
					    u_xlat23 = dot(u_xlat13.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat33 = u_xlat33;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat5.y = (-u_xlat33) + 1.0;
					    u_xlat5.zw = u_xlat5.xy * u_xlat5.xy;
					    u_xlat0.xy = u_xlat5.xy * u_xlat5.xw;
					    u_xlat0.xy = u_xlat5.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat5 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.xzw = u_xlat5.xxx * vec3(0.639999986, 0.639999986, 0.639999986) + u_xlat3.xyz;
					    u_xlat13.xyz = vec3(u_xlat23) * _LightColor0.xyz;
					    u_xlat11 = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat5.xyz = vec3(u_xlat11) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xzw * u_xlat13.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat13;
					vec3 u_xlat15;
					float u_xlat17;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat37 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat37 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat37 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat37 = u_xlat37 + u_xlat37;
					    u_xlat15.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat37)) + (-u_xlat1.xyz);
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD3.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat17 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat26);
					        u_xlat5.x = min(u_xlat17, u_xlat37);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD2.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5 = vs_TEXCOORD2.yzzx * vs_TEXCOORD2.xyzz;
					    u_xlat7.x = dot(unity_SHBr, u_xlat5);
					    u_xlat7.y = dot(unity_SHBg, u_xlat5);
					    u_xlat7.z = dot(unity_SHBb, u_xlat5);
					    u_xlat37 = vs_TEXCOORD2.y * vs_TEXCOORD2.y;
					    u_xlat37 = vs_TEXCOORD2.x * vs_TEXCOORD2.x + (-u_xlat37);
					    u_xlat5.xyz = unity_SHC.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat6.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat37 = log2(u_xlat6.w);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.x;
					    u_xlat5.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat5.xyz;
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = log2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat8.xyz = vec3(u_xlat26) * u_xlat15.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat26 = min(u_xlat9.z, u_xlat26);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, 6.0);
					        u_xlat26 = u_xlat8.w + -1.0;
					        u_xlat26 = unity_SpecCube1_HDR.w * u_xlat26 + 1.0;
					        u_xlat26 = log2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.y;
					        u_xlat26 = exp2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.xyz = u_xlat0.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat13.xyz = u_xlat4.xyz * u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat13.xyz;
					    u_xlat13.xyz = u_xlat7.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat36 = (-u_xlat1.x) + 1.0;
					    u_xlat36 = u_xlat36 * u_xlat36;
					    u_xlat36 = u_xlat36 * u_xlat36;
					    u_xlat36 = u_xlat36 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat13.xyz * vec3(u_xlat36) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    u_xlat36 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat36 = (-u_xlat36) + 1.0;
					    u_xlat36 = u_xlat36 * _ProjectionParams.z;
					    u_xlat36 = max(u_xlat36, 0.0);
					    u_xlat36 = u_xlat36 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec3 u_xlat15;
					float u_xlat17;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat37 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat37 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat2.xyw = u_xlat4.xyz * vec3(_Emissive_intensity);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat37 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat37 = u_xlat37 + u_xlat37;
					    u_xlat15.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat37)) + (-u_xlat1.xyz);
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD3.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat17 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat26);
					        u_xlat5.x = min(u_xlat17, u_xlat37);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat6, u_xlat8);
					        u_xlat6.y = dot(u_xlat7, u_xlat8);
					        u_xlat6.z = dot(u_xlat5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD2.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    }
					    u_xlat5 = vs_TEXCOORD2.yzzx * vs_TEXCOORD2.xyzz;
					    u_xlat7.x = dot(unity_SHBr, u_xlat5);
					    u_xlat7.y = dot(unity_SHBg, u_xlat5);
					    u_xlat7.z = dot(unity_SHBb, u_xlat5);
					    u_xlat37 = vs_TEXCOORD2.y * vs_TEXCOORD2.y;
					    u_xlat37 = vs_TEXCOORD2.x * vs_TEXCOORD2.x + (-u_xlat37);
					    u_xlat5.xyz = unity_SHC.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat6.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat37 = log2(u_xlat6.w);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_Lightmap_HDR.x;
					    u_xlat5.xyz = vec3(u_xlat37) * u_xlat6.xyz + u_xlat5.xyz;
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat15.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat15.xyz;
					    }
					    u_xlat6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 6.0);
					    u_xlat37 = u_xlat6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat37 + 1.0;
					    u_xlat37 = log2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.y;
					    u_xlat37 = exp2(u_xlat37);
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat6.xyz * vec3(u_xlat37);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat8.xyz = vec3(u_xlat26) * u_xlat15.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat26 = min(u_xlat9.z, u_xlat26);
					            u_xlat9.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26) + u_xlat9.xyz;
					        }
					        u_xlat8 = textureLod(unity_SpecCube1, u_xlat15.xyz, 6.0);
					        u_xlat26 = u_xlat8.w + -1.0;
					        u_xlat26 = unity_SpecCube1_HDR.w * u_xlat26 + 1.0;
					        u_xlat26 = log2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.y;
					        u_xlat26 = exp2(u_xlat26);
					        u_xlat26 = u_xlat26 * unity_SpecCube1_HDR.x;
					        u_xlat15.xyz = u_xlat8.xyz * vec3(u_xlat26);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz + (-u_xlat15.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat15.xyz;
					    }
					    u_xlat37 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat15.xyz = vec3(u_xlat37) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat15.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat15.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat24 * u_xlat24;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat24 = u_xlat24 * u_xlat13;
					    u_xlat24 = u_xlat12.x * u_xlat24 + 1.0;
					    u_xlat13 = -abs(u_xlat36) + 1.0;
					    u_xlat25 = u_xlat13 * u_xlat13;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat13 = u_xlat13 * u_xlat25;
					    u_xlat12.x = u_xlat12.x * u_xlat13 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24;
					    u_xlat24 = abs(u_xlat36) + u_xlat1.x;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat12.y = u_xlat24 * 0.999999881;
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat1.xzw = _LightColor0.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat12.yyy * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat26 = u_xlat0.x * u_xlat0.x;
					    u_xlat26 = u_xlat26 * u_xlat26;
					    u_xlat0.x = u_xlat0.x * u_xlat26;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat1.xzw = u_xlat7.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat36 = u_xlat13 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(u_xlat36) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat4.www * u_xlat2.xyw + u_xlat0.xyz;
					    u_xlat36 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat36 = (-u_xlat36) + 1.0;
					    u_xlat36 = u_xlat36 * _ProjectionParams.z;
					    u_xlat36 = max(u_xlat36, 0.0);
					    u_xlat36 = u_xlat36 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat11;
					vec3 u_xlat13;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat4.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat13.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat11 = u_xlat0.x * u_xlat0.x;
					    u_xlat11 = u_xlat0.x * u_xlat11;
					    u_xlat0.x = u_xlat0.x * u_xlat11;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					vec3 u_xlat13;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat4.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat13.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat6.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					vec3 u_xlat13;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat4.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat13.xyz, u_xlat0.xyz);
					    u_xlat11.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat23 = u_xlat0.x * u_xlat0.x;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat0.x = u_xlat0.x * u_xlat23;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat11;
					vec3 u_xlat13;
					float u_xlat15;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb33)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat33 = max(u_xlat33, u_xlat23);
					        u_xlat4.x = min(u_xlat15, u_xlat33);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD2.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4 = vs_TEXCOORD2.yzzx * vs_TEXCOORD2.xyzz;
					    u_xlat6.x = dot(unity_SHBr, u_xlat4);
					    u_xlat6.y = dot(unity_SHBg, u_xlat4);
					    u_xlat6.z = dot(unity_SHBb, u_xlat4);
					    u_xlat33 = vs_TEXCOORD2.y * vs_TEXCOORD2.y;
					    u_xlat33 = vs_TEXCOORD2.x * vs_TEXCOORD2.x + (-u_xlat33);
					    u_xlat4.xyz = unity_SHC.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat5.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = vec3(u_xlat33) * u_xlat5.xyz + u_xlat4.xyz;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat13.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat11 = u_xlat0.x * u_xlat0.x;
					    u_xlat11 = u_xlat0.x * u_xlat11;
					    u_xlat0.x = u_xlat0.x * u_xlat11;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					vec3 u_xlat13;
					float u_xlat15;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb33)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat33 = max(u_xlat33, u_xlat23);
					        u_xlat4.x = min(u_xlat15, u_xlat33);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD2.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4 = vs_TEXCOORD2.yzzx * vs_TEXCOORD2.xyzz;
					    u_xlat6.x = dot(unity_SHBr, u_xlat4);
					    u_xlat6.y = dot(unity_SHBg, u_xlat4);
					    u_xlat6.z = dot(unity_SHBb, u_xlat4);
					    u_xlat33 = vs_TEXCOORD2.y * vs_TEXCOORD2.y;
					    u_xlat33 = vs_TEXCOORD2.x * vs_TEXCOORD2.x + (-u_xlat33);
					    u_xlat4.xyz = unity_SHC.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat5.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = vec3(u_xlat33) * u_xlat5.xyz + u_xlat4.xyz;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat13.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat6.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						float _Emissive_intensity;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					vec3 u_xlat13;
					float u_xlat15;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat33 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat33 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat1.xyw = u_xlat3.xyz * vec3(_Emissive_intensity);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat13.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb33)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat33 = max(u_xlat33, u_xlat23);
					        u_xlat4.x = min(u_xlat15, u_xlat33);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD2.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4 = vs_TEXCOORD2.yzzx * vs_TEXCOORD2.xyzz;
					    u_xlat6.x = dot(unity_SHBr, u_xlat4);
					    u_xlat6.y = dot(unity_SHBg, u_xlat4);
					    u_xlat6.z = dot(unity_SHBb, u_xlat4);
					    u_xlat33 = vs_TEXCOORD2.y * vs_TEXCOORD2.y;
					    u_xlat33 = vs_TEXCOORD2.x * vs_TEXCOORD2.x + (-u_xlat33);
					    u_xlat4.xyz = unity_SHC.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat33 = log2(u_xlat5.w);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_Lightmap_HDR.x;
					    u_xlat4.xyz = vec3(u_xlat33) * u_xlat5.xyz + u_xlat4.xyz;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat13.xyz, u_xlat13.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat13.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat13.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat33 = u_xlat5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat33);
					    u_xlatb23 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb23){
					        u_xlatb23 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb23){
					            u_xlat23 = dot(u_xlat13.xyz, u_xlat13.xyz);
					            u_xlat23 = inversesqrt(u_xlat23);
					            u_xlat7.xyz = vec3(u_xlat23) * u_xlat13.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat23 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat23 = min(u_xlat8.z, u_xlat23);
					            u_xlat8.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat13.xyz, 6.0);
					        u_xlat23 = u_xlat7.w + -1.0;
					        u_xlat23 = unity_SpecCube1_HDR.w * u_xlat23 + 1.0;
					        u_xlat23 = log2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.y;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat23 = u_xlat23 * unity_SpecCube1_HDR.x;
					        u_xlat13.xyz = u_xlat7.xyz * vec3(u_xlat23);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat5.xyz + (-u_xlat13.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat13.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat13.xyz = vec3(u_xlat33) * vs_TEXCOORD2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat13.xyz, u_xlat0.xyz);
					    u_xlat11.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat23 = u_xlat0.x * u_xlat0.x;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat0.x = u_xlat0.x * u_xlat23;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat3.www * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 94148
			Program "vp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD4.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD4.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD4.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat6 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD4.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD4.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[2];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_6;
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = textureLod(_fx_skill_mine_cloud_tex, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Deformation_scale);
					    u_xlat9 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD4.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat7;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat15 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat15 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat7.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat7.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat7.xyz;
					    u_xlat7.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat7.xyz;
					    u_xlat7.xyz = u_xlat7.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb15)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat15, u_xlat16);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat3 = texture(_LightTexture0, vec2(u_xlat16));
					    u_xlat15 = u_xlat15 * u_xlat3.x;
					    u_xlat7.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD2.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat15 = u_xlat15 + u_xlat15;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat15)) + u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat7.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat16 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat16 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat7.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat7.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat7.xyz;
					    u_xlat7.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat7.xyz;
					    u_xlat7.xyz = u_xlat7.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb16)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat8 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat8);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat3 = texture(_LightTexture0, u_xlat7.xx);
					    u_xlat16 = u_xlat16 * u_xlat3.x;
					    u_xlat7.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					vec3 u_xlat9;
					float u_xlat12;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat3 = texture(_fx_skill_mine_cloud_tex, u_xlat3.xy);
					    u_xlat19 = (-_min) + _max;
					    u_xlat4.y = u_xlat3.y * u_xlat19 + _min;
					    u_xlat4.xz = vs_TEXCOORD0.zz;
					    u_xlat5 = texture(_Tex_gradient, u_xlat4.xy);
					    u_xlat4.w = (-u_xlat3.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat4.zw);
					    u_xlat9.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat9.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat9.xyz;
					    u_xlat9.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat9.xyz;
					    u_xlat9.xyz = u_xlat9.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb19)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat20 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat19, u_xlat20);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat20 = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat4 = texture(_LightTexture0, vec2(u_xlat20));
					    u_xlat19 = u_xlat19 * u_xlat4.x;
					    u_xlat9.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat4.xyz = vec3(u_xlat19) * vs_TEXCOORD2.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat2.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat19 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat19) + 1.0;
					    u_xlat1.x = u_xlat12 * u_xlat12;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat12 = u_xlat12 * u_xlat1.x;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat1.x = -abs(u_xlat18) + 1.0;
					    u_xlat7 = u_xlat1.x * u_xlat1.x;
					    u_xlat7 = u_xlat7 * u_xlat7;
					    u_xlat1.x = u_xlat1.x * u_xlat7;
					    u_xlat6.x = u_xlat6.x * u_xlat1.x + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = abs(u_xlat18) + u_xlat19;
					    u_xlat12 = u_xlat12 + 9.99999975e-06;
					    u_xlat12 = 0.5 / u_xlat12;
					    u_xlat6.y = u_xlat12 * 0.999999881;
					    u_xlat6.xy = vec2(u_xlat19) * u_xlat6.xy;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat9.xyz;
					    u_xlat6.xyz = u_xlat9.xyz * u_xlat6.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_6[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					float u_xlat12;
					bool u_xlatb12;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat12 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat12 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat1 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb12)) ? u_xlat5.xyz : vs_TEXCOORD3.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat5.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12, u_xlat5.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat5.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat12)) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat5.xyz = vec3(u_xlat12) * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat5.xyz;
					    SV_Target0.w = u_xlat1.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_6[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					bool u_xlatb5;
					float u_xlat9;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat1.x = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat1.x + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat1 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlatb5 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb5){
					        u_xlatb5 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb5)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat5.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9, u_xlat5.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat5.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    SV_Target0.w = u_xlat1.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_6[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					vec3 u_xlat7;
					float u_xlat10;
					float u_xlat11;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat16 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat16 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb16)) ? u_xlat7.xyz : vs_TEXCOORD3.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat7.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat7.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat7.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat5.x = u_xlat5.x + -0.5;
					    u_xlat10 = (-u_xlat1.x) + 1.0;
					    u_xlat6 = u_xlat10 * u_xlat10;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat10 = u_xlat10 * u_xlat6;
					    u_xlat10 = u_xlat5.x * u_xlat10 + 1.0;
					    u_xlat6 = -abs(u_xlat15) + 1.0;
					    u_xlat11 = u_xlat6 * u_xlat6;
					    u_xlat11 = u_xlat11 * u_xlat11;
					    u_xlat6 = u_xlat6 * u_xlat11;
					    u_xlat5.x = u_xlat5.x * u_xlat6 + 1.0;
					    u_xlat5.x = u_xlat5.x * u_xlat10;
					    u_xlat10 = abs(u_xlat15) + u_xlat1.x;
					    u_xlat10 = u_xlat10 + 9.99999975e-06;
					    u_xlat10 = 0.5 / u_xlat10;
					    u_xlat5.y = u_xlat10 * 0.999999881;
					    u_xlat5.xy = u_xlat1.xx * u_xlat5.xy;
					    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz;
					    u_xlat5.xyz = u_xlat7.xyz * u_xlat5.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat16 = u_xlat0.x * u_xlat0.x;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat0.x = u_xlat0.x * u_xlat16;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat8;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat18 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat18 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat3 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat3 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat3;
					    u_xlat3 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat3;
					    u_xlat3 = u_xlat3 + unity_WorldToLight[3];
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat8.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat8.xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat8.xyz = (bool(u_xlatb18)) ? u_xlat8.xyz : vs_TEXCOORD3.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat8.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat18, u_xlat19);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlatb19 = 0.0<u_xlat3.z;
					    u_xlat19 = u_xlatb19 ? 1.0 : float(0.0);
					    u_xlat8.xy = u_xlat3.xy / u_xlat3.ww;
					    u_xlat8.xy = u_xlat8.xy + vec2(0.5, 0.5);
					    u_xlat5 = texture(_LightTexture0, u_xlat8.xy);
					    u_xlat19 = u_xlat19 * u_xlat5.w;
					    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat8.xx);
					    u_xlat19 = u_xlat19 * u_xlat3.x;
					    u_xlat18 = u_xlat18 * u_xlat19;
					    u_xlat8.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat3.xyz = vec3(u_xlat18) * vs_TEXCOORD2.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat18)) + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat8;
					bool u_xlatb8;
					vec2 u_xlat14;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat19 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat19 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat3 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat3 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat3;
					    u_xlat3 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat3;
					    u_xlat3 = u_xlat3 + unity_WorldToLight[3];
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat8.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat8.xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat8.xyz = (bool(u_xlatb19)) ? u_xlat8.xyz : vs_TEXCOORD3.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat8.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat8.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat19, u_xlat8.x);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlatb8 = 0.0<u_xlat3.z;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat14.xy = u_xlat3.xy / u_xlat3.ww;
					    u_xlat14.xy = u_xlat14.xy + vec2(0.5, 0.5);
					    u_xlat5 = texture(_LightTexture0, u_xlat14.xy);
					    u_xlat8.x = u_xlat8.x * u_xlat5.w;
					    u_xlat14.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat14.xx);
					    u_xlat8.x = u_xlat8.x * u_xlat3.x;
					    u_xlat19 = u_xlat19 * u_xlat8.x;
					    u_xlat8.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat8.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					vec3 u_xlat10;
					float u_xlat14;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					bool u_xlatb23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat3 = texture(_fx_skill_mine_cloud_tex, u_xlat3.xy);
					    u_xlat22 = (-_min) + _max;
					    u_xlat4.y = u_xlat3.y * u_xlat22 + _min;
					    u_xlat4.xz = vs_TEXCOORD0.zz;
					    u_xlat5 = texture(_Tex_gradient, u_xlat4.xy);
					    u_xlat4.w = (-u_xlat3.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat4.zw);
					    u_xlat4 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat10.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat10.xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat10.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb22)) ? u_xlat10.xyz : vs_TEXCOORD3.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat22, u_xlat23);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb23 = 0.0<u_xlat4.z;
					    u_xlat23 = u_xlatb23 ? 1.0 : float(0.0);
					    u_xlat10.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat10.xy = u_xlat10.xy + vec2(0.5, 0.5);
					    u_xlat6 = texture(_LightTexture0, u_xlat10.xy);
					    u_xlat23 = u_xlat23 * u_xlat6.w;
					    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTextureB0, u_xlat10.xx);
					    u_xlat23 = u_xlat23 * u_xlat4.x;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat10.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD2.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat22) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat22;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat7.y = u_xlat14 * 0.999999881;
					    u_xlat7.xy = vec2(u_xlat22) * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat10.xyz;
					    u_xlat7.xyz = u_xlat10.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat8;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat18 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat18 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat8.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat8.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat8.xyz;
					    u_xlat8.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat8.xyz;
					    u_xlat8.xyz = u_xlat8.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat19));
					    u_xlat5 = texture(_LightTexture0, u_xlat8.xyz);
					    u_xlat19 = u_xlat3.x * u_xlat5.w;
					    u_xlat18 = u_xlat18 * u_xlat19;
					    u_xlat8.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat3.xyz = vec3(u_xlat18) * vs_TEXCOORD2.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat18)) + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat19 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat19 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat8.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat8.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat8.xyz;
					    u_xlat8.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat8.xyz;
					    u_xlat8.xyz = u_xlat8.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb19)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat19, u_xlat9);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat3.xx);
					    u_xlat5 = texture(_LightTexture0, u_xlat8.xyz);
					    u_xlat8.x = u_xlat3.x * u_xlat5.w;
					    u_xlat19 = u_xlat19 * u_xlat8.x;
					    u_xlat8.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat8.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					vec3 u_xlat10;
					float u_xlat14;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat3 = texture(_fx_skill_mine_cloud_tex, u_xlat3.xy);
					    u_xlat22 = (-_min) + _max;
					    u_xlat4.y = u_xlat3.y * u_xlat22 + _min;
					    u_xlat4.xz = vs_TEXCOORD0.zz;
					    u_xlat5 = texture(_Tex_gradient, u_xlat4.xy);
					    u_xlat4.w = (-u_xlat3.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat4.zw);
					    u_xlat10.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat10.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat10.xyz;
					    u_xlat10.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat22, u_xlat23);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat23 = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat23));
					    u_xlat6 = texture(_LightTexture0, u_xlat10.xyz);
					    u_xlat23 = u_xlat4.x * u_xlat6.w;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat10.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD2.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat22) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat22;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat7.y = u_xlat14 * 0.999999881;
					    u_xlat7.xy = vec2(u_xlat22) * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat10.xyz;
					    u_xlat7.xyz = u_xlat10.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat12 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat12 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat1 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat5.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat5.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat5.xy;
					    u_xlat5.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + unity_WorldToLight[3].xy;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb12)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12, u_xlat13);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat12 = u_xlat12 * u_xlat2.w;
					    u_xlat5.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat12)) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat5.xyz = vec3(u_xlat12) * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat5.xyz;
					    SV_Target0.w = u_xlat1.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat1.x = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat1.x + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat1 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat5.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat5.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat5.xy;
					    u_xlat5.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + unity_WorldToLight[3].xy;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13, u_xlat6);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat5.x = u_xlat13 * u_xlat2.w;
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    SV_Target0.w = u_xlat1.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					vec3 u_xlat7;
					float u_xlat10;
					float u_xlat11;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat16 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat16 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat7.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat7.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat7.xy;
					    u_xlat7.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat7.xy;
					    u_xlat7.xy = u_xlat7.xy + unity_WorldToLight[3].xy;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb16)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat17);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat3 = texture(_LightTexture0, u_xlat7.xy);
					    u_xlat16 = u_xlat16 * u_xlat3.w;
					    u_xlat7.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat5.x = u_xlat5.x + -0.5;
					    u_xlat10 = (-u_xlat1.x) + 1.0;
					    u_xlat6 = u_xlat10 * u_xlat10;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat10 = u_xlat10 * u_xlat6;
					    u_xlat10 = u_xlat5.x * u_xlat10 + 1.0;
					    u_xlat6 = -abs(u_xlat15) + 1.0;
					    u_xlat11 = u_xlat6 * u_xlat6;
					    u_xlat11 = u_xlat11 * u_xlat11;
					    u_xlat6 = u_xlat6 * u_xlat11;
					    u_xlat5.x = u_xlat5.x * u_xlat6 + 1.0;
					    u_xlat5.x = u_xlat5.x * u_xlat10;
					    u_xlat10 = abs(u_xlat15) + u_xlat1.x;
					    u_xlat10 = u_xlat10 + 9.99999975e-06;
					    u_xlat10 = 0.5 / u_xlat10;
					    u_xlat5.y = u_xlat10 * 0.999999881;
					    u_xlat5.xy = u_xlat1.xx * u_xlat5.xy;
					    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz;
					    u_xlat5.xyz = u_xlat7.xyz * u_xlat5.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat16 = u_xlat0.x * u_xlat0.x;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat0.x = u_xlat0.x * u_xlat16;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat7;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat15 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat15 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat7.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat7.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat7.xyz;
					    u_xlat7.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat7.xyz;
					    u_xlat7.xyz = u_xlat7.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb15)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat15, u_xlat16);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat3 = texture(_LightTexture0, vec2(u_xlat16));
					    u_xlat15 = u_xlat15 * u_xlat3.x;
					    u_xlat7.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD2.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat15 = u_xlat15 + u_xlat15;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat15)) + u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat15 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat16 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat16 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat7.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat7.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat7.xyz;
					    u_xlat7.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat7.xyz;
					    u_xlat7.xyz = u_xlat7.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb16)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat8 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat8);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat3 = texture(_LightTexture0, u_xlat7.xx);
					    u_xlat16 = u_xlat16 * u_xlat3.x;
					    u_xlat7.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					vec3 u_xlat9;
					float u_xlat12;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat3 = texture(_fx_skill_mine_cloud_tex, u_xlat3.xy);
					    u_xlat19 = (-_min) + _max;
					    u_xlat4.y = u_xlat3.y * u_xlat19 + _min;
					    u_xlat4.xz = vs_TEXCOORD0.zz;
					    u_xlat5 = texture(_Tex_gradient, u_xlat4.xy);
					    u_xlat4.w = (-u_xlat3.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat4.zw);
					    u_xlat9.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat9.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat9.xyz;
					    u_xlat9.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat9.xyz;
					    u_xlat9.xyz = u_xlat9.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb19)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat20 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat19, u_xlat20);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat20 = dot(u_xlat9.xyz, u_xlat9.xyz);
					    u_xlat4 = texture(_LightTexture0, vec2(u_xlat20));
					    u_xlat19 = u_xlat19 * u_xlat4.x;
					    u_xlat9.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat4.xyz = vec3(u_xlat19) * vs_TEXCOORD2.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat2.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat19 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat19) + 1.0;
					    u_xlat1.x = u_xlat12 * u_xlat12;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat12 = u_xlat12 * u_xlat1.x;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat1.x = -abs(u_xlat18) + 1.0;
					    u_xlat7 = u_xlat1.x * u_xlat1.x;
					    u_xlat7 = u_xlat7 * u_xlat7;
					    u_xlat1.x = u_xlat1.x * u_xlat7;
					    u_xlat6.x = u_xlat6.x * u_xlat1.x + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = abs(u_xlat18) + u_xlat19;
					    u_xlat12 = u_xlat12 + 9.99999975e-06;
					    u_xlat12 = 0.5 / u_xlat12;
					    u_xlat6.y = u_xlat12 * 0.999999881;
					    u_xlat6.xy = vec2(u_xlat19) * u_xlat6.xy;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat9.xyz;
					    u_xlat6.xyz = u_xlat9.xyz * u_xlat6.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_6[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					float u_xlat12;
					bool u_xlatb12;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat12 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat12 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat1 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb12)) ? u_xlat5.xyz : vs_TEXCOORD3.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat5.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12, u_xlat5.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat5.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat12)) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat5.xyz = vec3(u_xlat12) * u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat5.xyz;
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    SV_Target0.w = u_xlat1.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_6[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					bool u_xlatb5;
					float u_xlat9;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat1.x = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat1.x + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat1 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlatb5 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb5){
					        u_xlatb5 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb5)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat5.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9, u_xlat5.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat5.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    SV_Target0.w = u_xlat1.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_6[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					vec3 u_xlat7;
					float u_xlat10;
					float u_xlat11;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat16 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat16 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb16)) ? u_xlat7.xyz : vs_TEXCOORD3.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat7.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat7.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat7.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat5.x = u_xlat5.x + -0.5;
					    u_xlat10 = (-u_xlat1.x) + 1.0;
					    u_xlat6 = u_xlat10 * u_xlat10;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat10 = u_xlat10 * u_xlat6;
					    u_xlat10 = u_xlat5.x * u_xlat10 + 1.0;
					    u_xlat6 = -abs(u_xlat15) + 1.0;
					    u_xlat11 = u_xlat6 * u_xlat6;
					    u_xlat11 = u_xlat11 * u_xlat11;
					    u_xlat6 = u_xlat6 * u_xlat11;
					    u_xlat5.x = u_xlat5.x * u_xlat6 + 1.0;
					    u_xlat5.x = u_xlat5.x * u_xlat10;
					    u_xlat10 = abs(u_xlat15) + u_xlat1.x;
					    u_xlat10 = u_xlat10 + 9.99999975e-06;
					    u_xlat10 = 0.5 / u_xlat10;
					    u_xlat5.y = u_xlat10 * 0.999999881;
					    u_xlat5.xy = u_xlat1.xx * u_xlat5.xy;
					    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz;
					    u_xlat5.xyz = u_xlat7.xyz * u_xlat5.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat16 = u_xlat0.x * u_xlat0.x;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat0.x = u_xlat0.x * u_xlat16;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat15 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat8;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat18 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat18 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat3 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat3 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat3;
					    u_xlat3 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat3;
					    u_xlat3 = u_xlat3 + unity_WorldToLight[3];
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat8.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat8.xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat8.xyz = (bool(u_xlatb18)) ? u_xlat8.xyz : vs_TEXCOORD3.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat8.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat18, u_xlat19);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlatb19 = 0.0<u_xlat3.z;
					    u_xlat19 = u_xlatb19 ? 1.0 : float(0.0);
					    u_xlat8.xy = u_xlat3.xy / u_xlat3.ww;
					    u_xlat8.xy = u_xlat8.xy + vec2(0.5, 0.5);
					    u_xlat5 = texture(_LightTexture0, u_xlat8.xy);
					    u_xlat19 = u_xlat19 * u_xlat5.w;
					    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat8.xx);
					    u_xlat19 = u_xlat19 * u_xlat3.x;
					    u_xlat18 = u_xlat18 * u_xlat19;
					    u_xlat8.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat3.xyz = vec3(u_xlat18) * vs_TEXCOORD2.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat18)) + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat18 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat8;
					bool u_xlatb8;
					vec2 u_xlat14;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat19 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat19 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat3 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat3 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat3;
					    u_xlat3 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat3;
					    u_xlat3 = u_xlat3 + unity_WorldToLight[3];
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat8.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat8.xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat8.xyz = (bool(u_xlatb19)) ? u_xlat8.xyz : vs_TEXCOORD3.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat8.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat8.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat19, u_xlat8.x);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlatb8 = 0.0<u_xlat3.z;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat14.xy = u_xlat3.xy / u_xlat3.ww;
					    u_xlat14.xy = u_xlat14.xy + vec2(0.5, 0.5);
					    u_xlat5 = texture(_LightTexture0, u_xlat14.xy);
					    u_xlat8.x = u_xlat8.x * u_xlat5.w;
					    u_xlat14.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat14.xx);
					    u_xlat8.x = u_xlat8.x * u_xlat3.x;
					    u_xlat19 = u_xlat19 * u_xlat8.x;
					    u_xlat8.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat8.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					vec3 u_xlat10;
					float u_xlat14;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					bool u_xlatb23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat3 = texture(_fx_skill_mine_cloud_tex, u_xlat3.xy);
					    u_xlat22 = (-_min) + _max;
					    u_xlat4.y = u_xlat3.y * u_xlat22 + _min;
					    u_xlat4.xz = vs_TEXCOORD0.zz;
					    u_xlat5 = texture(_Tex_gradient, u_xlat4.xy);
					    u_xlat4.w = (-u_xlat3.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat4.zw);
					    u_xlat4 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat10.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat10.xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat10.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb22)) ? u_xlat10.xyz : vs_TEXCOORD3.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat22, u_xlat23);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb23 = 0.0<u_xlat4.z;
					    u_xlat23 = u_xlatb23 ? 1.0 : float(0.0);
					    u_xlat10.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat10.xy = u_xlat10.xy + vec2(0.5, 0.5);
					    u_xlat6 = texture(_LightTexture0, u_xlat10.xy);
					    u_xlat23 = u_xlat23 * u_xlat6.w;
					    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTextureB0, u_xlat10.xx);
					    u_xlat23 = u_xlat23 * u_xlat4.x;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat10.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD2.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat22) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat22;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat7.y = u_xlat14 * 0.999999881;
					    u_xlat7.xy = vec2(u_xlat22) * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat10.xyz;
					    u_xlat7.xyz = u_xlat10.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat8;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat18 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat18 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat8.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat8.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat8.xyz;
					    u_xlat8.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat8.xyz;
					    u_xlat8.xyz = u_xlat8.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat19));
					    u_xlat5 = texture(_LightTexture0, u_xlat8.xyz);
					    u_xlat19 = u_xlat3.x * u_xlat5.w;
					    u_xlat18 = u_xlat18 * u_xlat19;
					    u_xlat8.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat3.xyz = vec3(u_xlat18) * vs_TEXCOORD2.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat18)) + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat18 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat19 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat19 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat8.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat8.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat8.xyz;
					    u_xlat8.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat8.xyz;
					    u_xlat8.xyz = u_xlat8.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb19)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat19, u_xlat9);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat3.xx);
					    u_xlat5 = texture(_LightTexture0, u_xlat8.xyz);
					    u_xlat8.x = u_xlat3.x * u_xlat5.w;
					    u_xlat19 = u_xlat19 * u_xlat8.x;
					    u_xlat8.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat8.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					vec3 u_xlat10;
					float u_xlat14;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat3 = texture(_fx_skill_mine_cloud_tex, u_xlat3.xy);
					    u_xlat22 = (-_min) + _max;
					    u_xlat4.y = u_xlat3.y * u_xlat22 + _min;
					    u_xlat4.xz = vs_TEXCOORD0.zz;
					    u_xlat5 = texture(_Tex_gradient, u_xlat4.xy);
					    u_xlat4.w = (-u_xlat3.z) + 1.0;
					    u_xlat3 = texture(_TextureSample1, u_xlat4.zw);
					    u_xlat10.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat10.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat10.xyz;
					    u_xlat10.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat22, u_xlat23);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat23 = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat23));
					    u_xlat6 = texture(_LightTexture0, u_xlat10.xyz);
					    u_xlat23 = u_xlat4.x * u_xlat6.w;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat10.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD2.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat22) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat22;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat7.y = u_xlat14 * 0.999999881;
					    u_xlat7.xy = vec2(u_xlat22) * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat10.xyz;
					    u_xlat7.xyz = u_xlat10.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = u_xlat3.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat12 = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat12 + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat1 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat5.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat5.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat5.xy;
					    u_xlat5.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + unity_WorldToLight[3].xy;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb12)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12, u_xlat13);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat12 = u_xlat12 * u_xlat2.w;
					    u_xlat5.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat12)) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat5.xyz = vec3(u_xlat12) * u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat5.xyz;
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    SV_Target0.w = u_xlat1.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = texture(_fx_skill_mine_cloud_tex, u_xlat1.xy);
					    u_xlat1.x = (-_min) + _max;
					    u_xlat2.y = u_xlat1.y * u_xlat1.x + _min;
					    u_xlat2.xz = vs_TEXCOORD0.zz;
					    u_xlat3 = texture(_Tex_gradient, u_xlat2.xy);
					    u_xlat2.w = (-u_xlat1.z) + 1.0;
					    u_xlat1 = texture(_TextureSample1, u_xlat2.zw);
					    u_xlat5.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat5.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat5.xy;
					    u_xlat5.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + unity_WorldToLight[3].xy;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13, u_xlat6);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat5.x = u_xlat13 * u_xlat2.w;
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    SV_Target0.w = u_xlat1.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _min;
						float _max;
						vec4 unused_0_7[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _Tex_gradient;
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					vec3 u_xlat7;
					float u_xlat10;
					float u_xlat11;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat2 = texture(_fx_skill_mine_cloud_tex, u_xlat2.xy);
					    u_xlat16 = (-_min) + _max;
					    u_xlat3.y = u_xlat2.y * u_xlat16 + _min;
					    u_xlat3.xz = vs_TEXCOORD0.zz;
					    u_xlat4 = texture(_Tex_gradient, u_xlat3.xy);
					    u_xlat3.w = (-u_xlat2.z) + 1.0;
					    u_xlat2 = texture(_TextureSample1, u_xlat3.zw);
					    u_xlat7.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat7.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat7.xy;
					    u_xlat7.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat7.xy;
					    u_xlat7.xy = u_xlat7.xy + unity_WorldToLight[3].xy;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb16)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat17);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat3 = texture(_LightTexture0, u_xlat7.xy);
					    u_xlat16 = u_xlat16 * u_xlat3.w;
					    u_xlat7.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat5.x = u_xlat5.x + -0.5;
					    u_xlat10 = (-u_xlat1.x) + 1.0;
					    u_xlat6 = u_xlat10 * u_xlat10;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat10 = u_xlat10 * u_xlat6;
					    u_xlat10 = u_xlat5.x * u_xlat10 + 1.0;
					    u_xlat6 = -abs(u_xlat15) + 1.0;
					    u_xlat11 = u_xlat6 * u_xlat6;
					    u_xlat11 = u_xlat11 * u_xlat11;
					    u_xlat6 = u_xlat6 * u_xlat11;
					    u_xlat5.x = u_xlat5.x * u_xlat6 + 1.0;
					    u_xlat5.x = u_xlat5.x * u_xlat10;
					    u_xlat10 = abs(u_xlat15) + u_xlat1.x;
					    u_xlat10 = u_xlat10 + 9.99999975e-06;
					    u_xlat10 = 0.5 / u_xlat10;
					    u_xlat5.y = u_xlat10 * 0.999999881;
					    u_xlat5.xy = u_xlat1.xx * u_xlat5.xy;
					    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz;
					    u_xlat5.xyz = u_xlat7.xyz * u_xlat5.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat16 = u_xlat0.x * u_xlat0.x;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat0.x = u_xlat0.x * u_xlat16;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat15 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    SV_Target0.w = u_xlat2.x;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "ShadowCaster"
			Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			ColorMask RGB -1
			GpuProgramID 242697
			Program "vp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_2_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_2_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = textureLod(_fx_skill_mine_cloud_tex, u_xlat1.xy, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(_Deformation_scale);
					    u_xlat12 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + in_POSITION0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
					    u_xlat3.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat2.xyz;
					    u_xlatb12 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat2.xyz;
					    u_xlat3 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat13 = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat13 = min(u_xlat13, 0.0);
					    u_xlat13 = max(u_xlat13, -1.0);
					    u_xlat8 = u_xlat0.z + u_xlat13;
					    u_xlat13 = min(u_xlat0.w, u_xlat8);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat8) + u_xlat13;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
					    vs_TEXCOORD1 = in_TEXCOORD0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_2_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_2_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = textureLod(_fx_skill_mine_cloud_tex, u_xlat1.xy, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(_Deformation_scale);
					    u_xlat12 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + in_POSITION0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
					    u_xlat3.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat2.xyz;
					    u_xlatb12 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat2.xyz;
					    u_xlat3 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat13 = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat13 = min(u_xlat13, 0.0);
					    u_xlat13 = max(u_xlat13, -1.0);
					    u_xlat8 = u_xlat0.z + u_xlat13;
					    u_xlat13 = min(u_xlat0.w, u_xlat8);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat8) + u_xlat13;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
					    vs_TEXCOORD1 = in_TEXCOORD0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_2_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_2_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = textureLod(_fx_skill_mine_cloud_tex, u_xlat1.xy, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(_Deformation_scale);
					    u_xlat12 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + in_POSITION0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
					    u_xlat3.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat2.xyz;
					    u_xlatb12 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat2.xyz;
					    u_xlat3 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat13 = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat13 = min(u_xlat13, 0.0);
					    u_xlat13 = max(u_xlat13, -1.0);
					    u_xlat8 = u_xlat0.z + u_xlat13;
					    u_xlat13 = min(u_xlat0.w, u_xlat8);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat8) + u_xlat13;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
					    vs_TEXCOORD1 = in_TEXCOORD0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_2_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_2_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = textureLod(_fx_skill_mine_cloud_tex, u_xlat1.xy, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(_Deformation_scale);
					    u_xlat12 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + in_POSITION0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
					    u_xlat3.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat2.xyz;
					    u_xlatb12 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat2.xyz;
					    u_xlat3 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat13 = min(u_xlat0.w, u_xlat0.z);
					    u_xlat13 = (-u_xlat0.z) + u_xlat13;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat13 + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_TEXCOORD1 = in_TEXCOORD0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_2_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_2_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = textureLod(_fx_skill_mine_cloud_tex, u_xlat1.xy, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(_Deformation_scale);
					    u_xlat12 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + in_POSITION0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
					    u_xlat3.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat2.xyz;
					    u_xlatb12 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat2.xyz;
					    u_xlat3 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat13 = min(u_xlat0.w, u_xlat0.z);
					    u_xlat13 = (-u_xlat0.z) + u_xlat13;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat13 + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_TEXCOORD1 = in_TEXCOORD0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						float _Deformation_scale;
						float _Deformation_TimeOffset;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_2_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_2_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = in_TEXCOORD0.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat1 = textureLod(_fx_skill_mine_cloud_tex, u_xlat1.xy, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(_Deformation_scale);
					    u_xlat12 = in_TEXCOORD0.z + (-_Deformation_TimeOffset);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + in_POSITION0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
					    u_xlat3.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat12 = (-u_xlat12) * u_xlat12 + 1.0;
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat12) + u_xlat2.xyz;
					    u_xlatb12 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : u_xlat2.xyz;
					    u_xlat3 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat13 = min(u_xlat0.w, u_xlat0.z);
					    u_xlat13 = (-u_xlat0.z) + u_xlat13;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat13 + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_TEXCOORD1 = in_TEXCOORD0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						vec4 unused_0_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _TextureSample1;
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD2.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = texture(_fx_skill_mine_cloud_tex, u_xlat0.xy);
					    u_xlat0.y = (-u_xlat0.z) + 1.0;
					    u_xlat0.x = vs_TEXCOORD1.z;
					    u_xlat0 = texture(_TextureSample1, u_xlat0.xy);
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						vec4 unused_0_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _TextureSample1;
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD2.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = texture(_fx_skill_mine_cloud_tex, u_xlat0.xy);
					    u_xlat0.y = (-u_xlat0.z) + 1.0;
					    u_xlat0.x = vs_TEXCOORD1.z;
					    u_xlat0 = texture(_TextureSample1, u_xlat0.xy);
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						vec4 unused_0_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _TextureSample1;
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD2.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = texture(_fx_skill_mine_cloud_tex, u_xlat0.xy);
					    u_xlat0.y = (-u_xlat0.z) + 1.0;
					    u_xlat0.x = vs_TEXCOORD1.z;
					    u_xlat0 = texture(_TextureSample1, u_xlat0.xy);
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						vec4 unused_0_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _TextureSample1;
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD2.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = texture(_fx_skill_mine_cloud_tex, u_xlat0.xy);
					    u_xlat0.y = (-u_xlat0.z) + 1.0;
					    u_xlat0.x = vs_TEXCOORD1.z;
					    u_xlat0 = texture(_TextureSample1, u_xlat0.xy);
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						vec4 unused_0_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _TextureSample1;
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD2.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = texture(_fx_skill_mine_cloud_tex, u_xlat0.xy);
					    u_xlat0.y = (-u_xlat0.z) + 1.0;
					    u_xlat0.x = vs_TEXCOORD1.z;
					    u_xlat0 = texture(_TextureSample1, u_xlat0.xy);
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _fx_skill_mine_cloud_tex_ST;
						vec4 unused_0_2[2];
					};
					uniform  sampler2D _fx_skill_mine_cloud_tex;
					uniform  sampler2D _TextureSample1;
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD2.xy * _fx_skill_mine_cloud_tex_ST.xy + _fx_skill_mine_cloud_tex_ST.zw;
					    u_xlat0 = texture(_fx_skill_mine_cloud_tex, u_xlat0.xy);
					    u_xlat0.y = (-u_xlat0.z) + 1.0;
					    u_xlat0.x = vs_TEXCOORD1.z;
					    u_xlat0 = texture(_TextureSample1, u_xlat0.xy);
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}