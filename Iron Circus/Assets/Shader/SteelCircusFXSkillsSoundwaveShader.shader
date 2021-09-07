Shader "SteelCircus/FX/Skills/SoundwaveShader" {
	Properties {
		_MainTex ("Displacement", 2D) = "white" {}
		_DispIntensity ("Displacement Intensity", Range(-0.5, 0.5)) = 0.2
		_AlphaScale ("Alpha Scale", Range(0, 1)) = 1
		_GlowScale ("Glow Scale", Float) = 1
		_Color ("Glow Color", Vector) = (1,1,1,1)
	}
	SubShader {
		Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ZWrite Off
			Cull Off
			GpuProgramID 7102
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
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_NORMAL0;
					out vec4 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					vec2 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlat0.xy = unity_ObjectToWorld[1].yy * unity_MatrixV[1].xy;
					    u_xlat0.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[1].xx + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[1].zz + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[1].ww + u_xlat0.xy;
					    u_xlat8.xy = u_xlat0.xy * in_TANGENT0.yy;
					    u_xlat1.xy = unity_ObjectToWorld[0].yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[0].xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[0].zz + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[0].ww + u_xlat1.xy;
					    u_xlat8.xy = u_xlat1.xy * in_TANGENT0.xx + u_xlat8.xy;
					    u_xlat9.xy = unity_ObjectToWorld[2].yy * unity_MatrixV[1].xy;
					    u_xlat9.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[2].xx + u_xlat9.xy;
					    u_xlat9.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[2].zz + u_xlat9.xy;
					    u_xlat9.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[2].ww + u_xlat9.xy;
					    vs_NORMAL0.xy = u_xlat9.xy * in_TANGENT0.zz + u_xlat8.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat8.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat8.x * 0.5;
					    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat2.zw;
					    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat2.xyz = in_TANGENT0.zxy * in_NORMAL0.yzx;
					    u_xlat2.xyz = in_TANGENT0.yzx * in_NORMAL0.zxy + (-u_xlat2.xyz);
					    u_xlat0.xy = u_xlat0.xy * u_xlat2.yy;
					    u_xlat0.xy = u_xlat1.xy * u_xlat2.xx + u_xlat0.xy;
					    vs_TEXCOORD1.xy = u_xlat9.xy * u_xlat2.zz + u_xlat0.xy;
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
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_NORMAL0;
					out vec4 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					vec2 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlat0.xy = unity_ObjectToWorld[1].yy * unity_MatrixV[1].xy;
					    u_xlat0.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[1].xx + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[1].zz + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[1].ww + u_xlat0.xy;
					    u_xlat8.xy = u_xlat0.xy * in_TANGENT0.yy;
					    u_xlat1.xy = unity_ObjectToWorld[0].yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[0].xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[0].zz + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[0].ww + u_xlat1.xy;
					    u_xlat8.xy = u_xlat1.xy * in_TANGENT0.xx + u_xlat8.xy;
					    u_xlat9.xy = unity_ObjectToWorld[2].yy * unity_MatrixV[1].xy;
					    u_xlat9.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[2].xx + u_xlat9.xy;
					    u_xlat9.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[2].zz + u_xlat9.xy;
					    u_xlat9.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[2].ww + u_xlat9.xy;
					    vs_NORMAL0.xy = u_xlat9.xy * in_TANGENT0.zz + u_xlat8.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat8.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat8.x * 0.5;
					    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat2.zw;
					    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat2.xyz = in_TANGENT0.zxy * in_NORMAL0.yzx;
					    u_xlat2.xyz = in_TANGENT0.yzx * in_NORMAL0.zxy + (-u_xlat2.xyz);
					    u_xlat0.xy = u_xlat0.xy * u_xlat2.yy;
					    u_xlat0.xy = u_xlat1.xy * u_xlat2.xx + u_xlat0.xy;
					    vs_TEXCOORD1.xy = u_xlat9.xy * u_xlat2.zz + u_xlat0.xy;
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
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_NORMAL0;
					out vec4 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					vec2 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlat0.xy = unity_ObjectToWorld[1].yy * unity_MatrixV[1].xy;
					    u_xlat0.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[1].xx + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[1].zz + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[1].ww + u_xlat0.xy;
					    u_xlat8.xy = u_xlat0.xy * in_TANGENT0.yy;
					    u_xlat1.xy = unity_ObjectToWorld[0].yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[0].xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[0].zz + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[0].ww + u_xlat1.xy;
					    u_xlat8.xy = u_xlat1.xy * in_TANGENT0.xx + u_xlat8.xy;
					    u_xlat9.xy = unity_ObjectToWorld[2].yy * unity_MatrixV[1].xy;
					    u_xlat9.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[2].xx + u_xlat9.xy;
					    u_xlat9.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[2].zz + u_xlat9.xy;
					    u_xlat9.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[2].ww + u_xlat9.xy;
					    vs_NORMAL0.xy = u_xlat9.xy * in_TANGENT0.zz + u_xlat8.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
					    u_xlat2 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat8.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat8.x * 0.5;
					    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat2.zw;
					    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat2.xyz = in_TANGENT0.zxy * in_NORMAL0.yzx;
					    u_xlat2.xyz = in_TANGENT0.yzx * in_NORMAL0.zxy + (-u_xlat2.xyz);
					    u_xlat0.xy = u_xlat0.xy * u_xlat2.yy;
					    u_xlat0.xy = u_xlat1.xy * u_xlat2.xx + u_xlat0.xy;
					    vs_TEXCOORD1.xy = u_xlat9.xy * u_xlat2.zz + u_xlat0.xy;
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
						float _DispIntensity;
						float _AlphaScale;
						float _GlowScale;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[6];
						vec4 _ScreenParams;
						vec4 unused_1_2[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _GrabBlurTexture;
					uniform  sampler2D _GrabTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_NORMAL0;
					in  vec4 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1 = u_xlat0.zzzw * vec4(_GlowScale, _GlowScale, _GlowScale, _AlphaScale);
					    u_xlat3.xy = u_xlat0.yy * vs_TEXCOORD1.xy;
					    u_xlat0.xy = vs_NORMAL0.xy * u_xlat0.xx + u_xlat3.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(_DispIntensity);
					    u_xlat6.x = _ScreenParams.x / _ScreenParams.y;
					    u_xlat2.x = float(1.0) / u_xlat6.x;
					    u_xlat2.y = 1.0;
					    u_xlat6.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat0.xy = u_xlat0.xy * u_xlat2.xy + u_xlat6.xy;
					    u_xlat2 = texture(_GrabTexture, u_xlat6.xy);
					    u_xlat0 = texture(_GrabBlurTexture, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat1.xyz * _Color.xyz + u_xlat0.xyz;
					    u_xlat0 = (-u_xlat2) + u_xlat0;
					    u_xlat1.x = u_xlat1.w * _Color.w;
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
						vec4 unused_0_0[3];
						float _DispIntensity;
						float _AlphaScale;
						float _GlowScale;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[6];
						vec4 _ScreenParams;
						vec4 unused_1_2[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _GrabBlurTexture;
					uniform  sampler2D _GrabTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_NORMAL0;
					in  vec4 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1 = u_xlat0.zzzw * vec4(_GlowScale, _GlowScale, _GlowScale, _AlphaScale);
					    u_xlat3.xy = u_xlat0.yy * vs_TEXCOORD1.xy;
					    u_xlat0.xy = vs_NORMAL0.xy * u_xlat0.xx + u_xlat3.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(_DispIntensity);
					    u_xlat6.x = _ScreenParams.x / _ScreenParams.y;
					    u_xlat2.x = float(1.0) / u_xlat6.x;
					    u_xlat2.y = 1.0;
					    u_xlat6.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat0.xy = u_xlat0.xy * u_xlat2.xy + u_xlat6.xy;
					    u_xlat2 = texture(_GrabTexture, u_xlat6.xy);
					    u_xlat0 = texture(_GrabBlurTexture, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat1.xyz * _Color.xyz + u_xlat0.xyz;
					    u_xlat0 = (-u_xlat2) + u_xlat0;
					    u_xlat1.x = u_xlat1.w * _Color.w;
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
						vec4 unused_0_0[3];
						float _DispIntensity;
						float _AlphaScale;
						float _GlowScale;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[6];
						vec4 _ScreenParams;
						vec4 unused_1_2[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _GrabBlurTexture;
					uniform  sampler2D _GrabTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_NORMAL0;
					in  vec4 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1 = u_xlat0.zzzw * vec4(_GlowScale, _GlowScale, _GlowScale, _AlphaScale);
					    u_xlat3.xy = u_xlat0.yy * vs_TEXCOORD1.xy;
					    u_xlat0.xy = vs_NORMAL0.xy * u_xlat0.xx + u_xlat3.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(_DispIntensity);
					    u_xlat6.x = _ScreenParams.x / _ScreenParams.y;
					    u_xlat2.x = float(1.0) / u_xlat6.x;
					    u_xlat2.y = 1.0;
					    u_xlat6.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat0.xy = u_xlat0.xy * u_xlat2.xy + u_xlat6.xy;
					    u_xlat2 = texture(_GrabTexture, u_xlat6.xy);
					    u_xlat0 = texture(_GrabBlurTexture, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat1.xyz * _Color.xyz + u_xlat0.xyz;
					    u_xlat0 = (-u_xlat2) + u_xlat0;
					    u_xlat1.x = u_xlat1.w * _Color.w;
					    SV_Target0 = u_xlat0 * u_xlat1.xxxx;
					    return;
					}"
				}
			}
		}
	}
}