Shader "UI/Hidden/UI-Effect-Shiny" {
	Properties {
		[PerRendererData] _MainTex ("Main Texture", 2D) = "white" {}
		_Color ("Tint", Vector) = (1,1,1,1)
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
		_ParamTex ("Parameter Texture", 2D) = "white" {}
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
			GpuProgramID 49211
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
						vec4 unused_0_2[3];
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
					 vec4 phase0_Output0_2;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec3 u_xlat3;
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
					    u_xlat0 = in_TEXCOORD0.xxyy * vec4(4096.0, 0.000244140625, 4096.0, 0.000244140625);
					    u_xlat3.xz = floor(u_xlat0.yw);
					    u_xlatb1 = greaterThanEqual(u_xlat0.xxzz, (-u_xlat0.xxzz));
					    u_xlat1.x = (u_xlatb1.x) ? float(4096.0) : float(-4096.0);
					    u_xlat1.y = (u_xlatb1.y) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat1.z = (u_xlatb1.z) ? float(4096.0) : float(-4096.0);
					    u_xlat1.w = (u_xlatb1.w) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat2 = u_xlat3.xxzz * vec4(4096.0, 4096.0, 4096.0, 4096.0);
					    u_xlatb2 = greaterThanEqual(u_xlat2, (-u_xlat2.yyww));
					    u_xlat2.x = (u_xlatb2.x) ? float(4096.0) : float(-4096.0);
					    u_xlat2.y = (u_xlatb2.y) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat2.z = (u_xlatb2.z) ? float(4096.0) : float(-4096.0);
					    u_xlat2.w = (u_xlatb2.w) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat0.xy = u_xlat3.xz * u_xlat2.yw;
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat2.xz;
					    phase0_Output0_2.yw = u_xlat0.xy * vec2(0.000244200259, 0.000244200259);
					    u_xlat0.xy = u_xlat1.yw * in_TEXCOORD0.xy;
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xz;
					    phase0_Output0_2.xz = u_xlat0.xy * vec2(0.000244200259, 0.000244200259);
					    vs_TEXCOORD1 = in_POSITION0;
					vs_TEXCOORD0 = phase0_Output0_2.xy;
					vs_TEXCOORD2 = phase0_Output0_2.zw;
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
						vec4 unused_0_2[3];
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
					 vec4 phase0_Output0_2;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec3 u_xlat3;
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
					    u_xlat0 = in_TEXCOORD0.xxyy * vec4(4096.0, 0.000244140625, 4096.0, 0.000244140625);
					    u_xlat3.xz = floor(u_xlat0.yw);
					    u_xlatb1 = greaterThanEqual(u_xlat0.xxzz, (-u_xlat0.xxzz));
					    u_xlat1.x = (u_xlatb1.x) ? float(4096.0) : float(-4096.0);
					    u_xlat1.y = (u_xlatb1.y) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat1.z = (u_xlatb1.z) ? float(4096.0) : float(-4096.0);
					    u_xlat1.w = (u_xlatb1.w) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat2 = u_xlat3.xxzz * vec4(4096.0, 4096.0, 4096.0, 4096.0);
					    u_xlatb2 = greaterThanEqual(u_xlat2, (-u_xlat2.yyww));
					    u_xlat2.x = (u_xlatb2.x) ? float(4096.0) : float(-4096.0);
					    u_xlat2.y = (u_xlatb2.y) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat2.z = (u_xlatb2.z) ? float(4096.0) : float(-4096.0);
					    u_xlat2.w = (u_xlatb2.w) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat0.xy = u_xlat3.xz * u_xlat2.yw;
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat2.xz;
					    phase0_Output0_2.yw = u_xlat0.xy * vec2(0.000244200259, 0.000244200259);
					    u_xlat0.xy = u_xlat1.yw * in_TEXCOORD0.xy;
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xz;
					    phase0_Output0_2.xz = u_xlat0.xy * vec2(0.000244200259, 0.000244200259);
					    vs_TEXCOORD1 = in_POSITION0;
					vs_TEXCOORD0 = phase0_Output0_2.xy;
					vs_TEXCOORD2 = phase0_Output0_2.zw;
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
						vec4 unused_0_2[3];
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
					 vec4 phase0_Output0_2;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec3 u_xlat3;
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
					    u_xlat0 = in_TEXCOORD0.xxyy * vec4(4096.0, 0.000244140625, 4096.0, 0.000244140625);
					    u_xlat3.xz = floor(u_xlat0.yw);
					    u_xlatb1 = greaterThanEqual(u_xlat0.xxzz, (-u_xlat0.xxzz));
					    u_xlat1.x = (u_xlatb1.x) ? float(4096.0) : float(-4096.0);
					    u_xlat1.y = (u_xlatb1.y) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat1.z = (u_xlatb1.z) ? float(4096.0) : float(-4096.0);
					    u_xlat1.w = (u_xlatb1.w) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat2 = u_xlat3.xxzz * vec4(4096.0, 4096.0, 4096.0, 4096.0);
					    u_xlatb2 = greaterThanEqual(u_xlat2, (-u_xlat2.yyww));
					    u_xlat2.x = (u_xlatb2.x) ? float(4096.0) : float(-4096.0);
					    u_xlat2.y = (u_xlatb2.y) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat2.z = (u_xlatb2.z) ? float(4096.0) : float(-4096.0);
					    u_xlat2.w = (u_xlatb2.w) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat0.xy = u_xlat3.xz * u_xlat2.yw;
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat2.xz;
					    phase0_Output0_2.yw = u_xlat0.xy * vec2(0.000244200259, 0.000244200259);
					    u_xlat0.xy = u_xlat1.yw * in_TEXCOORD0.xy;
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xz;
					    phase0_Output0_2.xz = u_xlat0.xy * vec2(0.000244200259, 0.000244200259);
					    vs_TEXCOORD1 = in_POSITION0;
					vs_TEXCOORD0 = phase0_Output0_2.xy;
					vs_TEXCOORD2 = phase0_Output0_2.zw;
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
						vec4 unused_0_2[3];
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
					 vec4 phase0_Output0_2;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec3 u_xlat3;
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
					    u_xlat0 = in_TEXCOORD0.xxyy * vec4(4096.0, 0.000244140625, 4096.0, 0.000244140625);
					    u_xlat3.xz = floor(u_xlat0.yw);
					    u_xlatb1 = greaterThanEqual(u_xlat0.xxzz, (-u_xlat0.xxzz));
					    u_xlat1.x = (u_xlatb1.x) ? float(4096.0) : float(-4096.0);
					    u_xlat1.y = (u_xlatb1.y) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat1.z = (u_xlatb1.z) ? float(4096.0) : float(-4096.0);
					    u_xlat1.w = (u_xlatb1.w) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat2 = u_xlat3.xxzz * vec4(4096.0, 4096.0, 4096.0, 4096.0);
					    u_xlatb2 = greaterThanEqual(u_xlat2, (-u_xlat2.yyww));
					    u_xlat2.x = (u_xlatb2.x) ? float(4096.0) : float(-4096.0);
					    u_xlat2.y = (u_xlatb2.y) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat2.z = (u_xlatb2.z) ? float(4096.0) : float(-4096.0);
					    u_xlat2.w = (u_xlatb2.w) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat0.xy = u_xlat3.xz * u_xlat2.yw;
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat2.xz;
					    phase0_Output0_2.yw = u_xlat0.xy * vec2(0.000244200259, 0.000244200259);
					    u_xlat0.xy = u_xlat1.yw * in_TEXCOORD0.xy;
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xz;
					    phase0_Output0_2.xz = u_xlat0.xy * vec2(0.000244200259, 0.000244200259);
					    vs_TEXCOORD1 = in_POSITION0;
					vs_TEXCOORD0 = phase0_Output0_2.xy;
					vs_TEXCOORD2 = phase0_Output0_2.zw;
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
						vec4 unused_0_2[3];
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
					 vec4 phase0_Output0_2;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec3 u_xlat3;
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
					    u_xlat0 = in_TEXCOORD0.xxyy * vec4(4096.0, 0.000244140625, 4096.0, 0.000244140625);
					    u_xlat3.xz = floor(u_xlat0.yw);
					    u_xlatb1 = greaterThanEqual(u_xlat0.xxzz, (-u_xlat0.xxzz));
					    u_xlat1.x = (u_xlatb1.x) ? float(4096.0) : float(-4096.0);
					    u_xlat1.y = (u_xlatb1.y) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat1.z = (u_xlatb1.z) ? float(4096.0) : float(-4096.0);
					    u_xlat1.w = (u_xlatb1.w) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat2 = u_xlat3.xxzz * vec4(4096.0, 4096.0, 4096.0, 4096.0);
					    u_xlatb2 = greaterThanEqual(u_xlat2, (-u_xlat2.yyww));
					    u_xlat2.x = (u_xlatb2.x) ? float(4096.0) : float(-4096.0);
					    u_xlat2.y = (u_xlatb2.y) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat2.z = (u_xlatb2.z) ? float(4096.0) : float(-4096.0);
					    u_xlat2.w = (u_xlatb2.w) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat0.xy = u_xlat3.xz * u_xlat2.yw;
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat2.xz;
					    phase0_Output0_2.yw = u_xlat0.xy * vec2(0.000244200259, 0.000244200259);
					    u_xlat0.xy = u_xlat1.yw * in_TEXCOORD0.xy;
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xz;
					    phase0_Output0_2.xz = u_xlat0.xy * vec2(0.000244200259, 0.000244200259);
					    vs_TEXCOORD1 = in_POSITION0;
					vs_TEXCOORD0 = phase0_Output0_2.xy;
					vs_TEXCOORD2 = phase0_Output0_2.zw;
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
						vec4 unused_0_2[3];
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
					 vec4 phase0_Output0_2;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec3 u_xlat3;
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
					    u_xlat0 = in_TEXCOORD0.xxyy * vec4(4096.0, 0.000244140625, 4096.0, 0.000244140625);
					    u_xlat3.xz = floor(u_xlat0.yw);
					    u_xlatb1 = greaterThanEqual(u_xlat0.xxzz, (-u_xlat0.xxzz));
					    u_xlat1.x = (u_xlatb1.x) ? float(4096.0) : float(-4096.0);
					    u_xlat1.y = (u_xlatb1.y) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat1.z = (u_xlatb1.z) ? float(4096.0) : float(-4096.0);
					    u_xlat1.w = (u_xlatb1.w) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat2 = u_xlat3.xxzz * vec4(4096.0, 4096.0, 4096.0, 4096.0);
					    u_xlatb2 = greaterThanEqual(u_xlat2, (-u_xlat2.yyww));
					    u_xlat2.x = (u_xlatb2.x) ? float(4096.0) : float(-4096.0);
					    u_xlat2.y = (u_xlatb2.y) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat2.z = (u_xlatb2.z) ? float(4096.0) : float(-4096.0);
					    u_xlat2.w = (u_xlatb2.w) ? float(0.000244140625) : float(-0.000244140625);
					    u_xlat0.xy = u_xlat3.xz * u_xlat2.yw;
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat2.xz;
					    phase0_Output0_2.yw = u_xlat0.xy * vec2(0.000244200259, 0.000244200259);
					    u_xlat0.xy = u_xlat1.yw * in_TEXCOORD0.xy;
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xz;
					    phase0_Output0_2.xz = u_xlat0.xy * vec2(0.000244200259, 0.000244200259);
					    vs_TEXCOORD1 = in_POSITION0;
					vs_TEXCOORD0 = phase0_Output0_2.xy;
					vs_TEXCOORD2 = phase0_Output0_2.zw;
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
						vec4 _ClipRect;
						vec4 unused_0_3;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ParamTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.x = float(0.25);
					    u_xlat0.z = float(0.75);
					    u_xlat0.yw = vs_TEXCOORD2.yy;
					    u_xlat1 = texture(_ParamTex, u_xlat0.xy);
					    u_xlat0 = texture(_ParamTex, u_xlat0.zw);
					    u_xlat3 = u_xlat1.x * 2.0 + -0.5;
					    u_xlat3 = (-u_xlat3) + vs_TEXCOORD2.x;
					    u_xlat3 = u_xlat3 / u_xlat1.y;
					    u_xlat3 = min(abs(u_xlat3), 1.0);
					    u_xlat3 = (-u_xlat3) + 1.0;
					    u_xlat6.x = u_xlat1.z + u_xlat1.z;
					    u_xlat6.x = float(1.0) / u_xlat6.x;
					    u_xlat3 = u_xlat6.x * u_xlat3;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat6.x = u_xlat3 * -2.0 + 3.0;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat6.x;
					    u_xlat3 = u_xlat3 * 0.5;
					    u_xlatb6.xy = greaterThanEqual(vs_TEXCOORD1.xyxy, _ClipRect.xyxy).xy;
					    u_xlat6.x = u_xlatb6.x ? float(1.0) : 0.0;
					    u_xlat6.y = u_xlatb6.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.x = u_xlat6.y * u_xlat6.x;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat2 + _TextureSampleAdd;
					    u_xlat2 = u_xlat2 * vs_COLOR0;
					    u_xlat6.x = u_xlat6.x * u_xlat2.w;
					    u_xlat3 = u_xlat3 * u_xlat6.x;
					    SV_Target0.w = u_xlat6.x;
					    u_xlat3 = u_xlat1.w * u_xlat3;
					    u_xlat1.xyz = u_xlat2.xyz * vec3(10.0, 10.0, 10.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xzw + u_xlat2.xyz;
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
						vec4 _ClipRect;
						vec4 unused_0_3;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ParamTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.x = float(0.25);
					    u_xlat0.z = float(0.75);
					    u_xlat0.yw = vs_TEXCOORD2.yy;
					    u_xlat1 = texture(_ParamTex, u_xlat0.xy);
					    u_xlat0 = texture(_ParamTex, u_xlat0.zw);
					    u_xlat3 = u_xlat1.x * 2.0 + -0.5;
					    u_xlat3 = (-u_xlat3) + vs_TEXCOORD2.x;
					    u_xlat3 = u_xlat3 / u_xlat1.y;
					    u_xlat3 = min(abs(u_xlat3), 1.0);
					    u_xlat3 = (-u_xlat3) + 1.0;
					    u_xlat6.x = u_xlat1.z + u_xlat1.z;
					    u_xlat6.x = float(1.0) / u_xlat6.x;
					    u_xlat3 = u_xlat6.x * u_xlat3;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat6.x = u_xlat3 * -2.0 + 3.0;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat6.x;
					    u_xlat3 = u_xlat3 * 0.5;
					    u_xlatb6.xy = greaterThanEqual(vs_TEXCOORD1.xyxy, _ClipRect.xyxy).xy;
					    u_xlat6.x = u_xlatb6.x ? float(1.0) : 0.0;
					    u_xlat6.y = u_xlatb6.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.x = u_xlat6.y * u_xlat6.x;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat2 + _TextureSampleAdd;
					    u_xlat2 = u_xlat2 * vs_COLOR0;
					    u_xlat6.x = u_xlat6.x * u_xlat2.w;
					    u_xlat3 = u_xlat3 * u_xlat6.x;
					    SV_Target0.w = u_xlat6.x;
					    u_xlat3 = u_xlat1.w * u_xlat3;
					    u_xlat1.xyz = u_xlat2.xyz * vec3(10.0, 10.0, 10.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xzw + u_xlat2.xyz;
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
						vec4 _ClipRect;
						vec4 unused_0_3;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ParamTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec2 u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					void main()
					{
					    u_xlat0.x = float(0.25);
					    u_xlat0.z = float(0.75);
					    u_xlat0.yw = vs_TEXCOORD2.yy;
					    u_xlat1 = texture(_ParamTex, u_xlat0.xy);
					    u_xlat0 = texture(_ParamTex, u_xlat0.zw);
					    u_xlat3 = u_xlat1.x * 2.0 + -0.5;
					    u_xlat3 = (-u_xlat3) + vs_TEXCOORD2.x;
					    u_xlat3 = u_xlat3 / u_xlat1.y;
					    u_xlat3 = min(abs(u_xlat3), 1.0);
					    u_xlat3 = (-u_xlat3) + 1.0;
					    u_xlat6.x = u_xlat1.z + u_xlat1.z;
					    u_xlat6.x = float(1.0) / u_xlat6.x;
					    u_xlat3 = u_xlat6.x * u_xlat3;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat6.x = u_xlat3 * -2.0 + 3.0;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat6.x;
					    u_xlat3 = u_xlat3 * 0.5;
					    u_xlatb6.xy = greaterThanEqual(vs_TEXCOORD1.xyxy, _ClipRect.xyxy).xy;
					    u_xlat6.x = u_xlatb6.x ? float(1.0) : 0.0;
					    u_xlat6.y = u_xlatb6.y ? float(1.0) : 0.0;
					;
					    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
					    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
					    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
					;
					    u_xlat6.xy = u_xlat6.xy * u_xlat1.xy;
					    u_xlat6.x = u_xlat6.y * u_xlat6.x;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat2 + _TextureSampleAdd;
					    u_xlat2 = u_xlat2 * vs_COLOR0;
					    u_xlat6.x = u_xlat6.x * u_xlat2.w;
					    u_xlat3 = u_xlat3 * u_xlat6.x;
					    SV_Target0.w = u_xlat6.x;
					    u_xlat3 = u_xlat1.w * u_xlat3;
					    u_xlat1.xyz = u_xlat2.xyz * vec3(10.0, 10.0, 10.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xzw + u_xlat2.xyz;
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
						vec4 _ClipRect;
						vec4 unused_0_3;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ParamTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					bool u_xlatb4;
					float u_xlat8;
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
					    u_xlat1 = u_xlat1 + _TextureSampleAdd;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat4.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlatb4 = u_xlat4.x<0.0;
					    if(((int(u_xlatb4) * int(0xffffffffu)))!=0){discard;}
					    u_xlat2.x = float(0.25);
					    u_xlat2.z = float(0.75);
					    u_xlat2.yw = vs_TEXCOORD2.yy;
					    u_xlat3 = texture(_ParamTex, u_xlat2.xy);
					    u_xlat2 = texture(_ParamTex, u_xlat2.zw);
					    u_xlat4.x = u_xlat3.x * 2.0 + -0.5;
					    u_xlat4.x = (-u_xlat4.x) + vs_TEXCOORD2.x;
					    u_xlat4.x = u_xlat4.x / u_xlat3.y;
					    u_xlat4.x = min(abs(u_xlat4.x), 1.0);
					    u_xlat4.x = (-u_xlat4.x) + 1.0;
					    u_xlat8 = u_xlat3.z + u_xlat3.z;
					    u_xlat8 = float(1.0) / u_xlat8;
					    u_xlat4.x = u_xlat8 * u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat8 = u_xlat4.x * -2.0 + 3.0;
					    u_xlat4.x = u_xlat4.x * u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * u_xlat8;
					    u_xlat4.x = u_xlat4.x * 0.5;
					    u_xlat4.x = u_xlat4.x * u_xlat0.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlat0.x = u_xlat3.w * u_xlat4.x;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(10.0, 10.0, 10.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat1.xyz;
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
						vec4 _ClipRect;
						vec4 unused_0_3;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ParamTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					bool u_xlatb4;
					float u_xlat8;
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
					    u_xlat1 = u_xlat1 + _TextureSampleAdd;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat4.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlatb4 = u_xlat4.x<0.0;
					    if(((int(u_xlatb4) * int(0xffffffffu)))!=0){discard;}
					    u_xlat2.x = float(0.25);
					    u_xlat2.z = float(0.75);
					    u_xlat2.yw = vs_TEXCOORD2.yy;
					    u_xlat3 = texture(_ParamTex, u_xlat2.xy);
					    u_xlat2 = texture(_ParamTex, u_xlat2.zw);
					    u_xlat4.x = u_xlat3.x * 2.0 + -0.5;
					    u_xlat4.x = (-u_xlat4.x) + vs_TEXCOORD2.x;
					    u_xlat4.x = u_xlat4.x / u_xlat3.y;
					    u_xlat4.x = min(abs(u_xlat4.x), 1.0);
					    u_xlat4.x = (-u_xlat4.x) + 1.0;
					    u_xlat8 = u_xlat3.z + u_xlat3.z;
					    u_xlat8 = float(1.0) / u_xlat8;
					    u_xlat4.x = u_xlat8 * u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat8 = u_xlat4.x * -2.0 + 3.0;
					    u_xlat4.x = u_xlat4.x * u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * u_xlat8;
					    u_xlat4.x = u_xlat4.x * 0.5;
					    u_xlat4.x = u_xlat4.x * u_xlat0.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlat0.x = u_xlat3.w * u_xlat4.x;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(10.0, 10.0, 10.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat1.xyz;
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
						vec4 _ClipRect;
						vec4 unused_0_3;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ParamTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					bool u_xlatb4;
					float u_xlat8;
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
					    u_xlat1 = u_xlat1 + _TextureSampleAdd;
					    u_xlat1 = u_xlat1 * vs_COLOR0;
					    u_xlat4.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlatb4 = u_xlat4.x<0.0;
					    if(((int(u_xlatb4) * int(0xffffffffu)))!=0){discard;}
					    u_xlat2.x = float(0.25);
					    u_xlat2.z = float(0.75);
					    u_xlat2.yw = vs_TEXCOORD2.yy;
					    u_xlat3 = texture(_ParamTex, u_xlat2.xy);
					    u_xlat2 = texture(_ParamTex, u_xlat2.zw);
					    u_xlat4.x = u_xlat3.x * 2.0 + -0.5;
					    u_xlat4.x = (-u_xlat4.x) + vs_TEXCOORD2.x;
					    u_xlat4.x = u_xlat4.x / u_xlat3.y;
					    u_xlat4.x = min(abs(u_xlat4.x), 1.0);
					    u_xlat4.x = (-u_xlat4.x) + 1.0;
					    u_xlat8 = u_xlat3.z + u_xlat3.z;
					    u_xlat8 = float(1.0) / u_xlat8;
					    u_xlat4.x = u_xlat8 * u_xlat4.x;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat8 = u_xlat4.x * -2.0 + 3.0;
					    u_xlat4.x = u_xlat4.x * u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * u_xlat8;
					    u_xlat4.x = u_xlat4.x * 0.5;
					    u_xlat4.x = u_xlat4.x * u_xlat0.x;
					    SV_Target0.w = u_xlat0.x;
					    u_xlat0.x = u_xlat3.w * u_xlat4.x;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(10.0, 10.0, 10.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat1.xyz;
					    return;
					}"
				}
			}
		}
	}
}