Shader "SteelCircus/FX/Skills/VirtualSwapOriginNormalShader" {
	Properties {
		[KeywordEnum(Circle, Rect)] _Shape ("Shape", Float) = 0
		_InnerRadius ("Inner radius (local space)", Range(0, 1)) = 0.5
		_InnerRadiusSoftness ("Inner radius soft edge", Float) = 0.1
		_RectFadeout ("Rect mode soft edge", Range(0, 1)) = 0.1
		_RectMinThickness ("Rect mode taper - min thickness (should be larger than inner radius)", Range(0, 1)) = 0.7
		_RectTaper ("Rect mode taper - distance (percent)", Range(0, 1)) = 0.5
		_RippleStrength ("Strength of secondary ripples", Float) = 0.002
		_RippleSpeed ("Secondary ripple speed", Float) = 0.2
		_RippleFrequency ("Secondary ripple frequency", Float) = 2
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 45882
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
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "_SHAPE_CIRCLE" }
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
					Keywords { "_SHAPE_CIRCLE" }
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
					Keywords { "_SHAPE_CIRCLE" }
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
						float _InnerRadius;
						float _RippleStrength;
						float _RippleSpeed;
						float _RippleFrequency;
						float _InnerRadiusSoftness;
						float _RectFadeout;
						float _RectTaper;
						float _RectMinThickness;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					int u_xlati1;
					vec2 u_xlat2;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					int u_xlati6;
					void main()
					{
					    u_xlat0 = _RippleSpeed * _Time.y;
					    u_xlat2.xy = vs_TEXCOORD0.yx * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0 = _RippleFrequency * abs(u_xlat2.y) + u_xlat0;
					    u_xlat0 = sin(u_xlat0);
					    u_xlat0 = u_xlat0 * (-_RippleStrength);
					    u_xlat6 = min(abs(u_xlat2.y), 1.0);
					    u_xlat6 = u_xlat6 * 6.28318405;
					    u_xlat6 = cos(u_xlat6);
					    u_xlat6 = (-u_xlat6) * 0.5 + 0.5;
					    u_xlat0 = u_xlat6 * u_xlat0;
					    u_xlat6 = (-_InnerRadiusSoftness) * 0.5 + _InnerRadius;
					    u_xlat6 = (-u_xlat6) + abs(u_xlat2.y);
					    u_xlat6 = u_xlat6 / _InnerRadiusSoftness;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0 = u_xlat6 * u_xlat0;
					    u_xlati6 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati1 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlat0 = -abs(u_xlat0) + 1.0;
					    u_xlati6 = u_xlati6 + (-u_xlati1);
					    u_xlat6 = float(u_xlati6);
					    u_xlat1.x = u_xlat2.y * u_xlat2.y;
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat2.y * u_xlat1.x;
					    u_xlat6 = u_xlat6 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat0) * u_xlat0 + 1.0;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat6 = u_xlat6 * u_xlat1.x;
					    u_xlat1 = vec4(u_xlat0) * unity_ObjectToWorld[1];
					    u_xlat0 = log2(abs(u_xlat0));
					    u_xlat0 = u_xlat0 * 100.0;
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + 1.0;
					    u_xlat1 = unity_ObjectToWorld[0] * vec4(u_xlat6) + u_xlat1;
					    u_xlat6 = dot(u_xlat1, u_xlat1);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xzy;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat6 = (-_InnerRadius) + _RectMinThickness;
					    u_xlat1.x = abs(u_xlat2.y) + (-_InnerRadius);
					    u_xlat6 = u_xlat1.x / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat0 * u_xlat6 + (-u_xlat0);
					    u_xlat1.x = vs_TEXCOORD0.y / _RectTaper;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0 = u_xlat1.x * u_xlat6 + u_xlat0;
					    u_xlat6 = _InnerRadius + _InnerRadiusSoftness;
					    u_xlatb4 = u_xlat6>=abs(u_xlat2.y);
					    u_xlat0 = (u_xlatb4) ? 1.0 : u_xlat0;
					    u_xlat4 = (-_RectFadeout) + 1.0;
					    u_xlat2.x = (-u_xlat4) + abs(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x / _RectFadeout;
					    u_xlat2.x = (-u_xlat2.x) + 1.0;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat2.x * u_xlat0;
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
						float _InnerRadius;
						float _RippleStrength;
						float _RippleSpeed;
						float _RippleFrequency;
						float _InnerRadiusSoftness;
						float _RectFadeout;
						float _RectTaper;
						float _RectMinThickness;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					int u_xlati1;
					vec2 u_xlat2;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					int u_xlati6;
					void main()
					{
					    u_xlat0 = _RippleSpeed * _Time.y;
					    u_xlat2.xy = vs_TEXCOORD0.yx * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0 = _RippleFrequency * abs(u_xlat2.y) + u_xlat0;
					    u_xlat0 = sin(u_xlat0);
					    u_xlat0 = u_xlat0 * (-_RippleStrength);
					    u_xlat6 = min(abs(u_xlat2.y), 1.0);
					    u_xlat6 = u_xlat6 * 6.28318405;
					    u_xlat6 = cos(u_xlat6);
					    u_xlat6 = (-u_xlat6) * 0.5 + 0.5;
					    u_xlat0 = u_xlat6 * u_xlat0;
					    u_xlat6 = (-_InnerRadiusSoftness) * 0.5 + _InnerRadius;
					    u_xlat6 = (-u_xlat6) + abs(u_xlat2.y);
					    u_xlat6 = u_xlat6 / _InnerRadiusSoftness;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0 = u_xlat6 * u_xlat0;
					    u_xlati6 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati1 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlat0 = -abs(u_xlat0) + 1.0;
					    u_xlati6 = u_xlati6 + (-u_xlati1);
					    u_xlat6 = float(u_xlati6);
					    u_xlat1.x = u_xlat2.y * u_xlat2.y;
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat2.y * u_xlat1.x;
					    u_xlat6 = u_xlat6 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat0) * u_xlat0 + 1.0;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat6 = u_xlat6 * u_xlat1.x;
					    u_xlat1 = vec4(u_xlat0) * unity_ObjectToWorld[1];
					    u_xlat0 = log2(abs(u_xlat0));
					    u_xlat0 = u_xlat0 * 100.0;
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + 1.0;
					    u_xlat1 = unity_ObjectToWorld[0] * vec4(u_xlat6) + u_xlat1;
					    u_xlat6 = dot(u_xlat1, u_xlat1);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xzy;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat6 = (-_InnerRadius) + _RectMinThickness;
					    u_xlat1.x = abs(u_xlat2.y) + (-_InnerRadius);
					    u_xlat6 = u_xlat1.x / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat0 * u_xlat6 + (-u_xlat0);
					    u_xlat1.x = vs_TEXCOORD0.y / _RectTaper;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0 = u_xlat1.x * u_xlat6 + u_xlat0;
					    u_xlat6 = _InnerRadius + _InnerRadiusSoftness;
					    u_xlatb4 = u_xlat6>=abs(u_xlat2.y);
					    u_xlat0 = (u_xlatb4) ? 1.0 : u_xlat0;
					    u_xlat4 = (-_RectFadeout) + 1.0;
					    u_xlat2.x = (-u_xlat4) + abs(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x / _RectFadeout;
					    u_xlat2.x = (-u_xlat2.x) + 1.0;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat2.x * u_xlat0;
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
						float _InnerRadius;
						float _RippleStrength;
						float _RippleSpeed;
						float _RippleFrequency;
						float _InnerRadiusSoftness;
						float _RectFadeout;
						float _RectTaper;
						float _RectMinThickness;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					int u_xlati1;
					vec2 u_xlat2;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					int u_xlati6;
					void main()
					{
					    u_xlat0 = _RippleSpeed * _Time.y;
					    u_xlat2.xy = vs_TEXCOORD0.yx * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0 = _RippleFrequency * abs(u_xlat2.y) + u_xlat0;
					    u_xlat0 = sin(u_xlat0);
					    u_xlat0 = u_xlat0 * (-_RippleStrength);
					    u_xlat6 = min(abs(u_xlat2.y), 1.0);
					    u_xlat6 = u_xlat6 * 6.28318405;
					    u_xlat6 = cos(u_xlat6);
					    u_xlat6 = (-u_xlat6) * 0.5 + 0.5;
					    u_xlat0 = u_xlat6 * u_xlat0;
					    u_xlat6 = (-_InnerRadiusSoftness) * 0.5 + _InnerRadius;
					    u_xlat6 = (-u_xlat6) + abs(u_xlat2.y);
					    u_xlat6 = u_xlat6 / _InnerRadiusSoftness;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0 = u_xlat6 * u_xlat0;
					    u_xlati6 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati1 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlat0 = -abs(u_xlat0) + 1.0;
					    u_xlati6 = u_xlati6 + (-u_xlati1);
					    u_xlat6 = float(u_xlati6);
					    u_xlat1.x = u_xlat2.y * u_xlat2.y;
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat2.y * u_xlat1.x;
					    u_xlat6 = u_xlat6 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat0) * u_xlat0 + 1.0;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat6 = u_xlat6 * u_xlat1.x;
					    u_xlat1 = vec4(u_xlat0) * unity_ObjectToWorld[1];
					    u_xlat0 = log2(abs(u_xlat0));
					    u_xlat0 = u_xlat0 * 100.0;
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + 1.0;
					    u_xlat1 = unity_ObjectToWorld[0] * vec4(u_xlat6) + u_xlat1;
					    u_xlat6 = dot(u_xlat1, u_xlat1);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xzy;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat6 = (-_InnerRadius) + _RectMinThickness;
					    u_xlat1.x = abs(u_xlat2.y) + (-_InnerRadius);
					    u_xlat6 = u_xlat1.x / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat0 * u_xlat6 + (-u_xlat0);
					    u_xlat1.x = vs_TEXCOORD0.y / _RectTaper;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0 = u_xlat1.x * u_xlat6 + u_xlat0;
					    u_xlat6 = _InnerRadius + _InnerRadiusSoftness;
					    u_xlatb4 = u_xlat6>=abs(u_xlat2.y);
					    u_xlat0 = (u_xlatb4) ? 1.0 : u_xlat0;
					    u_xlat4 = (-_RectFadeout) + 1.0;
					    u_xlat2.x = (-u_xlat4) + abs(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x / _RectFadeout;
					    u_xlat2.x = (-u_xlat2.x) + 1.0;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat2.x * u_xlat0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "_SHAPE_CIRCLE" }
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
						float _InnerRadius;
						float _RippleStrength;
						float _RippleSpeed;
						float _RippleFrequency;
						float _InnerRadiusSoftness;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					int u_xlati1;
					vec2 u_xlat2;
					float u_xlat6;
					int u_xlati6;
					void main()
					{
					    u_xlat0.x = _RippleSpeed * _Time.y;
					    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat6 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat1.x = sqrt(u_xlat6);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat2.xy = vec2(u_xlat6) * u_xlat2.xy;
					    u_xlat0.x = _RippleFrequency * u_xlat1.x + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * (-_RippleStrength);
					    u_xlat6 = min(u_xlat1.x, 1.0);
					    u_xlat6 = u_xlat6 * 6.28318405;
					    u_xlat6 = cos(u_xlat6);
					    u_xlat6 = (-u_xlat6) * 0.5 + 0.5;
					    u_xlat0.x = u_xlat6 * u_xlat0.x;
					    u_xlat6 = (-_InnerRadiusSoftness) * 0.5 + _InnerRadius;
					    u_xlat6 = (-u_xlat6) + u_xlat1.x;
					    u_xlat6 = u_xlat6 / _InnerRadiusSoftness;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x;
					    u_xlati6 = int((0.0<u_xlat0.x) ? 0xFFFFFFFFu : uint(0));
					    u_xlati1 = int((u_xlat0.x<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlati6 = u_xlati6 + (-u_xlati1);
					    u_xlat6 = float(u_xlati6);
					    u_xlat2.xy = vec2(u_xlat6) * u_xlat2.xy;
					    u_xlat6 = (-u_xlat0.x) * u_xlat0.x + 1.0;
					    u_xlat6 = sqrt(u_xlat6);
					    u_xlat2.xy = vec2(u_xlat6) * u_xlat2.xy;
					    u_xlat1 = u_xlat0.xxxx * unity_ObjectToWorld[1];
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * 100.0;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.w = (-u_xlat0.x) + 1.0;
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
					    u_xlat6 = dot(u_xlat0, u_xlat0);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzy;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "_SHAPE_CIRCLE" }
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
						float _InnerRadius;
						float _RippleStrength;
						float _RippleSpeed;
						float _RippleFrequency;
						float _InnerRadiusSoftness;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					int u_xlati1;
					vec2 u_xlat2;
					float u_xlat6;
					int u_xlati6;
					void main()
					{
					    u_xlat0.x = _RippleSpeed * _Time.y;
					    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat6 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat1.x = sqrt(u_xlat6);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat2.xy = vec2(u_xlat6) * u_xlat2.xy;
					    u_xlat0.x = _RippleFrequency * u_xlat1.x + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * (-_RippleStrength);
					    u_xlat6 = min(u_xlat1.x, 1.0);
					    u_xlat6 = u_xlat6 * 6.28318405;
					    u_xlat6 = cos(u_xlat6);
					    u_xlat6 = (-u_xlat6) * 0.5 + 0.5;
					    u_xlat0.x = u_xlat6 * u_xlat0.x;
					    u_xlat6 = (-_InnerRadiusSoftness) * 0.5 + _InnerRadius;
					    u_xlat6 = (-u_xlat6) + u_xlat1.x;
					    u_xlat6 = u_xlat6 / _InnerRadiusSoftness;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x;
					    u_xlati6 = int((0.0<u_xlat0.x) ? 0xFFFFFFFFu : uint(0));
					    u_xlati1 = int((u_xlat0.x<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlati6 = u_xlati6 + (-u_xlati1);
					    u_xlat6 = float(u_xlati6);
					    u_xlat2.xy = vec2(u_xlat6) * u_xlat2.xy;
					    u_xlat6 = (-u_xlat0.x) * u_xlat0.x + 1.0;
					    u_xlat6 = sqrt(u_xlat6);
					    u_xlat2.xy = vec2(u_xlat6) * u_xlat2.xy;
					    u_xlat1 = u_xlat0.xxxx * unity_ObjectToWorld[1];
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * 100.0;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.w = (-u_xlat0.x) + 1.0;
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
					    u_xlat6 = dot(u_xlat0, u_xlat0);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzy;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "_SHAPE_CIRCLE" }
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
						float _InnerRadius;
						float _RippleStrength;
						float _RippleSpeed;
						float _RippleFrequency;
						float _InnerRadiusSoftness;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					int u_xlati1;
					vec2 u_xlat2;
					float u_xlat6;
					int u_xlati6;
					void main()
					{
					    u_xlat0.x = _RippleSpeed * _Time.y;
					    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat6 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat1.x = sqrt(u_xlat6);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat2.xy = vec2(u_xlat6) * u_xlat2.xy;
					    u_xlat0.x = _RippleFrequency * u_xlat1.x + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * (-_RippleStrength);
					    u_xlat6 = min(u_xlat1.x, 1.0);
					    u_xlat6 = u_xlat6 * 6.28318405;
					    u_xlat6 = cos(u_xlat6);
					    u_xlat6 = (-u_xlat6) * 0.5 + 0.5;
					    u_xlat0.x = u_xlat6 * u_xlat0.x;
					    u_xlat6 = (-_InnerRadiusSoftness) * 0.5 + _InnerRadius;
					    u_xlat6 = (-u_xlat6) + u_xlat1.x;
					    u_xlat6 = u_xlat6 / _InnerRadiusSoftness;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x;
					    u_xlati6 = int((0.0<u_xlat0.x) ? 0xFFFFFFFFu : uint(0));
					    u_xlati1 = int((u_xlat0.x<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlati6 = u_xlati6 + (-u_xlati1);
					    u_xlat6 = float(u_xlati6);
					    u_xlat2.xy = vec2(u_xlat6) * u_xlat2.xy;
					    u_xlat6 = (-u_xlat0.x) * u_xlat0.x + 1.0;
					    u_xlat6 = sqrt(u_xlat6);
					    u_xlat2.xy = vec2(u_xlat6) * u_xlat2.xy;
					    u_xlat1 = u_xlat0.xxxx * unity_ObjectToWorld[1];
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * 100.0;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.w = (-u_xlat0.x) + 1.0;
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat2.yyyy + u_xlat1;
					    u_xlat6 = dot(u_xlat0, u_xlat0);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzy;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    return;
					}"
				}
			}
		}
	}
}