Shader "SteelCircus/FX/Skills/ParabolaSpeedLineShader" {
	Properties {
		_AnimationTime ("Animation Time", Range(0, 1)) = 0.5
		_MaxLength ("Maximum effect length", Range(0, 0.99)) = 0.5
		[NoScaleOffset] _AlphaGradientTex ("Alpha Gradient", 2D) = "white" {}
		_InitialHeight ("Initial Height (local space)", Float) = 1
		_DisplacementIntensity ("Displacement Intensity", Float) = 0.001
		[NoScaleOffset] _DisplacementIntensityTex ("Displacement Intensity Texture", 2D) = "white" {}
		[NoScaleOffset] _SwooshGradientTex ("Swoosh Intensity Gradient", 2D) = "white" {}
		[NoScaleOffset] _SpeedLinesTex ("Speed Lines", 2D) = "white" {}
	}
	SubShader {
		LOD 100
		Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ZWrite Off
			Cull Off
			GpuProgramID 49035
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
						float _InitialHeight;
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
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec2 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat4;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = (-in_TEXCOORD0.x) + 1.0;
					    u_xlat0.x = _InitialHeight * u_xlat0.x + in_POSITION0.y;
					    u_xlat0 = u_xlat0.xxxx * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.xy = unity_ObjectToWorld[1].yy * unity_MatrixV[1].xy;
					    u_xlat0.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[1].xx + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[1].zz + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[1].ww + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * in_TANGENT0.yy;
					    u_xlat4.xy = unity_ObjectToWorld[0].yy * unity_MatrixV[1].xy;
					    u_xlat4.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[0].xx + u_xlat4.xy;
					    u_xlat4.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[0].zz + u_xlat4.xy;
					    u_xlat4.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[0].ww + u_xlat4.xy;
					    u_xlat0.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat0.xy;
					    u_xlat4.xy = unity_ObjectToWorld[2].yy * unity_MatrixV[1].xy;
					    u_xlat4.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[2].xx + u_xlat4.xy;
					    u_xlat4.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[2].zz + u_xlat4.xy;
					    u_xlat4.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[2].ww + u_xlat4.xy;
					    vs_NORMAL0.xy = u_xlat4.xy * in_TANGENT0.zz + u_xlat0.xy;
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
						float _InitialHeight;
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
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec2 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat4;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = (-in_TEXCOORD0.x) + 1.0;
					    u_xlat0.x = _InitialHeight * u_xlat0.x + in_POSITION0.y;
					    u_xlat0 = u_xlat0.xxxx * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.xy = unity_ObjectToWorld[1].yy * unity_MatrixV[1].xy;
					    u_xlat0.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[1].xx + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[1].zz + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[1].ww + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * in_TANGENT0.yy;
					    u_xlat4.xy = unity_ObjectToWorld[0].yy * unity_MatrixV[1].xy;
					    u_xlat4.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[0].xx + u_xlat4.xy;
					    u_xlat4.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[0].zz + u_xlat4.xy;
					    u_xlat4.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[0].ww + u_xlat4.xy;
					    u_xlat0.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat0.xy;
					    u_xlat4.xy = unity_ObjectToWorld[2].yy * unity_MatrixV[1].xy;
					    u_xlat4.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[2].xx + u_xlat4.xy;
					    u_xlat4.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[2].zz + u_xlat4.xy;
					    u_xlat4.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[2].ww + u_xlat4.xy;
					    vs_NORMAL0.xy = u_xlat4.xy * in_TANGENT0.zz + u_xlat0.xy;
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
						float _InitialHeight;
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
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec2 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat4;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = (-in_TEXCOORD0.x) + 1.0;
					    u_xlat0.x = _InitialHeight * u_xlat0.x + in_POSITION0.y;
					    u_xlat0 = u_xlat0.xxxx * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.xy = unity_ObjectToWorld[1].yy * unity_MatrixV[1].xy;
					    u_xlat0.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[1].xx + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[1].zz + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[1].ww + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * in_TANGENT0.yy;
					    u_xlat4.xy = unity_ObjectToWorld[0].yy * unity_MatrixV[1].xy;
					    u_xlat4.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[0].xx + u_xlat4.xy;
					    u_xlat4.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[0].zz + u_xlat4.xy;
					    u_xlat4.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[0].ww + u_xlat4.xy;
					    u_xlat0.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat0.xy;
					    u_xlat4.xy = unity_ObjectToWorld[2].yy * unity_MatrixV[1].xy;
					    u_xlat4.xy = unity_MatrixV[0].xy * unity_ObjectToWorld[2].xx + u_xlat4.xy;
					    u_xlat4.xy = unity_MatrixV[2].xy * unity_ObjectToWorld[2].zz + u_xlat4.xy;
					    u_xlat4.xy = unity_MatrixV[3].xy * unity_ObjectToWorld[2].ww + u_xlat4.xy;
					    vs_NORMAL0.xy = u_xlat4.xy * in_TANGENT0.zz + u_xlat0.xy;
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
						float _DisplacementIntensity;
						float _AnimationTime;
						float _MaxLength;
					};
					layout(std140) uniform UnityPerCameraRare {
						vec4 unused_1_0[6];
						mat4x4 unity_CameraProjection;
						vec4 unused_1_2[12];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_2_2[10];
					};
					uniform  sampler2D _DisplacementIntensityTex;
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _AlphaGradientTex;
					uniform  sampler2D _GrabBlurTexture;
					uniform  sampler2D _SpeedLinesTex;
					uniform  sampler2D _SwooshGradientTex;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec2 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat10;
					bool u_xlatb10;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD3.y * unity_MatrixV[1].z;
					    u_xlat0.x = unity_MatrixV[0].z * vs_TEXCOORD3.x + u_xlat0.x;
					    u_xlat0.x = unity_MatrixV[2].z * vs_TEXCOORD3.z + u_xlat0.x;
					    u_xlat0.x = unity_MatrixV[3].z * vs_TEXCOORD3.w + u_xlat0.x;
					    u_xlat0.x = abs(u_xlat0.x) / unity_CameraProjection[1].y;
					    u_xlat5.xy = vec2(_AnimationTime, _DisplacementIntensity) * vec2(3.1415, 0.00100000005);
					    u_xlat0.x = u_xlat0.x * u_xlat5.y;
					    u_xlat5.x = sin(u_xlat5.x);
					    u_xlat5.x = log2(u_xlat5.x);
					    u_xlat5.x = u_xlat5.x * 0.25;
					    u_xlat5.x = exp2(u_xlat5.x);
					    u_xlat5.x = (-u_xlat5.x) * _MaxLength + _AnimationTime;
					    u_xlat1 = texture(_DisplacementIntensityTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat10.x = (-u_xlat5.x) + vs_TEXCOORD1.x;
					    u_xlat5.x = (-u_xlat5.x) + _AnimationTime;
					    u_xlat5.x = u_xlat10.x / u_xlat5.x;
					    u_xlatb10 = 1.0<u_xlat5.x;
					    u_xlatb15 = u_xlat5.x<0.0;
					    u_xlatb10 = u_xlatb15 || u_xlatb10;
					    u_xlat1.x = (u_xlatb10) ? 0.0 : u_xlat5.x;
					    u_xlat1.y = vs_TEXCOORD1.y;
					    u_xlat2 = texture(_AlphaGradientTex, u_xlat1.xy);
					    u_xlat3 = texture(_SpeedLinesTex, u_xlat1.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat5.x = u_xlat1.x * u_xlat2.x;
					    u_xlat10.x = log2(u_xlat1.x);
					    u_xlat10.x = u_xlat10.x * 0.300000012;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat0.x = u_xlat10.x * u_xlat0.x;
					    u_xlat10.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat6.xz = vs_NORMAL0.xy * u_xlat0.xx + u_xlat10.xy;
					    u_xlat2 = texture(_GrabTexture, u_xlat10.xy);
					    u_xlat4 = texture(_GrabBlurTexture, u_xlat6.xz);
					    u_xlat0.xzw = (-u_xlat2.xyz) + u_xlat4.xyz;
					    u_xlat1.z = 0.0;
					    u_xlat1 = texture(_SwooshGradientTex, u_xlat1.xz);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat0.xzw * u_xlat5.xxx + u_xlat1.xyz;
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
						vec4 unused_0_0[3];
						float _DisplacementIntensity;
						float _AnimationTime;
						float _MaxLength;
					};
					layout(std140) uniform UnityPerCameraRare {
						vec4 unused_1_0[6];
						mat4x4 unity_CameraProjection;
						vec4 unused_1_2[12];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_2_2[10];
					};
					uniform  sampler2D _DisplacementIntensityTex;
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _AlphaGradientTex;
					uniform  sampler2D _GrabBlurTexture;
					uniform  sampler2D _SpeedLinesTex;
					uniform  sampler2D _SwooshGradientTex;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec2 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat10;
					bool u_xlatb10;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD3.y * unity_MatrixV[1].z;
					    u_xlat0.x = unity_MatrixV[0].z * vs_TEXCOORD3.x + u_xlat0.x;
					    u_xlat0.x = unity_MatrixV[2].z * vs_TEXCOORD3.z + u_xlat0.x;
					    u_xlat0.x = unity_MatrixV[3].z * vs_TEXCOORD3.w + u_xlat0.x;
					    u_xlat0.x = abs(u_xlat0.x) / unity_CameraProjection[1].y;
					    u_xlat5.xy = vec2(_AnimationTime, _DisplacementIntensity) * vec2(3.1415, 0.00100000005);
					    u_xlat0.x = u_xlat0.x * u_xlat5.y;
					    u_xlat5.x = sin(u_xlat5.x);
					    u_xlat5.x = log2(u_xlat5.x);
					    u_xlat5.x = u_xlat5.x * 0.25;
					    u_xlat5.x = exp2(u_xlat5.x);
					    u_xlat5.x = (-u_xlat5.x) * _MaxLength + _AnimationTime;
					    u_xlat1 = texture(_DisplacementIntensityTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat10.x = (-u_xlat5.x) + vs_TEXCOORD1.x;
					    u_xlat5.x = (-u_xlat5.x) + _AnimationTime;
					    u_xlat5.x = u_xlat10.x / u_xlat5.x;
					    u_xlatb10 = 1.0<u_xlat5.x;
					    u_xlatb15 = u_xlat5.x<0.0;
					    u_xlatb10 = u_xlatb15 || u_xlatb10;
					    u_xlat1.x = (u_xlatb10) ? 0.0 : u_xlat5.x;
					    u_xlat1.y = vs_TEXCOORD1.y;
					    u_xlat2 = texture(_AlphaGradientTex, u_xlat1.xy);
					    u_xlat3 = texture(_SpeedLinesTex, u_xlat1.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat5.x = u_xlat1.x * u_xlat2.x;
					    u_xlat10.x = log2(u_xlat1.x);
					    u_xlat10.x = u_xlat10.x * 0.300000012;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat0.x = u_xlat10.x * u_xlat0.x;
					    u_xlat10.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat6.xz = vs_NORMAL0.xy * u_xlat0.xx + u_xlat10.xy;
					    u_xlat2 = texture(_GrabTexture, u_xlat10.xy);
					    u_xlat4 = texture(_GrabBlurTexture, u_xlat6.xz);
					    u_xlat0.xzw = (-u_xlat2.xyz) + u_xlat4.xyz;
					    u_xlat1.z = 0.0;
					    u_xlat1 = texture(_SwooshGradientTex, u_xlat1.xz);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat0.xzw * u_xlat5.xxx + u_xlat1.xyz;
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
						vec4 unused_0_0[3];
						float _DisplacementIntensity;
						float _AnimationTime;
						float _MaxLength;
					};
					layout(std140) uniform UnityPerCameraRare {
						vec4 unused_1_0[6];
						mat4x4 unity_CameraProjection;
						vec4 unused_1_2[12];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_2_2[10];
					};
					uniform  sampler2D _DisplacementIntensityTex;
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _AlphaGradientTex;
					uniform  sampler2D _GrabBlurTexture;
					uniform  sampler2D _SpeedLinesTex;
					uniform  sampler2D _SwooshGradientTex;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec2 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat10;
					bool u_xlatb10;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD3.y * unity_MatrixV[1].z;
					    u_xlat0.x = unity_MatrixV[0].z * vs_TEXCOORD3.x + u_xlat0.x;
					    u_xlat0.x = unity_MatrixV[2].z * vs_TEXCOORD3.z + u_xlat0.x;
					    u_xlat0.x = unity_MatrixV[3].z * vs_TEXCOORD3.w + u_xlat0.x;
					    u_xlat0.x = abs(u_xlat0.x) / unity_CameraProjection[1].y;
					    u_xlat5.xy = vec2(_AnimationTime, _DisplacementIntensity) * vec2(3.1415, 0.00100000005);
					    u_xlat0.x = u_xlat0.x * u_xlat5.y;
					    u_xlat5.x = sin(u_xlat5.x);
					    u_xlat5.x = log2(u_xlat5.x);
					    u_xlat5.x = u_xlat5.x * 0.25;
					    u_xlat5.x = exp2(u_xlat5.x);
					    u_xlat5.x = (-u_xlat5.x) * _MaxLength + _AnimationTime;
					    u_xlat1 = texture(_DisplacementIntensityTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat10.x = (-u_xlat5.x) + vs_TEXCOORD1.x;
					    u_xlat5.x = (-u_xlat5.x) + _AnimationTime;
					    u_xlat5.x = u_xlat10.x / u_xlat5.x;
					    u_xlatb10 = 1.0<u_xlat5.x;
					    u_xlatb15 = u_xlat5.x<0.0;
					    u_xlatb10 = u_xlatb15 || u_xlatb10;
					    u_xlat1.x = (u_xlatb10) ? 0.0 : u_xlat5.x;
					    u_xlat1.y = vs_TEXCOORD1.y;
					    u_xlat2 = texture(_AlphaGradientTex, u_xlat1.xy);
					    u_xlat3 = texture(_SpeedLinesTex, u_xlat1.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat5.x = u_xlat1.x * u_xlat2.x;
					    u_xlat10.x = log2(u_xlat1.x);
					    u_xlat10.x = u_xlat10.x * 0.300000012;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat0.x = u_xlat10.x * u_xlat0.x;
					    u_xlat10.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat6.xz = vs_NORMAL0.xy * u_xlat0.xx + u_xlat10.xy;
					    u_xlat2 = texture(_GrabTexture, u_xlat10.xy);
					    u_xlat4 = texture(_GrabBlurTexture, u_xlat6.xz);
					    u_xlat0.xzw = (-u_xlat2.xyz) + u_xlat4.xyz;
					    u_xlat1.z = 0.0;
					    u_xlat1 = texture(_SwooshGradientTex, u_xlat1.xz);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat0.xzw * u_xlat5.xxx + u_xlat1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}