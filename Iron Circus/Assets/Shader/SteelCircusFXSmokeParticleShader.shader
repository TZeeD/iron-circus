Shader "SteelCircus/FX/SmokeParticleShader" {
	Properties {
		_MaskTex ("MaskTex", 2D) = "white" {}
		_MainTex ("MainTex", 2D) = "white" {}
		_ScrollSpeed ("ScrollSpeed", Float) = 1
		_Color ("Color", Vector) = (1,0.7202423,0.2720588,1)
		_AlbedoBoost ("AlbedoBoost", Vector) = (0,0,0,1)
		_NormalRange ("NormalRange", Range(0, 1)) = 1
		[HideInInspector] _texcoord ("", 2D) = "white" {}
		[HideInInspector] _tex4coord ("", 2D) = "white" {}
		[HideInInspector] __dirty ("", Float) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 52267
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3 = vec4(u_xlat17) * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat15 * 0.5;
					    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat3.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat3.wwzw + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat3.y * u_xlat3.y;
					    u_xlat15 = u_xlat3.x * u_xlat3.x + (-u_xlat15);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD6.xyz = u_xlat0.xyz + u_xlat1.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3 = vec4(u_xlat17) * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat15 * 0.5;
					    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat3.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat3.wwzw + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat3.y * u_xlat3.y;
					    u_xlat15 = u_xlat3.x * u_xlat3.x + (-u_xlat15);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD6.xyz = u_xlat0.xyz + u_xlat1.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3 = vec4(u_xlat17) * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat15 * 0.5;
					    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat3.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat3.wwzw + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat3.y * u_xlat3.y;
					    u_xlat15 = u_xlat3.x * u_xlat3.x + (-u_xlat15);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD6.xyz = u_xlat0.xyz + u_xlat1.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat11;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat3 = vec4(u_xlat11) * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat15 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat3.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat3.wwzw + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat3.y * u_xlat3.y;
					    u_xlat15 = u_xlat3.x * u_xlat3.x + (-u_xlat15);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD6.xyz = u_xlat0.xyz + u_xlat1.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat11;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat3 = vec4(u_xlat11) * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat15 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat3.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat3.wwzw + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat3.y * u_xlat3.y;
					    u_xlat15 = u_xlat3.x * u_xlat3.x + (-u_xlat15);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD6.xyz = u_xlat0.xyz + u_xlat1.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat11;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat3 = vec4(u_xlat11) * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat15 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat3.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat3.wwzw + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat3.y * u_xlat3.y;
					    u_xlat15 = u_xlat3.x * u_xlat3.x + (-u_xlat15);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD6.xyz = u_xlat0.xyz + u_xlat1.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					float u_xlat15;
					vec2 u_xlat28;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					bool u_xlatb40;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3.x = 0.0;
					    u_xlat3.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat2.xy = u_xlat2.xy + u_xlat3.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat39 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat39) + (-vec2(_NormalRange));
					    u_xlat28.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat39 = u_xlat28.y + u_xlat28.x;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat3.z = sqrt(u_xlat39);
					    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat39 = vs_TEXCOORD5.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD5.zxy / vec3(u_xlat39);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat39 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat39 = float(1.0) / u_xlat39;
					    u_xlat40 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat40 = float(1.0) / u_xlat40;
					    u_xlat39 = u_xlat39 + (-u_xlat40);
					    u_xlat39 = min(abs(u_xlat39), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat40 = u_xlat2.y * u_xlat4.w;
					    u_xlat40 = u_xlat40 * vs_COLOR0.w;
					    u_xlat39 = u_xlat39 * u_xlat40;
					    SV_Target0.w = u_xlat39 * _Color.w;
					    u_xlatb39 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb39){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb40)) ? u_xlat4.xyz : u_xlat0.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat15 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat40, u_xlat15);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat40 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat3.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat15 = dot((-u_xlat1.xyz), u_xlat3.xyz);
					    u_xlat15 = u_xlat15 + u_xlat15;
					    u_xlat4.xyz = u_xlat3.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    if(u_xlatb39){
					        u_xlatb39 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb39)) ? u_xlat6.xyz : u_xlat0.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat39 = u_xlat6.y * 0.25;
					        u_xlat40 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat39 = max(u_xlat39, u_xlat40);
					        u_xlat6.x = min(u_xlat15, u_xlat39);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat3.w = 1.0;
					        u_xlat7.x = dot(u_xlat7, u_xlat3);
					        u_xlat7.y = dot(u_xlat8, u_xlat3);
					        u_xlat7.z = dot(u_xlat6, u_xlat3);
					    } else {
					        u_xlat3.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat3);
					        u_xlat7.y = dot(unity_SHAg, u_xlat3);
					        u_xlat7.z = dot(unity_SHAb, u_xlat3);
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD6.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb39 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb39){
					        u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat39 = inversesqrt(u_xlat39);
					        u_xlat7.xyz = vec3(u_xlat39) * u_xlat4.xyz;
					        u_xlat8.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat39 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat39 = min(u_xlat8.z, u_xlat39);
					        u_xlat8.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat39) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    }
					    u_xlat7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 6.0);
					    u_xlat39 = u_xlat7.w + -1.0;
					    u_xlat39 = unity_SpecCube0_HDR.w * u_xlat39 + 1.0;
					    u_xlat39 = log2(u_xlat39);
					    u_xlat39 = u_xlat39 * unity_SpecCube0_HDR.y;
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat39 = u_xlat39 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat7.xyz * vec3(u_xlat39);
					    u_xlatb40 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb40){
					        u_xlatb40 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb40){
					            u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat40 = inversesqrt(u_xlat40);
					            u_xlat9.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					            u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat40 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat40 = min(u_xlat10.z, u_xlat40);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat40) + u_xlat0.xyz;
					        }
					        u_xlat4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 6.0);
					        u_xlat0.x = u_xlat4.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat0.x + 1.0;
					        u_xlat0.x = log2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.y;
					        u_xlat0.x = exp2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					        u_xlat4.xyz = vec3(u_xlat39) * u_xlat7.xyz + (-u_xlat0.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat39 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat40 = u_xlat39 + u_xlat39;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat40)) + u_xlat1.xyz;
					    u_xlat40 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat39 = u_xlat39;
					    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.y = (-u_xlat39) + 1.0;
					    u_xlat2.zw = u_xlat2.xy * u_xlat2.xy;
					    u_xlat1.xy = u_xlat2.xy * u_xlat2.xw;
					    u_xlat1.xy = u_xlat2.zy * u_xlat1.xy;
					    u_xlat1.z = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat1.xz);
					    u_xlat2.xyz = u_xlat2.xxx * vec3(0.639999986, 0.639999986, 0.639999986) + u_xlat0.xyz;
					    u_xlat1.xzw = vec3(u_xlat40) * u_xlat5.xyz;
					    u_xlat39 = u_xlat1.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat0.xyz + u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xzw + u_xlat0.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					bvec3 u_xlatb13;
					float u_xlat17;
					vec2 u_xlat31;
					float u_xlat42;
					float u_xlat43;
					bool u_xlatb43;
					float u_xlat44;
					bool u_xlatb44;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat2.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4.x = 0.0;
					    u_xlat4.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat3.xy = u_xlat3.xy + u_xlat4.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat43 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat43) + (-vec2(_NormalRange));
					    u_xlat31.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat43 = u_xlat31.y + u_xlat31.x;
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat4.z = sqrt(u_xlat43);
					    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat43 = inversesqrt(u_xlat43);
					    u_xlat4.xyz = vec3(u_xlat43) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat43 = vs_TEXCOORD5.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD5.zxy / vec3(u_xlat43);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat43 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat43 = float(1.0) / u_xlat43;
					    u_xlat44 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat44 = float(1.0) / u_xlat44;
					    u_xlat43 = u_xlat43 + (-u_xlat44);
					    u_xlat43 = min(abs(u_xlat43), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat44 = u_xlat3.y * u_xlat5.w;
					    u_xlat44 = u_xlat44 * vs_COLOR0.w;
					    u_xlat43 = u_xlat43 * u_xlat44;
					    SV_Target0.w = u_xlat43 * _Color.w;
					    u_xlatb43 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb43){
					        u_xlatb44 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb44)) ? u_xlat5.xyz : u_xlat0.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat44 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat44, u_xlat17);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat44 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat17 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat5.xyz;
					    u_xlat17 = dot((-u_xlat2.xyz), u_xlat4.xyz);
					    u_xlat17 = u_xlat17 + u_xlat17;
					    u_xlat5.xyz = u_xlat4.xyz * (-vec3(u_xlat17)) + (-u_xlat2.xyz);
					    u_xlat6.xyz = vec3(u_xlat44) * _LightColor0.xyz;
					    if(u_xlatb43){
					        u_xlatb43 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb43)) ? u_xlat7.xyz : u_xlat0.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat43 = u_xlat7.y * 0.25;
					        u_xlat44 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat17 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat43 = max(u_xlat43, u_xlat44);
					        u_xlat7.x = min(u_xlat17, u_xlat43);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					        u_xlat9.xyz = u_xlat7.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat9 = texture(unity_ProbeVolumeSH, u_xlat9.xyz);
					        u_xlat7.xyz = u_xlat7.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(u_xlat8, u_xlat4);
					        u_xlat8.y = dot(u_xlat9, u_xlat4);
					        u_xlat8.z = dot(u_xlat7, u_xlat4);
					    } else {
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(unity_SHAr, u_xlat4);
					        u_xlat8.y = dot(unity_SHAg, u_xlat4);
					        u_xlat8.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat7.xyz = u_xlat8.xyz + vs_TEXCOORD6.xyz;
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb43 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb43){
					        u_xlat43 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat43 = inversesqrt(u_xlat43);
					        u_xlat8.xyz = vec3(u_xlat43) * u_xlat5.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					        u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					        u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat9;
					            hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					            hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					            hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					            u_xlat9 = hlslcc_movcTemp;
					        }
					        u_xlat43 = min(u_xlat9.y, u_xlat9.x);
					        u_xlat43 = min(u_xlat9.z, u_xlat43);
					        u_xlat9.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat43) + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat5.xyz;
					    }
					    u_xlat8 = textureLod(unity_SpecCube0, u_xlat8.xyz, 6.0);
					    u_xlat43 = u_xlat8.w + -1.0;
					    u_xlat43 = unity_SpecCube0_HDR.w * u_xlat43 + 1.0;
					    u_xlat43 = log2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.y;
					    u_xlat43 = exp2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.x;
					    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat43);
					    u_xlatb44 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb44){
					        u_xlatb44 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb44){
					            u_xlat44 = dot(u_xlat5.xyz, u_xlat5.xyz);
					            u_xlat44 = inversesqrt(u_xlat44);
					            u_xlat10.xyz = vec3(u_xlat44) * u_xlat5.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat10.xyz;
					            u_xlat12.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat12.xyz = u_xlat12.xyz / u_xlat10.xyz;
					            u_xlatb13.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat10.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat11;
					                hlslcc_movcTemp.x = (u_xlatb13.x) ? u_xlat11.x : u_xlat12.x;
					                hlslcc_movcTemp.y = (u_xlatb13.y) ? u_xlat11.y : u_xlat12.y;
					                hlslcc_movcTemp.z = (u_xlatb13.z) ? u_xlat11.z : u_xlat12.z;
					                u_xlat11 = hlslcc_movcTemp;
					            }
					            u_xlat44 = min(u_xlat11.y, u_xlat11.x);
					            u_xlat44 = min(u_xlat11.z, u_xlat44);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat5.xyz = u_xlat10.xyz * vec3(u_xlat44) + u_xlat0.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat5.xyz, 6.0);
					        u_xlat0.x = u_xlat5.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat0.x + 1.0;
					        u_xlat0.x = log2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.y;
					        u_xlat0.x = exp2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xxx;
					        u_xlat5.xyz = vec3(u_xlat43) * u_xlat8.xyz + (-u_xlat0.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat42) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat1.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat42 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
					    u_xlat43 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = max(u_xlat1.x, 0.100000001);
					    u_xlat1.x = u_xlat1.x * 6.00012016;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat42 = (-u_xlat43) + 1.0;
					    u_xlat42 = u_xlat42 * u_xlat42;
					    u_xlat42 = u_xlat42 * u_xlat42;
					    u_xlat42 = u_xlat42 * 2.23517418e-08 + 0.0399999991;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					bvec3 u_xlatb13;
					vec3 u_xlat15;
					vec3 u_xlat16;
					float u_xlat17;
					float u_xlat29;
					vec2 u_xlat31;
					float u_xlat42;
					float u_xlat43;
					bool u_xlatb43;
					float u_xlat44;
					bool u_xlatb44;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat2.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4.x = 0.0;
					    u_xlat4.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat3.xy = u_xlat3.xy + u_xlat4.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat43 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat43) + (-vec2(_NormalRange));
					    u_xlat31.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat43 = u_xlat31.y + u_xlat31.x;
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat4.z = sqrt(u_xlat43);
					    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat43 = inversesqrt(u_xlat43);
					    u_xlat4.xyz = vec3(u_xlat43) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat43 = vs_TEXCOORD5.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD5.zxy / vec3(u_xlat43);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat43 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat43 = float(1.0) / u_xlat43;
					    u_xlat44 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat44 = float(1.0) / u_xlat44;
					    u_xlat43 = u_xlat43 + (-u_xlat44);
					    u_xlat43 = min(abs(u_xlat43), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat44 = u_xlat3.y * u_xlat5.w;
					    u_xlat44 = u_xlat44 * vs_COLOR0.w;
					    u_xlat43 = u_xlat43 * u_xlat44;
					    SV_Target0.w = u_xlat43 * _Color.w;
					    u_xlatb43 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb43){
					        u_xlatb44 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb44)) ? u_xlat5.xyz : u_xlat0.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat44 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat44, u_xlat17);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat44 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat17 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat5.xyz;
					    u_xlat17 = dot((-u_xlat2.xyz), u_xlat4.xyz);
					    u_xlat17 = u_xlat17 + u_xlat17;
					    u_xlat5.xyz = u_xlat4.xyz * (-vec3(u_xlat17)) + (-u_xlat2.xyz);
					    u_xlat6.xyz = vec3(u_xlat44) * _LightColor0.xyz;
					    if(u_xlatb43){
					        u_xlatb43 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb43)) ? u_xlat7.xyz : u_xlat0.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat43 = u_xlat7.y * 0.25;
					        u_xlat44 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat17 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat43 = max(u_xlat43, u_xlat44);
					        u_xlat7.x = min(u_xlat17, u_xlat43);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					        u_xlat9.xyz = u_xlat7.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat9 = texture(unity_ProbeVolumeSH, u_xlat9.xyz);
					        u_xlat7.xyz = u_xlat7.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(u_xlat8, u_xlat4);
					        u_xlat8.y = dot(u_xlat9, u_xlat4);
					        u_xlat8.z = dot(u_xlat7, u_xlat4);
					    } else {
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(unity_SHAr, u_xlat4);
					        u_xlat8.y = dot(unity_SHAg, u_xlat4);
					        u_xlat8.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat7.xyz = u_xlat8.xyz + vs_TEXCOORD6.xyz;
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb43 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb43){
					        u_xlat43 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat43 = inversesqrt(u_xlat43);
					        u_xlat8.xyz = vec3(u_xlat43) * u_xlat5.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					        u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					        u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat9;
					            hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					            hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					            hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					            u_xlat9 = hlslcc_movcTemp;
					        }
					        u_xlat43 = min(u_xlat9.y, u_xlat9.x);
					        u_xlat43 = min(u_xlat9.z, u_xlat43);
					        u_xlat9.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat43) + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat5.xyz;
					    }
					    u_xlat8 = textureLod(unity_SpecCube0, u_xlat8.xyz, 6.0);
					    u_xlat43 = u_xlat8.w + -1.0;
					    u_xlat43 = unity_SpecCube0_HDR.w * u_xlat43 + 1.0;
					    u_xlat43 = log2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.y;
					    u_xlat43 = exp2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.x;
					    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat43);
					    u_xlatb44 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb44){
					        u_xlatb44 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb44){
					            u_xlat44 = dot(u_xlat5.xyz, u_xlat5.xyz);
					            u_xlat44 = inversesqrt(u_xlat44);
					            u_xlat10.xyz = vec3(u_xlat44) * u_xlat5.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat10.xyz;
					            u_xlat12.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat12.xyz = u_xlat12.xyz / u_xlat10.xyz;
					            u_xlatb13.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat10.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat11;
					                hlslcc_movcTemp.x = (u_xlatb13.x) ? u_xlat11.x : u_xlat12.x;
					                hlslcc_movcTemp.y = (u_xlatb13.y) ? u_xlat11.y : u_xlat12.y;
					                hlslcc_movcTemp.z = (u_xlatb13.z) ? u_xlat11.z : u_xlat12.z;
					                u_xlat11 = hlslcc_movcTemp;
					            }
					            u_xlat44 = min(u_xlat11.y, u_xlat11.x);
					            u_xlat44 = min(u_xlat11.z, u_xlat44);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat5.xyz = u_xlat10.xyz * vec3(u_xlat44) + u_xlat0.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat5.xyz, 6.0);
					        u_xlat0.x = u_xlat5.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat0.x + 1.0;
					        u_xlat0.x = log2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.y;
					        u_xlat0.x = exp2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xxx;
					        u_xlat5.xyz = vec3(u_xlat43) * u_xlat8.xyz + (-u_xlat0.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat42) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat1.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat42 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat43 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat15.x = dot(u_xlat1.xx, u_xlat1.xx);
					    u_xlat15.x = u_xlat15.x + -0.5;
					    u_xlat29 = (-u_xlat43) + 1.0;
					    u_xlat2.x = u_xlat29 * u_xlat29;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat29 = u_xlat29 * u_xlat2.x;
					    u_xlat29 = u_xlat15.x * u_xlat29 + 1.0;
					    u_xlat2.x = -abs(u_xlat42) + 1.0;
					    u_xlat16.x = u_xlat2.x * u_xlat2.x;
					    u_xlat16.x = u_xlat16.x * u_xlat16.x;
					    u_xlat2.x = u_xlat2.x * u_xlat16.x;
					    u_xlat15.x = u_xlat15.x * u_xlat2.x + 1.0;
					    u_xlat15.x = u_xlat15.x * u_xlat29;
					    u_xlat15.x = u_xlat43 * u_xlat15.x;
					    u_xlat42 = abs(u_xlat42) + u_xlat43;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat42 = u_xlat42 * 0.999999881;
					    u_xlat42 = u_xlat43 * u_xlat42;
					    u_xlat15.xyz = u_xlat6.xyz * u_xlat15.xxx + u_xlat7.xyz;
					    u_xlat16.xyz = u_xlat6.xyz * vec3(u_xlat42);
					    u_xlat42 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat42 * u_xlat42;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat42 = u_xlat42 * u_xlat1.x;
					    u_xlat42 = u_xlat42 * 0.959999979 + 0.0399999991;
					    u_xlat16.xyz = vec3(u_xlat42) * u_xlat16.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat15.xyz + u_xlat16.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat42 = u_xlat2.x * 2.23517418e-08 + 0.0399999991;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					float u_xlat15;
					vec2 u_xlat28;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					bool u_xlatb40;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3.x = 0.0;
					    u_xlat3.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat2.xy = u_xlat2.xy + u_xlat3.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat39 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat39) + (-vec2(_NormalRange));
					    u_xlat28.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat39 = u_xlat28.y + u_xlat28.x;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat3.z = sqrt(u_xlat39);
					    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat39 = vs_TEXCOORD5.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD5.zxy / vec3(u_xlat39);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat39 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat39 = float(1.0) / u_xlat39;
					    u_xlat40 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat40 = float(1.0) / u_xlat40;
					    u_xlat39 = u_xlat39 + (-u_xlat40);
					    u_xlat39 = min(abs(u_xlat39), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat40 = u_xlat2.y * u_xlat4.w;
					    u_xlat40 = u_xlat40 * vs_COLOR0.w;
					    u_xlat39 = u_xlat39 * u_xlat40;
					    SV_Target0.w = u_xlat39 * _Color.w;
					    u_xlatb39 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb39){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb40)) ? u_xlat4.xyz : u_xlat0.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat15 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat40, u_xlat15);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat40 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat3.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat15 = dot((-u_xlat1.xyz), u_xlat3.xyz);
					    u_xlat15 = u_xlat15 + u_xlat15;
					    u_xlat4.xyz = u_xlat3.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    if(u_xlatb39){
					        u_xlatb39 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb39)) ? u_xlat6.xyz : u_xlat0.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat39 = u_xlat6.y * 0.25;
					        u_xlat40 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat39 = max(u_xlat39, u_xlat40);
					        u_xlat6.x = min(u_xlat15, u_xlat39);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat3.w = 1.0;
					        u_xlat7.x = dot(u_xlat7, u_xlat3);
					        u_xlat7.y = dot(u_xlat8, u_xlat3);
					        u_xlat7.z = dot(u_xlat6, u_xlat3);
					    } else {
					        u_xlat3.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat3);
					        u_xlat7.y = dot(unity_SHAg, u_xlat3);
					        u_xlat7.z = dot(unity_SHAb, u_xlat3);
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD6.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb39 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb39){
					        u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat39 = inversesqrt(u_xlat39);
					        u_xlat7.xyz = vec3(u_xlat39) * u_xlat4.xyz;
					        u_xlat8.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat39 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat39 = min(u_xlat8.z, u_xlat39);
					        u_xlat8.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat39) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    }
					    u_xlat7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 6.0);
					    u_xlat39 = u_xlat7.w + -1.0;
					    u_xlat39 = unity_SpecCube0_HDR.w * u_xlat39 + 1.0;
					    u_xlat39 = log2(u_xlat39);
					    u_xlat39 = u_xlat39 * unity_SpecCube0_HDR.y;
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat39 = u_xlat39 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat7.xyz * vec3(u_xlat39);
					    u_xlatb40 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb40){
					        u_xlatb40 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb40){
					            u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat40 = inversesqrt(u_xlat40);
					            u_xlat9.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					            u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat40 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat40 = min(u_xlat10.z, u_xlat40);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat40) + u_xlat0.xyz;
					        }
					        u_xlat4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 6.0);
					        u_xlat0.x = u_xlat4.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat0.x + 1.0;
					        u_xlat0.x = log2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.y;
					        u_xlat0.x = exp2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					        u_xlat4.xyz = vec3(u_xlat39) * u_xlat7.xyz + (-u_xlat0.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat39 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat40 = u_xlat39 + u_xlat39;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat40)) + u_xlat1.xyz;
					    u_xlat40 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat39 = u_xlat39;
					    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.y = (-u_xlat39) + 1.0;
					    u_xlat2.zw = u_xlat2.xy * u_xlat2.xy;
					    u_xlat1.xy = u_xlat2.xy * u_xlat2.xw;
					    u_xlat1.xy = u_xlat2.zy * u_xlat1.xy;
					    u_xlat1.z = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat1.xz);
					    u_xlat2.xyz = u_xlat2.xxx * vec3(0.639999986, 0.639999986, 0.639999986) + u_xlat0.xyz;
					    u_xlat1.xzw = vec3(u_xlat40) * u_xlat5.xyz;
					    u_xlat39 = u_xlat1.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat0.xyz + u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xzw + u_xlat0.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					bvec3 u_xlatb13;
					float u_xlat17;
					vec2 u_xlat31;
					float u_xlat42;
					float u_xlat43;
					bool u_xlatb43;
					float u_xlat44;
					bool u_xlatb44;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat2.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4.x = 0.0;
					    u_xlat4.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat3.xy = u_xlat3.xy + u_xlat4.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat43 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat43) + (-vec2(_NormalRange));
					    u_xlat31.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat43 = u_xlat31.y + u_xlat31.x;
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat4.z = sqrt(u_xlat43);
					    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat43 = inversesqrt(u_xlat43);
					    u_xlat4.xyz = vec3(u_xlat43) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat43 = vs_TEXCOORD5.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD5.zxy / vec3(u_xlat43);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat43 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat43 = float(1.0) / u_xlat43;
					    u_xlat44 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat44 = float(1.0) / u_xlat44;
					    u_xlat43 = u_xlat43 + (-u_xlat44);
					    u_xlat43 = min(abs(u_xlat43), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat44 = u_xlat3.y * u_xlat5.w;
					    u_xlat44 = u_xlat44 * vs_COLOR0.w;
					    u_xlat43 = u_xlat43 * u_xlat44;
					    SV_Target0.w = u_xlat43 * _Color.w;
					    u_xlatb43 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb43){
					        u_xlatb44 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb44)) ? u_xlat5.xyz : u_xlat0.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat44 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat44, u_xlat17);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat44 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat17 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat5.xyz;
					    u_xlat17 = dot((-u_xlat2.xyz), u_xlat4.xyz);
					    u_xlat17 = u_xlat17 + u_xlat17;
					    u_xlat5.xyz = u_xlat4.xyz * (-vec3(u_xlat17)) + (-u_xlat2.xyz);
					    u_xlat6.xyz = vec3(u_xlat44) * _LightColor0.xyz;
					    if(u_xlatb43){
					        u_xlatb43 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb43)) ? u_xlat7.xyz : u_xlat0.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat43 = u_xlat7.y * 0.25;
					        u_xlat44 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat17 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat43 = max(u_xlat43, u_xlat44);
					        u_xlat7.x = min(u_xlat17, u_xlat43);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					        u_xlat9.xyz = u_xlat7.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat9 = texture(unity_ProbeVolumeSH, u_xlat9.xyz);
					        u_xlat7.xyz = u_xlat7.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(u_xlat8, u_xlat4);
					        u_xlat8.y = dot(u_xlat9, u_xlat4);
					        u_xlat8.z = dot(u_xlat7, u_xlat4);
					    } else {
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(unity_SHAr, u_xlat4);
					        u_xlat8.y = dot(unity_SHAg, u_xlat4);
					        u_xlat8.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat7.xyz = u_xlat8.xyz + vs_TEXCOORD6.xyz;
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb43 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb43){
					        u_xlat43 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat43 = inversesqrt(u_xlat43);
					        u_xlat8.xyz = vec3(u_xlat43) * u_xlat5.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					        u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					        u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat9;
					            hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					            hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					            hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					            u_xlat9 = hlslcc_movcTemp;
					        }
					        u_xlat43 = min(u_xlat9.y, u_xlat9.x);
					        u_xlat43 = min(u_xlat9.z, u_xlat43);
					        u_xlat9.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat43) + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat5.xyz;
					    }
					    u_xlat8 = textureLod(unity_SpecCube0, u_xlat8.xyz, 6.0);
					    u_xlat43 = u_xlat8.w + -1.0;
					    u_xlat43 = unity_SpecCube0_HDR.w * u_xlat43 + 1.0;
					    u_xlat43 = log2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.y;
					    u_xlat43 = exp2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.x;
					    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat43);
					    u_xlatb44 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb44){
					        u_xlatb44 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb44){
					            u_xlat44 = dot(u_xlat5.xyz, u_xlat5.xyz);
					            u_xlat44 = inversesqrt(u_xlat44);
					            u_xlat10.xyz = vec3(u_xlat44) * u_xlat5.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat10.xyz;
					            u_xlat12.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat12.xyz = u_xlat12.xyz / u_xlat10.xyz;
					            u_xlatb13.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat10.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat11;
					                hlslcc_movcTemp.x = (u_xlatb13.x) ? u_xlat11.x : u_xlat12.x;
					                hlslcc_movcTemp.y = (u_xlatb13.y) ? u_xlat11.y : u_xlat12.y;
					                hlslcc_movcTemp.z = (u_xlatb13.z) ? u_xlat11.z : u_xlat12.z;
					                u_xlat11 = hlslcc_movcTemp;
					            }
					            u_xlat44 = min(u_xlat11.y, u_xlat11.x);
					            u_xlat44 = min(u_xlat11.z, u_xlat44);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat5.xyz = u_xlat10.xyz * vec3(u_xlat44) + u_xlat0.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat5.xyz, 6.0);
					        u_xlat0.x = u_xlat5.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat0.x + 1.0;
					        u_xlat0.x = log2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.y;
					        u_xlat0.x = exp2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xxx;
					        u_xlat5.xyz = vec3(u_xlat43) * u_xlat8.xyz + (-u_xlat0.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat42) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat1.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat42 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
					    u_xlat43 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = max(u_xlat1.x, 0.100000001);
					    u_xlat1.x = u_xlat1.x * 6.00012016;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat42 = (-u_xlat43) + 1.0;
					    u_xlat42 = u_xlat42 * u_xlat42;
					    u_xlat42 = u_xlat42 * u_xlat42;
					    u_xlat42 = u_xlat42 * 2.23517418e-08 + 0.0399999991;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					bvec3 u_xlatb13;
					vec3 u_xlat15;
					vec3 u_xlat16;
					float u_xlat17;
					float u_xlat29;
					vec2 u_xlat31;
					float u_xlat42;
					float u_xlat43;
					bool u_xlatb43;
					float u_xlat44;
					bool u_xlatb44;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat2.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4.x = 0.0;
					    u_xlat4.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat3.xy = u_xlat3.xy + u_xlat4.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat43 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat43) + (-vec2(_NormalRange));
					    u_xlat31.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat43 = u_xlat31.y + u_xlat31.x;
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat4.z = sqrt(u_xlat43);
					    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat43 = inversesqrt(u_xlat43);
					    u_xlat4.xyz = vec3(u_xlat43) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat43 = vs_TEXCOORD5.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD5.zxy / vec3(u_xlat43);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat43 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat43 = float(1.0) / u_xlat43;
					    u_xlat44 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat44 = float(1.0) / u_xlat44;
					    u_xlat43 = u_xlat43 + (-u_xlat44);
					    u_xlat43 = min(abs(u_xlat43), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat44 = u_xlat3.y * u_xlat5.w;
					    u_xlat44 = u_xlat44 * vs_COLOR0.w;
					    u_xlat43 = u_xlat43 * u_xlat44;
					    SV_Target0.w = u_xlat43 * _Color.w;
					    u_xlatb43 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb43){
					        u_xlatb44 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb44)) ? u_xlat5.xyz : u_xlat0.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat44 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat44, u_xlat17);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat44 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat17 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat5.xyz;
					    u_xlat17 = dot((-u_xlat2.xyz), u_xlat4.xyz);
					    u_xlat17 = u_xlat17 + u_xlat17;
					    u_xlat5.xyz = u_xlat4.xyz * (-vec3(u_xlat17)) + (-u_xlat2.xyz);
					    u_xlat6.xyz = vec3(u_xlat44) * _LightColor0.xyz;
					    if(u_xlatb43){
					        u_xlatb43 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb43)) ? u_xlat7.xyz : u_xlat0.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat43 = u_xlat7.y * 0.25;
					        u_xlat44 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat17 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat43 = max(u_xlat43, u_xlat44);
					        u_xlat7.x = min(u_xlat17, u_xlat43);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					        u_xlat9.xyz = u_xlat7.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat9 = texture(unity_ProbeVolumeSH, u_xlat9.xyz);
					        u_xlat7.xyz = u_xlat7.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(u_xlat8, u_xlat4);
					        u_xlat8.y = dot(u_xlat9, u_xlat4);
					        u_xlat8.z = dot(u_xlat7, u_xlat4);
					    } else {
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(unity_SHAr, u_xlat4);
					        u_xlat8.y = dot(unity_SHAg, u_xlat4);
					        u_xlat8.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat7.xyz = u_xlat8.xyz + vs_TEXCOORD6.xyz;
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb43 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb43){
					        u_xlat43 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat43 = inversesqrt(u_xlat43);
					        u_xlat8.xyz = vec3(u_xlat43) * u_xlat5.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					        u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					        u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat9;
					            hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					            hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					            hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					            u_xlat9 = hlslcc_movcTemp;
					        }
					        u_xlat43 = min(u_xlat9.y, u_xlat9.x);
					        u_xlat43 = min(u_xlat9.z, u_xlat43);
					        u_xlat9.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat43) + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat5.xyz;
					    }
					    u_xlat8 = textureLod(unity_SpecCube0, u_xlat8.xyz, 6.0);
					    u_xlat43 = u_xlat8.w + -1.0;
					    u_xlat43 = unity_SpecCube0_HDR.w * u_xlat43 + 1.0;
					    u_xlat43 = log2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.y;
					    u_xlat43 = exp2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.x;
					    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat43);
					    u_xlatb44 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb44){
					        u_xlatb44 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb44){
					            u_xlat44 = dot(u_xlat5.xyz, u_xlat5.xyz);
					            u_xlat44 = inversesqrt(u_xlat44);
					            u_xlat10.xyz = vec3(u_xlat44) * u_xlat5.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat10.xyz;
					            u_xlat12.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat12.xyz = u_xlat12.xyz / u_xlat10.xyz;
					            u_xlatb13.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat10.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat11;
					                hlslcc_movcTemp.x = (u_xlatb13.x) ? u_xlat11.x : u_xlat12.x;
					                hlslcc_movcTemp.y = (u_xlatb13.y) ? u_xlat11.y : u_xlat12.y;
					                hlslcc_movcTemp.z = (u_xlatb13.z) ? u_xlat11.z : u_xlat12.z;
					                u_xlat11 = hlslcc_movcTemp;
					            }
					            u_xlat44 = min(u_xlat11.y, u_xlat11.x);
					            u_xlat44 = min(u_xlat11.z, u_xlat44);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat5.xyz = u_xlat10.xyz * vec3(u_xlat44) + u_xlat0.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat5.xyz, 6.0);
					        u_xlat0.x = u_xlat5.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat0.x + 1.0;
					        u_xlat0.x = log2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.y;
					        u_xlat0.x = exp2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xxx;
					        u_xlat5.xyz = vec3(u_xlat43) * u_xlat8.xyz + (-u_xlat0.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat42) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat1.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat42 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat43 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat15.x = dot(u_xlat1.xx, u_xlat1.xx);
					    u_xlat15.x = u_xlat15.x + -0.5;
					    u_xlat29 = (-u_xlat43) + 1.0;
					    u_xlat2.x = u_xlat29 * u_xlat29;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat29 = u_xlat29 * u_xlat2.x;
					    u_xlat29 = u_xlat15.x * u_xlat29 + 1.0;
					    u_xlat2.x = -abs(u_xlat42) + 1.0;
					    u_xlat16.x = u_xlat2.x * u_xlat2.x;
					    u_xlat16.x = u_xlat16.x * u_xlat16.x;
					    u_xlat2.x = u_xlat2.x * u_xlat16.x;
					    u_xlat15.x = u_xlat15.x * u_xlat2.x + 1.0;
					    u_xlat15.x = u_xlat15.x * u_xlat29;
					    u_xlat15.x = u_xlat43 * u_xlat15.x;
					    u_xlat42 = abs(u_xlat42) + u_xlat43;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat42 = u_xlat42 * 0.999999881;
					    u_xlat42 = u_xlat43 * u_xlat42;
					    u_xlat15.xyz = u_xlat6.xyz * u_xlat15.xxx + u_xlat7.xyz;
					    u_xlat16.xyz = u_xlat6.xyz * vec3(u_xlat42);
					    u_xlat42 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat42 * u_xlat42;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat42 = u_xlat42 * u_xlat1.x;
					    u_xlat42 = u_xlat42 * 0.959999979 + 0.0399999991;
					    u_xlat16.xyz = vec3(u_xlat42) * u_xlat16.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat15.xyz + u_xlat16.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat42 = u_xlat2.x * 2.23517418e-08 + 0.0399999991;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					float u_xlat15;
					vec2 u_xlat28;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					bool u_xlatb40;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3.x = 0.0;
					    u_xlat3.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat2.xy = u_xlat2.xy + u_xlat3.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat39 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat39) + (-vec2(_NormalRange));
					    u_xlat28.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat39 = u_xlat28.y + u_xlat28.x;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat3.z = sqrt(u_xlat39);
					    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat39 = vs_TEXCOORD5.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD5.zxy / vec3(u_xlat39);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat39 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat39 = float(1.0) / u_xlat39;
					    u_xlat40 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat40 = float(1.0) / u_xlat40;
					    u_xlat39 = u_xlat39 + (-u_xlat40);
					    u_xlat39 = min(abs(u_xlat39), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat40 = u_xlat2.y * u_xlat4.w;
					    u_xlat40 = u_xlat40 * vs_COLOR0.w;
					    u_xlat39 = u_xlat39 * u_xlat40;
					    SV_Target0.w = u_xlat39 * _Color.w;
					    u_xlatb39 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb39){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb40)) ? u_xlat4.xyz : u_xlat0.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat15 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat40, u_xlat15);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat40 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat3.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat15 = dot((-u_xlat1.xyz), u_xlat3.xyz);
					    u_xlat15 = u_xlat15 + u_xlat15;
					    u_xlat4.xyz = u_xlat3.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    if(u_xlatb39){
					        u_xlatb39 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb39)) ? u_xlat6.xyz : u_xlat0.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat39 = u_xlat6.y * 0.25;
					        u_xlat40 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat39 = max(u_xlat39, u_xlat40);
					        u_xlat6.x = min(u_xlat15, u_xlat39);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat3.w = 1.0;
					        u_xlat7.x = dot(u_xlat7, u_xlat3);
					        u_xlat7.y = dot(u_xlat8, u_xlat3);
					        u_xlat7.z = dot(u_xlat6, u_xlat3);
					    } else {
					        u_xlat3.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat3);
					        u_xlat7.y = dot(unity_SHAg, u_xlat3);
					        u_xlat7.z = dot(unity_SHAb, u_xlat3);
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD6.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb39 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb39){
					        u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat39 = inversesqrt(u_xlat39);
					        u_xlat7.xyz = vec3(u_xlat39) * u_xlat4.xyz;
					        u_xlat8.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat39 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat39 = min(u_xlat8.z, u_xlat39);
					        u_xlat8.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat39) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    }
					    u_xlat7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 6.0);
					    u_xlat39 = u_xlat7.w + -1.0;
					    u_xlat39 = unity_SpecCube0_HDR.w * u_xlat39 + 1.0;
					    u_xlat39 = log2(u_xlat39);
					    u_xlat39 = u_xlat39 * unity_SpecCube0_HDR.y;
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat39 = u_xlat39 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat7.xyz * vec3(u_xlat39);
					    u_xlatb40 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb40){
					        u_xlatb40 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb40){
					            u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat40 = inversesqrt(u_xlat40);
					            u_xlat9.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					            u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat40 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat40 = min(u_xlat10.z, u_xlat40);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat40) + u_xlat0.xyz;
					        }
					        u_xlat4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 6.0);
					        u_xlat0.x = u_xlat4.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat0.x + 1.0;
					        u_xlat0.x = log2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.y;
					        u_xlat0.x = exp2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					        u_xlat4.xyz = vec3(u_xlat39) * u_xlat7.xyz + (-u_xlat0.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat39 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat40 = u_xlat39 + u_xlat39;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat40)) + u_xlat1.xyz;
					    u_xlat40 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat39 = u_xlat39;
					    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.y = (-u_xlat39) + 1.0;
					    u_xlat2.zw = u_xlat2.xy * u_xlat2.xy;
					    u_xlat1.xy = u_xlat2.xy * u_xlat2.xw;
					    u_xlat1.xy = u_xlat2.zy * u_xlat1.xy;
					    u_xlat1.z = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat1.xz);
					    u_xlat2.xyz = u_xlat2.xxx * vec3(0.639999986, 0.639999986, 0.639999986) + u_xlat0.xyz;
					    u_xlat1.xzw = vec3(u_xlat40) * u_xlat5.xyz;
					    u_xlat39 = u_xlat1.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					bvec3 u_xlatb13;
					float u_xlat17;
					vec2 u_xlat31;
					float u_xlat42;
					float u_xlat43;
					bool u_xlatb43;
					float u_xlat44;
					bool u_xlatb44;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat2.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat3.y = _ScrollSpeed * _Time.y;
					    u_xlat31.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3.x = _Time.y;
					    u_xlat3.xy = u_xlat3.xy * vec2(0.0, -1.0) + u_xlat31.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat43 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat43) + (-vec2(_NormalRange));
					    u_xlat31.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat43 = u_xlat31.y + u_xlat31.x;
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat4.z = sqrt(u_xlat43);
					    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat43 = inversesqrt(u_xlat43);
					    u_xlat4.xyz = vec3(u_xlat43) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat43 = vs_TEXCOORD5.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD5.zxy / vec3(u_xlat43);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat43 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat43 = float(1.0) / u_xlat43;
					    u_xlat44 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat44 = float(1.0) / u_xlat44;
					    u_xlat43 = u_xlat43 + (-u_xlat44);
					    u_xlat43 = min(abs(u_xlat43), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat44 = u_xlat3.y * u_xlat5.w;
					    u_xlat44 = u_xlat44 * vs_COLOR0.w;
					    u_xlat43 = u_xlat43 * u_xlat44;
					    SV_Target0.w = u_xlat43 * _Color.w;
					    u_xlatb43 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb43){
					        u_xlatb44 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb44)) ? u_xlat5.xyz : u_xlat0.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat44 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat44, u_xlat17);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat44 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat17 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat5.xyz;
					    u_xlat17 = dot((-u_xlat2.xyz), u_xlat4.xyz);
					    u_xlat17 = u_xlat17 + u_xlat17;
					    u_xlat5.xyz = u_xlat4.xyz * (-vec3(u_xlat17)) + (-u_xlat2.xyz);
					    u_xlat6.xyz = vec3(u_xlat44) * _LightColor0.xyz;
					    if(u_xlatb43){
					        u_xlatb43 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb43)) ? u_xlat7.xyz : u_xlat0.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat43 = u_xlat7.y * 0.25;
					        u_xlat44 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat17 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat43 = max(u_xlat43, u_xlat44);
					        u_xlat7.x = min(u_xlat17, u_xlat43);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					        u_xlat9.xyz = u_xlat7.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat9 = texture(unity_ProbeVolumeSH, u_xlat9.xyz);
					        u_xlat7.xyz = u_xlat7.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(u_xlat8, u_xlat4);
					        u_xlat8.y = dot(u_xlat9, u_xlat4);
					        u_xlat8.z = dot(u_xlat7, u_xlat4);
					    } else {
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(unity_SHAr, u_xlat4);
					        u_xlat8.y = dot(unity_SHAg, u_xlat4);
					        u_xlat8.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat7.xyz = u_xlat8.xyz + vs_TEXCOORD6.xyz;
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb43 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb43){
					        u_xlat43 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat43 = inversesqrt(u_xlat43);
					        u_xlat8.xyz = vec3(u_xlat43) * u_xlat5.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					        u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					        u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat9;
					            hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					            hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					            hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					            u_xlat9 = hlslcc_movcTemp;
					        }
					        u_xlat43 = min(u_xlat9.y, u_xlat9.x);
					        u_xlat43 = min(u_xlat9.z, u_xlat43);
					        u_xlat9.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat43) + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat5.xyz;
					    }
					    u_xlat8 = textureLod(unity_SpecCube0, u_xlat8.xyz, 6.0);
					    u_xlat43 = u_xlat8.w + -1.0;
					    u_xlat43 = unity_SpecCube0_HDR.w * u_xlat43 + 1.0;
					    u_xlat43 = log2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.y;
					    u_xlat43 = exp2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.x;
					    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat43);
					    u_xlatb44 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb44){
					        u_xlatb44 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb44){
					            u_xlat44 = dot(u_xlat5.xyz, u_xlat5.xyz);
					            u_xlat44 = inversesqrt(u_xlat44);
					            u_xlat10.xyz = vec3(u_xlat44) * u_xlat5.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat10.xyz;
					            u_xlat12.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat12.xyz = u_xlat12.xyz / u_xlat10.xyz;
					            u_xlatb13.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat10.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat11;
					                hlslcc_movcTemp.x = (u_xlatb13.x) ? u_xlat11.x : u_xlat12.x;
					                hlslcc_movcTemp.y = (u_xlatb13.y) ? u_xlat11.y : u_xlat12.y;
					                hlslcc_movcTemp.z = (u_xlatb13.z) ? u_xlat11.z : u_xlat12.z;
					                u_xlat11 = hlslcc_movcTemp;
					            }
					            u_xlat44 = min(u_xlat11.y, u_xlat11.x);
					            u_xlat44 = min(u_xlat11.z, u_xlat44);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat5.xyz = u_xlat10.xyz * vec3(u_xlat44) + u_xlat0.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat5.xyz, 6.0);
					        u_xlat0.x = u_xlat5.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat0.x + 1.0;
					        u_xlat0.x = log2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.y;
					        u_xlat0.x = exp2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xxx;
					        u_xlat5.xyz = vec3(u_xlat43) * u_xlat8.xyz + (-u_xlat0.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat42) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat1.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat42 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
					    u_xlat43 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = max(u_xlat1.x, 0.100000001);
					    u_xlat1.x = u_xlat1.x * 6.00012016;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat42 = (-u_xlat43) + 1.0;
					    u_xlat42 = u_xlat42 * u_xlat42;
					    u_xlat42 = u_xlat42 * u_xlat42;
					    u_xlat42 = u_xlat42 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    u_xlat42 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat42 = (-u_xlat42) + 1.0;
					    u_xlat42 = u_xlat42 * _ProjectionParams.z;
					    u_xlat42 = max(u_xlat42, 0.0);
					    u_xlat42 = u_xlat42 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat42) * u_xlat0.xyz + unity_FogColor.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					bvec3 u_xlatb13;
					vec3 u_xlat15;
					vec3 u_xlat16;
					float u_xlat17;
					float u_xlat29;
					vec2 u_xlat31;
					float u_xlat42;
					float u_xlat43;
					bool u_xlatb43;
					float u_xlat44;
					bool u_xlatb44;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat2.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4.x = 0.0;
					    u_xlat4.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat3.xy = u_xlat3.xy + u_xlat4.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat43 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat43) + (-vec2(_NormalRange));
					    u_xlat31.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat43 = u_xlat31.y + u_xlat31.x;
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat4.z = sqrt(u_xlat43);
					    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat43 = inversesqrt(u_xlat43);
					    u_xlat4.xyz = vec3(u_xlat43) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat43 = vs_TEXCOORD5.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD5.zxy / vec3(u_xlat43);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat43 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat43 = float(1.0) / u_xlat43;
					    u_xlat44 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat44 = float(1.0) / u_xlat44;
					    u_xlat43 = u_xlat43 + (-u_xlat44);
					    u_xlat43 = min(abs(u_xlat43), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat44 = u_xlat3.y * u_xlat5.w;
					    u_xlat44 = u_xlat44 * vs_COLOR0.w;
					    u_xlat43 = u_xlat43 * u_xlat44;
					    SV_Target0.w = u_xlat43 * _Color.w;
					    u_xlatb43 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb43){
					        u_xlatb44 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb44)) ? u_xlat5.xyz : u_xlat0.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat44 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat44, u_xlat17);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat44 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat17 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat5.xyz;
					    u_xlat17 = dot((-u_xlat2.xyz), u_xlat4.xyz);
					    u_xlat17 = u_xlat17 + u_xlat17;
					    u_xlat5.xyz = u_xlat4.xyz * (-vec3(u_xlat17)) + (-u_xlat2.xyz);
					    u_xlat6.xyz = vec3(u_xlat44) * _LightColor0.xyz;
					    if(u_xlatb43){
					        u_xlatb43 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb43)) ? u_xlat7.xyz : u_xlat0.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat43 = u_xlat7.y * 0.25;
					        u_xlat44 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat17 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat43 = max(u_xlat43, u_xlat44);
					        u_xlat7.x = min(u_xlat17, u_xlat43);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					        u_xlat9.xyz = u_xlat7.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat9 = texture(unity_ProbeVolumeSH, u_xlat9.xyz);
					        u_xlat7.xyz = u_xlat7.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(u_xlat8, u_xlat4);
					        u_xlat8.y = dot(u_xlat9, u_xlat4);
					        u_xlat8.z = dot(u_xlat7, u_xlat4);
					    } else {
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(unity_SHAr, u_xlat4);
					        u_xlat8.y = dot(unity_SHAg, u_xlat4);
					        u_xlat8.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat7.xyz = u_xlat8.xyz + vs_TEXCOORD6.xyz;
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb43 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb43){
					        u_xlat43 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat43 = inversesqrt(u_xlat43);
					        u_xlat8.xyz = vec3(u_xlat43) * u_xlat5.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					        u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					        u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat9;
					            hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					            hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					            hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					            u_xlat9 = hlslcc_movcTemp;
					        }
					        u_xlat43 = min(u_xlat9.y, u_xlat9.x);
					        u_xlat43 = min(u_xlat9.z, u_xlat43);
					        u_xlat9.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat43) + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat5.xyz;
					    }
					    u_xlat8 = textureLod(unity_SpecCube0, u_xlat8.xyz, 6.0);
					    u_xlat43 = u_xlat8.w + -1.0;
					    u_xlat43 = unity_SpecCube0_HDR.w * u_xlat43 + 1.0;
					    u_xlat43 = log2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.y;
					    u_xlat43 = exp2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.x;
					    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat43);
					    u_xlatb44 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb44){
					        u_xlatb44 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb44){
					            u_xlat44 = dot(u_xlat5.xyz, u_xlat5.xyz);
					            u_xlat44 = inversesqrt(u_xlat44);
					            u_xlat10.xyz = vec3(u_xlat44) * u_xlat5.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat10.xyz;
					            u_xlat12.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat12.xyz = u_xlat12.xyz / u_xlat10.xyz;
					            u_xlatb13.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat10.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat11;
					                hlslcc_movcTemp.x = (u_xlatb13.x) ? u_xlat11.x : u_xlat12.x;
					                hlslcc_movcTemp.y = (u_xlatb13.y) ? u_xlat11.y : u_xlat12.y;
					                hlslcc_movcTemp.z = (u_xlatb13.z) ? u_xlat11.z : u_xlat12.z;
					                u_xlat11 = hlslcc_movcTemp;
					            }
					            u_xlat44 = min(u_xlat11.y, u_xlat11.x);
					            u_xlat44 = min(u_xlat11.z, u_xlat44);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat5.xyz = u_xlat10.xyz * vec3(u_xlat44) + u_xlat0.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat5.xyz, 6.0);
					        u_xlat0.x = u_xlat5.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat0.x + 1.0;
					        u_xlat0.x = log2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.y;
					        u_xlat0.x = exp2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xxx;
					        u_xlat5.xyz = vec3(u_xlat43) * u_xlat8.xyz + (-u_xlat0.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat42) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat1.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat42 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat43 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat15.x = dot(u_xlat1.xx, u_xlat1.xx);
					    u_xlat15.x = u_xlat15.x + -0.5;
					    u_xlat29 = (-u_xlat43) + 1.0;
					    u_xlat2.x = u_xlat29 * u_xlat29;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat29 = u_xlat29 * u_xlat2.x;
					    u_xlat29 = u_xlat15.x * u_xlat29 + 1.0;
					    u_xlat2.x = -abs(u_xlat42) + 1.0;
					    u_xlat16.x = u_xlat2.x * u_xlat2.x;
					    u_xlat16.x = u_xlat16.x * u_xlat16.x;
					    u_xlat2.x = u_xlat2.x * u_xlat16.x;
					    u_xlat15.x = u_xlat15.x * u_xlat2.x + 1.0;
					    u_xlat15.x = u_xlat15.x * u_xlat29;
					    u_xlat15.x = u_xlat43 * u_xlat15.x;
					    u_xlat42 = abs(u_xlat42) + u_xlat43;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat42 = u_xlat42 * 0.999999881;
					    u_xlat42 = u_xlat43 * u_xlat42;
					    u_xlat15.xyz = u_xlat6.xyz * u_xlat15.xxx + u_xlat7.xyz;
					    u_xlat16.xyz = u_xlat6.xyz * vec3(u_xlat42);
					    u_xlat42 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat42 * u_xlat42;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat42 = u_xlat42 * u_xlat1.x;
					    u_xlat42 = u_xlat42 * 0.959999979 + 0.0399999991;
					    u_xlat16.xyz = vec3(u_xlat42) * u_xlat16.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat15.xyz + u_xlat16.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat42 = u_xlat2.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    u_xlat42 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat42 = (-u_xlat42) + 1.0;
					    u_xlat42 = u_xlat42 * _ProjectionParams.z;
					    u_xlat42 = max(u_xlat42, 0.0);
					    u_xlat42 = u_xlat42 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat42) * u_xlat0.xyz + unity_FogColor.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					float u_xlat15;
					vec2 u_xlat28;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					bool u_xlatb40;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3.x = 0.0;
					    u_xlat3.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat2.xy = u_xlat2.xy + u_xlat3.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat39 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat39) + (-vec2(_NormalRange));
					    u_xlat28.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat39 = u_xlat28.y + u_xlat28.x;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat3.z = sqrt(u_xlat39);
					    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat39 = vs_TEXCOORD5.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD5.zxy / vec3(u_xlat39);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat39 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat39 = float(1.0) / u_xlat39;
					    u_xlat40 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat40 = float(1.0) / u_xlat40;
					    u_xlat39 = u_xlat39 + (-u_xlat40);
					    u_xlat39 = min(abs(u_xlat39), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat40 = u_xlat2.y * u_xlat4.w;
					    u_xlat40 = u_xlat40 * vs_COLOR0.w;
					    u_xlat39 = u_xlat39 * u_xlat40;
					    SV_Target0.w = u_xlat39 * _Color.w;
					    u_xlatb39 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb39){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb40)) ? u_xlat4.xyz : u_xlat0.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat15 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat40, u_xlat15);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat40 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat3.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat15 = dot((-u_xlat1.xyz), u_xlat3.xyz);
					    u_xlat15 = u_xlat15 + u_xlat15;
					    u_xlat4.xyz = u_xlat3.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    if(u_xlatb39){
					        u_xlatb39 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb39)) ? u_xlat6.xyz : u_xlat0.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat39 = u_xlat6.y * 0.25;
					        u_xlat40 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat39 = max(u_xlat39, u_xlat40);
					        u_xlat6.x = min(u_xlat15, u_xlat39);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat3.w = 1.0;
					        u_xlat7.x = dot(u_xlat7, u_xlat3);
					        u_xlat7.y = dot(u_xlat8, u_xlat3);
					        u_xlat7.z = dot(u_xlat6, u_xlat3);
					    } else {
					        u_xlat3.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat3);
					        u_xlat7.y = dot(unity_SHAg, u_xlat3);
					        u_xlat7.z = dot(unity_SHAb, u_xlat3);
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD6.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb39 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb39){
					        u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat39 = inversesqrt(u_xlat39);
					        u_xlat7.xyz = vec3(u_xlat39) * u_xlat4.xyz;
					        u_xlat8.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat39 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat39 = min(u_xlat8.z, u_xlat39);
					        u_xlat8.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat39) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    }
					    u_xlat7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 6.0);
					    u_xlat39 = u_xlat7.w + -1.0;
					    u_xlat39 = unity_SpecCube0_HDR.w * u_xlat39 + 1.0;
					    u_xlat39 = log2(u_xlat39);
					    u_xlat39 = u_xlat39 * unity_SpecCube0_HDR.y;
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat39 = u_xlat39 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat7.xyz * vec3(u_xlat39);
					    u_xlatb40 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb40){
					        u_xlatb40 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb40){
					            u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat40 = inversesqrt(u_xlat40);
					            u_xlat9.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					            u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat40 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat40 = min(u_xlat10.z, u_xlat40);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat40) + u_xlat0.xyz;
					        }
					        u_xlat4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 6.0);
					        u_xlat0.x = u_xlat4.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat0.x + 1.0;
					        u_xlat0.x = log2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.y;
					        u_xlat0.x = exp2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					        u_xlat4.xyz = vec3(u_xlat39) * u_xlat7.xyz + (-u_xlat0.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat39 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat40 = u_xlat39 + u_xlat39;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat40)) + u_xlat1.xyz;
					    u_xlat40 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat39 = u_xlat39;
					    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.y = (-u_xlat39) + 1.0;
					    u_xlat2.zw = u_xlat2.xy * u_xlat2.xy;
					    u_xlat1.xy = u_xlat2.xy * u_xlat2.xw;
					    u_xlat1.xy = u_xlat2.zy * u_xlat1.xy;
					    u_xlat1.z = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat1.xz);
					    u_xlat2.xyz = u_xlat2.xxx * vec3(0.639999986, 0.639999986, 0.639999986) + u_xlat0.xyz;
					    u_xlat1.xzw = vec3(u_xlat40) * u_xlat5.xyz;
					    u_xlat39 = u_xlat1.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xzw + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					bvec3 u_xlatb13;
					float u_xlat17;
					vec2 u_xlat31;
					float u_xlat42;
					float u_xlat43;
					bool u_xlatb43;
					float u_xlat44;
					bool u_xlatb44;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat2.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat3.y = _ScrollSpeed * _Time.y;
					    u_xlat31.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3.x = _Time.y;
					    u_xlat3.xy = u_xlat3.xy * vec2(0.0, -1.0) + u_xlat31.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat43 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat43) + (-vec2(_NormalRange));
					    u_xlat31.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat43 = u_xlat31.y + u_xlat31.x;
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat4.z = sqrt(u_xlat43);
					    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat43 = inversesqrt(u_xlat43);
					    u_xlat4.xyz = vec3(u_xlat43) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat43 = vs_TEXCOORD5.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD5.zxy / vec3(u_xlat43);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat43 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat43 = float(1.0) / u_xlat43;
					    u_xlat44 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat44 = float(1.0) / u_xlat44;
					    u_xlat43 = u_xlat43 + (-u_xlat44);
					    u_xlat43 = min(abs(u_xlat43), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat44 = u_xlat3.y * u_xlat5.w;
					    u_xlat44 = u_xlat44 * vs_COLOR0.w;
					    u_xlat43 = u_xlat43 * u_xlat44;
					    SV_Target0.w = u_xlat43 * _Color.w;
					    u_xlatb43 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb43){
					        u_xlatb44 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb44)) ? u_xlat5.xyz : u_xlat0.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat44 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat44, u_xlat17);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat44 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat17 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat5.xyz;
					    u_xlat17 = dot((-u_xlat2.xyz), u_xlat4.xyz);
					    u_xlat17 = u_xlat17 + u_xlat17;
					    u_xlat5.xyz = u_xlat4.xyz * (-vec3(u_xlat17)) + (-u_xlat2.xyz);
					    u_xlat6.xyz = vec3(u_xlat44) * _LightColor0.xyz;
					    if(u_xlatb43){
					        u_xlatb43 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb43)) ? u_xlat7.xyz : u_xlat0.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat43 = u_xlat7.y * 0.25;
					        u_xlat44 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat17 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat43 = max(u_xlat43, u_xlat44);
					        u_xlat7.x = min(u_xlat17, u_xlat43);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					        u_xlat9.xyz = u_xlat7.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat9 = texture(unity_ProbeVolumeSH, u_xlat9.xyz);
					        u_xlat7.xyz = u_xlat7.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(u_xlat8, u_xlat4);
					        u_xlat8.y = dot(u_xlat9, u_xlat4);
					        u_xlat8.z = dot(u_xlat7, u_xlat4);
					    } else {
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(unity_SHAr, u_xlat4);
					        u_xlat8.y = dot(unity_SHAg, u_xlat4);
					        u_xlat8.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat7.xyz = u_xlat8.xyz + vs_TEXCOORD6.xyz;
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb43 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb43){
					        u_xlat43 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat43 = inversesqrt(u_xlat43);
					        u_xlat8.xyz = vec3(u_xlat43) * u_xlat5.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					        u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					        u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat9;
					            hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					            hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					            hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					            u_xlat9 = hlslcc_movcTemp;
					        }
					        u_xlat43 = min(u_xlat9.y, u_xlat9.x);
					        u_xlat43 = min(u_xlat9.z, u_xlat43);
					        u_xlat9.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat43) + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat5.xyz;
					    }
					    u_xlat8 = textureLod(unity_SpecCube0, u_xlat8.xyz, 6.0);
					    u_xlat43 = u_xlat8.w + -1.0;
					    u_xlat43 = unity_SpecCube0_HDR.w * u_xlat43 + 1.0;
					    u_xlat43 = log2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.y;
					    u_xlat43 = exp2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.x;
					    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat43);
					    u_xlatb44 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb44){
					        u_xlatb44 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb44){
					            u_xlat44 = dot(u_xlat5.xyz, u_xlat5.xyz);
					            u_xlat44 = inversesqrt(u_xlat44);
					            u_xlat10.xyz = vec3(u_xlat44) * u_xlat5.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat10.xyz;
					            u_xlat12.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat12.xyz = u_xlat12.xyz / u_xlat10.xyz;
					            u_xlatb13.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat10.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat11;
					                hlslcc_movcTemp.x = (u_xlatb13.x) ? u_xlat11.x : u_xlat12.x;
					                hlslcc_movcTemp.y = (u_xlatb13.y) ? u_xlat11.y : u_xlat12.y;
					                hlslcc_movcTemp.z = (u_xlatb13.z) ? u_xlat11.z : u_xlat12.z;
					                u_xlat11 = hlslcc_movcTemp;
					            }
					            u_xlat44 = min(u_xlat11.y, u_xlat11.x);
					            u_xlat44 = min(u_xlat11.z, u_xlat44);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat5.xyz = u_xlat10.xyz * vec3(u_xlat44) + u_xlat0.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat5.xyz, 6.0);
					        u_xlat0.x = u_xlat5.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat0.x + 1.0;
					        u_xlat0.x = log2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.y;
					        u_xlat0.x = exp2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xxx;
					        u_xlat5.xyz = vec3(u_xlat43) * u_xlat8.xyz + (-u_xlat0.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat42) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat1.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat42 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
					    u_xlat43 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = max(u_xlat1.x, 0.100000001);
					    u_xlat1.x = u_xlat1.x * 6.00012016;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vec3(0.0399999991, 0.0399999991, 0.0399999991) + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat42 = (-u_xlat43) + 1.0;
					    u_xlat42 = u_xlat42 * u_xlat42;
					    u_xlat42 = u_xlat42 * u_xlat42;
					    u_xlat42 = u_xlat42 * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    u_xlat42 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat42 = (-u_xlat42) + 1.0;
					    u_xlat42 = u_xlat42 * _ProjectionParams.z;
					    u_xlat42 = max(u_xlat42, 0.0);
					    u_xlat42 = u_xlat42 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat42) * u_xlat0.xyz + unity_FogColor.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					bvec3 u_xlatb13;
					vec3 u_xlat15;
					vec3 u_xlat16;
					float u_xlat17;
					float u_xlat29;
					vec2 u_xlat31;
					float u_xlat42;
					float u_xlat43;
					bool u_xlatb43;
					float u_xlat44;
					bool u_xlatb44;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat2.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4.x = 0.0;
					    u_xlat4.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat3.xy = u_xlat3.xy + u_xlat4.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat43 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat43) + (-vec2(_NormalRange));
					    u_xlat31.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat43 = u_xlat31.y + u_xlat31.x;
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat4.z = sqrt(u_xlat43);
					    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat43 = inversesqrt(u_xlat43);
					    u_xlat4.xyz = vec3(u_xlat43) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat43 = vs_TEXCOORD5.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD5.zxy / vec3(u_xlat43);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat43 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat43 = float(1.0) / u_xlat43;
					    u_xlat44 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat44 = float(1.0) / u_xlat44;
					    u_xlat43 = u_xlat43 + (-u_xlat44);
					    u_xlat43 = min(abs(u_xlat43), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat44 = u_xlat3.y * u_xlat5.w;
					    u_xlat44 = u_xlat44 * vs_COLOR0.w;
					    u_xlat43 = u_xlat43 * u_xlat44;
					    SV_Target0.w = u_xlat43 * _Color.w;
					    u_xlatb43 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb43){
					        u_xlatb44 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb44)) ? u_xlat5.xyz : u_xlat0.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat44 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat44, u_xlat17);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat44 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat17 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat5.xyz;
					    u_xlat17 = dot((-u_xlat2.xyz), u_xlat4.xyz);
					    u_xlat17 = u_xlat17 + u_xlat17;
					    u_xlat5.xyz = u_xlat4.xyz * (-vec3(u_xlat17)) + (-u_xlat2.xyz);
					    u_xlat6.xyz = vec3(u_xlat44) * _LightColor0.xyz;
					    if(u_xlatb43){
					        u_xlatb43 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb43)) ? u_xlat7.xyz : u_xlat0.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat43 = u_xlat7.y * 0.25;
					        u_xlat44 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat17 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat43 = max(u_xlat43, u_xlat44);
					        u_xlat7.x = min(u_xlat17, u_xlat43);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					        u_xlat9.xyz = u_xlat7.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat9 = texture(unity_ProbeVolumeSH, u_xlat9.xyz);
					        u_xlat7.xyz = u_xlat7.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(u_xlat8, u_xlat4);
					        u_xlat8.y = dot(u_xlat9, u_xlat4);
					        u_xlat8.z = dot(u_xlat7, u_xlat4);
					    } else {
					        u_xlat4.w = 1.0;
					        u_xlat8.x = dot(unity_SHAr, u_xlat4);
					        u_xlat8.y = dot(unity_SHAg, u_xlat4);
					        u_xlat8.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat7.xyz = u_xlat8.xyz + vs_TEXCOORD6.xyz;
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb43 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb43){
					        u_xlat43 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat43 = inversesqrt(u_xlat43);
					        u_xlat8.xyz = vec3(u_xlat43) * u_xlat5.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					        u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					        u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat9;
					            hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					            hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					            hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					            u_xlat9 = hlslcc_movcTemp;
					        }
					        u_xlat43 = min(u_xlat9.y, u_xlat9.x);
					        u_xlat43 = min(u_xlat9.z, u_xlat43);
					        u_xlat9.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat43) + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat5.xyz;
					    }
					    u_xlat8 = textureLod(unity_SpecCube0, u_xlat8.xyz, 6.0);
					    u_xlat43 = u_xlat8.w + -1.0;
					    u_xlat43 = unity_SpecCube0_HDR.w * u_xlat43 + 1.0;
					    u_xlat43 = log2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.y;
					    u_xlat43 = exp2(u_xlat43);
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.x;
					    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat43);
					    u_xlatb44 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb44){
					        u_xlatb44 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb44){
					            u_xlat44 = dot(u_xlat5.xyz, u_xlat5.xyz);
					            u_xlat44 = inversesqrt(u_xlat44);
					            u_xlat10.xyz = vec3(u_xlat44) * u_xlat5.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat10.xyz;
					            u_xlat12.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat12.xyz = u_xlat12.xyz / u_xlat10.xyz;
					            u_xlatb13.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat10.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat11;
					                hlslcc_movcTemp.x = (u_xlatb13.x) ? u_xlat11.x : u_xlat12.x;
					                hlslcc_movcTemp.y = (u_xlatb13.y) ? u_xlat11.y : u_xlat12.y;
					                hlslcc_movcTemp.z = (u_xlatb13.z) ? u_xlat11.z : u_xlat12.z;
					                u_xlat11 = hlslcc_movcTemp;
					            }
					            u_xlat44 = min(u_xlat11.y, u_xlat11.x);
					            u_xlat44 = min(u_xlat11.z, u_xlat44);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat5.xyz = u_xlat10.xyz * vec3(u_xlat44) + u_xlat0.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat5.xyz, 6.0);
					        u_xlat0.x = u_xlat5.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat0.x + 1.0;
					        u_xlat0.x = log2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.y;
					        u_xlat0.x = exp2(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat5.xyz * u_xlat0.xxx;
					        u_xlat5.xyz = vec3(u_xlat43) * u_xlat8.xyz + (-u_xlat0.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat42) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat1.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat42 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat43 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat15.x = dot(u_xlat1.xx, u_xlat1.xx);
					    u_xlat15.x = u_xlat15.x + -0.5;
					    u_xlat29 = (-u_xlat43) + 1.0;
					    u_xlat2.x = u_xlat29 * u_xlat29;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat29 = u_xlat29 * u_xlat2.x;
					    u_xlat29 = u_xlat15.x * u_xlat29 + 1.0;
					    u_xlat2.x = -abs(u_xlat42) + 1.0;
					    u_xlat16.x = u_xlat2.x * u_xlat2.x;
					    u_xlat16.x = u_xlat16.x * u_xlat16.x;
					    u_xlat2.x = u_xlat2.x * u_xlat16.x;
					    u_xlat15.x = u_xlat15.x * u_xlat2.x + 1.0;
					    u_xlat15.x = u_xlat15.x * u_xlat29;
					    u_xlat15.x = u_xlat43 * u_xlat15.x;
					    u_xlat42 = abs(u_xlat42) + u_xlat43;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat42 = u_xlat42 * 0.999999881;
					    u_xlat42 = u_xlat43 * u_xlat42;
					    u_xlat15.xyz = u_xlat6.xyz * u_xlat15.xxx + u_xlat7.xyz;
					    u_xlat16.xyz = u_xlat6.xyz * vec3(u_xlat42);
					    u_xlat42 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat42 * u_xlat42;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat42 = u_xlat42 * u_xlat1.x;
					    u_xlat42 = u_xlat42 * 0.959999979 + 0.0399999991;
					    u_xlat16.xyz = vec3(u_xlat42) * u_xlat16.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat15.xyz + u_xlat16.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat42 = u_xlat2.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    u_xlat42 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat42 = (-u_xlat42) + 1.0;
					    u_xlat42 = u_xlat42 * _ProjectionParams.z;
					    u_xlat42 = max(u_xlat42, 0.0);
					    u_xlat42 = u_xlat42 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat42) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 125718
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat17 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat17 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat17 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat0.zw;
					    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat0.zw;
					    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat0.zw;
					    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat17 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat17 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat17 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat17 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat17 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat17 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat2.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat2.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat2.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat2.ww + u_xlat0.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat0.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat0.x;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat2.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat2.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat2.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat2.ww + u_xlat0.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat0.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat0.x;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat2.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat2.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat2.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat2.ww + u_xlat0.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat0.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat0.x;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat3.xyz = vec3(u_xlat11) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat11 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat11) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat6 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat6 * 0.5;
					    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat3.xyz = vec3(u_xlat11) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat11 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat11) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat6 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat6 * 0.5;
					    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat3.xyz = vec3(u_xlat11) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat11 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat11) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat6 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat6 * 0.5;
					    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat8;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD8 = u_xlat0.z;
					    vs_TEXCOORD6.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat8 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat8) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat4 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat4 * 0.5;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat8;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD8 = u_xlat0.z;
					    vs_TEXCOORD6.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat8 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat8) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat4 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat4 * 0.5;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat8;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD8 = u_xlat0.z;
					    vs_TEXCOORD6.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat8 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat8) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_TEXCOORD4.z = u_xlat1.x;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat4 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat4 * 0.5;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat3.xyz = vec3(u_xlat11) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat11 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat11) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat6 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat6 * 0.5;
					    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat3.xyz = vec3(u_xlat11) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat11 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat11) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat6 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat6 * 0.5;
					    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat3.xyz = vec3(u_xlat11) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat11 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat11) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat6 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat6 * 0.5;
					    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat3.xyz = vec3(u_xlat11) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat11 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat11) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat6 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat6 * 0.5;
					    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat3.xyz = vec3(u_xlat11) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat11 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat11) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat6 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat6 * 0.5;
					    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat11 = inversesqrt(u_xlat11);
					    u_xlat3.xyz = vec3(u_xlat11) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat11 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat11) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.x = u_xlat3.x;
					    vs_TEXCOORD4.x = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_TEXCOORD4.z = u_xlat2.x;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat6 = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat6 * 0.5;
					    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat2.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat2.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat2.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat2.ww + u_xlat0.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD8 = u_xlat1.z;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat0.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat0.x;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat2.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat2.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat2.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat2.ww + u_xlat0.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD8 = u_xlat1.z;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat0.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat0.x;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _tex4coord_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD7;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD5.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat2.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat2.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat2.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat2.ww + u_xlat0.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD8 = u_xlat1.z;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD2.y = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.z;
					    vs_TEXCOORD2.z = u_xlat0.y;
					    vs_TEXCOORD3.x = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat0.x;
					    vs_TEXCOORD3.y = u_xlat3.y;
					    vs_TEXCOORD4.y = u_xlat3.z;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat21 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat21) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat21 = u_xlat16.y + u_xlat16.x;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat3.z = sqrt(u_xlat21);
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat21 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat21);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat21 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat21 = float(1.0) / u_xlat21;
					    u_xlat22 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat21 = u_xlat21 + (-u_xlat22);
					    u_xlat21 = min(abs(u_xlat21), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat22 = u_xlat2.y * u_xlat4.w;
					    u_xlat22 = u_xlat22 * vs_COLOR0.w;
					    u_xlat21 = u_xlat21 * u_xlat22;
					    SV_Target0.w = u_xlat21 * _Color.w;
					    u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb21 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb21){
					        u_xlatb21 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb21)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat21 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat22 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat21, u_xlat22);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat21 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTexture0, vec2(u_xlat22));
					    u_xlat21 = u_xlat21 * u_xlat4.x;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat21 = u_xlat21 + u_xlat21;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat9;
					vec2 u_xlat16;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat22 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat22) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat22 = u_xlat16.y + u_xlat16.x;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat22 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat22);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat22 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat24 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat24 = float(1.0) / u_xlat24;
					    u_xlat22 = u_xlat22 + (-u_xlat24);
					    u_xlat22 = min(abs(u_xlat22), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat9 = u_xlat2.y * u_xlat4.w;
					    u_xlat9 = u_xlat9 * vs_COLOR0.w;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    SV_Target0.w = u_xlat22 * _Color.w;
					    u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat9);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTexture0, vec2(u_xlat9));
					    u_xlat22 = u_xlat22 * u_xlat4.x;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat24;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat3.y = _ScrollSpeed * _Time.y;
					    u_xlat19.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3.x = _Time.y;
					    u_xlat3.xy = u_xlat3.xy * vec2(0.0, -1.0) + u_xlat19.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat25 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat25) + (-vec2(_NormalRange));
					    u_xlat19.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat25 = u_xlat19.y + u_xlat19.x;
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat4.z = sqrt(u_xlat25);
					    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat25 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat25);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat25 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat25 = float(1.0) / u_xlat25;
					    u_xlat26 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat26 = float(1.0) / u_xlat26;
					    u_xlat25 = u_xlat25 + (-u_xlat26);
					    u_xlat25 = min(abs(u_xlat25), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat26 = u_xlat3.y * u_xlat5.w;
					    u_xlat26 = u_xlat26 * vs_COLOR0.w;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    SV_Target0.w = u_xlat25 * _Color.w;
					    u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb25){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb25)) ? u_xlat6.xyz : vs_TEXCOORD5.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat25, u_xlat26);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5 = texture(_LightTexture0, vec2(u_xlat26));
					    u_xlat25 = u_xlat25 * u_xlat5.x;
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat26 = inversesqrt(u_xlat26);
					    u_xlat4.xyz = vec3(u_xlat26) * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat25 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat25) + 1.0;
					    u_xlat1.x = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat1.x;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat1.x = -abs(u_xlat24) + 1.0;
					    u_xlat9 = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat9 * u_xlat9;
					    u_xlat1.x = u_xlat1.x * u_xlat9;
					    u_xlat8.x = u_xlat8.x * u_xlat1.x + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = abs(u_xlat24) + u_xlat25;
					    u_xlat16 = u_xlat16 + 9.99999975e-06;
					    u_xlat16 = 0.5 / u_xlat16;
					    u_xlat8.y = u_xlat16 * 0.999999881;
					    u_xlat8.xy = vec2(u_xlat25) * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat5.xyz;
					    u_xlat8.xyz = u_xlat5.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat7;
					vec2 u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.y = _ScrollSpeed * _Time.y;
					    u_xlat13.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = _Time.y;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.0, -1.0) + u_xlat13.xy;
					    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD1.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat18 = _NormalRange + _NormalRange;
					    u_xlat2.xy = u_xlat1.yz * vec2(u_xlat18) + (-vec2(_NormalRange));
					    u_xlat13.xy = u_xlat2.xy * u_xlat2.xy;
					    u_xlat18 = u_xlat13.y + u_xlat13.x;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat2.z = sqrt(u_xlat18);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat1.xzw = u_xlat1.xxx + _AlbedoBoost.xyz;
					    u_xlat1.xzw = clamp(u_xlat1.xzw, 0.0, 1.0);
					    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.xyz;
					    u_xlat1.xzw = u_xlat1.xzw * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat18 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat4.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat18);
					    u_xlat5 = texture(_CameraDepthTexture, u_xlat4.yz);
					    u_xlat18 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat18 = float(1.0) / u_xlat18;
					    u_xlat20 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat18 = u_xlat18 + (-u_xlat20);
					    u_xlat18 = min(abs(u_xlat18), 1.0);
					    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
					    u_xlat7 = u_xlat1.y * u_xlat3.w;
					    u_xlat7 = u_xlat7 * vs_COLOR0.w;
					    u_xlat18 = u_xlat18 * u_xlat7;
					    SV_Target0.w = u_xlat18 * _Color.w;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD5.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat7 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat7);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat3.x = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat3.y = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
					    u_xlat7 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    u_xlat2.xyz = vec3(u_xlat7) * u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat18)) + u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat13;
					float u_xlat15;
					float u_xlat18;
					float u_xlat19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.y = _ScrollSpeed * _Time.y;
					    u_xlat13.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = _Time.y;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.0, -1.0) + u_xlat13.xy;
					    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD1.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat19 = _NormalRange + _NormalRange;
					    u_xlat2.xy = u_xlat1.yz * vec2(u_xlat19) + (-vec2(_NormalRange));
					    u_xlat13.xy = u_xlat2.xy * u_xlat2.xy;
					    u_xlat13.x = u_xlat13.y + u_xlat13.x;
					    u_xlat13.x = (-u_xlat13.x) + 1.0;
					    u_xlat2.z = sqrt(u_xlat13.x);
					    u_xlat13.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13.x = inversesqrt(u_xlat13.x);
					    u_xlat2.xyz = u_xlat13.xxx * u_xlat2.xyz;
					    u_xlat1.xzw = u_xlat1.xxx + _AlbedoBoost.xyz;
					    u_xlat1.xzw = clamp(u_xlat1.xzw, 0.0, 1.0);
					    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.xyz;
					    u_xlat1.xzw = u_xlat1.xzw * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat20 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat4.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat20);
					    u_xlat5 = texture(_CameraDepthTexture, u_xlat4.yz);
					    u_xlat20 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat15 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat15 = float(1.0) / u_xlat15;
					    u_xlat20 = u_xlat20 + (-u_xlat15);
					    u_xlat20 = min(abs(u_xlat20), 1.0);
					    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
					    u_xlat7 = u_xlat1.y * u_xlat3.w;
					    u_xlat7 = u_xlat7 * vs_COLOR0.w;
					    u_xlat7 = u_xlat20 * u_xlat7;
					    SV_Target0.w = u_xlat7 * _Color.w;
					    u_xlatb7 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb7){
					        u_xlatb7 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb7)) ? u_xlat3.xyz : vs_TEXCOORD5.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat7 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat20 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat7, u_xlat20);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat7 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat3.x = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat3.y = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat7) * _LightColor0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat15;
					vec2 u_xlat16;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat22 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat22) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat22 = u_xlat16.y + u_xlat16.x;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat22 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat22);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat22 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat24 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat24 = float(1.0) / u_xlat24;
					    u_xlat22 = u_xlat22 + (-u_xlat24);
					    u_xlat22 = min(abs(u_xlat22), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat9 = u_xlat2.y * u_xlat4.w;
					    u_xlat9 = u_xlat9 * vs_COLOR0.w;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    SV_Target0.w = u_xlat22 * _Color.w;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : vs_TEXCOORD5.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat22, u_xlat9);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat2.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat8 = u_xlat14 * u_xlat14;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat8;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat8 = -abs(u_xlat21) + 1.0;
					    u_xlat15 = u_xlat8 * u_xlat8;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat8 = u_xlat8 * u_xlat15;
					    u_xlat7.x = u_xlat7.x * u_xlat8 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat1.x;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat7.y = u_xlat14 * 0.999999881;
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat4.xyz;
					    u_xlat7.xyz = u_xlat4.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat9;
					vec2 u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat21 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat21) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat21 = u_xlat16.y + u_xlat16.x;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat3.z = sqrt(u_xlat21);
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat21 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat21);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat21 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat21 = float(1.0) / u_xlat21;
					    u_xlat22 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat21 = u_xlat21 + (-u_xlat22);
					    u_xlat21 = min(abs(u_xlat21), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat22 = u_xlat2.y * u_xlat4.w;
					    u_xlat22 = u_xlat22 * vs_COLOR0.w;
					    u_xlat21 = u_xlat21 * u_xlat22;
					    SV_Target0.w = u_xlat21 * _Color.w;
					    u_xlat4 = vs_TEXCOORD5.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD5.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD5.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlatb21 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb21){
					        u_xlatb21 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb21)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat21 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat22 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat21, u_xlat22);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat21 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlatb22 = 0.0<u_xlat4.z;
					    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					    u_xlat5.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat22 = u_xlat22 * u_xlat5.w;
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat9));
					    u_xlat22 = u_xlat22 * u_xlat4.x;
					    u_xlat21 = u_xlat21 * u_xlat22;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat21 = u_xlat21 + u_xlat21;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					vec2 u_xlat16;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat22 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat22) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat22 = u_xlat16.y + u_xlat16.x;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat22 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat22);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat22 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat24 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat24 = float(1.0) / u_xlat24;
					    u_xlat22 = u_xlat22 + (-u_xlat24);
					    u_xlat22 = min(abs(u_xlat22), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat9 = u_xlat2.y * u_xlat4.w;
					    u_xlat9 = u_xlat9 * vs_COLOR0.w;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    SV_Target0.w = u_xlat22 * _Color.w;
					    u_xlat4 = vs_TEXCOORD5.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD5.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD5.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat9);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb9 = 0.0<u_xlat4.z;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat5.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat9 = u_xlat9 * u_xlat5.w;
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat24));
					    u_xlat9 = u_xlat9 * u_xlat4.x;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat11;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat24;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat26;
					bool u_xlatb26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4.x = 0.0;
					    u_xlat4.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat3.xy = u_xlat3.xy + u_xlat4.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat25 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat25) + (-vec2(_NormalRange));
					    u_xlat19.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat25 = u_xlat19.y + u_xlat19.x;
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat4.z = sqrt(u_xlat25);
					    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat25 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat25);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat25 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat25 = float(1.0) / u_xlat25;
					    u_xlat26 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat26 = float(1.0) / u_xlat26;
					    u_xlat25 = u_xlat25 + (-u_xlat26);
					    u_xlat25 = min(abs(u_xlat25), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat26 = u_xlat3.y * u_xlat5.w;
					    u_xlat26 = u_xlat26 * vs_COLOR0.w;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    SV_Target0.w = u_xlat25 * _Color.w;
					    u_xlat5 = vs_TEXCOORD5.yyyy * unity_WorldToLight[1];
					    u_xlat5 = unity_WorldToLight[0] * vs_TEXCOORD5.xxxx + u_xlat5;
					    u_xlat5 = unity_WorldToLight[2] * vs_TEXCOORD5.zzzz + u_xlat5;
					    u_xlat5 = u_xlat5 + unity_WorldToLight[3];
					    u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb25){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb25)) ? u_xlat6.xyz : vs_TEXCOORD5.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat25, u_xlat26);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlatb26 = 0.0<u_xlat5.z;
					    u_xlat26 = u_xlatb26 ? 1.0 : float(0.0);
					    u_xlat6.xy = u_xlat5.xy / u_xlat5.ww;
					    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
					    u_xlat6 = texture(_LightTexture0, u_xlat6.xy);
					    u_xlat26 = u_xlat26 * u_xlat6.w;
					    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5 = texture(_LightTextureB0, vec2(u_xlat11));
					    u_xlat26 = u_xlat26 * u_xlat5.x;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat26 = inversesqrt(u_xlat26);
					    u_xlat4.xyz = vec3(u_xlat26) * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat25 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat25) + 1.0;
					    u_xlat1.x = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat1.x;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat1.x = -abs(u_xlat24) + 1.0;
					    u_xlat9 = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat9 * u_xlat9;
					    u_xlat1.x = u_xlat1.x * u_xlat9;
					    u_xlat8.x = u_xlat8.x * u_xlat1.x + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = abs(u_xlat24) + u_xlat25;
					    u_xlat16 = u_xlat16 + 9.99999975e-06;
					    u_xlat16 = 0.5 / u_xlat16;
					    u_xlat8.y = u_xlat16 * 0.999999881;
					    u_xlat8.xy = vec2(u_xlat25) * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat5.xyz;
					    u_xlat8.xyz = u_xlat5.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat21 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat21) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat21 = u_xlat16.y + u_xlat16.x;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat3.z = sqrt(u_xlat21);
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat21 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat21);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat21 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat21 = float(1.0) / u_xlat21;
					    u_xlat22 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat21 = u_xlat21 + (-u_xlat22);
					    u_xlat21 = min(abs(u_xlat21), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat22 = u_xlat2.y * u_xlat4.w;
					    u_xlat22 = u_xlat22 * vs_COLOR0.w;
					    u_xlat21 = u_xlat21 * u_xlat22;
					    SV_Target0.w = u_xlat21 * _Color.w;
					    u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb21 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb21){
					        u_xlatb21 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb21)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat21 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat22 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat21, u_xlat22);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat21 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat5 = texture(_LightTextureB0, vec2(u_xlat22));
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xyz);
					    u_xlat22 = u_xlat4.w * u_xlat5.x;
					    u_xlat21 = u_xlat21 * u_xlat22;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat21 = u_xlat21 + u_xlat21;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat9;
					vec2 u_xlat16;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat22 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat22) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat22 = u_xlat16.y + u_xlat16.x;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat22 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat22);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat22 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat24 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat24 = float(1.0) / u_xlat24;
					    u_xlat22 = u_xlat22 + (-u_xlat24);
					    u_xlat22 = min(abs(u_xlat22), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat9 = u_xlat2.y * u_xlat4.w;
					    u_xlat9 = u_xlat9 * vs_COLOR0.w;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    SV_Target0.w = u_xlat22 * _Color.w;
					    u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat9);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat5 = texture(_LightTextureB0, vec2(u_xlat9));
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xyz);
					    u_xlat9 = u_xlat4.w * u_xlat5.x;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat24;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat3.y = _ScrollSpeed * _Time.y;
					    u_xlat19.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3.x = _Time.y;
					    u_xlat3.xy = u_xlat3.xy * vec2(0.0, -1.0) + u_xlat19.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat25 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat25) + (-vec2(_NormalRange));
					    u_xlat19.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat25 = u_xlat19.y + u_xlat19.x;
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat4.z = sqrt(u_xlat25);
					    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat25 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat25);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat25 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat25 = float(1.0) / u_xlat25;
					    u_xlat26 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat26 = float(1.0) / u_xlat26;
					    u_xlat25 = u_xlat25 + (-u_xlat26);
					    u_xlat25 = min(abs(u_xlat25), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat26 = u_xlat3.y * u_xlat5.w;
					    u_xlat26 = u_xlat26 * vs_COLOR0.w;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    SV_Target0.w = u_xlat25 * _Color.w;
					    u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb25){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb25)) ? u_xlat6.xyz : vs_TEXCOORD5.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat25, u_xlat26);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat6 = texture(_LightTextureB0, vec2(u_xlat26));
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xyz);
					    u_xlat26 = u_xlat5.w * u_xlat6.x;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat26 = inversesqrt(u_xlat26);
					    u_xlat4.xyz = vec3(u_xlat26) * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat25 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat25) + 1.0;
					    u_xlat1.x = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat1.x;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat1.x = -abs(u_xlat24) + 1.0;
					    u_xlat9 = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat9 * u_xlat9;
					    u_xlat1.x = u_xlat1.x * u_xlat9;
					    u_xlat8.x = u_xlat8.x * u_xlat1.x + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = abs(u_xlat24) + u_xlat25;
					    u_xlat16 = u_xlat16 + 9.99999975e-06;
					    u_xlat16 = 0.5 / u_xlat16;
					    u_xlat8.y = u_xlat16 * 0.999999881;
					    u_xlat8.xy = vec2(u_xlat25) * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat5.xyz;
					    u_xlat8.xyz = u_xlat5.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat7;
					vec2 u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.y = _ScrollSpeed * _Time.y;
					    u_xlat13.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = _Time.y;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.0, -1.0) + u_xlat13.xy;
					    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD1.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat18 = _NormalRange + _NormalRange;
					    u_xlat2.xy = u_xlat1.yz * vec2(u_xlat18) + (-vec2(_NormalRange));
					    u_xlat13.xy = u_xlat2.xy * u_xlat2.xy;
					    u_xlat18 = u_xlat13.y + u_xlat13.x;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat2.z = sqrt(u_xlat18);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat1.xzw = u_xlat1.xxx + _AlbedoBoost.xyz;
					    u_xlat1.xzw = clamp(u_xlat1.xzw, 0.0, 1.0);
					    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.xyz;
					    u_xlat1.xzw = u_xlat1.xzw * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat18 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat4.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat18);
					    u_xlat5 = texture(_CameraDepthTexture, u_xlat4.yz);
					    u_xlat18 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat18 = float(1.0) / u_xlat18;
					    u_xlat20 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat18 = u_xlat18 + (-u_xlat20);
					    u_xlat18 = min(abs(u_xlat18), 1.0);
					    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
					    u_xlat7 = u_xlat1.y * u_xlat3.w;
					    u_xlat7 = u_xlat7 * vs_COLOR0.w;
					    u_xlat18 = u_xlat18 * u_xlat7;
					    SV_Target0.w = u_xlat18 * _Color.w;
					    u_xlat3.xy = vs_TEXCOORD5.yy * unity_WorldToLight[1].xy;
					    u_xlat3.xy = unity_WorldToLight[0].xy * vs_TEXCOORD5.xx + u_xlat3.xy;
					    u_xlat3.xy = unity_WorldToLight[2].xy * vs_TEXCOORD5.zz + u_xlat3.xy;
					    u_xlat3.xy = u_xlat3.xy + unity_WorldToLight[3].xy;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb18)) ? u_xlat4.xyz : vs_TEXCOORD5.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat7 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat18, u_xlat7);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat18 = u_xlat18 * u_xlat3.w;
					    u_xlat3.x = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat3.y = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
					    u_xlat7 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    u_xlat2.xyz = vec3(u_xlat7) * u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat18)) + u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat13;
					float u_xlat15;
					float u_xlat18;
					float u_xlat19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.y = _ScrollSpeed * _Time.y;
					    u_xlat13.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = _Time.y;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.0, -1.0) + u_xlat13.xy;
					    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD1.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat19 = _NormalRange + _NormalRange;
					    u_xlat2.xy = u_xlat1.yz * vec2(u_xlat19) + (-vec2(_NormalRange));
					    u_xlat13.xy = u_xlat2.xy * u_xlat2.xy;
					    u_xlat13.x = u_xlat13.y + u_xlat13.x;
					    u_xlat13.x = (-u_xlat13.x) + 1.0;
					    u_xlat2.z = sqrt(u_xlat13.x);
					    u_xlat13.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13.x = inversesqrt(u_xlat13.x);
					    u_xlat2.xyz = u_xlat13.xxx * u_xlat2.xyz;
					    u_xlat1.xzw = u_xlat1.xxx + _AlbedoBoost.xyz;
					    u_xlat1.xzw = clamp(u_xlat1.xzw, 0.0, 1.0);
					    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.xyz;
					    u_xlat1.xzw = u_xlat1.xzw * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat20 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat4.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat20);
					    u_xlat5 = texture(_CameraDepthTexture, u_xlat4.yz);
					    u_xlat20 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat15 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat15 = float(1.0) / u_xlat15;
					    u_xlat20 = u_xlat20 + (-u_xlat15);
					    u_xlat20 = min(abs(u_xlat20), 1.0);
					    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
					    u_xlat7 = u_xlat1.y * u_xlat3.w;
					    u_xlat7 = u_xlat7 * vs_COLOR0.w;
					    u_xlat7 = u_xlat20 * u_xlat7;
					    SV_Target0.w = u_xlat7 * _Color.w;
					    u_xlat3.xy = vs_TEXCOORD5.yy * unity_WorldToLight[1].xy;
					    u_xlat3.xy = unity_WorldToLight[0].xy * vs_TEXCOORD5.xx + u_xlat3.xy;
					    u_xlat3.xy = unity_WorldToLight[2].xy * vs_TEXCOORD5.zz + u_xlat3.xy;
					    u_xlat3.xy = u_xlat3.xy + unity_WorldToLight[3].xy;
					    u_xlatb7 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb7){
					        u_xlatb7 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : vs_TEXCOORD5.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat7 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat20 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat7, u_xlat20);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat7 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat7 = u_xlat7 * u_xlat3.w;
					    u_xlat3.x = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat3.y = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat7) * _LightColor0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat15;
					vec2 u_xlat16;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat22 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat22) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat22 = u_xlat16.y + u_xlat16.x;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat22 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat22);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat22 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat24 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat24 = float(1.0) / u_xlat24;
					    u_xlat22 = u_xlat22 + (-u_xlat24);
					    u_xlat22 = min(abs(u_xlat22), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat9 = u_xlat2.y * u_xlat4.w;
					    u_xlat9 = u_xlat9 * vs_COLOR0.w;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    SV_Target0.w = u_xlat22 * _Color.w;
					    u_xlat4.xy = vs_TEXCOORD5.yy * unity_WorldToLight[1].xy;
					    u_xlat4.xy = unity_WorldToLight[0].xy * vs_TEXCOORD5.xx + u_xlat4.xy;
					    u_xlat4.xy = unity_WorldToLight[2].xy * vs_TEXCOORD5.zz + u_xlat4.xy;
					    u_xlat4.xy = u_xlat4.xy + unity_WorldToLight[3].xy;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat9);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xy);
					    u_xlat22 = u_xlat22 * u_xlat4.w;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat2.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat8 = u_xlat14 * u_xlat14;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat8;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat8 = -abs(u_xlat21) + 1.0;
					    u_xlat15 = u_xlat8 * u_xlat8;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat8 = u_xlat8 * u_xlat15;
					    u_xlat7.x = u_xlat7.x * u_xlat8 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat1.x;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat7.y = u_xlat14 * 0.999999881;
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat4.xyz;
					    u_xlat7.xyz = u_xlat4.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat21 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat21) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat21 = u_xlat16.y + u_xlat16.x;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat3.z = sqrt(u_xlat21);
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat21 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat21);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat21 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat21 = float(1.0) / u_xlat21;
					    u_xlat22 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat21 = u_xlat21 + (-u_xlat22);
					    u_xlat21 = min(abs(u_xlat21), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat22 = u_xlat2.y * u_xlat4.w;
					    u_xlat22 = u_xlat22 * vs_COLOR0.w;
					    u_xlat21 = u_xlat21 * u_xlat22;
					    SV_Target0.w = u_xlat21 * _Color.w;
					    u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb21 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb21){
					        u_xlatb21 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb21)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat21 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat22 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat21, u_xlat22);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat21 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTexture0, vec2(u_xlat22));
					    u_xlat21 = u_xlat21 * u_xlat4.x;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat21 = u_xlat21 + u_xlat21;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat21 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat9;
					vec2 u_xlat16;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat22 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat22) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat22 = u_xlat16.y + u_xlat16.x;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat22 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat22);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat22 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat24 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat24 = float(1.0) / u_xlat24;
					    u_xlat22 = u_xlat22 + (-u_xlat24);
					    u_xlat22 = min(abs(u_xlat22), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat9 = u_xlat2.y * u_xlat4.w;
					    u_xlat9 = u_xlat9 * vs_COLOR0.w;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    SV_Target0.w = u_xlat22 * _Color.w;
					    u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat9);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTexture0, vec2(u_xlat9));
					    u_xlat22 = u_xlat22 * u_xlat4.x;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat24;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4.x = 0.0;
					    u_xlat4.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat3.xy = u_xlat3.xy + u_xlat4.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat25 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat25) + (-vec2(_NormalRange));
					    u_xlat19.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat25 = u_xlat19.y + u_xlat19.x;
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat4.z = sqrt(u_xlat25);
					    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat25 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat25);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat25 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat25 = float(1.0) / u_xlat25;
					    u_xlat26 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat26 = float(1.0) / u_xlat26;
					    u_xlat25 = u_xlat25 + (-u_xlat26);
					    u_xlat25 = min(abs(u_xlat25), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat26 = u_xlat3.y * u_xlat5.w;
					    u_xlat26 = u_xlat26 * vs_COLOR0.w;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    SV_Target0.w = u_xlat25 * _Color.w;
					    u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb25){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb25)) ? u_xlat6.xyz : vs_TEXCOORD5.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat25, u_xlat26);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5 = texture(_LightTexture0, vec2(u_xlat26));
					    u_xlat25 = u_xlat25 * u_xlat5.x;
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat26 = inversesqrt(u_xlat26);
					    u_xlat4.xyz = vec3(u_xlat26) * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat25 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat25) + 1.0;
					    u_xlat1.x = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat1.x;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat1.x = -abs(u_xlat24) + 1.0;
					    u_xlat9 = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat9 * u_xlat9;
					    u_xlat1.x = u_xlat1.x * u_xlat9;
					    u_xlat8.x = u_xlat8.x * u_xlat1.x + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = abs(u_xlat24) + u_xlat25;
					    u_xlat16 = u_xlat16 + 9.99999975e-06;
					    u_xlat16 = 0.5 / u_xlat16;
					    u_xlat8.y = u_xlat16 * 0.999999881;
					    u_xlat8.xy = vec2(u_xlat25) * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat5.xyz;
					    u_xlat8.xyz = u_xlat5.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat24 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat24 = u_xlat24 * _ProjectionParams.z;
					    u_xlat24 = max(u_xlat24, 0.0);
					    u_xlat24 = u_xlat24 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat24);
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat7;
					vec2 u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.y = _ScrollSpeed * _Time.y;
					    u_xlat13.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = _Time.y;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.0, -1.0) + u_xlat13.xy;
					    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD1.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat18 = _NormalRange + _NormalRange;
					    u_xlat2.xy = u_xlat1.yz * vec2(u_xlat18) + (-vec2(_NormalRange));
					    u_xlat13.xy = u_xlat2.xy * u_xlat2.xy;
					    u_xlat18 = u_xlat13.y + u_xlat13.x;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat2.z = sqrt(u_xlat18);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat1.xzw = u_xlat1.xxx + _AlbedoBoost.xyz;
					    u_xlat1.xzw = clamp(u_xlat1.xzw, 0.0, 1.0);
					    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.xyz;
					    u_xlat1.xzw = u_xlat1.xzw * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat18 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat4.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat18);
					    u_xlat5 = texture(_CameraDepthTexture, u_xlat4.yz);
					    u_xlat18 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat18 = float(1.0) / u_xlat18;
					    u_xlat20 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat18 = u_xlat18 + (-u_xlat20);
					    u_xlat18 = min(abs(u_xlat18), 1.0);
					    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
					    u_xlat7 = u_xlat1.y * u_xlat3.w;
					    u_xlat7 = u_xlat7 * vs_COLOR0.w;
					    u_xlat18 = u_xlat18 * u_xlat7;
					    SV_Target0.w = u_xlat18 * _Color.w;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD5.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat7 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat7);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat3.x = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat3.y = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
					    u_xlat7 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    u_xlat2.xyz = vec3(u_xlat7) * u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat18)) + u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat18 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat13;
					float u_xlat15;
					float u_xlat18;
					float u_xlat19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.y = _ScrollSpeed * _Time.y;
					    u_xlat13.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = _Time.y;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.0, -1.0) + u_xlat13.xy;
					    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD1.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat19 = _NormalRange + _NormalRange;
					    u_xlat2.xy = u_xlat1.yz * vec2(u_xlat19) + (-vec2(_NormalRange));
					    u_xlat13.xy = u_xlat2.xy * u_xlat2.xy;
					    u_xlat13.x = u_xlat13.y + u_xlat13.x;
					    u_xlat13.x = (-u_xlat13.x) + 1.0;
					    u_xlat2.z = sqrt(u_xlat13.x);
					    u_xlat13.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13.x = inversesqrt(u_xlat13.x);
					    u_xlat2.xyz = u_xlat13.xxx * u_xlat2.xyz;
					    u_xlat1.xzw = u_xlat1.xxx + _AlbedoBoost.xyz;
					    u_xlat1.xzw = clamp(u_xlat1.xzw, 0.0, 1.0);
					    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.xyz;
					    u_xlat1.xzw = u_xlat1.xzw * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat20 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat4.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat20);
					    u_xlat5 = texture(_CameraDepthTexture, u_xlat4.yz);
					    u_xlat20 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat15 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat15 = float(1.0) / u_xlat15;
					    u_xlat20 = u_xlat20 + (-u_xlat15);
					    u_xlat20 = min(abs(u_xlat20), 1.0);
					    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
					    u_xlat7 = u_xlat1.y * u_xlat3.w;
					    u_xlat7 = u_xlat7 * vs_COLOR0.w;
					    u_xlat7 = u_xlat20 * u_xlat7;
					    SV_Target0.w = u_xlat7 * _Color.w;
					    u_xlatb7 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb7){
					        u_xlatb7 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb7)) ? u_xlat3.xyz : vs_TEXCOORD5.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat7 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat20 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat7, u_xlat20);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat7 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat3.x = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat3.y = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat7) * _LightColor0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
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
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat15;
					vec2 u_xlat16;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3.x = 0.0;
					    u_xlat3.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat2.xy = u_xlat2.xy + u_xlat3.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat22 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat22) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat22 = u_xlat16.y + u_xlat16.x;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat22 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat22);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat22 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat24 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat24 = float(1.0) / u_xlat24;
					    u_xlat22 = u_xlat22 + (-u_xlat24);
					    u_xlat22 = min(abs(u_xlat22), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat9 = u_xlat2.y * u_xlat4.w;
					    u_xlat9 = u_xlat9 * vs_COLOR0.w;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    SV_Target0.w = u_xlat22 * _Color.w;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : vs_TEXCOORD5.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat22, u_xlat9);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat2.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat8 = u_xlat14 * u_xlat14;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat8;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat8 = -abs(u_xlat21) + 1.0;
					    u_xlat15 = u_xlat8 * u_xlat8;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat8 = u_xlat8 * u_xlat15;
					    u_xlat7.x = u_xlat7.x * u_xlat8 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat1.x;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat7.y = u_xlat14 * 0.999999881;
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat4.xyz;
					    u_xlat7.xyz = u_xlat4.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat9;
					vec2 u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat21 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat21) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat21 = u_xlat16.y + u_xlat16.x;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat3.z = sqrt(u_xlat21);
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat21 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat21);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat21 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat21 = float(1.0) / u_xlat21;
					    u_xlat22 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat21 = u_xlat21 + (-u_xlat22);
					    u_xlat21 = min(abs(u_xlat21), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat22 = u_xlat2.y * u_xlat4.w;
					    u_xlat22 = u_xlat22 * vs_COLOR0.w;
					    u_xlat21 = u_xlat21 * u_xlat22;
					    SV_Target0.w = u_xlat21 * _Color.w;
					    u_xlat4 = vs_TEXCOORD5.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD5.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD5.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlatb21 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb21){
					        u_xlatb21 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb21)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat21 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat22 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat21, u_xlat22);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat21 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlatb22 = 0.0<u_xlat4.z;
					    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
					    u_xlat5.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat22 = u_xlat22 * u_xlat5.w;
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat9));
					    u_xlat22 = u_xlat22 * u_xlat4.x;
					    u_xlat21 = u_xlat21 * u_xlat22;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat21 = u_xlat21 + u_xlat21;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat21 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					vec2 u_xlat16;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat22 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat22) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat22 = u_xlat16.y + u_xlat16.x;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat22 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat22);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat22 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat24 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat24 = float(1.0) / u_xlat24;
					    u_xlat22 = u_xlat22 + (-u_xlat24);
					    u_xlat22 = min(abs(u_xlat22), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat9 = u_xlat2.y * u_xlat4.w;
					    u_xlat9 = u_xlat9 * vs_COLOR0.w;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    SV_Target0.w = u_xlat22 * _Color.w;
					    u_xlat4 = vs_TEXCOORD5.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD5.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD5.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat9);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb9 = 0.0<u_xlat4.z;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat5.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat9 = u_xlat9 * u_xlat5.w;
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat24));
					    u_xlat9 = u_xlat9 * u_xlat4.x;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat11;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat24;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat26;
					bool u_xlatb26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat3.y = _ScrollSpeed * _Time.y;
					    u_xlat19.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3.x = _Time.y;
					    u_xlat3.xy = u_xlat3.xy * vec2(0.0, -1.0) + u_xlat19.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat25 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat25) + (-vec2(_NormalRange));
					    u_xlat19.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat25 = u_xlat19.y + u_xlat19.x;
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat4.z = sqrt(u_xlat25);
					    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat25 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat25);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat25 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat25 = float(1.0) / u_xlat25;
					    u_xlat26 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat26 = float(1.0) / u_xlat26;
					    u_xlat25 = u_xlat25 + (-u_xlat26);
					    u_xlat25 = min(abs(u_xlat25), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat26 = u_xlat3.y * u_xlat5.w;
					    u_xlat26 = u_xlat26 * vs_COLOR0.w;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    SV_Target0.w = u_xlat25 * _Color.w;
					    u_xlat5 = vs_TEXCOORD5.yyyy * unity_WorldToLight[1];
					    u_xlat5 = unity_WorldToLight[0] * vs_TEXCOORD5.xxxx + u_xlat5;
					    u_xlat5 = unity_WorldToLight[2] * vs_TEXCOORD5.zzzz + u_xlat5;
					    u_xlat5 = u_xlat5 + unity_WorldToLight[3];
					    u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb25){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb25)) ? u_xlat6.xyz : vs_TEXCOORD5.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat25, u_xlat26);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlatb26 = 0.0<u_xlat5.z;
					    u_xlat26 = u_xlatb26 ? 1.0 : float(0.0);
					    u_xlat6.xy = u_xlat5.xy / u_xlat5.ww;
					    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
					    u_xlat6 = texture(_LightTexture0, u_xlat6.xy);
					    u_xlat26 = u_xlat26 * u_xlat6.w;
					    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5 = texture(_LightTextureB0, vec2(u_xlat11));
					    u_xlat26 = u_xlat26 * u_xlat5.x;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat26 = inversesqrt(u_xlat26);
					    u_xlat4.xyz = vec3(u_xlat26) * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat25 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat25) + 1.0;
					    u_xlat1.x = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat1.x;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat1.x = -abs(u_xlat24) + 1.0;
					    u_xlat9 = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat9 * u_xlat9;
					    u_xlat1.x = u_xlat1.x * u_xlat9;
					    u_xlat8.x = u_xlat8.x * u_xlat1.x + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = abs(u_xlat24) + u_xlat25;
					    u_xlat16 = u_xlat16 + 9.99999975e-06;
					    u_xlat16 = 0.5 / u_xlat16;
					    u_xlat8.y = u_xlat16 * 0.999999881;
					    u_xlat8.xy = vec2(u_xlat25) * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat5.xyz;
					    u_xlat8.xyz = u_xlat5.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat24 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat24 = u_xlat24 * _ProjectionParams.z;
					    u_xlat24 = max(u_xlat24, 0.0);
					    u_xlat24 = u_xlat24 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat24);
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat21 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat21) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat21 = u_xlat16.y + u_xlat16.x;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat3.z = sqrt(u_xlat21);
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat21 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat21);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat21 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat21 = float(1.0) / u_xlat21;
					    u_xlat22 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat21 = u_xlat21 + (-u_xlat22);
					    u_xlat21 = min(abs(u_xlat21), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat22 = u_xlat2.y * u_xlat4.w;
					    u_xlat22 = u_xlat22 * vs_COLOR0.w;
					    u_xlat21 = u_xlat21 * u_xlat22;
					    SV_Target0.w = u_xlat21 * _Color.w;
					    u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb21 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb21){
					        u_xlatb21 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb21)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat21 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat22 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat21, u_xlat22);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat21 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat5 = texture(_LightTextureB0, vec2(u_xlat22));
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xyz);
					    u_xlat22 = u_xlat4.w * u_xlat5.x;
					    u_xlat21 = u_xlat21 * u_xlat22;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat21 = u_xlat21 + u_xlat21;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat21 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat9;
					vec2 u_xlat16;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.y = _ScrollSpeed * _Time.y;
					    u_xlat16.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = _Time.y;
					    u_xlat2.xy = u_xlat2.xy * vec2(0.0, -1.0) + u_xlat16.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat22 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat22) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat22 = u_xlat16.y + u_xlat16.x;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat22 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat22);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat22 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat24 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat24 = float(1.0) / u_xlat24;
					    u_xlat22 = u_xlat22 + (-u_xlat24);
					    u_xlat22 = min(abs(u_xlat22), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat9 = u_xlat2.y * u_xlat4.w;
					    u_xlat9 = u_xlat9 * vs_COLOR0.w;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    SV_Target0.w = u_xlat22 * _Color.w;
					    u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat9);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat5 = texture(_LightTextureB0, vec2(u_xlat9));
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xyz);
					    u_xlat9 = u_xlat4.w * u_xlat5.x;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat24;
					float u_xlat25;
					bool u_xlatb25;
					float u_xlat26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat4.x = 0.0;
					    u_xlat4.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat3.xy = u_xlat3.xy + u_xlat4.xy;
					    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD1.zw;
					    u_xlat3 = texture(_MainTex, u_xlat3.xy);
					    u_xlat25 = _NormalRange + _NormalRange;
					    u_xlat4.xy = u_xlat3.yz * vec2(u_xlat25) + (-vec2(_NormalRange));
					    u_xlat19.xy = u_xlat4.xy * u_xlat4.xy;
					    u_xlat25 = u_xlat19.y + u_xlat19.x;
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat4.z = sqrt(u_xlat25);
					    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat3.xzw = u_xlat3.xxx + _AlbedoBoost.xyz;
					    u_xlat3.xzw = clamp(u_xlat3.xzw, 0.0, 1.0);
					    u_xlat3.xzw = u_xlat3.xzw * vs_COLOR0.xyz;
					    u_xlat3.xzw = u_xlat3.xzw * _Color.xyz;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat25 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat6.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat25);
					    u_xlat7 = texture(_CameraDepthTexture, u_xlat6.yz);
					    u_xlat25 = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
					    u_xlat25 = float(1.0) / u_xlat25;
					    u_xlat26 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat26 = float(1.0) / u_xlat26;
					    u_xlat25 = u_xlat25 + (-u_xlat26);
					    u_xlat25 = min(abs(u_xlat25), 1.0);
					    u_xlat5 = texture(_MaskTex, u_xlat5.xy);
					    u_xlat26 = u_xlat3.y * u_xlat5.w;
					    u_xlat26 = u_xlat26 * vs_COLOR0.w;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    SV_Target0.w = u_xlat25 * _Color.w;
					    u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb25){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb25)) ? u_xlat6.xyz : vs_TEXCOORD5.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat25, u_xlat26);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    }
					    u_xlat25 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat6 = texture(_LightTextureB0, vec2(u_xlat26));
					    u_xlat5 = texture(_LightTexture0, u_xlat5.xyz);
					    u_xlat26 = u_xlat5.w * u_xlat6.x;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat5.x = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD4.xyz, u_xlat4.xyz);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat26 = inversesqrt(u_xlat26);
					    u_xlat4.xyz = vec3(u_xlat26) * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat25 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat25) + 1.0;
					    u_xlat1.x = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat1.x;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat1.x = -abs(u_xlat24) + 1.0;
					    u_xlat9 = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat9 * u_xlat9;
					    u_xlat1.x = u_xlat1.x * u_xlat9;
					    u_xlat8.x = u_xlat8.x * u_xlat1.x + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = abs(u_xlat24) + u_xlat25;
					    u_xlat16 = u_xlat16 + 9.99999975e-06;
					    u_xlat16 = 0.5 / u_xlat16;
					    u_xlat8.y = u_xlat16 * 0.999999881;
					    u_xlat8.xy = vec2(u_xlat25) * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat5.xyz;
					    u_xlat8.xyz = u_xlat5.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat24 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat24 = u_xlat24 * _ProjectionParams.z;
					    u_xlat24 = max(u_xlat24, 0.0);
					    u_xlat24 = u_xlat24 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat24);
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat7;
					vec2 u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.y = _ScrollSpeed * _Time.y;
					    u_xlat13.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = _Time.y;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.0, -1.0) + u_xlat13.xy;
					    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD1.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat18 = _NormalRange + _NormalRange;
					    u_xlat2.xy = u_xlat1.yz * vec2(u_xlat18) + (-vec2(_NormalRange));
					    u_xlat13.xy = u_xlat2.xy * u_xlat2.xy;
					    u_xlat18 = u_xlat13.y + u_xlat13.x;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat2.z = sqrt(u_xlat18);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat1.xzw = u_xlat1.xxx + _AlbedoBoost.xyz;
					    u_xlat1.xzw = clamp(u_xlat1.xzw, 0.0, 1.0);
					    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.xyz;
					    u_xlat1.xzw = u_xlat1.xzw * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat18 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat4.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat18);
					    u_xlat5 = texture(_CameraDepthTexture, u_xlat4.yz);
					    u_xlat18 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat18 = float(1.0) / u_xlat18;
					    u_xlat20 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat18 = u_xlat18 + (-u_xlat20);
					    u_xlat18 = min(abs(u_xlat18), 1.0);
					    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
					    u_xlat7 = u_xlat1.y * u_xlat3.w;
					    u_xlat7 = u_xlat7 * vs_COLOR0.w;
					    u_xlat18 = u_xlat18 * u_xlat7;
					    SV_Target0.w = u_xlat18 * _Color.w;
					    u_xlat3.xy = vs_TEXCOORD5.yy * unity_WorldToLight[1].xy;
					    u_xlat3.xy = unity_WorldToLight[0].xy * vs_TEXCOORD5.xx + u_xlat3.xy;
					    u_xlat3.xy = unity_WorldToLight[2].xy * vs_TEXCOORD5.zz + u_xlat3.xy;
					    u_xlat3.xy = u_xlat3.xy + unity_WorldToLight[3].xy;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb18)) ? u_xlat4.xyz : vs_TEXCOORD5.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat7 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat18, u_xlat7);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat18 = u_xlat18 * u_xlat3.w;
					    u_xlat3.x = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat3.y = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
					    u_xlat7 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    u_xlat2.xyz = vec3(u_xlat7) * u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat18)) + u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat18 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat13;
					float u_xlat15;
					float u_xlat18;
					float u_xlat19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.y = _ScrollSpeed * _Time.y;
					    u_xlat13.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = _Time.y;
					    u_xlat1.xy = u_xlat1.xy * vec2(0.0, -1.0) + u_xlat13.xy;
					    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD1.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat19 = _NormalRange + _NormalRange;
					    u_xlat2.xy = u_xlat1.yz * vec2(u_xlat19) + (-vec2(_NormalRange));
					    u_xlat13.xy = u_xlat2.xy * u_xlat2.xy;
					    u_xlat13.x = u_xlat13.y + u_xlat13.x;
					    u_xlat13.x = (-u_xlat13.x) + 1.0;
					    u_xlat2.z = sqrt(u_xlat13.x);
					    u_xlat13.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13.x = inversesqrt(u_xlat13.x);
					    u_xlat2.xyz = u_xlat13.xxx * u_xlat2.xyz;
					    u_xlat1.xzw = u_xlat1.xxx + _AlbedoBoost.xyz;
					    u_xlat1.xzw = clamp(u_xlat1.xzw, 0.0, 1.0);
					    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.xyz;
					    u_xlat1.xzw = u_xlat1.xzw * _Color.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat20 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat4.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat20);
					    u_xlat5 = texture(_CameraDepthTexture, u_xlat4.yz);
					    u_xlat20 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat15 = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
					    u_xlat15 = float(1.0) / u_xlat15;
					    u_xlat20 = u_xlat20 + (-u_xlat15);
					    u_xlat20 = min(abs(u_xlat20), 1.0);
					    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
					    u_xlat7 = u_xlat1.y * u_xlat3.w;
					    u_xlat7 = u_xlat7 * vs_COLOR0.w;
					    u_xlat7 = u_xlat20 * u_xlat7;
					    SV_Target0.w = u_xlat7 * _Color.w;
					    u_xlat3.xy = vs_TEXCOORD5.yy * unity_WorldToLight[1].xy;
					    u_xlat3.xy = unity_WorldToLight[0].xy * vs_TEXCOORD5.xx + u_xlat3.xy;
					    u_xlat3.xy = unity_WorldToLight[2].xy * vs_TEXCOORD5.zz + u_xlat3.xy;
					    u_xlat3.xy = u_xlat3.xy + unity_WorldToLight[3].xy;
					    u_xlatb7 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb7){
					        u_xlatb7 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : vs_TEXCOORD5.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat7 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat20 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat7, u_xlat20);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat7 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat7 = u_xlat7 * u_xlat3.w;
					    u_xlat3.x = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat3.y = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(vs_TEXCOORD4.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat7) * _LightColor0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xzw * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _ScrollSpeed;
						vec4 _MainTex_ST;
						float _NormalRange;
						vec4 _Color;
						vec4 _AlbedoBoost;
						vec4 _MaskTex_ST;
						vec4 unused_0_10[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat15;
					vec2 u_xlat16;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3.x = 0.0;
					    u_xlat3.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat2.xy = u_xlat2.xy + u_xlat3.xy;
					    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD1.zw;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat22 = _NormalRange + _NormalRange;
					    u_xlat3.xy = u_xlat2.yz * vec2(u_xlat22) + (-vec2(_NormalRange));
					    u_xlat16.xy = u_xlat3.xy * u_xlat3.xy;
					    u_xlat22 = u_xlat16.y + u_xlat16.x;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
					    u_xlat2.xzw = u_xlat2.xxx + _AlbedoBoost.xyz;
					    u_xlat2.xzw = clamp(u_xlat2.xzw, 0.0, 1.0);
					    u_xlat2.xzw = u_xlat2.xzw * vs_COLOR0.xyz;
					    u_xlat2.xzw = u_xlat2.xzw * _Color.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat22 = vs_TEXCOORD6.w + 9.99999996e-12;
					    u_xlat5.xyz = vs_TEXCOORD6.zxy / vec3(u_xlat22);
					    u_xlat6 = texture(_CameraDepthTexture, u_xlat5.yz);
					    u_xlat22 = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat24 = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
					    u_xlat24 = float(1.0) / u_xlat24;
					    u_xlat22 = u_xlat22 + (-u_xlat24);
					    u_xlat22 = min(abs(u_xlat22), 1.0);
					    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
					    u_xlat9 = u_xlat2.y * u_xlat4.w;
					    u_xlat9 = u_xlat9 * vs_COLOR0.w;
					    u_xlat22 = u_xlat22 * u_xlat9;
					    SV_Target0.w = u_xlat22 * _Color.w;
					    u_xlat4.xy = vs_TEXCOORD5.yy * unity_WorldToLight[1].xy;
					    u_xlat4.xy = unity_WorldToLight[0].xy * vs_TEXCOORD5.xx + u_xlat4.xy;
					    u_xlat4.xy = unity_WorldToLight[2].xy * vs_TEXCOORD5.zz + u_xlat4.xy;
					    u_xlat4.xy = u_xlat4.xy + unity_WorldToLight[3].xy;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD5.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD5.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD5.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb22)) ? u_xlat5.xyz : vs_TEXCOORD5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat9);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xy);
					    u_xlat22 = u_xlat22 * u_xlat4.w;
					    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat3.xyz);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat2.xyz = u_xlat2.xzw * vec3(0.959999979, 0.959999979, 0.959999979);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xx, u_xlat0.xx);
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat8 = u_xlat14 * u_xlat14;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat8;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat8 = -abs(u_xlat21) + 1.0;
					    u_xlat15 = u_xlat8 * u_xlat8;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat8 = u_xlat8 * u_xlat15;
					    u_xlat7.x = u_xlat7.x * u_xlat8 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = abs(u_xlat21) + u_xlat1.x;
					    u_xlat14 = u_xlat14 + 9.99999975e-06;
					    u_xlat14 = 0.5 / u_xlat14;
					    u_xlat7.y = u_xlat14 * 0.999999881;
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat4.xyz;
					    u_xlat7.xyz = u_xlat4.xyz * u_xlat7.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}