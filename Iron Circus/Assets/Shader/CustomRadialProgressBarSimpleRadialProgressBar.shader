Shader "Custom/RadialProgressBar/SimpleRadialProgressBar" {
	Properties {
		_Radius ("Radius", Range(0, 1)) = 0.25
		_Arcrange ("Arc range", Range(0, 360)) = 360
		_Fillpercentage ("Fill percentage", Range(0, 1)) = 0.25
		_Globalopacity ("Global opacity", Range(0, 1)) = 1
		[HDR] _Barmincolor ("Bar min color", Vector) = (1,0,0,1)
		[HDR] _Barmaxcolor ("Bar max color", Vector) = (0,1,0.08965516,1)
		_Rotation ("Rotation", Range(0, 360)) = 0
		_Mask ("Mask", 2D) = "white" {}
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
			GpuProgramID 10930
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
						vec4 unused_0_0[9];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
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
						vec4 unused_0_0[9];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
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
						vec4 unused_0_0[9];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
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
						vec4 unused_0_0[9];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
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
						vec4 unused_0_0[9];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
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
						vec4 unused_0_0[9];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
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
						float _Rotation;
						float _Fillpercentage;
						float _Arcrange;
						float _Radius;
						vec4 _Barmincolor;
						vec4 _Barmaxcolor;
						float _Globalopacity;
						vec4 _Mask_ST;
						vec4 unused_0_11;
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
					uniform  sampler2D _Mask;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					float u_xlat12;
					float u_xlat21;
					bool u_xlatb21;
					bool u_xlatb22;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat30 = _Rotation * 0.0174532924;
					    u_xlat2.x = sin(u_xlat30);
					    u_xlat3.x = cos(u_xlat30);
					    u_xlat4.x = (-u_xlat2.x);
					    u_xlat4.y = u_xlat3.x;
					    u_xlat4.z = u_xlat2.x;
					    u_xlat30 = dot(u_xlat1.xy, u_xlat4.yz);
					    u_xlat21 = dot(u_xlat1.xy, u_xlat4.xy);
					    u_xlat31 = min(abs(u_xlat30), abs(u_xlat21));
					    u_xlat2.x = max(abs(u_xlat30), abs(u_xlat21));
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat2.x = u_xlat31 * u_xlat31;
					    u_xlat12 = u_xlat2.x * 0.0208350997 + -0.0851330012;
					    u_xlat12 = u_xlat2.x * u_xlat12 + 0.180141002;
					    u_xlat12 = u_xlat2.x * u_xlat12 + -0.330299497;
					    u_xlat2.x = u_xlat2.x * u_xlat12 + 0.999866009;
					    u_xlat12 = u_xlat31 * u_xlat2.x;
					    u_xlatb22 = abs(u_xlat30)<abs(u_xlat21);
					    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
					    u_xlat12 = u_xlatb22 ? u_xlat12 : float(0.0);
					    u_xlat31 = u_xlat31 * u_xlat2.x + u_xlat12;
					    u_xlatb2 = u_xlat30<(-u_xlat30);
					    u_xlat2.x = u_xlatb2 ? -3.14159274 : float(0.0);
					    u_xlat31 = u_xlat31 + u_xlat2.x;
					    u_xlat2.x = min(u_xlat30, u_xlat21);
					    u_xlat30 = max(u_xlat30, u_xlat21);
					    u_xlatb21 = u_xlat2.x<(-u_xlat2.x);
					    u_xlatb30 = u_xlat30>=(-u_xlat30);
					    u_xlatb30 = u_xlatb30 && u_xlatb21;
					    u_xlat30 = (u_xlatb30) ? (-u_xlat31) : u_xlat31;
					    u_xlat30 = u_xlat30 + 3.14159274;
					    u_xlat21 = _Fillpercentage * _Arcrange;
					    u_xlat21 = u_xlat21 * -0.00277777785 + 1.0;
					    u_xlat30 = u_xlat30 * 0.159154937 + (-u_xlat21);
					    u_xlat30 = ceil(u_xlat30);
					    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.y = u_xlat1.x + _Radius;
					    u_xlat1.xy = floor(u_xlat1.xy);
					    u_xlat30 = u_xlat30 * u_xlat1.y;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat1 = (-_Barmincolor) + _Barmaxcolor;
					    u_xlat1 = vec4(vec4(_Fillpercentage, _Fillpercentage, _Fillpercentage, _Fillpercentage)) * u_xlat1 + _Barmincolor;
					    u_xlat31 = u_xlat30 * u_xlat1.w;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
					    u_xlat2 = texture(_Mask, u_xlat2.xy);
					    u_xlat31 = u_xlat31 * _Globalopacity;
					    SV_Target0.w = u_xlat2.x * u_xlat31;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-u_xlat2.xxx) + (-u_xlat0.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb32 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb32){
					        u_xlatb32 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb32){
					            u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat32 = inversesqrt(u_xlat32);
					            u_xlat6.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat32 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat32 = min(u_xlat7.z, u_xlat32);
					            u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat32) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat32 = u_xlat2.w + -1.0;
					        u_xlat32 = unity_SpecCube1_HDR.w * u_xlat32 + 1.0;
					        u_xlat32 = log2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.y;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat2.xyz = vec3(u_xlat31) * vs_TEXCOORD1.xyz;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat32 = u_xlat31 + u_xlat31;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat32)) + u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat31 = u_xlat31;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat4.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat4.y = (-u_xlat31) + 1.0;
					    u_xlat4.zw = u_xlat4.xy * u_xlat4.xy;
					    u_xlat0.xy = u_xlat4.xy * u_xlat4.xw;
					    u_xlat0.xy = u_xlat4.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat4 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat4.x * 0.639999986;
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat10 = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat3.xyz = vec3(u_xlat10) * u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat1.xyz + u_xlat0.xyz;
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
						float _Rotation;
						float _Fillpercentage;
						float _Arcrange;
						float _Radius;
						vec4 _Barmincolor;
						vec4 _Barmaxcolor;
						float _Globalopacity;
						vec4 _Mask_ST;
						vec4 unused_0_11;
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
					uniform  sampler2D _Mask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat14;
					float u_xlat24;
					bool u_xlatb24;
					bool u_xlatb25;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					bool u_xlatb35;
					float u_xlat36;
					bool u_xlatb36;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat34 = _Rotation * 0.0174532924;
					    u_xlat3.x = sin(u_xlat34);
					    u_xlat4.x = cos(u_xlat34);
					    u_xlat5.x = (-u_xlat3.x);
					    u_xlat5.y = u_xlat4.x;
					    u_xlat5.z = u_xlat3.x;
					    u_xlat34 = dot(u_xlat2.xy, u_xlat5.yz);
					    u_xlat24 = dot(u_xlat2.xy, u_xlat5.xy);
					    u_xlat35 = min(abs(u_xlat34), abs(u_xlat24));
					    u_xlat3.x = max(abs(u_xlat34), abs(u_xlat24));
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat35 = u_xlat35 * u_xlat3.x;
					    u_xlat3.x = u_xlat35 * u_xlat35;
					    u_xlat14 = u_xlat3.x * 0.0208350997 + -0.0851330012;
					    u_xlat14 = u_xlat3.x * u_xlat14 + 0.180141002;
					    u_xlat14 = u_xlat3.x * u_xlat14 + -0.330299497;
					    u_xlat3.x = u_xlat3.x * u_xlat14 + 0.999866009;
					    u_xlat14 = u_xlat35 * u_xlat3.x;
					    u_xlatb25 = abs(u_xlat34)<abs(u_xlat24);
					    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
					    u_xlat14 = u_xlatb25 ? u_xlat14 : float(0.0);
					    u_xlat35 = u_xlat35 * u_xlat3.x + u_xlat14;
					    u_xlatb3 = u_xlat34<(-u_xlat34);
					    u_xlat3.x = u_xlatb3 ? -3.14159274 : float(0.0);
					    u_xlat35 = u_xlat35 + u_xlat3.x;
					    u_xlat3.x = min(u_xlat34, u_xlat24);
					    u_xlat34 = max(u_xlat34, u_xlat24);
					    u_xlatb24 = u_xlat3.x<(-u_xlat3.x);
					    u_xlatb34 = u_xlat34>=(-u_xlat34);
					    u_xlatb34 = u_xlatb34 && u_xlatb24;
					    u_xlat34 = (u_xlatb34) ? (-u_xlat35) : u_xlat35;
					    u_xlat34 = u_xlat34 + 3.14159274;
					    u_xlat24 = _Fillpercentage * _Arcrange;
					    u_xlat24 = u_xlat24 * -0.00277777785 + 1.0;
					    u_xlat34 = u_xlat34 * 0.159154937 + (-u_xlat24);
					    u_xlat34 = ceil(u_xlat34);
					    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.y = u_xlat2.x + _Radius;
					    u_xlat2.xy = floor(u_xlat2.xy);
					    u_xlat34 = u_xlat34 * u_xlat2.y;
					    u_xlat2.x = (-u_xlat2.x) + 1.0;
					    u_xlat34 = u_xlat34 * u_xlat2.x;
					    u_xlat2 = (-_Barmincolor) + _Barmaxcolor;
					    u_xlat2 = vec4(vec4(_Fillpercentage, _Fillpercentage, _Fillpercentage, _Fillpercentage)) * u_xlat2 + _Barmincolor;
					    u_xlat35 = u_xlat34 * u_xlat2.w;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
					    u_xlat3 = texture(_Mask, u_xlat3.xy);
					    u_xlat35 = u_xlat35 * _Globalopacity;
					    SV_Target0.w = u_xlat3.x * u_xlat35;
					    u_xlatb35 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb35){
					        u_xlatb35 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb35)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat35 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat35, u_xlat14);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat35 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
					    u_xlat3.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat3.x = u_xlat3.x + u_xlat3.x;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat35) * _LightColor0.xyz;
					    u_xlatb35 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb35){
					        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat35 = inversesqrt(u_xlat35);
					        u_xlat5.xyz = vec3(u_xlat35) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat35 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat35 = min(u_xlat6.z, u_xlat35);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat35 = u_xlat5.w + -1.0;
					    u_xlat35 = unity_SpecCube0_HDR.w * u_xlat35 + 1.0;
					    u_xlat35 = log2(u_xlat35);
					    u_xlat35 = u_xlat35 * unity_SpecCube0_HDR.y;
					    u_xlat35 = exp2(u_xlat35);
					    u_xlat35 = u_xlat35 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat35);
					    u_xlatb36 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb36){
					        u_xlatb36 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb36){
					            u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat36 = inversesqrt(u_xlat36);
					            u_xlat7.xyz = vec3(u_xlat36) * u_xlat3.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat36 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat36 = min(u_xlat8.z, u_xlat36);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat8.xyz;
					        }
					        u_xlat3 = textureLod(unity_SpecCube1, u_xlat3.xyz, 6.0);
					        u_xlat36 = u_xlat3.w + -1.0;
					        u_xlat36 = unity_SpecCube1_HDR.w * u_xlat36 + 1.0;
					        u_xlat36 = log2(u_xlat36);
					        u_xlat36 = u_xlat36 * unity_SpecCube1_HDR.y;
					        u_xlat36 = exp2(u_xlat36);
					        u_xlat36 = u_xlat36 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat36);
					        u_xlat5.xyz = vec3(u_xlat35) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat35 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat35 = inversesqrt(u_xlat35);
					    u_xlat3.xyz = vec3(u_xlat35) * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat34) * u_xlat2.xyz + u_xlat0.xyz;
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
						float _Rotation;
						float _Fillpercentage;
						float _Arcrange;
						float _Radius;
						vec4 _Barmincolor;
						vec4 _Barmaxcolor;
						float _Globalopacity;
						vec4 _Mask_ST;
						vec4 unused_0_11;
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
					uniform  sampler2D _Mask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat14;
					float u_xlat22;
					float u_xlat24;
					bool u_xlatb24;
					bool u_xlatb25;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					bool u_xlatb35;
					float u_xlat36;
					bool u_xlatb36;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat34 = _Rotation * 0.0174532924;
					    u_xlat3.x = sin(u_xlat34);
					    u_xlat4.x = cos(u_xlat34);
					    u_xlat5.x = (-u_xlat3.x);
					    u_xlat5.y = u_xlat4.x;
					    u_xlat5.z = u_xlat3.x;
					    u_xlat34 = dot(u_xlat2.xy, u_xlat5.yz);
					    u_xlat24 = dot(u_xlat2.xy, u_xlat5.xy);
					    u_xlat35 = min(abs(u_xlat34), abs(u_xlat24));
					    u_xlat3.x = max(abs(u_xlat34), abs(u_xlat24));
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat35 = u_xlat35 * u_xlat3.x;
					    u_xlat3.x = u_xlat35 * u_xlat35;
					    u_xlat14 = u_xlat3.x * 0.0208350997 + -0.0851330012;
					    u_xlat14 = u_xlat3.x * u_xlat14 + 0.180141002;
					    u_xlat14 = u_xlat3.x * u_xlat14 + -0.330299497;
					    u_xlat3.x = u_xlat3.x * u_xlat14 + 0.999866009;
					    u_xlat14 = u_xlat35 * u_xlat3.x;
					    u_xlatb25 = abs(u_xlat34)<abs(u_xlat24);
					    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
					    u_xlat14 = u_xlatb25 ? u_xlat14 : float(0.0);
					    u_xlat35 = u_xlat35 * u_xlat3.x + u_xlat14;
					    u_xlatb3 = u_xlat34<(-u_xlat34);
					    u_xlat3.x = u_xlatb3 ? -3.14159274 : float(0.0);
					    u_xlat35 = u_xlat35 + u_xlat3.x;
					    u_xlat3.x = min(u_xlat34, u_xlat24);
					    u_xlat34 = max(u_xlat34, u_xlat24);
					    u_xlatb24 = u_xlat3.x<(-u_xlat3.x);
					    u_xlatb34 = u_xlat34>=(-u_xlat34);
					    u_xlatb34 = u_xlatb34 && u_xlatb24;
					    u_xlat34 = (u_xlatb34) ? (-u_xlat35) : u_xlat35;
					    u_xlat34 = u_xlat34 + 3.14159274;
					    u_xlat24 = _Fillpercentage * _Arcrange;
					    u_xlat24 = u_xlat24 * -0.00277777785 + 1.0;
					    u_xlat34 = u_xlat34 * 0.159154937 + (-u_xlat24);
					    u_xlat34 = ceil(u_xlat34);
					    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.y = u_xlat2.x + _Radius;
					    u_xlat2.xy = floor(u_xlat2.xy);
					    u_xlat34 = u_xlat34 * u_xlat2.y;
					    u_xlat2.x = (-u_xlat2.x) + 1.0;
					    u_xlat34 = u_xlat34 * u_xlat2.x;
					    u_xlat2 = (-_Barmincolor) + _Barmaxcolor;
					    u_xlat2 = vec4(vec4(_Fillpercentage, _Fillpercentage, _Fillpercentage, _Fillpercentage)) * u_xlat2 + _Barmincolor;
					    u_xlat35 = u_xlat34 * u_xlat2.w;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
					    u_xlat3 = texture(_Mask, u_xlat3.xy);
					    u_xlat35 = u_xlat35 * _Globalopacity;
					    SV_Target0.w = u_xlat3.x * u_xlat35;
					    u_xlatb35 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb35){
					        u_xlatb35 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb35)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat35 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat35, u_xlat14);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat35 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
					    u_xlat3.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat3.x = u_xlat3.x + u_xlat3.x;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat35) * _LightColor0.xyz;
					    u_xlatb35 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb35){
					        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat35 = inversesqrt(u_xlat35);
					        u_xlat5.xyz = vec3(u_xlat35) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat35 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat35 = min(u_xlat6.z, u_xlat35);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat35 = u_xlat5.w + -1.0;
					    u_xlat35 = unity_SpecCube0_HDR.w * u_xlat35 + 1.0;
					    u_xlat35 = log2(u_xlat35);
					    u_xlat35 = u_xlat35 * unity_SpecCube0_HDR.y;
					    u_xlat35 = exp2(u_xlat35);
					    u_xlat35 = u_xlat35 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat35);
					    u_xlatb36 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb36){
					        u_xlatb36 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb36){
					            u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat36 = inversesqrt(u_xlat36);
					            u_xlat7.xyz = vec3(u_xlat36) * u_xlat3.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat36 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat36 = min(u_xlat8.z, u_xlat36);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat8.xyz;
					        }
					        u_xlat3 = textureLod(unity_SpecCube1, u_xlat3.xyz, 6.0);
					        u_xlat36 = u_xlat3.w + -1.0;
					        u_xlat36 = unity_SpecCube1_HDR.w * u_xlat36 + 1.0;
					        u_xlat36 = log2(u_xlat36);
					        u_xlat36 = u_xlat36 * unity_SpecCube1_HDR.y;
					        u_xlat36 = exp2(u_xlat36);
					        u_xlat36 = u_xlat36 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat36);
					        u_xlat5.xyz = vec3(u_xlat35) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat35 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat35 = inversesqrt(u_xlat35);
					    u_xlat3.xyz = vec3(u_xlat35) * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = abs(u_xlat33) + u_xlat1.x;
					    u_xlat11.x = u_xlat11.x + 9.99999975e-06;
					    u_xlat11.x = 0.5 / u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * 0.999999881;
					    u_xlat11.x = u_xlat1.x * u_xlat11.x;
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat11.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat11.x = -abs(u_xlat33) + 1.0;
					    u_xlat22 = u_xlat11.x * u_xlat11.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat11.x = u_xlat11.x * u_xlat22;
					    u_xlat11.x = u_xlat11.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat11.xyz;
					    SV_Target0.xyz = vec3(u_xlat34) * u_xlat2.xyz + u_xlat0.xyz;
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
						float _Rotation;
						float _Fillpercentage;
						float _Arcrange;
						float _Radius;
						vec4 _Barmincolor;
						vec4 _Barmaxcolor;
						float _Globalopacity;
						vec4 _Mask_ST;
						vec4 unused_0_11;
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
					uniform  sampler2D _Mask;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					float u_xlat12;
					float u_xlat21;
					bool u_xlatb21;
					bool u_xlatb22;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat30 = _Rotation * 0.0174532924;
					    u_xlat2.x = sin(u_xlat30);
					    u_xlat3.x = cos(u_xlat30);
					    u_xlat4.x = (-u_xlat2.x);
					    u_xlat4.y = u_xlat3.x;
					    u_xlat4.z = u_xlat2.x;
					    u_xlat30 = dot(u_xlat1.xy, u_xlat4.yz);
					    u_xlat21 = dot(u_xlat1.xy, u_xlat4.xy);
					    u_xlat31 = min(abs(u_xlat30), abs(u_xlat21));
					    u_xlat2.x = max(abs(u_xlat30), abs(u_xlat21));
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat2.x = u_xlat31 * u_xlat31;
					    u_xlat12 = u_xlat2.x * 0.0208350997 + -0.0851330012;
					    u_xlat12 = u_xlat2.x * u_xlat12 + 0.180141002;
					    u_xlat12 = u_xlat2.x * u_xlat12 + -0.330299497;
					    u_xlat2.x = u_xlat2.x * u_xlat12 + 0.999866009;
					    u_xlat12 = u_xlat31 * u_xlat2.x;
					    u_xlatb22 = abs(u_xlat30)<abs(u_xlat21);
					    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
					    u_xlat12 = u_xlatb22 ? u_xlat12 : float(0.0);
					    u_xlat31 = u_xlat31 * u_xlat2.x + u_xlat12;
					    u_xlatb2 = u_xlat30<(-u_xlat30);
					    u_xlat2.x = u_xlatb2 ? -3.14159274 : float(0.0);
					    u_xlat31 = u_xlat31 + u_xlat2.x;
					    u_xlat2.x = min(u_xlat30, u_xlat21);
					    u_xlat30 = max(u_xlat30, u_xlat21);
					    u_xlatb21 = u_xlat2.x<(-u_xlat2.x);
					    u_xlatb30 = u_xlat30>=(-u_xlat30);
					    u_xlatb30 = u_xlatb30 && u_xlatb21;
					    u_xlat30 = (u_xlatb30) ? (-u_xlat31) : u_xlat31;
					    u_xlat30 = u_xlat30 + 3.14159274;
					    u_xlat21 = _Fillpercentage * _Arcrange;
					    u_xlat21 = u_xlat21 * -0.00277777785 + 1.0;
					    u_xlat30 = u_xlat30 * 0.159154937 + (-u_xlat21);
					    u_xlat30 = ceil(u_xlat30);
					    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.y = u_xlat1.x + _Radius;
					    u_xlat1.xy = floor(u_xlat1.xy);
					    u_xlat30 = u_xlat30 * u_xlat1.y;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat1 = (-_Barmincolor) + _Barmaxcolor;
					    u_xlat1 = vec4(vec4(_Fillpercentage, _Fillpercentage, _Fillpercentage, _Fillpercentage)) * u_xlat1 + _Barmincolor;
					    u_xlat31 = u_xlat30 * u_xlat1.w;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
					    u_xlat2 = texture(_Mask, u_xlat2.xy);
					    u_xlat31 = u_xlat31 * _Globalopacity;
					    SV_Target0.w = u_xlat2.x * u_xlat31;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-u_xlat2.xxx) + (-u_xlat0.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb32 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb32){
					        u_xlatb32 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb32){
					            u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat32 = inversesqrt(u_xlat32);
					            u_xlat6.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat32 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat32 = min(u_xlat7.z, u_xlat32);
					            u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat32) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat32 = u_xlat2.w + -1.0;
					        u_xlat32 = unity_SpecCube1_HDR.w * u_xlat32 + 1.0;
					        u_xlat32 = log2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.y;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat2.xyz = vec3(u_xlat31) * vs_TEXCOORD1.xyz;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat32 = u_xlat31 + u_xlat31;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat32)) + u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat31 = u_xlat31;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat4.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat4.y = (-u_xlat31) + 1.0;
					    u_xlat4.zw = u_xlat4.xy * u_xlat4.xy;
					    u_xlat0.xy = u_xlat4.xy * u_xlat4.xw;
					    u_xlat0.xy = u_xlat4.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat4 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat4.x * 0.639999986;
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat10 = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat3.xyz = vec3(u_xlat10) * u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat1.xyz + u_xlat0.xyz;
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
						float _Rotation;
						float _Fillpercentage;
						float _Arcrange;
						float _Radius;
						vec4 _Barmincolor;
						vec4 _Barmaxcolor;
						float _Globalopacity;
						vec4 _Mask_ST;
						vec4 unused_0_11;
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
					uniform  sampler2D _Mask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat14;
					float u_xlat24;
					bool u_xlatb24;
					bool u_xlatb25;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					bool u_xlatb35;
					float u_xlat36;
					bool u_xlatb36;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat34 = _Rotation * 0.0174532924;
					    u_xlat3.x = sin(u_xlat34);
					    u_xlat4.x = cos(u_xlat34);
					    u_xlat5.x = (-u_xlat3.x);
					    u_xlat5.y = u_xlat4.x;
					    u_xlat5.z = u_xlat3.x;
					    u_xlat34 = dot(u_xlat2.xy, u_xlat5.yz);
					    u_xlat24 = dot(u_xlat2.xy, u_xlat5.xy);
					    u_xlat35 = min(abs(u_xlat34), abs(u_xlat24));
					    u_xlat3.x = max(abs(u_xlat34), abs(u_xlat24));
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat35 = u_xlat35 * u_xlat3.x;
					    u_xlat3.x = u_xlat35 * u_xlat35;
					    u_xlat14 = u_xlat3.x * 0.0208350997 + -0.0851330012;
					    u_xlat14 = u_xlat3.x * u_xlat14 + 0.180141002;
					    u_xlat14 = u_xlat3.x * u_xlat14 + -0.330299497;
					    u_xlat3.x = u_xlat3.x * u_xlat14 + 0.999866009;
					    u_xlat14 = u_xlat35 * u_xlat3.x;
					    u_xlatb25 = abs(u_xlat34)<abs(u_xlat24);
					    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
					    u_xlat14 = u_xlatb25 ? u_xlat14 : float(0.0);
					    u_xlat35 = u_xlat35 * u_xlat3.x + u_xlat14;
					    u_xlatb3 = u_xlat34<(-u_xlat34);
					    u_xlat3.x = u_xlatb3 ? -3.14159274 : float(0.0);
					    u_xlat35 = u_xlat35 + u_xlat3.x;
					    u_xlat3.x = min(u_xlat34, u_xlat24);
					    u_xlat34 = max(u_xlat34, u_xlat24);
					    u_xlatb24 = u_xlat3.x<(-u_xlat3.x);
					    u_xlatb34 = u_xlat34>=(-u_xlat34);
					    u_xlatb34 = u_xlatb34 && u_xlatb24;
					    u_xlat34 = (u_xlatb34) ? (-u_xlat35) : u_xlat35;
					    u_xlat34 = u_xlat34 + 3.14159274;
					    u_xlat24 = _Fillpercentage * _Arcrange;
					    u_xlat24 = u_xlat24 * -0.00277777785 + 1.0;
					    u_xlat34 = u_xlat34 * 0.159154937 + (-u_xlat24);
					    u_xlat34 = ceil(u_xlat34);
					    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.y = u_xlat2.x + _Radius;
					    u_xlat2.xy = floor(u_xlat2.xy);
					    u_xlat34 = u_xlat34 * u_xlat2.y;
					    u_xlat2.x = (-u_xlat2.x) + 1.0;
					    u_xlat34 = u_xlat34 * u_xlat2.x;
					    u_xlat2 = (-_Barmincolor) + _Barmaxcolor;
					    u_xlat2 = vec4(vec4(_Fillpercentage, _Fillpercentage, _Fillpercentage, _Fillpercentage)) * u_xlat2 + _Barmincolor;
					    u_xlat35 = u_xlat34 * u_xlat2.w;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
					    u_xlat3 = texture(_Mask, u_xlat3.xy);
					    u_xlat35 = u_xlat35 * _Globalopacity;
					    SV_Target0.w = u_xlat3.x * u_xlat35;
					    u_xlatb35 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb35){
					        u_xlatb35 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb35)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat35 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat35, u_xlat14);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat35 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
					    u_xlat3.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat3.x = u_xlat3.x + u_xlat3.x;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat35) * _LightColor0.xyz;
					    u_xlatb35 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb35){
					        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat35 = inversesqrt(u_xlat35);
					        u_xlat5.xyz = vec3(u_xlat35) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat35 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat35 = min(u_xlat6.z, u_xlat35);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat35 = u_xlat5.w + -1.0;
					    u_xlat35 = unity_SpecCube0_HDR.w * u_xlat35 + 1.0;
					    u_xlat35 = log2(u_xlat35);
					    u_xlat35 = u_xlat35 * unity_SpecCube0_HDR.y;
					    u_xlat35 = exp2(u_xlat35);
					    u_xlat35 = u_xlat35 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat35);
					    u_xlatb36 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb36){
					        u_xlatb36 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb36){
					            u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat36 = inversesqrt(u_xlat36);
					            u_xlat7.xyz = vec3(u_xlat36) * u_xlat3.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat36 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat36 = min(u_xlat8.z, u_xlat36);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat8.xyz;
					        }
					        u_xlat3 = textureLod(unity_SpecCube1, u_xlat3.xyz, 6.0);
					        u_xlat36 = u_xlat3.w + -1.0;
					        u_xlat36 = unity_SpecCube1_HDR.w * u_xlat36 + 1.0;
					        u_xlat36 = log2(u_xlat36);
					        u_xlat36 = u_xlat36 * unity_SpecCube1_HDR.y;
					        u_xlat36 = exp2(u_xlat36);
					        u_xlat36 = u_xlat36 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat36);
					        u_xlat5.xyz = vec3(u_xlat35) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat35 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat35 = inversesqrt(u_xlat35);
					    u_xlat3.xyz = vec3(u_xlat35) * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat34) * u_xlat2.xyz + u_xlat0.xyz;
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
						float _Rotation;
						float _Fillpercentage;
						float _Arcrange;
						float _Radius;
						vec4 _Barmincolor;
						vec4 _Barmaxcolor;
						float _Globalopacity;
						vec4 _Mask_ST;
						vec4 unused_0_11;
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
					uniform  sampler2D _Mask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat14;
					float u_xlat22;
					float u_xlat24;
					bool u_xlatb24;
					bool u_xlatb25;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					bool u_xlatb35;
					float u_xlat36;
					bool u_xlatb36;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat34 = _Rotation * 0.0174532924;
					    u_xlat3.x = sin(u_xlat34);
					    u_xlat4.x = cos(u_xlat34);
					    u_xlat5.x = (-u_xlat3.x);
					    u_xlat5.y = u_xlat4.x;
					    u_xlat5.z = u_xlat3.x;
					    u_xlat34 = dot(u_xlat2.xy, u_xlat5.yz);
					    u_xlat24 = dot(u_xlat2.xy, u_xlat5.xy);
					    u_xlat35 = min(abs(u_xlat34), abs(u_xlat24));
					    u_xlat3.x = max(abs(u_xlat34), abs(u_xlat24));
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat35 = u_xlat35 * u_xlat3.x;
					    u_xlat3.x = u_xlat35 * u_xlat35;
					    u_xlat14 = u_xlat3.x * 0.0208350997 + -0.0851330012;
					    u_xlat14 = u_xlat3.x * u_xlat14 + 0.180141002;
					    u_xlat14 = u_xlat3.x * u_xlat14 + -0.330299497;
					    u_xlat3.x = u_xlat3.x * u_xlat14 + 0.999866009;
					    u_xlat14 = u_xlat35 * u_xlat3.x;
					    u_xlatb25 = abs(u_xlat34)<abs(u_xlat24);
					    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
					    u_xlat14 = u_xlatb25 ? u_xlat14 : float(0.0);
					    u_xlat35 = u_xlat35 * u_xlat3.x + u_xlat14;
					    u_xlatb3 = u_xlat34<(-u_xlat34);
					    u_xlat3.x = u_xlatb3 ? -3.14159274 : float(0.0);
					    u_xlat35 = u_xlat35 + u_xlat3.x;
					    u_xlat3.x = min(u_xlat34, u_xlat24);
					    u_xlat34 = max(u_xlat34, u_xlat24);
					    u_xlatb24 = u_xlat3.x<(-u_xlat3.x);
					    u_xlatb34 = u_xlat34>=(-u_xlat34);
					    u_xlatb34 = u_xlatb34 && u_xlatb24;
					    u_xlat34 = (u_xlatb34) ? (-u_xlat35) : u_xlat35;
					    u_xlat34 = u_xlat34 + 3.14159274;
					    u_xlat24 = _Fillpercentage * _Arcrange;
					    u_xlat24 = u_xlat24 * -0.00277777785 + 1.0;
					    u_xlat34 = u_xlat34 * 0.159154937 + (-u_xlat24);
					    u_xlat34 = ceil(u_xlat34);
					    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.y = u_xlat2.x + _Radius;
					    u_xlat2.xy = floor(u_xlat2.xy);
					    u_xlat34 = u_xlat34 * u_xlat2.y;
					    u_xlat2.x = (-u_xlat2.x) + 1.0;
					    u_xlat34 = u_xlat34 * u_xlat2.x;
					    u_xlat2 = (-_Barmincolor) + _Barmaxcolor;
					    u_xlat2 = vec4(vec4(_Fillpercentage, _Fillpercentage, _Fillpercentage, _Fillpercentage)) * u_xlat2 + _Barmincolor;
					    u_xlat35 = u_xlat34 * u_xlat2.w;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
					    u_xlat3 = texture(_Mask, u_xlat3.xy);
					    u_xlat35 = u_xlat35 * _Globalopacity;
					    SV_Target0.w = u_xlat3.x * u_xlat35;
					    u_xlatb35 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb35){
					        u_xlatb35 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb35)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat35 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat35, u_xlat14);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat35 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
					    u_xlat3.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat3.x = u_xlat3.x + u_xlat3.x;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-u_xlat3.xxx) + (-u_xlat1.xyz);
					    u_xlat4.xyz = vec3(u_xlat35) * _LightColor0.xyz;
					    u_xlatb35 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb35){
					        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat35 = inversesqrt(u_xlat35);
					        u_xlat5.xyz = vec3(u_xlat35) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat35 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat35 = min(u_xlat6.z, u_xlat35);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat35 = u_xlat5.w + -1.0;
					    u_xlat35 = unity_SpecCube0_HDR.w * u_xlat35 + 1.0;
					    u_xlat35 = log2(u_xlat35);
					    u_xlat35 = u_xlat35 * unity_SpecCube0_HDR.y;
					    u_xlat35 = exp2(u_xlat35);
					    u_xlat35 = u_xlat35 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat35);
					    u_xlatb36 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb36){
					        u_xlatb36 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb36){
					            u_xlat36 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat36 = inversesqrt(u_xlat36);
					            u_xlat7.xyz = vec3(u_xlat36) * u_xlat3.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat36 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat36 = min(u_xlat8.z, u_xlat36);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat8.xyz;
					        }
					        u_xlat3 = textureLod(unity_SpecCube1, u_xlat3.xyz, 6.0);
					        u_xlat36 = u_xlat3.w + -1.0;
					        u_xlat36 = unity_SpecCube1_HDR.w * u_xlat36 + 1.0;
					        u_xlat36 = log2(u_xlat36);
					        u_xlat36 = u_xlat36 * unity_SpecCube1_HDR.y;
					        u_xlat36 = exp2(u_xlat36);
					        u_xlat36 = u_xlat36 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat36);
					        u_xlat5.xyz = vec3(u_xlat35) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat35 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat35 = inversesqrt(u_xlat35);
					    u_xlat3.xyz = vec3(u_xlat35) * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = abs(u_xlat33) + u_xlat1.x;
					    u_xlat11.x = u_xlat11.x + 9.99999975e-06;
					    u_xlat11.x = 0.5 / u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * 0.999999881;
					    u_xlat11.x = u_xlat1.x * u_xlat11.x;
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat11.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat11.x = -abs(u_xlat33) + 1.0;
					    u_xlat22 = u_xlat11.x * u_xlat11.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat11.x = u_xlat11.x * u_xlat22;
					    u_xlat11.x = u_xlat11.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat11.xyz;
					    SV_Target0.xyz = vec3(u_xlat34) * u_xlat2.xyz + u_xlat0.xyz;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "ShadowCaster"
			Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			ColorMask RGB -1
			GpuProgramID 119463
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
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat6 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat6);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat6 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat6);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat6 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat6);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
						float _Rotation;
						float _Fillpercentage;
						float _Arcrange;
						float _Radius;
						vec4 _Barmincolor;
						vec4 _Barmaxcolor;
						float _Globalopacity;
						vec4 _Mask_ST;
					};
					uniform  sampler2D _Mask;
					uniform  sampler3D _DitherMaskLOD;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					float u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					bool u_xlatb7;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.x = _Rotation * 0.0174532924;
					    u_xlat1.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.x);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat2.z = u_xlat0.x;
					    u_xlat0.xy = vs_TEXCOORD1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat6 = dot(u_xlat0.xy, u_xlat2.xy);
					    u_xlat9 = dot(u_xlat0.xy, u_xlat2.yz);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3.x = max(abs(u_xlat9), abs(u_xlat6));
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat1.x = min(abs(u_xlat9), abs(u_xlat6));
					    u_xlat3.x = u_xlat3.x * u_xlat1.x;
					    u_xlat1.x = u_xlat3.x * u_xlat3.x;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat3.x * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat9)<abs(u_xlat6);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat3.x = u_xlat3.x * u_xlat1.x + u_xlat4;
					    u_xlatb1 = u_xlat9<(-u_xlat9);
					    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
					    u_xlat3.x = u_xlat3.x + u_xlat1.x;
					    u_xlat1.x = min(u_xlat9, u_xlat6);
					    u_xlat6 = max(u_xlat9, u_xlat6);
					    u_xlatb6 = u_xlat6>=(-u_xlat6);
					    u_xlatb9 = u_xlat1.x<(-u_xlat1.x);
					    u_xlatb6 = u_xlatb6 && u_xlatb9;
					    u_xlat3.x = (u_xlatb6) ? (-u_xlat3.x) : u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + 3.14159274;
					    u_xlat6 = _Fillpercentage * _Arcrange;
					    u_xlat6 = u_xlat6 * -0.00277777785 + 1.0;
					    u_xlat3.x = u_xlat3.x * 0.159154937 + (-u_xlat6);
					    u_xlat3.x = ceil(u_xlat3.x);
					    u_xlat0.z = u_xlat0.x + _Radius;
					    u_xlat0.xz = floor(u_xlat0.xz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat3.x = u_xlat0.z * u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x;
					    u_xlat3.x = (-_Barmincolor.w) + _Barmaxcolor.w;
					    u_xlat3.x = _Fillpercentage * u_xlat3.x + _Barmincolor.w;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _Globalopacity;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _Mask_ST.xy + _Mask_ST.zw;
					    u_xlat1 = texture(_Mask, u_xlat3.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
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
						float _Rotation;
						float _Fillpercentage;
						float _Arcrange;
						float _Radius;
						vec4 _Barmincolor;
						vec4 _Barmaxcolor;
						float _Globalopacity;
						vec4 _Mask_ST;
					};
					uniform  sampler2D _Mask;
					uniform  sampler3D _DitherMaskLOD;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					float u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					bool u_xlatb7;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.x = _Rotation * 0.0174532924;
					    u_xlat1.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.x);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat2.z = u_xlat0.x;
					    u_xlat0.xy = vs_TEXCOORD1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat6 = dot(u_xlat0.xy, u_xlat2.xy);
					    u_xlat9 = dot(u_xlat0.xy, u_xlat2.yz);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3.x = max(abs(u_xlat9), abs(u_xlat6));
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat1.x = min(abs(u_xlat9), abs(u_xlat6));
					    u_xlat3.x = u_xlat3.x * u_xlat1.x;
					    u_xlat1.x = u_xlat3.x * u_xlat3.x;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat3.x * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat9)<abs(u_xlat6);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat3.x = u_xlat3.x * u_xlat1.x + u_xlat4;
					    u_xlatb1 = u_xlat9<(-u_xlat9);
					    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
					    u_xlat3.x = u_xlat3.x + u_xlat1.x;
					    u_xlat1.x = min(u_xlat9, u_xlat6);
					    u_xlat6 = max(u_xlat9, u_xlat6);
					    u_xlatb6 = u_xlat6>=(-u_xlat6);
					    u_xlatb9 = u_xlat1.x<(-u_xlat1.x);
					    u_xlatb6 = u_xlatb6 && u_xlatb9;
					    u_xlat3.x = (u_xlatb6) ? (-u_xlat3.x) : u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + 3.14159274;
					    u_xlat6 = _Fillpercentage * _Arcrange;
					    u_xlat6 = u_xlat6 * -0.00277777785 + 1.0;
					    u_xlat3.x = u_xlat3.x * 0.159154937 + (-u_xlat6);
					    u_xlat3.x = ceil(u_xlat3.x);
					    u_xlat0.z = u_xlat0.x + _Radius;
					    u_xlat0.xz = floor(u_xlat0.xz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat3.x = u_xlat0.z * u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x;
					    u_xlat3.x = (-_Barmincolor.w) + _Barmaxcolor.w;
					    u_xlat3.x = _Fillpercentage * u_xlat3.x + _Barmincolor.w;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _Globalopacity;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _Mask_ST.xy + _Mask_ST.zw;
					    u_xlat1 = texture(_Mask, u_xlat3.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
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
						float _Rotation;
						float _Fillpercentage;
						float _Arcrange;
						float _Radius;
						vec4 _Barmincolor;
						vec4 _Barmaxcolor;
						float _Globalopacity;
						vec4 _Mask_ST;
					};
					uniform  sampler2D _Mask;
					uniform  sampler3D _DitherMaskLOD;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					float u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					bool u_xlatb7;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.x = _Rotation * 0.0174532924;
					    u_xlat1.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.x);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat2.z = u_xlat0.x;
					    u_xlat0.xy = vs_TEXCOORD1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat6 = dot(u_xlat0.xy, u_xlat2.xy);
					    u_xlat9 = dot(u_xlat0.xy, u_xlat2.yz);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3.x = max(abs(u_xlat9), abs(u_xlat6));
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat1.x = min(abs(u_xlat9), abs(u_xlat6));
					    u_xlat3.x = u_xlat3.x * u_xlat1.x;
					    u_xlat1.x = u_xlat3.x * u_xlat3.x;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat3.x * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat9)<abs(u_xlat6);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat3.x = u_xlat3.x * u_xlat1.x + u_xlat4;
					    u_xlatb1 = u_xlat9<(-u_xlat9);
					    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
					    u_xlat3.x = u_xlat3.x + u_xlat1.x;
					    u_xlat1.x = min(u_xlat9, u_xlat6);
					    u_xlat6 = max(u_xlat9, u_xlat6);
					    u_xlatb6 = u_xlat6>=(-u_xlat6);
					    u_xlatb9 = u_xlat1.x<(-u_xlat1.x);
					    u_xlatb6 = u_xlatb6 && u_xlatb9;
					    u_xlat3.x = (u_xlatb6) ? (-u_xlat3.x) : u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + 3.14159274;
					    u_xlat6 = _Fillpercentage * _Arcrange;
					    u_xlat6 = u_xlat6 * -0.00277777785 + 1.0;
					    u_xlat3.x = u_xlat3.x * 0.159154937 + (-u_xlat6);
					    u_xlat3.x = ceil(u_xlat3.x);
					    u_xlat0.z = u_xlat0.x + _Radius;
					    u_xlat0.xz = floor(u_xlat0.xz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat3.x = u_xlat0.z * u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x;
					    u_xlat3.x = (-_Barmincolor.w) + _Barmaxcolor.w;
					    u_xlat3.x = _Fillpercentage * u_xlat3.x + _Barmincolor.w;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _Globalopacity;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _Mask_ST.xy + _Mask_ST.zw;
					    u_xlat1 = texture(_Mask, u_xlat3.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
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
						float _Rotation;
						float _Fillpercentage;
						float _Arcrange;
						float _Radius;
						vec4 _Barmincolor;
						vec4 _Barmaxcolor;
						float _Globalopacity;
						vec4 _Mask_ST;
					};
					uniform  sampler2D _Mask;
					uniform  sampler3D _DitherMaskLOD;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					float u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					bool u_xlatb7;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.x = _Rotation * 0.0174532924;
					    u_xlat1.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.x);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat2.z = u_xlat0.x;
					    u_xlat0.xy = vs_TEXCOORD1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat6 = dot(u_xlat0.xy, u_xlat2.xy);
					    u_xlat9 = dot(u_xlat0.xy, u_xlat2.yz);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3.x = max(abs(u_xlat9), abs(u_xlat6));
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat1.x = min(abs(u_xlat9), abs(u_xlat6));
					    u_xlat3.x = u_xlat3.x * u_xlat1.x;
					    u_xlat1.x = u_xlat3.x * u_xlat3.x;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat3.x * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat9)<abs(u_xlat6);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat3.x = u_xlat3.x * u_xlat1.x + u_xlat4;
					    u_xlatb1 = u_xlat9<(-u_xlat9);
					    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
					    u_xlat3.x = u_xlat3.x + u_xlat1.x;
					    u_xlat1.x = min(u_xlat9, u_xlat6);
					    u_xlat6 = max(u_xlat9, u_xlat6);
					    u_xlatb6 = u_xlat6>=(-u_xlat6);
					    u_xlatb9 = u_xlat1.x<(-u_xlat1.x);
					    u_xlatb6 = u_xlatb6 && u_xlatb9;
					    u_xlat3.x = (u_xlatb6) ? (-u_xlat3.x) : u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + 3.14159274;
					    u_xlat6 = _Fillpercentage * _Arcrange;
					    u_xlat6 = u_xlat6 * -0.00277777785 + 1.0;
					    u_xlat3.x = u_xlat3.x * 0.159154937 + (-u_xlat6);
					    u_xlat3.x = ceil(u_xlat3.x);
					    u_xlat0.z = u_xlat0.x + _Radius;
					    u_xlat0.xz = floor(u_xlat0.xz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat3.x = u_xlat0.z * u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x;
					    u_xlat3.x = (-_Barmincolor.w) + _Barmaxcolor.w;
					    u_xlat3.x = _Fillpercentage * u_xlat3.x + _Barmincolor.w;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _Globalopacity;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _Mask_ST.xy + _Mask_ST.zw;
					    u_xlat1 = texture(_Mask, u_xlat3.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
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
						float _Rotation;
						float _Fillpercentage;
						float _Arcrange;
						float _Radius;
						vec4 _Barmincolor;
						vec4 _Barmaxcolor;
						float _Globalopacity;
						vec4 _Mask_ST;
					};
					uniform  sampler2D _Mask;
					uniform  sampler3D _DitherMaskLOD;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					float u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					bool u_xlatb7;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.x = _Rotation * 0.0174532924;
					    u_xlat1.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.x);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat2.z = u_xlat0.x;
					    u_xlat0.xy = vs_TEXCOORD1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat6 = dot(u_xlat0.xy, u_xlat2.xy);
					    u_xlat9 = dot(u_xlat0.xy, u_xlat2.yz);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3.x = max(abs(u_xlat9), abs(u_xlat6));
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat1.x = min(abs(u_xlat9), abs(u_xlat6));
					    u_xlat3.x = u_xlat3.x * u_xlat1.x;
					    u_xlat1.x = u_xlat3.x * u_xlat3.x;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat3.x * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat9)<abs(u_xlat6);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat3.x = u_xlat3.x * u_xlat1.x + u_xlat4;
					    u_xlatb1 = u_xlat9<(-u_xlat9);
					    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
					    u_xlat3.x = u_xlat3.x + u_xlat1.x;
					    u_xlat1.x = min(u_xlat9, u_xlat6);
					    u_xlat6 = max(u_xlat9, u_xlat6);
					    u_xlatb6 = u_xlat6>=(-u_xlat6);
					    u_xlatb9 = u_xlat1.x<(-u_xlat1.x);
					    u_xlatb6 = u_xlatb6 && u_xlatb9;
					    u_xlat3.x = (u_xlatb6) ? (-u_xlat3.x) : u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + 3.14159274;
					    u_xlat6 = _Fillpercentage * _Arcrange;
					    u_xlat6 = u_xlat6 * -0.00277777785 + 1.0;
					    u_xlat3.x = u_xlat3.x * 0.159154937 + (-u_xlat6);
					    u_xlat3.x = ceil(u_xlat3.x);
					    u_xlat0.z = u_xlat0.x + _Radius;
					    u_xlat0.xz = floor(u_xlat0.xz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat3.x = u_xlat0.z * u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x;
					    u_xlat3.x = (-_Barmincolor.w) + _Barmaxcolor.w;
					    u_xlat3.x = _Fillpercentage * u_xlat3.x + _Barmincolor.w;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _Globalopacity;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _Mask_ST.xy + _Mask_ST.zw;
					    u_xlat1 = texture(_Mask, u_xlat3.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
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
						float _Rotation;
						float _Fillpercentage;
						float _Arcrange;
						float _Radius;
						vec4 _Barmincolor;
						vec4 _Barmaxcolor;
						float _Globalopacity;
						vec4 _Mask_ST;
					};
					uniform  sampler2D _Mask;
					uniform  sampler3D _DitherMaskLOD;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					float u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					bool u_xlatb7;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.x = _Rotation * 0.0174532924;
					    u_xlat1.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.x);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat2.z = u_xlat0.x;
					    u_xlat0.xy = vs_TEXCOORD1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat6 = dot(u_xlat0.xy, u_xlat2.xy);
					    u_xlat9 = dot(u_xlat0.xy, u_xlat2.yz);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3.x = max(abs(u_xlat9), abs(u_xlat6));
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat1.x = min(abs(u_xlat9), abs(u_xlat6));
					    u_xlat3.x = u_xlat3.x * u_xlat1.x;
					    u_xlat1.x = u_xlat3.x * u_xlat3.x;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat3.x * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat9)<abs(u_xlat6);
					    u_xlat4 = u_xlatb7 ? u_xlat4 : float(0.0);
					    u_xlat3.x = u_xlat3.x * u_xlat1.x + u_xlat4;
					    u_xlatb1 = u_xlat9<(-u_xlat9);
					    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
					    u_xlat3.x = u_xlat3.x + u_xlat1.x;
					    u_xlat1.x = min(u_xlat9, u_xlat6);
					    u_xlat6 = max(u_xlat9, u_xlat6);
					    u_xlatb6 = u_xlat6>=(-u_xlat6);
					    u_xlatb9 = u_xlat1.x<(-u_xlat1.x);
					    u_xlatb6 = u_xlatb6 && u_xlatb9;
					    u_xlat3.x = (u_xlatb6) ? (-u_xlat3.x) : u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + 3.14159274;
					    u_xlat6 = _Fillpercentage * _Arcrange;
					    u_xlat6 = u_xlat6 * -0.00277777785 + 1.0;
					    u_xlat3.x = u_xlat3.x * 0.159154937 + (-u_xlat6);
					    u_xlat3.x = ceil(u_xlat3.x);
					    u_xlat0.z = u_xlat0.x + _Radius;
					    u_xlat0.xz = floor(u_xlat0.xz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat3.x = u_xlat0.z * u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x;
					    u_xlat3.x = (-_Barmincolor.w) + _Barmaxcolor.w;
					    u_xlat3.x = _Fillpercentage * u_xlat3.x + _Barmincolor.w;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _Globalopacity;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _Mask_ST.xy + _Mask_ST.zw;
					    u_xlat1 = texture(_Mask, u_xlat3.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
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
	CustomEditor "AdultLink.SimpleRadialProgressBarEditor"
}