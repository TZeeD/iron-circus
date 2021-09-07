Shader "Hidden/UI Default ETC1 (Soft Masked)" {
	Properties {
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		[PerRendererData] _AlphaTex ("Sprite Alpha Texture", 2D) = "white" {}
		_Color ("Tint", Vector) = (1,1,1,1)
		[PerRendererData] _SoftMask ("Mask", 2D) = "white" {}
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
	}
	SubShader {
		Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "Default"
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask 0 -1
			ZWrite Off
			Cull Off
			Stencil {
				ReadMask 0
				WriteMask 0
				Comp Disabled
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 7976
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
						vec4 _Color;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
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
						vec4 _Color;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
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
						vec4 _Color;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SOFTMASK_SIMPLE" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SOFTMASK_SIMPLE" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SOFTMASK_SIMPLE" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SOFTMASK_SLICED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[3];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SOFTMASK_SLICED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[3];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SOFTMASK_SLICED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[3];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SOFTMASK_TILED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[4];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SOFTMASK_TILED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[4];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SOFTMASK_TILED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[4];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
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
						vec4 _Color;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
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
						vec4 _Color;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
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
						vec4 _Color;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SIMPLE" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SIMPLE" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SIMPLE" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SLICED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[3];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SLICED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[3];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SLICED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[3];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_TILED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[4];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_TILED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[4];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_TILED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[4];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
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
						vec4 _Color;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
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
						vec4 _Color;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
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
						vec4 _Color;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SOFTMASK_SIMPLE" "UNITY_UI_CLIP_RECT" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SOFTMASK_SIMPLE" "UNITY_UI_CLIP_RECT" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SOFTMASK_SIMPLE" "UNITY_UI_CLIP_RECT" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_CLIP_RECT" "SOFTMASK_SLICED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[3];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_CLIP_RECT" "SOFTMASK_SLICED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[3];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_CLIP_RECT" "SOFTMASK_SLICED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[3];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_CLIP_RECT" "SOFTMASK_TILED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[4];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_CLIP_RECT" "SOFTMASK_TILED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[4];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_CLIP_RECT" "SOFTMASK_TILED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[4];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
						vec4 _Color;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
						vec4 _Color;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
						vec4 _Color;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SIMPLE" "UNITY_UI_CLIP_RECT" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SIMPLE" "UNITY_UI_CLIP_RECT" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SIMPLE" "UNITY_UI_CLIP_RECT" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "SOFTMASK_SLICED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[3];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "SOFTMASK_SLICED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[3];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "SOFTMASK_SLICED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[3];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "SOFTMASK_TILED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[4];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "SOFTMASK_TILED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[4];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "SOFTMASK_TILED" }
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
						mat4x4 _SoftMask_WorldToMask;
						vec4 unused_0_2[4];
						vec4 _Color;
						vec4 unused_0_4[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    u_xlat0 = in_POSITION0.yyyy * _SoftMask_WorldToMask[1];
					    u_xlat0 = _SoftMask_WorldToMask[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = _SoftMask_WorldToMask[2] * in_POSITION0.zzzz + u_xlat0;
					    vs_TEXCOORD2 = _SoftMask_WorldToMask[3] * in_POSITION0.wwww + u_xlat0;
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
						vec4 unused_0_0[3];
						vec4 _TextureSampleAdd;
						vec4 unused_0_2[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + _TextureSampleAdd.xyz;
					    u_xlat1 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat0.w = u_xlat1.x + _TextureSampleAdd.w;
					    SV_Target0 = u_xlat0 * vs_COLOR0;
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
						vec4 unused_0_0[3];
						vec4 _TextureSampleAdd;
						vec4 unused_0_2[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + _TextureSampleAdd.xyz;
					    u_xlat1 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat0.w = u_xlat1.x + _TextureSampleAdd.w;
					    SV_Target0 = u_xlat0 * vs_COLOR0;
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
						vec4 unused_0_0[3];
						vec4 _TextureSampleAdd;
						vec4 unused_0_2[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + _TextureSampleAdd.xyz;
					    u_xlat1 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat0.w = u_xlat1.x + _TextureSampleAdd.w;
					    SV_Target0 = u_xlat0 * vs_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SOFTMASK_SIMPLE" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 unused_0_5;
						vec4 _TextureSampleAdd;
						vec4 unused_0_7[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy + (-_SoftMask_Rect.xy);
					    u_xlat6.xy = (-_SoftMask_Rect.xy) + _SoftMask_Rect.zw;
					    u_xlat0.xy = u_xlat0.xy / u_xlat6.xy;
					    u_xlatb6.xy = notEqual(u_xlat6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat0.x = u_xlatb6.x ? u_xlat0.x : 0.0;
					    u_xlat0.y = u_xlatb6.y ? u_xlat0.y : 0.0;
					;
					    u_xlat6.xy = (-_SoftMask_UVRect.xy) + _SoftMask_UVRect.zw;
					    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + _SoftMask_UVRect.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SOFTMASK_SIMPLE" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 unused_0_5;
						vec4 _TextureSampleAdd;
						vec4 unused_0_7[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy + (-_SoftMask_Rect.xy);
					    u_xlat6.xy = (-_SoftMask_Rect.xy) + _SoftMask_Rect.zw;
					    u_xlat0.xy = u_xlat0.xy / u_xlat6.xy;
					    u_xlatb6.xy = notEqual(u_xlat6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat0.x = u_xlatb6.x ? u_xlat0.x : 0.0;
					    u_xlat0.y = u_xlatb6.y ? u_xlat0.y : 0.0;
					;
					    u_xlat6.xy = (-_SoftMask_UVRect.xy) + _SoftMask_UVRect.zw;
					    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + _SoftMask_UVRect.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SOFTMASK_SIMPLE" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 unused_0_5;
						vec4 _TextureSampleAdd;
						vec4 unused_0_7[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy + (-_SoftMask_Rect.xy);
					    u_xlat6.xy = (-_SoftMask_Rect.xy) + _SoftMask_Rect.zw;
					    u_xlat0.xy = u_xlat0.xy / u_xlat6.xy;
					    u_xlatb6.xy = notEqual(u_xlat6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat0.x = u_xlatb6.x ? u_xlat0.x : 0.0;
					    u_xlat0.y = u_xlatb6.y ? u_xlat0.y : 0.0;
					;
					    u_xlat6.xy = (-_SoftMask_UVRect.xy) + _SoftMask_UVRect.zw;
					    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + _SoftMask_UVRect.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SOFTMASK_SLICED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec4 unused_0_7;
						vec4 _TextureSampleAdd;
						vec4 unused_0_9[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat2.z = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.w = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.zwzw * _SoftMask_BorderRect;
					    u_xlat2 = u_xlat2 * _SoftMask_UVBorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat8.x = u_xlatb8.x ? u_xlat9.x : 0.0;
					    u_xlat8.y = u_xlatb8.y ? u_xlat9.y : 0.0;
					;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat2.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat2.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SOFTMASK_SLICED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec4 unused_0_7;
						vec4 _TextureSampleAdd;
						vec4 unused_0_9[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat2.z = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.w = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.zwzw * _SoftMask_BorderRect;
					    u_xlat2 = u_xlat2 * _SoftMask_UVBorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat8.x = u_xlatb8.x ? u_xlat9.x : 0.0;
					    u_xlat8.y = u_xlatb8.y ? u_xlat9.y : 0.0;
					;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat2.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat2.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SOFTMASK_SLICED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec4 unused_0_7;
						vec4 _TextureSampleAdd;
						vec4 unused_0_9[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat2.z = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.w = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.zwzw * _SoftMask_BorderRect;
					    u_xlat2 = u_xlat2 * _SoftMask_UVBorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat8.x = u_xlatb8.x ? u_xlat9.x : 0.0;
					    u_xlat8.y = u_xlatb8.y ? u_xlat9.y : 0.0;
					;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat2.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat2.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SOFTMASK_TILED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec2 _SoftMask_TileRepeat;
						vec4 unused_0_8;
						vec4 _TextureSampleAdd;
						vec4 unused_0_10[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_BorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlat10.xy = u_xlat2.xy * _SoftMask_TileRepeat.xy;
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_UVBorderRect;
					    u_xlat2.xy = u_xlat9.xy * u_xlat10.xy;
					    u_xlat8.xy = u_xlat8.xy * u_xlat10.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.xy = fract(u_xlat2.xy);
					    u_xlat8.x = (u_xlatb8.x) ? u_xlat2.x : u_xlat9.x;
					    u_xlat8.y = (u_xlatb8.y) ? u_xlat2.y : u_xlat9.y;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SOFTMASK_TILED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec2 _SoftMask_TileRepeat;
						vec4 unused_0_8;
						vec4 _TextureSampleAdd;
						vec4 unused_0_10[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_BorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlat10.xy = u_xlat2.xy * _SoftMask_TileRepeat.xy;
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_UVBorderRect;
					    u_xlat2.xy = u_xlat9.xy * u_xlat10.xy;
					    u_xlat8.xy = u_xlat8.xy * u_xlat10.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.xy = fract(u_xlat2.xy);
					    u_xlat8.x = (u_xlatb8.x) ? u_xlat2.x : u_xlat9.x;
					    u_xlat8.y = (u_xlatb8.y) ? u_xlat2.y : u_xlat9.y;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SOFTMASK_TILED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec2 _SoftMask_TileRepeat;
						vec4 unused_0_8;
						vec4 _TextureSampleAdd;
						vec4 unused_0_10[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_BorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlat10.xy = u_xlat2.xy * _SoftMask_TileRepeat.xy;
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_UVBorderRect;
					    u_xlat2.xy = u_xlat9.xy * u_xlat10.xy;
					    u_xlat8.xy = u_xlat8.xy * u_xlat10.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.xy = fract(u_xlat2.xy);
					    u_xlat8.x = (u_xlatb8.x) ? u_xlat2.x : u_xlat9.x;
					    u_xlat8.y = (u_xlatb8.y) ? u_xlat2.y : u_xlat9.y;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
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
						vec4 unused_0_0[3];
						vec4 _TextureSampleAdd;
						vec4 unused_0_2[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					void main()
					{
					    u_xlat0 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat0.w = u_xlat0.x + _TextureSampleAdd.w;
					    u_xlat1.x = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlatb1 = u_xlat1.x<0.0;
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat0 = u_xlat0 * vs_COLOR0;
					    SV_Target0 = u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
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
						vec4 unused_0_0[3];
						vec4 _TextureSampleAdd;
						vec4 unused_0_2[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					void main()
					{
					    u_xlat0 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat0.w = u_xlat0.x + _TextureSampleAdd.w;
					    u_xlat1.x = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlatb1 = u_xlat1.x<0.0;
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat0 = u_xlat0 * vs_COLOR0;
					    SV_Target0 = u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
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
						vec4 unused_0_0[3];
						vec4 _TextureSampleAdd;
						vec4 unused_0_2[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					void main()
					{
					    u_xlat0 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat0.w = u_xlat0.x + _TextureSampleAdd.w;
					    u_xlat1.x = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlatb1 = u_xlat1.x<0.0;
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat0 = u_xlat0 * vs_COLOR0;
					    SV_Target0 = u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SIMPLE" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 unused_0_5;
						vec4 _TextureSampleAdd;
						vec4 unused_0_7[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy + (-_SoftMask_Rect.xy);
					    u_xlat6.xy = (-_SoftMask_Rect.xy) + _SoftMask_Rect.zw;
					    u_xlat0.xy = u_xlat0.xy / u_xlat6.xy;
					    u_xlatb6.xy = notEqual(u_xlat6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat0.x = u_xlatb6.x ? u_xlat0.x : 0.0;
					    u_xlat0.y = u_xlatb6.y ? u_xlat0.y : 0.0;
					;
					    u_xlat6.xy = (-_SoftMask_UVRect.xy) + _SoftMask_UVRect.zw;
					    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + _SoftMask_UVRect.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat3.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0 = u_xlat3.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SIMPLE" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 unused_0_5;
						vec4 _TextureSampleAdd;
						vec4 unused_0_7[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy + (-_SoftMask_Rect.xy);
					    u_xlat6.xy = (-_SoftMask_Rect.xy) + _SoftMask_Rect.zw;
					    u_xlat0.xy = u_xlat0.xy / u_xlat6.xy;
					    u_xlatb6.xy = notEqual(u_xlat6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat0.x = u_xlatb6.x ? u_xlat0.x : 0.0;
					    u_xlat0.y = u_xlatb6.y ? u_xlat0.y : 0.0;
					;
					    u_xlat6.xy = (-_SoftMask_UVRect.xy) + _SoftMask_UVRect.zw;
					    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + _SoftMask_UVRect.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat3.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0 = u_xlat3.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SIMPLE" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 unused_0_5;
						vec4 _TextureSampleAdd;
						vec4 unused_0_7[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy + (-_SoftMask_Rect.xy);
					    u_xlat6.xy = (-_SoftMask_Rect.xy) + _SoftMask_Rect.zw;
					    u_xlat0.xy = u_xlat0.xy / u_xlat6.xy;
					    u_xlatb6.xy = notEqual(u_xlat6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat0.x = u_xlatb6.x ? u_xlat0.x : 0.0;
					    u_xlat0.y = u_xlatb6.y ? u_xlat0.y : 0.0;
					;
					    u_xlat6.xy = (-_SoftMask_UVRect.xy) + _SoftMask_UVRect.zw;
					    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + _SoftMask_UVRect.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat3.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0 = u_xlat3.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SLICED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec4 unused_0_7;
						vec4 _TextureSampleAdd;
						vec4 unused_0_9[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat2.z = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.w = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.zwzw * _SoftMask_BorderRect;
					    u_xlat2 = u_xlat2 * _SoftMask_UVBorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat8.x = u_xlatb8.x ? u_xlat9.x : 0.0;
					    u_xlat8.y = u_xlatb8.y ? u_xlat9.y : 0.0;
					;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat2.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat2.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat4.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat4.x<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SLICED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec4 unused_0_7;
						vec4 _TextureSampleAdd;
						vec4 unused_0_9[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat2.z = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.w = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.zwzw * _SoftMask_BorderRect;
					    u_xlat2 = u_xlat2 * _SoftMask_UVBorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat8.x = u_xlatb8.x ? u_xlat9.x : 0.0;
					    u_xlat8.y = u_xlatb8.y ? u_xlat9.y : 0.0;
					;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat2.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat2.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat4.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat4.x<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SLICED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec4 unused_0_7;
						vec4 _TextureSampleAdd;
						vec4 unused_0_9[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat2.z = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.w = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.zwzw * _SoftMask_BorderRect;
					    u_xlat2 = u_xlat2 * _SoftMask_UVBorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat8.x = u_xlatb8.x ? u_xlat9.x : 0.0;
					    u_xlat8.y = u_xlatb8.y ? u_xlat9.y : 0.0;
					;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat2.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat2.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat4.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat4.x<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_TILED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec2 _SoftMask_TileRepeat;
						vec4 unused_0_8;
						vec4 _TextureSampleAdd;
						vec4 unused_0_10[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_BorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlat10.xy = u_xlat2.xy * _SoftMask_TileRepeat.xy;
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_UVBorderRect;
					    u_xlat2.xy = u_xlat9.xy * u_xlat10.xy;
					    u_xlat8.xy = u_xlat8.xy * u_xlat10.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.xy = fract(u_xlat2.xy);
					    u_xlat8.x = (u_xlatb8.x) ? u_xlat2.x : u_xlat9.x;
					    u_xlat8.y = (u_xlatb8.y) ? u_xlat2.y : u_xlat9.y;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat4.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat4.x<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_TILED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec2 _SoftMask_TileRepeat;
						vec4 unused_0_8;
						vec4 _TextureSampleAdd;
						vec4 unused_0_10[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_BorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlat10.xy = u_xlat2.xy * _SoftMask_TileRepeat.xy;
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_UVBorderRect;
					    u_xlat2.xy = u_xlat9.xy * u_xlat10.xy;
					    u_xlat8.xy = u_xlat8.xy * u_xlat10.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.xy = fract(u_xlat2.xy);
					    u_xlat8.x = (u_xlatb8.x) ? u_xlat2.x : u_xlat9.x;
					    u_xlat8.y = (u_xlatb8.y) ? u_xlat2.y : u_xlat9.y;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat4.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat4.x<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_TILED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec2 _SoftMask_TileRepeat;
						vec4 unused_0_8;
						vec4 _TextureSampleAdd;
						vec4 unused_0_10[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_BorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlat10.xy = u_xlat2.xy * _SoftMask_TileRepeat.xy;
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_UVBorderRect;
					    u_xlat2.xy = u_xlat9.xy * u_xlat10.xy;
					    u_xlat8.xy = u_xlat8.xy * u_xlat10.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.xy = fract(u_xlat2.xy);
					    u_xlat8.x = (u_xlatb8.x) ? u_xlat2.x : u_xlat9.x;
					    u_xlat8.y = (u_xlatb8.y) ? u_xlat2.y : u_xlat9.y;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat4.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat4.x<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
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
						vec4 unused_0_0[3];
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_3;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
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
						vec4 unused_0_0[3];
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_3;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
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
						vec4 unused_0_0[3];
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_3;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SOFTMASK_SIMPLE" "UNITY_UI_CLIP_RECT" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 unused_0_5;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_8;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy + (-_SoftMask_Rect.xy);
					    u_xlat6.xy = (-_SoftMask_Rect.xy) + _SoftMask_Rect.zw;
					    u_xlat0.xy = u_xlat0.xy / u_xlat6.xy;
					    u_xlatb6.xy = notEqual(u_xlat6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat0.x = u_xlatb6.x ? u_xlat0.x : 0.0;
					    u_xlat0.y = u_xlatb6.y ? u_xlat0.y : 0.0;
					;
					    u_xlat6.xy = (-_SoftMask_UVRect.xy) + _SoftMask_UVRect.zw;
					    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + _SoftMask_UVRect.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    SV_Target0.w = u_xlat3.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SOFTMASK_SIMPLE" "UNITY_UI_CLIP_RECT" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 unused_0_5;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_8;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy + (-_SoftMask_Rect.xy);
					    u_xlat6.xy = (-_SoftMask_Rect.xy) + _SoftMask_Rect.zw;
					    u_xlat0.xy = u_xlat0.xy / u_xlat6.xy;
					    u_xlatb6.xy = notEqual(u_xlat6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat0.x = u_xlatb6.x ? u_xlat0.x : 0.0;
					    u_xlat0.y = u_xlatb6.y ? u_xlat0.y : 0.0;
					;
					    u_xlat6.xy = (-_SoftMask_UVRect.xy) + _SoftMask_UVRect.zw;
					    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + _SoftMask_UVRect.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    SV_Target0.w = u_xlat3.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SOFTMASK_SIMPLE" "UNITY_UI_CLIP_RECT" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 unused_0_5;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_8;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy + (-_SoftMask_Rect.xy);
					    u_xlat6.xy = (-_SoftMask_Rect.xy) + _SoftMask_Rect.zw;
					    u_xlat0.xy = u_xlat0.xy / u_xlat6.xy;
					    u_xlatb6.xy = notEqual(u_xlat6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat0.x = u_xlatb6.x ? u_xlat0.x : 0.0;
					    u_xlat0.y = u_xlatb6.y ? u_xlat0.y : 0.0;
					;
					    u_xlat6.xy = (-_SoftMask_UVRect.xy) + _SoftMask_UVRect.zw;
					    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + _SoftMask_UVRect.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    SV_Target0.w = u_xlat3.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_CLIP_RECT" "SOFTMASK_SLICED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec4 unused_0_7;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_10;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat2.z = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.w = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.zwzw * _SoftMask_BorderRect;
					    u_xlat2 = u_xlat2 * _SoftMask_UVBorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat8.x = u_xlatb8.x ? u_xlat9.x : 0.0;
					    u_xlat8.y = u_xlatb8.y ? u_xlat9.y : 0.0;
					;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat2.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat2.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    SV_Target0.w = u_xlat4.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_CLIP_RECT" "SOFTMASK_SLICED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec4 unused_0_7;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_10;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat2.z = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.w = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.zwzw * _SoftMask_BorderRect;
					    u_xlat2 = u_xlat2 * _SoftMask_UVBorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat8.x = u_xlatb8.x ? u_xlat9.x : 0.0;
					    u_xlat8.y = u_xlatb8.y ? u_xlat9.y : 0.0;
					;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat2.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat2.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    SV_Target0.w = u_xlat4.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_CLIP_RECT" "SOFTMASK_SLICED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec4 unused_0_7;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_10;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat2.z = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.w = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.zwzw * _SoftMask_BorderRect;
					    u_xlat2 = u_xlat2 * _SoftMask_UVBorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat8.x = u_xlatb8.x ? u_xlat9.x : 0.0;
					    u_xlat8.y = u_xlatb8.y ? u_xlat9.y : 0.0;
					;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat2.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat2.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    SV_Target0.w = u_xlat4.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_CLIP_RECT" "SOFTMASK_TILED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec2 _SoftMask_TileRepeat;
						vec4 unused_0_8;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_11;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_BorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlat10.xy = u_xlat2.xy * _SoftMask_TileRepeat.xy;
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_UVBorderRect;
					    u_xlat2.xy = u_xlat9.xy * u_xlat10.xy;
					    u_xlat8.xy = u_xlat8.xy * u_xlat10.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.xy = fract(u_xlat2.xy);
					    u_xlat8.x = (u_xlatb8.x) ? u_xlat2.x : u_xlat9.x;
					    u_xlat8.y = (u_xlatb8.y) ? u_xlat2.y : u_xlat9.y;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    SV_Target0.w = u_xlat4.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_CLIP_RECT" "SOFTMASK_TILED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec2 _SoftMask_TileRepeat;
						vec4 unused_0_8;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_11;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_BorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlat10.xy = u_xlat2.xy * _SoftMask_TileRepeat.xy;
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_UVBorderRect;
					    u_xlat2.xy = u_xlat9.xy * u_xlat10.xy;
					    u_xlat8.xy = u_xlat8.xy * u_xlat10.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.xy = fract(u_xlat2.xy);
					    u_xlat8.x = (u_xlatb8.x) ? u_xlat2.x : u_xlat9.x;
					    u_xlat8.y = (u_xlatb8.y) ? u_xlat2.y : u_xlat9.y;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    SV_Target0.w = u_xlat4.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_CLIP_RECT" "SOFTMASK_TILED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec2 _SoftMask_TileRepeat;
						vec4 unused_0_8;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_11;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_BorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlat10.xy = u_xlat2.xy * _SoftMask_TileRepeat.xy;
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_UVBorderRect;
					    u_xlat2.xy = u_xlat9.xy * u_xlat10.xy;
					    u_xlat8.xy = u_xlat8.xy * u_xlat10.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.xy = fract(u_xlat2.xy);
					    u_xlat8.x = (u_xlatb8.x) ? u_xlat2.x : u_xlat9.x;
					    u_xlat8.y = (u_xlatb8.y) ? u_xlat2.y : u_xlat9.y;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    SV_Target0.w = u_xlat4.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
						vec4 unused_0_0[3];
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_3;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat3 = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat3<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
						vec4 unused_0_0[3];
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_3;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat3 = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat3<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
						vec4 unused_0_0[3];
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_3;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat3 = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat3<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SIMPLE" "UNITY_UI_CLIP_RECT" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 unused_0_5;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_8;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy + (-_SoftMask_Rect.xy);
					    u_xlat6.xy = (-_SoftMask_Rect.xy) + _SoftMask_Rect.zw;
					    u_xlat0.xy = u_xlat0.xy / u_xlat6.xy;
					    u_xlatb6.xy = notEqual(u_xlat6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat0.x = u_xlatb6.x ? u_xlat0.x : 0.0;
					    u_xlat0.y = u_xlatb6.y ? u_xlat0.y : 0.0;
					;
					    u_xlat6.xy = (-_SoftMask_UVRect.xy) + _SoftMask_UVRect.zw;
					    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + _SoftMask_UVRect.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat6.x = u_xlat0.x * u_xlat3.x + -0.00100000005;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0 = u_xlat6.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SIMPLE" "UNITY_UI_CLIP_RECT" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 unused_0_5;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_8;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy + (-_SoftMask_Rect.xy);
					    u_xlat6.xy = (-_SoftMask_Rect.xy) + _SoftMask_Rect.zw;
					    u_xlat0.xy = u_xlat0.xy / u_xlat6.xy;
					    u_xlatb6.xy = notEqual(u_xlat6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat0.x = u_xlatb6.x ? u_xlat0.x : 0.0;
					    u_xlat0.y = u_xlatb6.y ? u_xlat0.y : 0.0;
					;
					    u_xlat6.xy = (-_SoftMask_UVRect.xy) + _SoftMask_UVRect.zw;
					    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + _SoftMask_UVRect.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat6.x = u_xlat0.x * u_xlat3.x + -0.00100000005;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0 = u_xlat6.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "SOFTMASK_SIMPLE" "UNITY_UI_CLIP_RECT" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 unused_0_5;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_8;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					bvec2 u_xlatb3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy + (-_SoftMask_Rect.xy);
					    u_xlat6.xy = (-_SoftMask_Rect.xy) + _SoftMask_Rect.zw;
					    u_xlat0.xy = u_xlat0.xy / u_xlat6.xy;
					    u_xlatb6.xy = notEqual(u_xlat6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat0.x = u_xlatb6.x ? u_xlat0.x : 0.0;
					    u_xlat0.y = u_xlatb6.y ? u_xlat0.y : 0.0;
					;
					    u_xlat6.xy = (-_SoftMask_UVRect.xy) + _SoftMask_UVRect.zw;
					    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + _SoftMask_UVRect.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
					    u_xlat3.x = u_xlat3.y * u_xlat3.x;
					    u_xlat6.x = u_xlat0.x * u_xlat3.x + -0.00100000005;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0 = u_xlat6.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "SOFTMASK_SLICED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec4 unused_0_7;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_10;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat2.z = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.w = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.zwzw * _SoftMask_BorderRect;
					    u_xlat2 = u_xlat2 * _SoftMask_UVBorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat8.x = u_xlatb8.x ? u_xlat9.x : 0.0;
					    u_xlat8.y = u_xlatb8.y ? u_xlat9.y : 0.0;
					;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat2.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat2.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat8.x = u_xlat0.x * u_xlat4.x + -0.00100000005;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat8.x<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "SOFTMASK_SLICED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec4 unused_0_7;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_10;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat2.z = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.w = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.zwzw * _SoftMask_BorderRect;
					    u_xlat2 = u_xlat2 * _SoftMask_UVBorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat8.x = u_xlatb8.x ? u_xlat9.x : 0.0;
					    u_xlat8.y = u_xlatb8.y ? u_xlat9.y : 0.0;
					;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat2.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat2.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat8.x = u_xlat0.x * u_xlat4.x + -0.00100000005;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat8.x<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "SOFTMASK_SLICED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec4 unused_0_7;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_10;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat2.z = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.w = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.zwzw * _SoftMask_BorderRect;
					    u_xlat2 = u_xlat2 * _SoftMask_UVBorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat8.x = u_xlatb8.x ? u_xlat9.x : 0.0;
					    u_xlat8.y = u_xlatb8.y ? u_xlat9.y : 0.0;
					;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat2.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat2.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat8.x = u_xlat0.x * u_xlat4.x + -0.00100000005;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat8.x<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "SOFTMASK_TILED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec2 _SoftMask_TileRepeat;
						vec4 unused_0_8;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_11;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_BorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlat10.xy = u_xlat2.xy * _SoftMask_TileRepeat.xy;
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_UVBorderRect;
					    u_xlat2.xy = u_xlat9.xy * u_xlat10.xy;
					    u_xlat8.xy = u_xlat8.xy * u_xlat10.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.xy = fract(u_xlat2.xy);
					    u_xlat8.x = (u_xlatb8.x) ? u_xlat2.x : u_xlat9.x;
					    u_xlat8.y = (u_xlatb8.y) ? u_xlat2.y : u_xlat9.y;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat8.x = u_xlat0.x * u_xlat4.x + -0.00100000005;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat8.x<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "SOFTMASK_TILED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec2 _SoftMask_TileRepeat;
						vec4 unused_0_8;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_11;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_BorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlat10.xy = u_xlat2.xy * _SoftMask_TileRepeat.xy;
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_UVBorderRect;
					    u_xlat2.xy = u_xlat9.xy * u_xlat10.xy;
					    u_xlat8.xy = u_xlat8.xy * u_xlat10.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.xy = fract(u_xlat2.xy);
					    u_xlat8.x = (u_xlatb8.x) ? u_xlat2.x : u_xlat9.x;
					    u_xlat8.y = (u_xlatb8.y) ? u_xlat2.y : u_xlat9.y;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat8.x = u_xlat0.x * u_xlat4.x + -0.00100000005;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat8.x<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "SOFTMASK_TILED" }
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
						vec4 _SoftMask_Rect;
						vec4 _SoftMask_UVRect;
						vec4 unused_0_3[4];
						vec4 _SoftMask_ChannelWeights;
						vec4 _SoftMask_BorderRect;
						vec4 _SoftMask_UVBorderRect;
						vec2 _SoftMask_TileRepeat;
						vec4 unused_0_8;
						vec4 _TextureSampleAdd;
						vec4 _ClipRect;
						vec4 unused_0_11;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaTex;
					uniform  sampler2D _SoftMask;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					bvec2 u_xlatb4;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					void main()
					{
					    u_xlatb0 = greaterThanEqual(vs_TEXCOORD2.xyxy, _SoftMask_BorderRect);
					    u_xlat1.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb0.y ? float(1.0) : 0.0;
					    u_xlat1.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat1.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat2.x = (u_xlatb0.z) ? float(0.0) : u_xlat1.x;
					    u_xlat2.y = (u_xlatb0.w) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlati0.xy = ivec2((uvec2(u_xlatb0.xy) * 0xffffffffu) | (uvec2(u_xlatb0.zw) * 0xffffffffu));
					    u_xlat0.x = (u_xlati0.x != 0) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlati0.y != 0) ? float(0.0) : float(1.0);
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_BorderRect;
					    u_xlat8.xy = _SoftMask_BorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat9.xy = _SoftMask_Rect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat9.xy = _SoftMask_BorderRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat8.xy = _SoftMask_Rect.zw * u_xlat1.xy + u_xlat8.xy;
					    u_xlat8.xy = (-u_xlat9.xy) + u_xlat8.xy;
					    u_xlat9.xy = (-u_xlat9.xy) + vs_TEXCOORD2.xy;
					    u_xlat9.xy = u_xlat9.xy / u_xlat8.xy;
					    u_xlat10.xy = u_xlat2.xy * _SoftMask_TileRepeat.xy;
					    u_xlat3 = u_xlat2.xyxy * _SoftMask_UVBorderRect;
					    u_xlat2.xy = u_xlat9.xy * u_xlat10.xy;
					    u_xlat8.xy = u_xlat8.xy * u_xlat10.xy;
					    u_xlatb8.xy = notEqual(u_xlat8.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.xy = fract(u_xlat2.xy);
					    u_xlat8.x = (u_xlatb8.x) ? u_xlat2.x : u_xlat9.x;
					    u_xlat8.y = (u_xlatb8.y) ? u_xlat2.y : u_xlat9.y;
					    u_xlat9.xy = _SoftMask_UVBorderRect.xy * u_xlat0.xy + u_xlat3.zw;
					    u_xlat0.xy = _SoftMask_UVRect.xy * u_xlat0.xy + u_xlat3.xy;
					    u_xlat0.xy = _SoftMask_UVBorderRect.zw * u_xlat1.xy + u_xlat0.xy;
					    u_xlat1.xy = _SoftMask_UVRect.zw * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat1.xy + u_xlat0.xy;
					    u_xlat0 = texture(_SoftMask, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _SoftMask_ChannelWeights;
					    u_xlat0.x = dot(u_xlat0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _SoftMask_Rect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_SoftMask_Rect.zwzz, vs_TEXCOORD2.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz + _TextureSampleAdd.xyz;
					    u_xlat2 = texture(_AlphaTex, vs_TEXCOORD0.xy);
					    u_xlat1.w = u_xlat2.x + _TextureSampleAdd.w;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
					    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
					    u_xlat4.x = u_xlat4.y * u_xlat4.x;
					    u_xlat8.x = u_xlat0.x * u_xlat4.x + -0.00100000005;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlatb0.x = u_xlat8.x<0.0;
					    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
			}
		}
	}
}