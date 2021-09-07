Shader "SteelCircus/FX/GoalAnimations/DefaultGoalAnimFireShader" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_MainTexDistPow ("Distance Power", Float) = 0.25
		_MainScrollSpeed ("Main Scroll Speed", Float) = 1
		_SecondaryScrollSpeed ("Secondary Scroll Speed", Float) = 1
		_NoiseDisplacement ("Noise Displacement", Range(0, 1)) = 0.2
		_NoiseRemapStart ("Noise Remap, Start", Range(0, 1)) = 0.4
		_NoiseRemapEnd ("Noise Remap, End", Range(0, 1)) = 0.8
		_NoiseRemapPow ("Noise Remap, Power", Float) = 1
		_ColorMap ("Color Map (1D)", 2D) = "white" {}
		_ColorMapPow ("Color Map Power", Float) = 1
		_BuildupMap ("Animation Map (2D)", 2D) = "white" {}
		_BuildupBGTime ("Animation Time", Range(0, 1)) = 0.5
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 27023
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
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
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
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
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
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
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
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						float _MainScrollSpeed;
						float _MainTexDistPow;
						float _ColorMapPow;
						float _SecondaryScrollSpeed;
						float _NoiseRemapStart;
						float _NoiseRemapEnd;
						float _NoiseDisplacement;
						float _NoiseRemapPow;
						float _BuildupBGTime;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _BuildupMap;
					uniform  sampler2D _ColorMap;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat4;
					vec2 u_xlat6;
					bool u_xlatb6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat6.xy = abs(u_xlat0.xy);
					    u_xlat1.x = max(u_xlat6.y, u_xlat6.x);
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat4 = min(u_xlat6.y, u_xlat6.x);
					    u_xlatb6 = u_xlat6.y<u_xlat6.x;
					    u_xlat9 = u_xlat1.x * u_xlat4;
					    u_xlat1.x = u_xlat9 * u_xlat9;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat9 * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlat6.x = u_xlatb6 ? u_xlat4 : float(0.0);
					    u_xlat6.x = u_xlat9 * u_xlat1.x + u_xlat6.x;
					    u_xlatb9 = (-u_xlat0.y)<u_xlat0.y;
					    u_xlat9 = u_xlatb9 ? -3.14159274 : float(0.0);
					    u_xlat6.x = u_xlat9 + u_xlat6.x;
					    u_xlat9 = min((-u_xlat0.y), (-u_xlat0.x));
					    u_xlatb9 = u_xlat9<(-u_xlat9);
					    u_xlat1.x = max((-u_xlat0.y), (-u_xlat0.x));
					    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.y = sqrt(u_xlat0.x);
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					    u_xlatb9 = u_xlatb9 && u_xlatb1;
					    u_xlat6.x = (u_xlatb9) ? (-u_xlat6.x) : u_xlat6.x;
					    u_xlat1.x = u_xlat6.x * 0.159154937 + 0.624000013;
					    u_xlat6.x = log2(u_xlat0.y);
					    u_xlat6.x = u_xlat6.x * _MainTexDistPow;
					    u_xlat1.y = exp2(u_xlat6.x);
					    u_xlat1.xy = u_xlat1.yx * _MainTex_ST.yx + _MainTex_ST.wz;
					    u_xlat1.zw = vec2(_MainScrollSpeed, _SecondaryScrollSpeed) * _Time.yy + u_xlat1.xx;
					    u_xlat2 = texture(_MainTex, u_xlat1.yz);
					    u_xlat6.x = u_xlat1.w + 0.242166996;
					    u_xlat1.x = (-u_xlat2.x) * _NoiseDisplacement + u_xlat6.x;
					    u_xlat2 = texture(_MainTex, u_xlat1.yx);
					    u_xlat1.z = (-u_xlat2.y) * _NoiseDisplacement + u_xlat1.z;
					    u_xlat1 = texture(_MainTex, u_xlat1.yz);
					    u_xlat6.x = u_xlat1.z + u_xlat2.y;
					    u_xlat6.x = u_xlat6.x * 0.5 + (-_NoiseRemapStart);
					    u_xlat9 = (-_NoiseRemapStart) + _NoiseRemapEnd;
					    u_xlat6.x = u_xlat6.x / u_xlat9;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _NoiseRemapPow;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat0.x = vs_COLOR0.x * _BuildupBGTime;
					    u_xlat1 = texture(_BuildupMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat6.x + u_xlat1.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ColorMapPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.y = 0.0;
					    SV_Target0 = texture(_ColorMap, u_xlat0.xy);
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
						float _MainScrollSpeed;
						float _MainTexDistPow;
						float _ColorMapPow;
						float _SecondaryScrollSpeed;
						float _NoiseRemapStart;
						float _NoiseRemapEnd;
						float _NoiseDisplacement;
						float _NoiseRemapPow;
						float _BuildupBGTime;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _BuildupMap;
					uniform  sampler2D _ColorMap;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat4;
					vec2 u_xlat6;
					bool u_xlatb6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat6.xy = abs(u_xlat0.xy);
					    u_xlat1.x = max(u_xlat6.y, u_xlat6.x);
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat4 = min(u_xlat6.y, u_xlat6.x);
					    u_xlatb6 = u_xlat6.y<u_xlat6.x;
					    u_xlat9 = u_xlat1.x * u_xlat4;
					    u_xlat1.x = u_xlat9 * u_xlat9;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat9 * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlat6.x = u_xlatb6 ? u_xlat4 : float(0.0);
					    u_xlat6.x = u_xlat9 * u_xlat1.x + u_xlat6.x;
					    u_xlatb9 = (-u_xlat0.y)<u_xlat0.y;
					    u_xlat9 = u_xlatb9 ? -3.14159274 : float(0.0);
					    u_xlat6.x = u_xlat9 + u_xlat6.x;
					    u_xlat9 = min((-u_xlat0.y), (-u_xlat0.x));
					    u_xlatb9 = u_xlat9<(-u_xlat9);
					    u_xlat1.x = max((-u_xlat0.y), (-u_xlat0.x));
					    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.y = sqrt(u_xlat0.x);
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					    u_xlatb9 = u_xlatb9 && u_xlatb1;
					    u_xlat6.x = (u_xlatb9) ? (-u_xlat6.x) : u_xlat6.x;
					    u_xlat1.x = u_xlat6.x * 0.159154937 + 0.624000013;
					    u_xlat6.x = log2(u_xlat0.y);
					    u_xlat6.x = u_xlat6.x * _MainTexDistPow;
					    u_xlat1.y = exp2(u_xlat6.x);
					    u_xlat1.xy = u_xlat1.yx * _MainTex_ST.yx + _MainTex_ST.wz;
					    u_xlat1.zw = vec2(_MainScrollSpeed, _SecondaryScrollSpeed) * _Time.yy + u_xlat1.xx;
					    u_xlat2 = texture(_MainTex, u_xlat1.yz);
					    u_xlat6.x = u_xlat1.w + 0.242166996;
					    u_xlat1.x = (-u_xlat2.x) * _NoiseDisplacement + u_xlat6.x;
					    u_xlat2 = texture(_MainTex, u_xlat1.yx);
					    u_xlat1.z = (-u_xlat2.y) * _NoiseDisplacement + u_xlat1.z;
					    u_xlat1 = texture(_MainTex, u_xlat1.yz);
					    u_xlat6.x = u_xlat1.z + u_xlat2.y;
					    u_xlat6.x = u_xlat6.x * 0.5 + (-_NoiseRemapStart);
					    u_xlat9 = (-_NoiseRemapStart) + _NoiseRemapEnd;
					    u_xlat6.x = u_xlat6.x / u_xlat9;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _NoiseRemapPow;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat0.x = vs_COLOR0.x * _BuildupBGTime;
					    u_xlat1 = texture(_BuildupMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat6.x + u_xlat1.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ColorMapPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.y = 0.0;
					    SV_Target0 = texture(_ColorMap, u_xlat0.xy);
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
						float _MainScrollSpeed;
						float _MainTexDistPow;
						float _ColorMapPow;
						float _SecondaryScrollSpeed;
						float _NoiseRemapStart;
						float _NoiseRemapEnd;
						float _NoiseDisplacement;
						float _NoiseRemapPow;
						float _BuildupBGTime;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _BuildupMap;
					uniform  sampler2D _ColorMap;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat4;
					vec2 u_xlat6;
					bool u_xlatb6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat6.xy = abs(u_xlat0.xy);
					    u_xlat1.x = max(u_xlat6.y, u_xlat6.x);
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat4 = min(u_xlat6.y, u_xlat6.x);
					    u_xlatb6 = u_xlat6.y<u_xlat6.x;
					    u_xlat9 = u_xlat1.x * u_xlat4;
					    u_xlat1.x = u_xlat9 * u_xlat9;
					    u_xlat4 = u_xlat1.x * 0.0208350997 + -0.0851330012;
					    u_xlat4 = u_xlat1.x * u_xlat4 + 0.180141002;
					    u_xlat4 = u_xlat1.x * u_xlat4 + -0.330299497;
					    u_xlat1.x = u_xlat1.x * u_xlat4 + 0.999866009;
					    u_xlat4 = u_xlat9 * u_xlat1.x;
					    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
					    u_xlat6.x = u_xlatb6 ? u_xlat4 : float(0.0);
					    u_xlat6.x = u_xlat9 * u_xlat1.x + u_xlat6.x;
					    u_xlatb9 = (-u_xlat0.y)<u_xlat0.y;
					    u_xlat9 = u_xlatb9 ? -3.14159274 : float(0.0);
					    u_xlat6.x = u_xlat9 + u_xlat6.x;
					    u_xlat9 = min((-u_xlat0.y), (-u_xlat0.x));
					    u_xlatb9 = u_xlat9<(-u_xlat9);
					    u_xlat1.x = max((-u_xlat0.y), (-u_xlat0.x));
					    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.y = sqrt(u_xlat0.x);
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					    u_xlatb9 = u_xlatb9 && u_xlatb1;
					    u_xlat6.x = (u_xlatb9) ? (-u_xlat6.x) : u_xlat6.x;
					    u_xlat1.x = u_xlat6.x * 0.159154937 + 0.624000013;
					    u_xlat6.x = log2(u_xlat0.y);
					    u_xlat6.x = u_xlat6.x * _MainTexDistPow;
					    u_xlat1.y = exp2(u_xlat6.x);
					    u_xlat1.xy = u_xlat1.yx * _MainTex_ST.yx + _MainTex_ST.wz;
					    u_xlat1.zw = vec2(_MainScrollSpeed, _SecondaryScrollSpeed) * _Time.yy + u_xlat1.xx;
					    u_xlat2 = texture(_MainTex, u_xlat1.yz);
					    u_xlat6.x = u_xlat1.w + 0.242166996;
					    u_xlat1.x = (-u_xlat2.x) * _NoiseDisplacement + u_xlat6.x;
					    u_xlat2 = texture(_MainTex, u_xlat1.yx);
					    u_xlat1.z = (-u_xlat2.y) * _NoiseDisplacement + u_xlat1.z;
					    u_xlat1 = texture(_MainTex, u_xlat1.yz);
					    u_xlat6.x = u_xlat1.z + u_xlat2.y;
					    u_xlat6.x = u_xlat6.x * 0.5 + (-_NoiseRemapStart);
					    u_xlat9 = (-_NoiseRemapStart) + _NoiseRemapEnd;
					    u_xlat6.x = u_xlat6.x / u_xlat9;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _NoiseRemapPow;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat0.x = vs_COLOR0.x * _BuildupBGTime;
					    u_xlat1 = texture(_BuildupMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat6.x + u_xlat1.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ColorMapPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.y = 0.0;
					    SV_Target0 = texture(_ColorMap, u_xlat0.xy);
					    return;
					}"
				}
			}
		}
	}
}