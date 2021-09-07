Shader "SteelCircus/FX/FlashShader" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_Color ("Tint", Vector) = (1,1,1,1)
		_Brightness ("Brightness", Float) = 1
		_AnimTime ("Animation Time", Range(0, 1)) = 0.5
		[NoScaleOffset] _RampTex ("Ramp Texture (x=color, y=time)", 2D) = "white" {}
		_RadialFadeStart ("Radial Fade Start", Range(0, 1)) = 0.5
		_RadialFadeEnd ("Radial Fade End", Range(0, 1)) = 1
		_DispMap ("Displacement Texture", 2D) = "white" {}
		_DispParams ("Displacement Params (x,y = intensity, z,w = scroll)", Vector) = (0,0.1,0,1)
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ZWrite Off
			Cull Off
			GpuProgramID 58407
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
						vec4 _DispMap_ST;
						vec4 unused_0_3[2];
						float _AnimTime;
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
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = (-_AnimTime) * 1.5 + u_xlat0.y;
					    vs_TEXCOORD0.x = u_xlat0.x;
					    vs_TEXCOORD0.y = u_xlat2 + 0.5;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _DispMap_ST.xy + _DispMap_ST.zw;
					    vs_COLOR0 = in_COLOR0;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _DispMap_ST;
						vec4 unused_0_3[2];
						float _AnimTime;
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
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = (-_AnimTime) * 1.5 + u_xlat0.y;
					    vs_TEXCOORD0.x = u_xlat0.x;
					    vs_TEXCOORD0.y = u_xlat2 + 0.5;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _DispMap_ST.xy + _DispMap_ST.zw;
					    vs_COLOR0 = in_COLOR0;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _DispMap_ST;
						vec4 unused_0_3[2];
						float _AnimTime;
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
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = (-_AnimTime) * 1.5 + u_xlat0.y;
					    vs_TEXCOORD0.x = u_xlat0.x;
					    vs_TEXCOORD0.y = u_xlat2 + 0.5;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _DispMap_ST.xy + _DispMap_ST.zw;
					    vs_COLOR0 = in_COLOR0;
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
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 _DispParams;
						float _AnimTime;
						float _RadialFadeStart;
						float _RadialFadeEnd;
						float _Brightness;
					};
					uniform  sampler2D _DispMap;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RampTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0.xy = vec2(_AnimTime) * _DispParams.zw + vs_TEXCOORD2.xy;
					    u_xlat0 = texture(_DispMap, u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xy = u_xlat0.xy * _DispParams.xy + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat2 = vs_TEXCOORD1.y + (-_RadialFadeStart);
					    u_xlat4 = (-_RadialFadeStart) + _RadialFadeEnd;
					    u_xlat2 = u_xlat2 / u_xlat4;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat0.y = _AnimTime;
					    u_xlat0 = texture(_RampTex, u_xlat0.xy);
					    u_xlat1.xyz = vs_COLOR0.xyz * _Color.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = 1.0;
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
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 _DispParams;
						float _AnimTime;
						float _RadialFadeStart;
						float _RadialFadeEnd;
						float _Brightness;
					};
					uniform  sampler2D _DispMap;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RampTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0.xy = vec2(_AnimTime) * _DispParams.zw + vs_TEXCOORD2.xy;
					    u_xlat0 = texture(_DispMap, u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xy = u_xlat0.xy * _DispParams.xy + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat2 = vs_TEXCOORD1.y + (-_RadialFadeStart);
					    u_xlat4 = (-_RadialFadeStart) + _RadialFadeEnd;
					    u_xlat2 = u_xlat2 / u_xlat4;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat0.y = _AnimTime;
					    u_xlat0 = texture(_RampTex, u_xlat0.xy);
					    u_xlat1.xyz = vs_COLOR0.xyz * _Color.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = 1.0;
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
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 _DispParams;
						float _AnimTime;
						float _RadialFadeStart;
						float _RadialFadeEnd;
						float _Brightness;
					};
					uniform  sampler2D _DispMap;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RampTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0.xy = vec2(_AnimTime) * _DispParams.zw + vs_TEXCOORD2.xy;
					    u_xlat0 = texture(_DispMap, u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xy = u_xlat0.xy * _DispParams.xy + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat2 = vs_TEXCOORD1.y + (-_RadialFadeStart);
					    u_xlat4 = (-_RadialFadeStart) + _RadialFadeEnd;
					    u_xlat2 = u_xlat2 / u_xlat4;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = (-u_xlat2) + 1.0;
					    u_xlat0.x = u_xlat2 * u_xlat0.x;
					    u_xlat0.y = _AnimTime;
					    u_xlat0 = texture(_RampTex, u_xlat0.xy);
					    u_xlat1.xyz = vs_COLOR0.xyz * _Color.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}