Shader "SteelCircus/FX/Skills/BallTrailShader" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_ColorGradient ("Color Gradient (soft Threshold)", 2D) = "white" {}
		_AlphaGradient ("Alpha Gradient (subtracted)", 2D) = "white" {}
		_Speed ("Speed", Float) = 1
		[HDR] _Tint ("Tint (for throwing)", Vector) = (1,1,1,1)
		_Disp ("Displacement", 2D) = "white" {}
		_DispParams ("Disp. Params (intensity x,y, speed x,y)", Vector) = (0,0,0,0)
		_DispScale ("Disp. Scale", Float) = 1
		_BrightnessScale ("Brightness Scale", Float) = 1
		_AnimationOffset ("Animation Offset", Float) = 0
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ZWrite Off
			Cull Off
			GpuProgramID 34431
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
						vec4 _MainTex_ST;
						vec4 unused_0_2[4];
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
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.z = (-u_xlat0.x) + 1.0;
					    vs_TEXCOORD0.xy = u_xlat0.zy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 _MainTex_ST;
						vec4 unused_0_2[4];
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
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.z = (-u_xlat0.x) + 1.0;
					    vs_TEXCOORD0.xy = u_xlat0.zy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 _MainTex_ST;
						vec4 unused_0_2[4];
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
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.z = (-u_xlat0.x) + 1.0;
					    vs_TEXCOORD0.xy = u_xlat0.zy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
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
						float _Speed;
						vec4 _DispParams;
						float _DispScale;
						float _BrightnessScale;
						float _AnimationOffset;
						vec4 _Tint;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _Disp;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaGradient;
					uniform  sampler2D _ColorGradient;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _AnimationOffset + _Time.y;
					    u_xlat2.xy = u_xlat0.xx * _DispParams.zw;
					    u_xlat1.x = u_xlat0.x * _Speed;
					    u_xlat0.xy = vec2(_DispScale) * vs_TEXCOORD0.xy + u_xlat2.xy;
					    u_xlat0 = texture(_Disp, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat1.y = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat2.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
					    u_xlat0.xy = u_xlat0.xx * _DispParams.xy + u_xlat2.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat5.x = vs_COLOR0.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat1 = texture(_AlphaGradient, u_xlat5.xy);
					    u_xlat0.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.y = 0.0;
					    u_xlat0 = texture(_ColorGradient, u_xlat0.xy);
					    u_xlat1.xyz = vec3(vec3(_BrightnessScale, _BrightnessScale, _BrightnessScale)) * _Tint.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.x = _BrightnessScale;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.x * u_xlat0.w;
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
						float _Speed;
						vec4 _DispParams;
						float _DispScale;
						float _BrightnessScale;
						float _AnimationOffset;
						vec4 _Tint;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _Disp;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaGradient;
					uniform  sampler2D _ColorGradient;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _AnimationOffset + _Time.y;
					    u_xlat2.xy = u_xlat0.xx * _DispParams.zw;
					    u_xlat1.x = u_xlat0.x * _Speed;
					    u_xlat0.xy = vec2(_DispScale) * vs_TEXCOORD0.xy + u_xlat2.xy;
					    u_xlat0 = texture(_Disp, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat1.y = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat2.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
					    u_xlat0.xy = u_xlat0.xx * _DispParams.xy + u_xlat2.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat5.x = vs_COLOR0.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat1 = texture(_AlphaGradient, u_xlat5.xy);
					    u_xlat0.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.y = 0.0;
					    u_xlat0 = texture(_ColorGradient, u_xlat0.xy);
					    u_xlat1.xyz = vec3(vec3(_BrightnessScale, _BrightnessScale, _BrightnessScale)) * _Tint.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.x = _BrightnessScale;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.x * u_xlat0.w;
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
						float _Speed;
						vec4 _DispParams;
						float _DispScale;
						float _BrightnessScale;
						float _AnimationOffset;
						vec4 _Tint;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _Disp;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AlphaGradient;
					uniform  sampler2D _ColorGradient;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _AnimationOffset + _Time.y;
					    u_xlat2.xy = u_xlat0.xx * _DispParams.zw;
					    u_xlat1.x = u_xlat0.x * _Speed;
					    u_xlat0.xy = vec2(_DispScale) * vs_TEXCOORD0.xy + u_xlat2.xy;
					    u_xlat0 = texture(_Disp, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat1.y = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat2.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
					    u_xlat0.xy = u_xlat0.xx * _DispParams.xy + u_xlat2.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat5.x = vs_COLOR0.x;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat1 = texture(_AlphaGradient, u_xlat5.xy);
					    u_xlat0.x = u_xlat0.x + (-u_xlat1.x);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.y = 0.0;
					    u_xlat0 = texture(_ColorGradient, u_xlat0.xy);
					    u_xlat1.xyz = vec3(vec3(_BrightnessScale, _BrightnessScale, _BrightnessScale)) * _Tint.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.x = _BrightnessScale;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.x * u_xlat0.w;
					    return;
					}"
				}
			}
		}
	}
}