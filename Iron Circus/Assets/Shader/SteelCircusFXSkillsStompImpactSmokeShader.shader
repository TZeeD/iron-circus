Shader "SteelCircus/FX/Skills/StompImpactSmokeShader" {
	Properties {
		_MaskTime ("Animate: Mask Time", Range(0, 1)) = 0
		_UVScroll ("Animate: UV.v Scroll", Float) = 0
		_Scale ("Animate: xz Scale", Float) = 1
		_MainTex ("Texture", 2D) = "white" {}
		[NoScaleOffset] _DispTex ("Displacement Tex", 2D) = "white" {}
		_DispStrength ("Displacement Strength", Float) = 0.1
		_DispSpeed ("Displacement Scroll Speed", Float) = 1
		[NoScaleOffset] _MaskTex ("Mask (x=time, y=intensity over v)", 2D) = "white" {}
		_FresnelPow ("Fresnel Power", Float) = 1
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 43536
			Program "vp" {
				SubProgram "d3d11 hw_tier00 " {
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
						float _Scale;
						vec4 _MainTex_ST;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec3 in_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.xy = in_POSITION0.xz * vec2(vec2(_Scale, _Scale));
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat2;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
					    vs_TEXCOORD3 = u_xlat1;
					    u_xlat0.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0 = in_NORMAL0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_NORMAL0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_NORMAL0.zzzz + u_xlat0;
					    u_xlat9 = dot(u_xlat0, u_xlat0);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
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
						float _Scale;
						vec4 _MainTex_ST;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec3 in_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.xy = in_POSITION0.xz * vec2(vec2(_Scale, _Scale));
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat2;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
					    vs_TEXCOORD3 = u_xlat1;
					    u_xlat0.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0 = in_NORMAL0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_NORMAL0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_NORMAL0.zzzz + u_xlat0;
					    u_xlat9 = dot(u_xlat0, u_xlat0);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
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
						float _Scale;
						vec4 _MainTex_ST;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec3 in_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.xy = in_POSITION0.xz * vec2(vec2(_Scale, _Scale));
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat2;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
					    vs_TEXCOORD3 = u_xlat1;
					    u_xlat0.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0 = in_NORMAL0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_NORMAL0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_NORMAL0.zzzz + u_xlat0;
					    u_xlat9 = dot(u_xlat0, u_xlat0);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "FOG_LINEAR" }
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
						float _Scale;
						vec4 _MainTex_ST;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec3 in_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.xy = in_POSITION0.xz * vec2(vec2(_Scale, _Scale));
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat2;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
					    vs_TEXCOORD3 = u_xlat1;
					    u_xlat0.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0 = in_NORMAL0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_NORMAL0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_NORMAL0.zzzz + u_xlat0;
					    u_xlat9 = dot(u_xlat0, u_xlat0);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "FOG_LINEAR" }
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
						float _Scale;
						vec4 _MainTex_ST;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec3 in_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.xy = in_POSITION0.xz * vec2(vec2(_Scale, _Scale));
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat2;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
					    vs_TEXCOORD3 = u_xlat1;
					    u_xlat0.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0 = in_NORMAL0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_NORMAL0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_NORMAL0.zzzz + u_xlat0;
					    u_xlat9 = dot(u_xlat0, u_xlat0);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "FOG_LINEAR" }
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
						float _Scale;
						vec4 _MainTex_ST;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec3 in_NORMAL0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.xy = in_POSITION0.xz * vec2(vec2(_Scale, _Scale));
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat2;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
					    vs_TEXCOORD3 = u_xlat1;
					    u_xlat0.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0 = in_NORMAL0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_NORMAL0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_NORMAL0.zzzz + u_xlat0;
					    u_xlat9 = dot(u_xlat0, u_xlat0);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 hw_tier00 " {
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
						float _MaskTime;
						float _UVScroll;
						vec4 unused_0_3;
						float _DispStrength;
						float _DispSpeed;
						float _FresnelPow;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DispTex;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _FresnelPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.x = log2(abs(vs_NORMAL0.y));
					    u_xlat3.x = u_xlat3.x * 20.0;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat0.x = u_xlat3.x + u_xlat0.x;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1.x = _DispSpeed * _Time.y;
					    u_xlat1.y = 0.0;
					    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.25) + u_xlat1.xy;
					    u_xlat1 = texture(_DispTex, u_xlat3.xy);
					    u_xlat3.x = inversesqrt(vs_TEXCOORD0.y);
					    u_xlat1.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat1.x + (-_UVScroll);
					    u_xlat2.z = (-u_xlat1.y) * _DispStrength + u_xlat3.x;
					    u_xlat2.x = vs_TEXCOORD0.x;
					    u_xlat2 = texture(_MainTex, u_xlat2.xz);
					    u_xlat2 = u_xlat2 * vs_COLOR0.xxxx;
					    u_xlat0 = u_xlat0.xxxx * u_xlat2;
					    u_xlat1.z = _MaskTime;
					    u_xlat1 = texture(_MaskTex, u_xlat1.zx);
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
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
						float _MaskTime;
						float _UVScroll;
						vec4 unused_0_3;
						float _DispStrength;
						float _DispSpeed;
						float _FresnelPow;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DispTex;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _FresnelPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.x = log2(abs(vs_NORMAL0.y));
					    u_xlat3.x = u_xlat3.x * 20.0;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat0.x = u_xlat3.x + u_xlat0.x;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1.x = _DispSpeed * _Time.y;
					    u_xlat1.y = 0.0;
					    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.25) + u_xlat1.xy;
					    u_xlat1 = texture(_DispTex, u_xlat3.xy);
					    u_xlat3.x = inversesqrt(vs_TEXCOORD0.y);
					    u_xlat1.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat1.x + (-_UVScroll);
					    u_xlat2.z = (-u_xlat1.y) * _DispStrength + u_xlat3.x;
					    u_xlat2.x = vs_TEXCOORD0.x;
					    u_xlat2 = texture(_MainTex, u_xlat2.xz);
					    u_xlat2 = u_xlat2 * vs_COLOR0.xxxx;
					    u_xlat0 = u_xlat0.xxxx * u_xlat2;
					    u_xlat1.z = _MaskTime;
					    u_xlat1 = texture(_MaskTex, u_xlat1.zx);
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
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
						float _MaskTime;
						float _UVScroll;
						vec4 unused_0_3;
						float _DispStrength;
						float _DispSpeed;
						float _FresnelPow;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DispTex;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _FresnelPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.x = log2(abs(vs_NORMAL0.y));
					    u_xlat3.x = u_xlat3.x * 20.0;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat0.x = u_xlat3.x + u_xlat0.x;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1.x = _DispSpeed * _Time.y;
					    u_xlat1.y = 0.0;
					    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.25) + u_xlat1.xy;
					    u_xlat1 = texture(_DispTex, u_xlat3.xy);
					    u_xlat3.x = inversesqrt(vs_TEXCOORD0.y);
					    u_xlat1.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat1.x + (-_UVScroll);
					    u_xlat2.z = (-u_xlat1.y) * _DispStrength + u_xlat3.x;
					    u_xlat2.x = vs_TEXCOORD0.x;
					    u_xlat2 = texture(_MainTex, u_xlat2.xz);
					    u_xlat2 = u_xlat2 * vs_COLOR0.xxxx;
					    u_xlat0 = u_xlat0.xxxx * u_xlat2;
					    u_xlat1.z = _MaskTime;
					    u_xlat1 = texture(_MaskTex, u_xlat1.zx);
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "FOG_LINEAR" }
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
						float _MaskTime;
						float _UVScroll;
						vec4 unused_0_3;
						float _DispStrength;
						float _DispSpeed;
						float _FresnelPow;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DispTex;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _FresnelPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.x = log2(abs(vs_NORMAL0.y));
					    u_xlat3.x = u_xlat3.x * 20.0;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat0.x = u_xlat3.x + u_xlat0.x;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1.x = _DispSpeed * _Time.y;
					    u_xlat1.y = 0.0;
					    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.25) + u_xlat1.xy;
					    u_xlat1 = texture(_DispTex, u_xlat3.xy);
					    u_xlat3.x = inversesqrt(vs_TEXCOORD0.y);
					    u_xlat1.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat1.x + (-_UVScroll);
					    u_xlat2.z = (-u_xlat1.y) * _DispStrength + u_xlat3.x;
					    u_xlat2.x = vs_TEXCOORD0.x;
					    u_xlat2 = texture(_MainTex, u_xlat2.xz);
					    u_xlat2 = u_xlat2 * vs_COLOR0.xxxx;
					    u_xlat0 = u_xlat0.xxxx * u_xlat2;
					    u_xlat1.z = _MaskTime;
					    u_xlat1 = texture(_MaskTex, u_xlat1.zx);
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "FOG_LINEAR" }
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
						float _MaskTime;
						float _UVScroll;
						vec4 unused_0_3;
						float _DispStrength;
						float _DispSpeed;
						float _FresnelPow;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DispTex;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _FresnelPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.x = log2(abs(vs_NORMAL0.y));
					    u_xlat3.x = u_xlat3.x * 20.0;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat0.x = u_xlat3.x + u_xlat0.x;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1.x = _DispSpeed * _Time.y;
					    u_xlat1.y = 0.0;
					    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.25) + u_xlat1.xy;
					    u_xlat1 = texture(_DispTex, u_xlat3.xy);
					    u_xlat3.x = inversesqrt(vs_TEXCOORD0.y);
					    u_xlat1.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat1.x + (-_UVScroll);
					    u_xlat2.z = (-u_xlat1.y) * _DispStrength + u_xlat3.x;
					    u_xlat2.x = vs_TEXCOORD0.x;
					    u_xlat2 = texture(_MainTex, u_xlat2.xz);
					    u_xlat2 = u_xlat2 * vs_COLOR0.xxxx;
					    u_xlat0 = u_xlat0.xxxx * u_xlat2;
					    u_xlat1.z = _MaskTime;
					    u_xlat1 = texture(_MaskTex, u_xlat1.zx);
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "FOG_LINEAR" }
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
						float _MaskTime;
						float _UVScroll;
						vec4 unused_0_3;
						float _DispStrength;
						float _DispSpeed;
						float _FresnelPow;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DispTex;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _FresnelPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.x = log2(abs(vs_NORMAL0.y));
					    u_xlat3.x = u_xlat3.x * 20.0;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat0.x = u_xlat3.x + u_xlat0.x;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1.x = _DispSpeed * _Time.y;
					    u_xlat1.y = 0.0;
					    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.25) + u_xlat1.xy;
					    u_xlat1 = texture(_DispTex, u_xlat3.xy);
					    u_xlat3.x = inversesqrt(vs_TEXCOORD0.y);
					    u_xlat1.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat1.x + (-_UVScroll);
					    u_xlat2.z = (-u_xlat1.y) * _DispStrength + u_xlat3.x;
					    u_xlat2.x = vs_TEXCOORD0.x;
					    u_xlat2 = texture(_MainTex, u_xlat2.xz);
					    u_xlat2 = u_xlat2 * vs_COLOR0.xxxx;
					    u_xlat0 = u_xlat0.xxxx * u_xlat2;
					    u_xlat1.z = _MaskTime;
					    u_xlat1 = texture(_MaskTex, u_xlat1.zx);
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
			}
		}
	}
}