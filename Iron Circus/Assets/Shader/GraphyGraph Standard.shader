Shader "Graphy/Graph Standard" {
	Properties {
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Vector) = (1,1,1,1)
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		_LowColor ("Low Color", Vector) = (1,1,1,1)
		_MidColor ("Mid Color", Vector) = (1,1,1,1)
		_HighColor ("High Color", Vector) = (1,1,1,1)
		_MidThreshold ("Mid Threshold", Float) = 0.5
		_HighThreshold ("High Threshold", Float) = 0.25
	}
	SubShader {
		Pass {
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 56566
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
						vec4 unused_0_2[517];
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
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_2[517];
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
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_2[517];
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
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "PIXELSNAP_ON" }
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
						vec4 unused_0_2[517];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[6];
						vec4 _ScreenParams;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
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
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
					    u_xlat0.xy = roundEven(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
					    gl_Position.zw = u_xlat0.zw;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "PIXELSNAP_ON" }
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
						vec4 unused_0_2[517];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[6];
						vec4 _ScreenParams;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
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
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
					    u_xlat0.xy = roundEven(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
					    gl_Position.zw = u_xlat0.zw;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "PIXELSNAP_ON" }
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
						vec4 unused_0_2[517];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[6];
						vec4 _ScreenParams;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
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
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
					    u_xlat0.xy = roundEven(u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
					    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
					    gl_Position.zw = u_xlat0.zw;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 _LowColor;
						vec4 _MidColor;
						vec4 _HighColor;
						float _MidThreshold;
						float _HighThreshold;
						float Average;
						float GraphValues[512];
						vec4 unused_0_8[510];
						float GraphValues_Length;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec4 u_xlat2;
					bvec3 u_xlatb2;
					float u_xlat3;
					uint u_xlatu3;
					float u_xlat5;
					bool u_xlatb5;
					bvec2 u_xlatb7;
					bool u_xlatb9;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = vs_COLOR0 * _HighColor;
					    u_xlat1 = vs_COLOR0 * _MidColor;
					    u_xlat2 = vs_COLOR0 * _LowColor;
					    u_xlat3 = vs_TEXCOORD0.x * GraphValues_Length;
					    u_xlat3 = floor(u_xlat3);
					    u_xlatu3 = uint(u_xlat3);
					    u_xlatb7.xy = lessThan(vec4(_HighThreshold, _MidThreshold, _HighThreshold, _HighThreshold), vec4(GraphValues[int(u_xlatu3)])).xy;
					    u_xlat1 = (u_xlatb7.y) ? u_xlat1 : u_xlat2;
					    u_xlat0 = (u_xlatb7.x) ? u_xlat0 : u_xlat1;
					    u_xlat1.x = vs_TEXCOORD0.y * 0.300000012;
					    u_xlat1.x = u_xlat1.x / GraphValues[int(u_xlatu3)];
					    u_xlat1.x = u_xlat0.w * u_xlat1.x;
					    u_xlat5 = (-vs_TEXCOORD0.y) + GraphValues[int(u_xlatu3)];
					    u_xlatb9 = GraphValues[int(u_xlatu3)]<vs_TEXCOORD0.y;
					    u_xlat13 = GraphValues_Length + -1.0;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat13 = u_xlat13 * 4.0;
					    u_xlatb5 = u_xlat13<u_xlat5;
					    u_xlat1.x = (u_xlatb5) ? u_xlat1.x : u_xlat0.w;
					    u_xlat0.w = (u_xlatb9) ? 0.0 : u_xlat1.x;
					    u_xlat1.xyz = vec3(Average, _HighThreshold, _MidThreshold) + vec3(-0.0199999996, -0.0199999996, -0.0199999996);
					    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vs_TEXCOORD0.yyyy).xyz;
					    u_xlatb2.xyz = lessThan(vs_TEXCOORD0.yyyy, vec4(Average, _HighThreshold, _MidThreshold, Average)).xyz;
					    u_xlatb1.x = u_xlatb1.x && u_xlatb2.x;
					    u_xlatb1.y = u_xlatb1.y && u_xlatb2.y;
					    u_xlatb1.z = u_xlatb1.z && u_xlatb2.z;
					    u_xlat0 = (u_xlatb1.x) ? vec4(1.0, 1.0, 1.0, 1.0) : u_xlat0;
					    u_xlat0 = (u_xlatb1.y) ? _MidColor : u_xlat0;
					    u_xlat0 = (u_xlatb1.z) ? _LowColor : u_xlat0;
					    u_xlat1.xy = (-vs_TEXCOORD0.xx) + vec2(0.0299999993, 1.0);
					    u_xlat1.y = u_xlat1.y * 33.3333359;
					    u_xlat1.x = (-u_xlat1.x) * 33.3333359 + 1.0;
					    u_xlat1.xy = u_xlat0.ww * u_xlat1.xy;
					    u_xlatb9 = 0.970000029<vs_TEXCOORD0.x;
					    u_xlat5 = (u_xlatb9) ? u_xlat1.y : u_xlat0.w;
					    u_xlatb9 = vs_TEXCOORD0.x<0.0299999993;
					    u_xlat0.w = (u_xlatb9) ? u_xlat1.x : u_xlat5;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
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
						vec4 _LowColor;
						vec4 _MidColor;
						vec4 _HighColor;
						float _MidThreshold;
						float _HighThreshold;
						float Average;
						float GraphValues[512];
						vec4 unused_0_8[510];
						float GraphValues_Length;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec4 u_xlat2;
					bvec3 u_xlatb2;
					float u_xlat3;
					uint u_xlatu3;
					float u_xlat5;
					bool u_xlatb5;
					bvec2 u_xlatb7;
					bool u_xlatb9;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = vs_COLOR0 * _HighColor;
					    u_xlat1 = vs_COLOR0 * _MidColor;
					    u_xlat2 = vs_COLOR0 * _LowColor;
					    u_xlat3 = vs_TEXCOORD0.x * GraphValues_Length;
					    u_xlat3 = floor(u_xlat3);
					    u_xlatu3 = uint(u_xlat3);
					    u_xlatb7.xy = lessThan(vec4(_HighThreshold, _MidThreshold, _HighThreshold, _HighThreshold), vec4(GraphValues[int(u_xlatu3)])).xy;
					    u_xlat1 = (u_xlatb7.y) ? u_xlat1 : u_xlat2;
					    u_xlat0 = (u_xlatb7.x) ? u_xlat0 : u_xlat1;
					    u_xlat1.x = vs_TEXCOORD0.y * 0.300000012;
					    u_xlat1.x = u_xlat1.x / GraphValues[int(u_xlatu3)];
					    u_xlat1.x = u_xlat0.w * u_xlat1.x;
					    u_xlat5 = (-vs_TEXCOORD0.y) + GraphValues[int(u_xlatu3)];
					    u_xlatb9 = GraphValues[int(u_xlatu3)]<vs_TEXCOORD0.y;
					    u_xlat13 = GraphValues_Length + -1.0;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat13 = u_xlat13 * 4.0;
					    u_xlatb5 = u_xlat13<u_xlat5;
					    u_xlat1.x = (u_xlatb5) ? u_xlat1.x : u_xlat0.w;
					    u_xlat0.w = (u_xlatb9) ? 0.0 : u_xlat1.x;
					    u_xlat1.xyz = vec3(Average, _HighThreshold, _MidThreshold) + vec3(-0.0199999996, -0.0199999996, -0.0199999996);
					    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vs_TEXCOORD0.yyyy).xyz;
					    u_xlatb2.xyz = lessThan(vs_TEXCOORD0.yyyy, vec4(Average, _HighThreshold, _MidThreshold, Average)).xyz;
					    u_xlatb1.x = u_xlatb1.x && u_xlatb2.x;
					    u_xlatb1.y = u_xlatb1.y && u_xlatb2.y;
					    u_xlatb1.z = u_xlatb1.z && u_xlatb2.z;
					    u_xlat0 = (u_xlatb1.x) ? vec4(1.0, 1.0, 1.0, 1.0) : u_xlat0;
					    u_xlat0 = (u_xlatb1.y) ? _MidColor : u_xlat0;
					    u_xlat0 = (u_xlatb1.z) ? _LowColor : u_xlat0;
					    u_xlat1.xy = (-vs_TEXCOORD0.xx) + vec2(0.0299999993, 1.0);
					    u_xlat1.y = u_xlat1.y * 33.3333359;
					    u_xlat1.x = (-u_xlat1.x) * 33.3333359 + 1.0;
					    u_xlat1.xy = u_xlat0.ww * u_xlat1.xy;
					    u_xlatb9 = 0.970000029<vs_TEXCOORD0.x;
					    u_xlat5 = (u_xlatb9) ? u_xlat1.y : u_xlat0.w;
					    u_xlatb9 = vs_TEXCOORD0.x<0.0299999993;
					    u_xlat0.w = (u_xlatb9) ? u_xlat1.x : u_xlat5;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
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
						vec4 _LowColor;
						vec4 _MidColor;
						vec4 _HighColor;
						float _MidThreshold;
						float _HighThreshold;
						float Average;
						float GraphValues[512];
						vec4 unused_0_8[510];
						float GraphValues_Length;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec4 u_xlat2;
					bvec3 u_xlatb2;
					float u_xlat3;
					uint u_xlatu3;
					float u_xlat5;
					bool u_xlatb5;
					bvec2 u_xlatb7;
					bool u_xlatb9;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = vs_COLOR0 * _HighColor;
					    u_xlat1 = vs_COLOR0 * _MidColor;
					    u_xlat2 = vs_COLOR0 * _LowColor;
					    u_xlat3 = vs_TEXCOORD0.x * GraphValues_Length;
					    u_xlat3 = floor(u_xlat3);
					    u_xlatu3 = uint(u_xlat3);
					    u_xlatb7.xy = lessThan(vec4(_HighThreshold, _MidThreshold, _HighThreshold, _HighThreshold), vec4(GraphValues[int(u_xlatu3)])).xy;
					    u_xlat1 = (u_xlatb7.y) ? u_xlat1 : u_xlat2;
					    u_xlat0 = (u_xlatb7.x) ? u_xlat0 : u_xlat1;
					    u_xlat1.x = vs_TEXCOORD0.y * 0.300000012;
					    u_xlat1.x = u_xlat1.x / GraphValues[int(u_xlatu3)];
					    u_xlat1.x = u_xlat0.w * u_xlat1.x;
					    u_xlat5 = (-vs_TEXCOORD0.y) + GraphValues[int(u_xlatu3)];
					    u_xlatb9 = GraphValues[int(u_xlatu3)]<vs_TEXCOORD0.y;
					    u_xlat13 = GraphValues_Length + -1.0;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat13 = u_xlat13 * 4.0;
					    u_xlatb5 = u_xlat13<u_xlat5;
					    u_xlat1.x = (u_xlatb5) ? u_xlat1.x : u_xlat0.w;
					    u_xlat0.w = (u_xlatb9) ? 0.0 : u_xlat1.x;
					    u_xlat1.xyz = vec3(Average, _HighThreshold, _MidThreshold) + vec3(-0.0199999996, -0.0199999996, -0.0199999996);
					    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vs_TEXCOORD0.yyyy).xyz;
					    u_xlatb2.xyz = lessThan(vs_TEXCOORD0.yyyy, vec4(Average, _HighThreshold, _MidThreshold, Average)).xyz;
					    u_xlatb1.x = u_xlatb1.x && u_xlatb2.x;
					    u_xlatb1.y = u_xlatb1.y && u_xlatb2.y;
					    u_xlatb1.z = u_xlatb1.z && u_xlatb2.z;
					    u_xlat0 = (u_xlatb1.x) ? vec4(1.0, 1.0, 1.0, 1.0) : u_xlat0;
					    u_xlat0 = (u_xlatb1.y) ? _MidColor : u_xlat0;
					    u_xlat0 = (u_xlatb1.z) ? _LowColor : u_xlat0;
					    u_xlat1.xy = (-vs_TEXCOORD0.xx) + vec2(0.0299999993, 1.0);
					    u_xlat1.y = u_xlat1.y * 33.3333359;
					    u_xlat1.x = (-u_xlat1.x) * 33.3333359 + 1.0;
					    u_xlat1.xy = u_xlat0.ww * u_xlat1.xy;
					    u_xlatb9 = 0.970000029<vs_TEXCOORD0.x;
					    u_xlat5 = (u_xlatb9) ? u_xlat1.y : u_xlat0.w;
					    u_xlatb9 = vs_TEXCOORD0.x<0.0299999993;
					    u_xlat0.w = (u_xlatb9) ? u_xlat1.x : u_xlat5;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "PIXELSNAP_ON" }
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
						vec4 _LowColor;
						vec4 _MidColor;
						vec4 _HighColor;
						float _MidThreshold;
						float _HighThreshold;
						float Average;
						float GraphValues[512];
						vec4 unused_0_8[510];
						float GraphValues_Length;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec4 u_xlat2;
					bvec3 u_xlatb2;
					float u_xlat3;
					uint u_xlatu3;
					float u_xlat5;
					bool u_xlatb5;
					bvec2 u_xlatb7;
					bool u_xlatb9;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = vs_COLOR0 * _HighColor;
					    u_xlat1 = vs_COLOR0 * _MidColor;
					    u_xlat2 = vs_COLOR0 * _LowColor;
					    u_xlat3 = vs_TEXCOORD0.x * GraphValues_Length;
					    u_xlat3 = floor(u_xlat3);
					    u_xlatu3 = uint(u_xlat3);
					    u_xlatb7.xy = lessThan(vec4(_HighThreshold, _MidThreshold, _HighThreshold, _HighThreshold), vec4(GraphValues[int(u_xlatu3)])).xy;
					    u_xlat1 = (u_xlatb7.y) ? u_xlat1 : u_xlat2;
					    u_xlat0 = (u_xlatb7.x) ? u_xlat0 : u_xlat1;
					    u_xlat1.x = vs_TEXCOORD0.y * 0.300000012;
					    u_xlat1.x = u_xlat1.x / GraphValues[int(u_xlatu3)];
					    u_xlat1.x = u_xlat0.w * u_xlat1.x;
					    u_xlat5 = (-vs_TEXCOORD0.y) + GraphValues[int(u_xlatu3)];
					    u_xlatb9 = GraphValues[int(u_xlatu3)]<vs_TEXCOORD0.y;
					    u_xlat13 = GraphValues_Length + -1.0;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat13 = u_xlat13 * 4.0;
					    u_xlatb5 = u_xlat13<u_xlat5;
					    u_xlat1.x = (u_xlatb5) ? u_xlat1.x : u_xlat0.w;
					    u_xlat0.w = (u_xlatb9) ? 0.0 : u_xlat1.x;
					    u_xlat1.xyz = vec3(Average, _HighThreshold, _MidThreshold) + vec3(-0.0199999996, -0.0199999996, -0.0199999996);
					    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vs_TEXCOORD0.yyyy).xyz;
					    u_xlatb2.xyz = lessThan(vs_TEXCOORD0.yyyy, vec4(Average, _HighThreshold, _MidThreshold, Average)).xyz;
					    u_xlatb1.x = u_xlatb1.x && u_xlatb2.x;
					    u_xlatb1.y = u_xlatb1.y && u_xlatb2.y;
					    u_xlatb1.z = u_xlatb1.z && u_xlatb2.z;
					    u_xlat0 = (u_xlatb1.x) ? vec4(1.0, 1.0, 1.0, 1.0) : u_xlat0;
					    u_xlat0 = (u_xlatb1.y) ? _MidColor : u_xlat0;
					    u_xlat0 = (u_xlatb1.z) ? _LowColor : u_xlat0;
					    u_xlat1.xy = (-vs_TEXCOORD0.xx) + vec2(0.0299999993, 1.0);
					    u_xlat1.y = u_xlat1.y * 33.3333359;
					    u_xlat1.x = (-u_xlat1.x) * 33.3333359 + 1.0;
					    u_xlat1.xy = u_xlat0.ww * u_xlat1.xy;
					    u_xlatb9 = 0.970000029<vs_TEXCOORD0.x;
					    u_xlat5 = (u_xlatb9) ? u_xlat1.y : u_xlat0.w;
					    u_xlatb9 = vs_TEXCOORD0.x<0.0299999993;
					    u_xlat0.w = (u_xlatb9) ? u_xlat1.x : u_xlat5;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "PIXELSNAP_ON" }
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
						vec4 _LowColor;
						vec4 _MidColor;
						vec4 _HighColor;
						float _MidThreshold;
						float _HighThreshold;
						float Average;
						float GraphValues[512];
						vec4 unused_0_8[510];
						float GraphValues_Length;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec4 u_xlat2;
					bvec3 u_xlatb2;
					float u_xlat3;
					uint u_xlatu3;
					float u_xlat5;
					bool u_xlatb5;
					bvec2 u_xlatb7;
					bool u_xlatb9;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = vs_COLOR0 * _HighColor;
					    u_xlat1 = vs_COLOR0 * _MidColor;
					    u_xlat2 = vs_COLOR0 * _LowColor;
					    u_xlat3 = vs_TEXCOORD0.x * GraphValues_Length;
					    u_xlat3 = floor(u_xlat3);
					    u_xlatu3 = uint(u_xlat3);
					    u_xlatb7.xy = lessThan(vec4(_HighThreshold, _MidThreshold, _HighThreshold, _HighThreshold), vec4(GraphValues[int(u_xlatu3)])).xy;
					    u_xlat1 = (u_xlatb7.y) ? u_xlat1 : u_xlat2;
					    u_xlat0 = (u_xlatb7.x) ? u_xlat0 : u_xlat1;
					    u_xlat1.x = vs_TEXCOORD0.y * 0.300000012;
					    u_xlat1.x = u_xlat1.x / GraphValues[int(u_xlatu3)];
					    u_xlat1.x = u_xlat0.w * u_xlat1.x;
					    u_xlat5 = (-vs_TEXCOORD0.y) + GraphValues[int(u_xlatu3)];
					    u_xlatb9 = GraphValues[int(u_xlatu3)]<vs_TEXCOORD0.y;
					    u_xlat13 = GraphValues_Length + -1.0;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat13 = u_xlat13 * 4.0;
					    u_xlatb5 = u_xlat13<u_xlat5;
					    u_xlat1.x = (u_xlatb5) ? u_xlat1.x : u_xlat0.w;
					    u_xlat0.w = (u_xlatb9) ? 0.0 : u_xlat1.x;
					    u_xlat1.xyz = vec3(Average, _HighThreshold, _MidThreshold) + vec3(-0.0199999996, -0.0199999996, -0.0199999996);
					    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vs_TEXCOORD0.yyyy).xyz;
					    u_xlatb2.xyz = lessThan(vs_TEXCOORD0.yyyy, vec4(Average, _HighThreshold, _MidThreshold, Average)).xyz;
					    u_xlatb1.x = u_xlatb1.x && u_xlatb2.x;
					    u_xlatb1.y = u_xlatb1.y && u_xlatb2.y;
					    u_xlatb1.z = u_xlatb1.z && u_xlatb2.z;
					    u_xlat0 = (u_xlatb1.x) ? vec4(1.0, 1.0, 1.0, 1.0) : u_xlat0;
					    u_xlat0 = (u_xlatb1.y) ? _MidColor : u_xlat0;
					    u_xlat0 = (u_xlatb1.z) ? _LowColor : u_xlat0;
					    u_xlat1.xy = (-vs_TEXCOORD0.xx) + vec2(0.0299999993, 1.0);
					    u_xlat1.y = u_xlat1.y * 33.3333359;
					    u_xlat1.x = (-u_xlat1.x) * 33.3333359 + 1.0;
					    u_xlat1.xy = u_xlat0.ww * u_xlat1.xy;
					    u_xlatb9 = 0.970000029<vs_TEXCOORD0.x;
					    u_xlat5 = (u_xlatb9) ? u_xlat1.y : u_xlat0.w;
					    u_xlatb9 = vs_TEXCOORD0.x<0.0299999993;
					    u_xlat0.w = (u_xlatb9) ? u_xlat1.x : u_xlat5;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "PIXELSNAP_ON" }
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
						vec4 _LowColor;
						vec4 _MidColor;
						vec4 _HighColor;
						float _MidThreshold;
						float _HighThreshold;
						float Average;
						float GraphValues[512];
						vec4 unused_0_8[510];
						float GraphValues_Length;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec4 u_xlat2;
					bvec3 u_xlatb2;
					float u_xlat3;
					uint u_xlatu3;
					float u_xlat5;
					bool u_xlatb5;
					bvec2 u_xlatb7;
					bool u_xlatb9;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = vs_COLOR0 * _HighColor;
					    u_xlat1 = vs_COLOR0 * _MidColor;
					    u_xlat2 = vs_COLOR0 * _LowColor;
					    u_xlat3 = vs_TEXCOORD0.x * GraphValues_Length;
					    u_xlat3 = floor(u_xlat3);
					    u_xlatu3 = uint(u_xlat3);
					    u_xlatb7.xy = lessThan(vec4(_HighThreshold, _MidThreshold, _HighThreshold, _HighThreshold), vec4(GraphValues[int(u_xlatu3)])).xy;
					    u_xlat1 = (u_xlatb7.y) ? u_xlat1 : u_xlat2;
					    u_xlat0 = (u_xlatb7.x) ? u_xlat0 : u_xlat1;
					    u_xlat1.x = vs_TEXCOORD0.y * 0.300000012;
					    u_xlat1.x = u_xlat1.x / GraphValues[int(u_xlatu3)];
					    u_xlat1.x = u_xlat0.w * u_xlat1.x;
					    u_xlat5 = (-vs_TEXCOORD0.y) + GraphValues[int(u_xlatu3)];
					    u_xlatb9 = GraphValues[int(u_xlatu3)]<vs_TEXCOORD0.y;
					    u_xlat13 = GraphValues_Length + -1.0;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat13 = u_xlat13 * 4.0;
					    u_xlatb5 = u_xlat13<u_xlat5;
					    u_xlat1.x = (u_xlatb5) ? u_xlat1.x : u_xlat0.w;
					    u_xlat0.w = (u_xlatb9) ? 0.0 : u_xlat1.x;
					    u_xlat1.xyz = vec3(Average, _HighThreshold, _MidThreshold) + vec3(-0.0199999996, -0.0199999996, -0.0199999996);
					    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vs_TEXCOORD0.yyyy).xyz;
					    u_xlatb2.xyz = lessThan(vs_TEXCOORD0.yyyy, vec4(Average, _HighThreshold, _MidThreshold, Average)).xyz;
					    u_xlatb1.x = u_xlatb1.x && u_xlatb2.x;
					    u_xlatb1.y = u_xlatb1.y && u_xlatb2.y;
					    u_xlatb1.z = u_xlatb1.z && u_xlatb2.z;
					    u_xlat0 = (u_xlatb1.x) ? vec4(1.0, 1.0, 1.0, 1.0) : u_xlat0;
					    u_xlat0 = (u_xlatb1.y) ? _MidColor : u_xlat0;
					    u_xlat0 = (u_xlatb1.z) ? _LowColor : u_xlat0;
					    u_xlat1.xy = (-vs_TEXCOORD0.xx) + vec2(0.0299999993, 1.0);
					    u_xlat1.y = u_xlat1.y * 33.3333359;
					    u_xlat1.x = (-u_xlat1.x) * 33.3333359 + 1.0;
					    u_xlat1.xy = u_xlat0.ww * u_xlat1.xy;
					    u_xlatb9 = 0.970000029<vs_TEXCOORD0.x;
					    u_xlat5 = (u_xlatb9) ? u_xlat1.y : u_xlat0.w;
					    u_xlatb9 = vs_TEXCOORD0.x<0.0299999993;
					    u_xlat0.w = (u_xlatb9) ? u_xlat1.x : u_xlat5;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
			}
		}
	}
}