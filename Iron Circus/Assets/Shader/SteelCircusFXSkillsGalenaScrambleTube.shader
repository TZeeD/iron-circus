Shader "SteelCircus/FX/Skills/GalenaScrambleTube" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_Color ("Tint", Vector) = (1,1,1,1)
		_FadeParams ("Fade Params (length start/end, angle start/end)", Vector) = (0.5,1,0.5,1)
		_FadePow ("Fade Pow", Float) = 1
		_ScrollSpeed ("Scroll Speed", Float) = 1
		_Displacement ("Displacement", Float) = 1
		_NoisePow ("Noise Pow", Float) = 1
		_Intensity ("Intensity", Float) = 1
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
			GpuProgramID 12927
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
						vec4 _MainTex_ST;
						vec4 _Color;
						vec4 _FadeParams;
						float _FadePow;
						float _ScrollSpeed;
						float _Displacement;
						float _NoisePow;
						float _Intensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _ScrollSpeed * _Time.y;
					    u_xlat0.y = 0.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.z = u_xlat0.x * _Displacement + u_xlat1.x;
					    u_xlat0 = texture(_MainTex, u_xlat1.xz);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _NoisePow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Intensity;
					    u_xlat0 = u_xlat0.xxxx * _Color;
					    u_xlat1.xy = vs_TEXCOORD0.yx + vec2(-0.5, -0.5);
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(2.0, 2.0) + (-_FadeParams.xz);
					    u_xlat5.xy = (-_FadeParams.xz) + _FadeParams.yw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat5.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _FadePow;
					    u_xlat1.x = exp2(u_xlat1.x);
					    SV_Target0 = u_xlat0 * u_xlat1.xxxx;
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
						vec4 _MainTex_ST;
						vec4 _Color;
						vec4 _FadeParams;
						float _FadePow;
						float _ScrollSpeed;
						float _Displacement;
						float _NoisePow;
						float _Intensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _ScrollSpeed * _Time.y;
					    u_xlat0.y = 0.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.z = u_xlat0.x * _Displacement + u_xlat1.x;
					    u_xlat0 = texture(_MainTex, u_xlat1.xz);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _NoisePow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Intensity;
					    u_xlat0 = u_xlat0.xxxx * _Color;
					    u_xlat1.xy = vs_TEXCOORD0.yx + vec2(-0.5, -0.5);
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(2.0, 2.0) + (-_FadeParams.xz);
					    u_xlat5.xy = (-_FadeParams.xz) + _FadeParams.yw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat5.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _FadePow;
					    u_xlat1.x = exp2(u_xlat1.x);
					    SV_Target0 = u_xlat0 * u_xlat1.xxxx;
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
						vec4 _MainTex_ST;
						vec4 _Color;
						vec4 _FadeParams;
						float _FadePow;
						float _ScrollSpeed;
						float _Displacement;
						float _NoisePow;
						float _Intensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _ScrollSpeed * _Time.y;
					    u_xlat0.y = 0.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.z = u_xlat0.x * _Displacement + u_xlat1.x;
					    u_xlat0 = texture(_MainTex, u_xlat1.xz);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _NoisePow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Intensity;
					    u_xlat0 = u_xlat0.xxxx * _Color;
					    u_xlat1.xy = vs_TEXCOORD0.yx + vec2(-0.5, -0.5);
					    u_xlat1.xy = abs(u_xlat1.xy) * vec2(2.0, 2.0) + (-_FadeParams.xz);
					    u_xlat5.xy = (-_FadeParams.xz) + _FadeParams.yw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat5.xy;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _FadePow;
					    u_xlat1.x = exp2(u_xlat1.x);
					    SV_Target0 = u_xlat0 * u_xlat1.xxxx;
					    return;
					}"
				}
			}
		}
	}
}