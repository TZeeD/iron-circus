Shader "SteelCircus/FX/Skills/VortexShader" {
	Properties {
		_MainTex ("Streak Texture", 2D) = "white" {}
		_OverlayTex ("Overlay Tex (additive)", 2D) = "white" {}
		_BoostTex ("Red: Boost/Attenuate Streaks, Green: Displace Overlay", 2D) = "white" {}
		_ScrollSpeed ("Scroll Speed, Streaks", Float) = 1
		_ScrollSpeedOverlay ("Scroll Speed, Overlay", Float) = 1
		_ScrollSpeedBoost ("Scroll Speed, Boost/Displace", Float) = 1
		_DisplacementOverlay ("Overlay Displacement", Float) = 1
		_Brightness ("Brightness Scale", Float) = 1
		_BrightnessOverlay ("Overlay Brightness Scale", Float) = 1
		_Displacement ("Background Displacement", Float) = 1
		_DisplacementCurve ("Displacement Curve (Pow)", Float) = 1
	}
	SubShader {
		LOD 100
		Tags { "DisableBatching" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "DisableBatching" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 25865
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
						vec4 _OverlayTex_ST;
						vec4 _BoostTex_ST;
						float _ScrollSpeed;
						float _ScrollSpeedOverlay;
						float _ScrollSpeedBoost;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					out vec2 vs_NORMAL0;
					out vec2 vs_TEXCOORD4;
					out vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xy = vec2(_ScrollSpeed, _ScrollSpeedOverlay) * _Time.yy;
					    u_xlat1.z = 0.0;
					    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xz;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.xy = in_TEXCOORD0.xy * _OverlayTex_ST.xy + _OverlayTex_ST.zw;
					    vs_TEXCOORD4.xy = u_xlat1.yz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[1].yy * unity_MatrixV[1].xy;
					    u_xlat0.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[1].xx + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[1].zz + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[1].ww + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * in_TANGENT0.yy;
					    u_xlat6.xy = unity_ObjectToWorld[0].yy * unity_MatrixV[1].xy;
					    u_xlat6.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[0].xx + u_xlat6.xy;
					    u_xlat6.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[0].zz + u_xlat6.xy;
					    u_xlat6.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[0].ww + u_xlat6.xy;
					    u_xlat0.xy = u_xlat6.xy * in_TANGENT0.xx + u_xlat0.xy;
					    u_xlat6.xy = unity_ObjectToWorld[2].yy * unity_MatrixV[1].xy;
					    u_xlat6.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[2].xx + u_xlat6.xy;
					    u_xlat6.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[2].zz + u_xlat6.xy;
					    u_xlat6.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[2].ww + u_xlat6.xy;
					    vs_NORMAL0.xy = u_xlat6.xy * in_TANGENT0.zz + u_xlat0.xy;
					    u_xlat0.xy = in_TEXCOORD0.xy * _BoostTex_ST.xy + _BoostTex_ST.zw;
					    u_xlat1.x = _ScrollSpeedBoost * _Time.y;
					    u_xlat1.y = 0.0;
					    vs_TEXCOORD5.xy = u_xlat0.xy + u_xlat1.xy;
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
						vec4 _OverlayTex_ST;
						vec4 _BoostTex_ST;
						float _ScrollSpeed;
						float _ScrollSpeedOverlay;
						float _ScrollSpeedBoost;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					out vec2 vs_NORMAL0;
					out vec2 vs_TEXCOORD4;
					out vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xy = vec2(_ScrollSpeed, _ScrollSpeedOverlay) * _Time.yy;
					    u_xlat1.z = 0.0;
					    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xz;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.xy = in_TEXCOORD0.xy * _OverlayTex_ST.xy + _OverlayTex_ST.zw;
					    vs_TEXCOORD4.xy = u_xlat1.yz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[1].yy * unity_MatrixV[1].xy;
					    u_xlat0.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[1].xx + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[1].zz + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[1].ww + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * in_TANGENT0.yy;
					    u_xlat6.xy = unity_ObjectToWorld[0].yy * unity_MatrixV[1].xy;
					    u_xlat6.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[0].xx + u_xlat6.xy;
					    u_xlat6.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[0].zz + u_xlat6.xy;
					    u_xlat6.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[0].ww + u_xlat6.xy;
					    u_xlat0.xy = u_xlat6.xy * in_TANGENT0.xx + u_xlat0.xy;
					    u_xlat6.xy = unity_ObjectToWorld[2].yy * unity_MatrixV[1].xy;
					    u_xlat6.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[2].xx + u_xlat6.xy;
					    u_xlat6.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[2].zz + u_xlat6.xy;
					    u_xlat6.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[2].ww + u_xlat6.xy;
					    vs_NORMAL0.xy = u_xlat6.xy * in_TANGENT0.zz + u_xlat0.xy;
					    u_xlat0.xy = in_TEXCOORD0.xy * _BoostTex_ST.xy + _BoostTex_ST.zw;
					    u_xlat1.x = _ScrollSpeedBoost * _Time.y;
					    u_xlat1.y = 0.0;
					    vs_TEXCOORD5.xy = u_xlat0.xy + u_xlat1.xy;
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
						vec4 _OverlayTex_ST;
						vec4 _BoostTex_ST;
						float _ScrollSpeed;
						float _ScrollSpeedOverlay;
						float _ScrollSpeedBoost;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					out vec2 vs_NORMAL0;
					out vec2 vs_TEXCOORD4;
					out vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat6;
					void main()
					{
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xy = vec2(_ScrollSpeed, _ScrollSpeedOverlay) * _Time.yy;
					    u_xlat1.z = 0.0;
					    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xz;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.xy = in_TEXCOORD0.xy * _OverlayTex_ST.xy + _OverlayTex_ST.zw;
					    vs_TEXCOORD4.xy = u_xlat1.yz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[1].yy * unity_MatrixV[1].xy;
					    u_xlat0.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[1].xx + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[1].zz + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[1].ww + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * in_TANGENT0.yy;
					    u_xlat6.xy = unity_ObjectToWorld[0].yy * unity_MatrixV[1].xy;
					    u_xlat6.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[0].xx + u_xlat6.xy;
					    u_xlat6.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[0].zz + u_xlat6.xy;
					    u_xlat6.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[0].ww + u_xlat6.xy;
					    u_xlat0.xy = u_xlat6.xy * in_TANGENT0.xx + u_xlat0.xy;
					    u_xlat6.xy = unity_ObjectToWorld[2].yy * unity_MatrixV[1].xy;
					    u_xlat6.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[2].xx + u_xlat6.xy;
					    u_xlat6.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[2].zz + u_xlat6.xy;
					    u_xlat6.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[2].ww + u_xlat6.xy;
					    vs_NORMAL0.xy = u_xlat6.xy * in_TANGENT0.zz + u_xlat0.xy;
					    u_xlat0.xy = in_TEXCOORD0.xy * _BoostTex_ST.xy + _BoostTex_ST.zw;
					    u_xlat1.x = _ScrollSpeedBoost * _Time.y;
					    u_xlat1.y = 0.0;
					    vs_TEXCOORD5.xy = u_xlat0.xy + u_xlat1.xy;
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
						vec4 unused_0_0[5];
						float _Displacement;
						float _DisplacementCurve;
						float _DisplacementOverlay;
						float _Brightness;
						float _BrightnessOverlay;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[6];
						vec4 _ScreenParams;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerCameraRare {
						vec4 unused_2_0[6];
						mat4x4 unity_CameraProjection;
						vec4 unused_2_2[12];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[10];
					};
					uniform  sampler2D _BoostTex;
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _OverlayTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					in  vec2 vs_NORMAL0;
					in  vec2 vs_TEXCOORD4;
					in  vec2 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD3.y * unity_MatrixV[1].z;
					    u_xlat0.x = unity_MatrixV[0].z * vs_TEXCOORD3.x + u_xlat0.x;
					    u_xlat0.x = unity_MatrixV[2].z * vs_TEXCOORD3.z + u_xlat0.x;
					    u_xlat0.x = unity_MatrixV[3].z * vs_TEXCOORD3.w + u_xlat0.x;
					    u_xlat0.x = abs(u_xlat0.x) / unity_CameraProjection[1].y;
					    u_xlat3 = _Displacement * 0.00100000005;
					    u_xlat0.y = u_xlat0.x * u_xlat3;
					    u_xlat6.x = _ScreenParams.x / _ScreenParams.y;
					    u_xlat0.x = u_xlat0.y / u_xlat6.x;
					    u_xlat6.x = vs_TEXCOORD1.y + -0.5;
					    u_xlat6.x = -abs(u_xlat6.x) * 2.0 + 1.0;
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _DisplacementCurve;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat0.xy = u_xlat6.xx * u_xlat0.xy;
					    u_xlat6.x = max(u_xlat6.x, 0.00999999978);
					    SV_Target0.w = u_xlat6.x * vs_COLOR0.w;
					    u_xlat0.xy = u_xlat0.xy * vs_COLOR0.ww;
					    u_xlat6.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat0.xy = vs_NORMAL0.xy * u_xlat0.xy + u_xlat6.xy;
					    u_xlat0 = texture(_GrabTexture, u_xlat0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat2 = texture(_BoostTex, vs_TEXCOORD5.xy);
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat2.xxx + u_xlat0.xyz;
					    u_xlat1.xy = u_xlat2.yy * vec2(vec2(_DisplacementOverlay, _DisplacementOverlay)) + vs_TEXCOORD4.xy;
					    u_xlat1 = texture(_OverlayTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BrightnessOverlay, _BrightnessOverlay, _BrightnessOverlay));
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat2.xxx + u_xlat0.xyz;
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
						vec4 unused_0_0[5];
						float _Displacement;
						float _DisplacementCurve;
						float _DisplacementOverlay;
						float _Brightness;
						float _BrightnessOverlay;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[6];
						vec4 _ScreenParams;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerCameraRare {
						vec4 unused_2_0[6];
						mat4x4 unity_CameraProjection;
						vec4 unused_2_2[12];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[10];
					};
					uniform  sampler2D _BoostTex;
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _OverlayTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					in  vec2 vs_NORMAL0;
					in  vec2 vs_TEXCOORD4;
					in  vec2 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD3.y * unity_MatrixV[1].z;
					    u_xlat0.x = unity_MatrixV[0].z * vs_TEXCOORD3.x + u_xlat0.x;
					    u_xlat0.x = unity_MatrixV[2].z * vs_TEXCOORD3.z + u_xlat0.x;
					    u_xlat0.x = unity_MatrixV[3].z * vs_TEXCOORD3.w + u_xlat0.x;
					    u_xlat0.x = abs(u_xlat0.x) / unity_CameraProjection[1].y;
					    u_xlat3 = _Displacement * 0.00100000005;
					    u_xlat0.y = u_xlat0.x * u_xlat3;
					    u_xlat6.x = _ScreenParams.x / _ScreenParams.y;
					    u_xlat0.x = u_xlat0.y / u_xlat6.x;
					    u_xlat6.x = vs_TEXCOORD1.y + -0.5;
					    u_xlat6.x = -abs(u_xlat6.x) * 2.0 + 1.0;
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _DisplacementCurve;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat0.xy = u_xlat6.xx * u_xlat0.xy;
					    u_xlat6.x = max(u_xlat6.x, 0.00999999978);
					    SV_Target0.w = u_xlat6.x * vs_COLOR0.w;
					    u_xlat0.xy = u_xlat0.xy * vs_COLOR0.ww;
					    u_xlat6.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat0.xy = vs_NORMAL0.xy * u_xlat0.xy + u_xlat6.xy;
					    u_xlat0 = texture(_GrabTexture, u_xlat0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat2 = texture(_BoostTex, vs_TEXCOORD5.xy);
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat2.xxx + u_xlat0.xyz;
					    u_xlat1.xy = u_xlat2.yy * vec2(vec2(_DisplacementOverlay, _DisplacementOverlay)) + vs_TEXCOORD4.xy;
					    u_xlat1 = texture(_OverlayTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BrightnessOverlay, _BrightnessOverlay, _BrightnessOverlay));
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat2.xxx + u_xlat0.xyz;
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
						vec4 unused_0_0[5];
						float _Displacement;
						float _DisplacementCurve;
						float _DisplacementOverlay;
						float _Brightness;
						float _BrightnessOverlay;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[6];
						vec4 _ScreenParams;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerCameraRare {
						vec4 unused_2_0[6];
						mat4x4 unity_CameraProjection;
						vec4 unused_2_2[12];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[10];
					};
					uniform  sampler2D _BoostTex;
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _OverlayTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					in  vec2 vs_NORMAL0;
					in  vec2 vs_TEXCOORD4;
					in  vec2 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD3.y * unity_MatrixV[1].z;
					    u_xlat0.x = unity_MatrixV[0].z * vs_TEXCOORD3.x + u_xlat0.x;
					    u_xlat0.x = unity_MatrixV[2].z * vs_TEXCOORD3.z + u_xlat0.x;
					    u_xlat0.x = unity_MatrixV[3].z * vs_TEXCOORD3.w + u_xlat0.x;
					    u_xlat0.x = abs(u_xlat0.x) / unity_CameraProjection[1].y;
					    u_xlat3 = _Displacement * 0.00100000005;
					    u_xlat0.y = u_xlat0.x * u_xlat3;
					    u_xlat6.x = _ScreenParams.x / _ScreenParams.y;
					    u_xlat0.x = u_xlat0.y / u_xlat6.x;
					    u_xlat6.x = vs_TEXCOORD1.y + -0.5;
					    u_xlat6.x = -abs(u_xlat6.x) * 2.0 + 1.0;
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _DisplacementCurve;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat0.xy = u_xlat6.xx * u_xlat0.xy;
					    u_xlat6.x = max(u_xlat6.x, 0.00999999978);
					    SV_Target0.w = u_xlat6.x * vs_COLOR0.w;
					    u_xlat0.xy = u_xlat0.xy * vs_COLOR0.ww;
					    u_xlat6.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat0.xy = vs_NORMAL0.xy * u_xlat0.xy + u_xlat6.xy;
					    u_xlat0 = texture(_GrabTexture, u_xlat0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat2 = texture(_BoostTex, vs_TEXCOORD5.xy);
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat2.xxx + u_xlat0.xyz;
					    u_xlat1.xy = u_xlat2.yy * vec2(vec2(_DisplacementOverlay, _DisplacementOverlay)) + vs_TEXCOORD4.xy;
					    u_xlat1 = texture(_OverlayTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BrightnessOverlay, _BrightnessOverlay, _BrightnessOverlay));
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat2.xxx + u_xlat0.xyz;
					    return;
					}"
				}
			}
		}
	}
}