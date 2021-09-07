Shader "SteelCircus/FX/Skills/AoePreviews/AoeSlamShader" {
	Properties {
		_ColorMiddle ("Middle Color", Vector) = (1,1,1,1)
		[NoScaleOffset] _GradientTex ("Gradient Texture", 2D) = "white" {}
		_MainTex ("Tiling Texture (mult)", 2D) = "white" {}
		_TilingSpeed ("Tiling Speed (uv/sec)", Float) = 0.1
		_TilingOpacity ("Tiling Opacity", Range(0, 1)) = 1
		_TilingPow ("Tiling UV Pow", Float) = 1
		_MinRadius ("Min Radius", Float) = 0.25
		_MaxRadius ("Max Radius", Float) = 6.5
		_Angle ("Angle", Float) = 90
		_OutlineWidth ("Outline Width (units!)", Float) = 0.1
		_OutlineSpeed ("Outline Speed (radians/sec!)", Float) = 1
		_ColorBuildupBG ("Buildup BG Color", Vector) = (1,0,0,1)
		_BuildupBGTime ("Buildup Time", Range(0, 1)) = 0.5
		_ColorOutlineBG ("Outline BG", Vector) = (1,0,1,1)
		_ColorOutlineFG ("Outline FG", Vector) = (1,1,0,1)
		[NoScaleOffset] _OutlineMaskTex ("Outline Mask Texture (1D, red channel)", 2D) = "white" {}
		_OutlineMaskOffsetAndRatio ("Outline Mask Center (UV space, xy) and Aspect Ratio (z)", Vector) = (0.5,0.5,1,1)
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 37400
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
						vec4 unused_0_0[9];
						float _BuildupBGTime;
						vec4 unused_0_2;
						float _MinRadius;
						float _MaxRadius;
						float _Angle;
						float _OutlineWidth;
						vec4 unused_0_7;
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
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD3;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat4;
					float u_xlat5;
					float u_xlat6;
					vec2 u_xlat7;
					vec2 u_xlat8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					float u_xlat14;
					float u_xlat15;
					float u_xlat16;
					float u_xlat21;
					int u_xlati21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    u_xlat0.xw = (-u_xlat0.xy) + in_TEXCOORD0.xy;
					    u_xlat1.x = dot(u_xlat0.xw, u_xlat0.xw);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat0.z = in_TEXCOORD0.x + -0.5;
					    u_xlat8.xy = in_TEXCOORD0.xy * vec2(2.0, 1.0) + vec2(-1.0, -0.0);
					    u_xlat7.xy = u_xlat0.zy + (-u_xlat8.xy);
					    u_xlat2.xy = abs(u_xlat0.xw) + abs(u_xlat0.xw);
					    u_xlat0.yz = u_xlat2.yy * u_xlat7.xy + u_xlat8.xy;
					    vs_TEXCOORD2.xy = (bool(u_xlatb1)) ? u_xlat0.yz : u_xlat8.xy;
					    u_xlati21 = int((0.0<u_xlat0.x) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0 = int((u_xlat0.x<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0 = (-u_xlati21) + u_xlati0;
					    u_xlat0.x = float(u_xlati0);
					    u_xlat21 = u_xlat0.x * _OutlineWidth;
					    u_xlat22 = inversesqrt(_BuildupBGTime);
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat3 = u_xlat22 * 0.899999976 + 0.100000001;
					    u_xlat3 = u_xlat3 * _Angle;
					    u_xlat3 = u_xlat3 * 0.00872638915;
					    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat3);
					    u_xlat4 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat10.x = u_xlat21 * u_xlat4;
					    u_xlat10.y = (-u_xlat0.x);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat0.xw = u_xlat2.xz * u_xlat10.xy;
					    u_xlat16 = dot(vec2(_MinRadius, _MaxRadius), vec2(0.100000001, 0.899999976));
					    u_xlat10.x = (-u_xlat16) + _MaxRadius;
					    u_xlat22 = u_xlat22 * u_xlat10.x + u_xlat16;
					    u_xlat16 = u_xlat2.y * _OutlineWidth + u_xlat22;
					    u_xlat22 = u_xlat22 + (-_MinRadius);
					    u_xlat15 = u_xlat8.y * u_xlat22 + _MinRadius;
					    u_xlat8.x = u_xlat8.x * u_xlat3;
					    u_xlat3 = sin(u_xlat0.y);
					    u_xlat4 = cos(u_xlat0.y);
					    u_xlat5 = sin(u_xlat8.x);
					    u_xlat6 = cos(u_xlat8.x);
					    u_xlat7.x = (-u_xlat2.y) * _OutlineWidth + _MinRadius;
					    u_xlat8.x = (-u_xlat7.x) + u_xlat16;
					    u_xlat7.x = u_xlat0.z * u_xlat8.x + u_xlat7.x;
					    u_xlat14 = u_xlat3 * u_xlat7.x;
					    u_xlat9.y = u_xlat4 * u_xlat7.x;
					    u_xlat9.x = (-u_xlat14);
					    u_xlat0.yz = u_xlat2.wx * u_xlat0.xw + u_xlat9.xy;
					    u_xlat21 = u_xlat15 * u_xlat5;
					    u_xlat2.z = u_xlat15 * u_xlat6;
					    u_xlat2.y = (-u_xlat21);
					    u_xlat0.x = 1.0;
					    u_xlat2.x = 0.0;
					    u_xlat0.xyz = (bool(u_xlatb1)) ? u_xlat0.xyz : u_xlat2.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = u_xlat0.x;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
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
						vec4 unused_0_0[9];
						float _BuildupBGTime;
						vec4 unused_0_2;
						float _MinRadius;
						float _MaxRadius;
						float _Angle;
						float _OutlineWidth;
						vec4 unused_0_7;
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
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD3;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat4;
					float u_xlat5;
					float u_xlat6;
					vec2 u_xlat7;
					vec2 u_xlat8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					float u_xlat14;
					float u_xlat15;
					float u_xlat16;
					float u_xlat21;
					int u_xlati21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    u_xlat0.xw = (-u_xlat0.xy) + in_TEXCOORD0.xy;
					    u_xlat1.x = dot(u_xlat0.xw, u_xlat0.xw);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat0.z = in_TEXCOORD0.x + -0.5;
					    u_xlat8.xy = in_TEXCOORD0.xy * vec2(2.0, 1.0) + vec2(-1.0, -0.0);
					    u_xlat7.xy = u_xlat0.zy + (-u_xlat8.xy);
					    u_xlat2.xy = abs(u_xlat0.xw) + abs(u_xlat0.xw);
					    u_xlat0.yz = u_xlat2.yy * u_xlat7.xy + u_xlat8.xy;
					    vs_TEXCOORD2.xy = (bool(u_xlatb1)) ? u_xlat0.yz : u_xlat8.xy;
					    u_xlati21 = int((0.0<u_xlat0.x) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0 = int((u_xlat0.x<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0 = (-u_xlati21) + u_xlati0;
					    u_xlat0.x = float(u_xlati0);
					    u_xlat21 = u_xlat0.x * _OutlineWidth;
					    u_xlat22 = inversesqrt(_BuildupBGTime);
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat3 = u_xlat22 * 0.899999976 + 0.100000001;
					    u_xlat3 = u_xlat3 * _Angle;
					    u_xlat3 = u_xlat3 * 0.00872638915;
					    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat3);
					    u_xlat4 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat10.x = u_xlat21 * u_xlat4;
					    u_xlat10.y = (-u_xlat0.x);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat0.xw = u_xlat2.xz * u_xlat10.xy;
					    u_xlat16 = dot(vec2(_MinRadius, _MaxRadius), vec2(0.100000001, 0.899999976));
					    u_xlat10.x = (-u_xlat16) + _MaxRadius;
					    u_xlat22 = u_xlat22 * u_xlat10.x + u_xlat16;
					    u_xlat16 = u_xlat2.y * _OutlineWidth + u_xlat22;
					    u_xlat22 = u_xlat22 + (-_MinRadius);
					    u_xlat15 = u_xlat8.y * u_xlat22 + _MinRadius;
					    u_xlat8.x = u_xlat8.x * u_xlat3;
					    u_xlat3 = sin(u_xlat0.y);
					    u_xlat4 = cos(u_xlat0.y);
					    u_xlat5 = sin(u_xlat8.x);
					    u_xlat6 = cos(u_xlat8.x);
					    u_xlat7.x = (-u_xlat2.y) * _OutlineWidth + _MinRadius;
					    u_xlat8.x = (-u_xlat7.x) + u_xlat16;
					    u_xlat7.x = u_xlat0.z * u_xlat8.x + u_xlat7.x;
					    u_xlat14 = u_xlat3 * u_xlat7.x;
					    u_xlat9.y = u_xlat4 * u_xlat7.x;
					    u_xlat9.x = (-u_xlat14);
					    u_xlat0.yz = u_xlat2.wx * u_xlat0.xw + u_xlat9.xy;
					    u_xlat21 = u_xlat15 * u_xlat5;
					    u_xlat2.z = u_xlat15 * u_xlat6;
					    u_xlat2.y = (-u_xlat21);
					    u_xlat0.x = 1.0;
					    u_xlat2.x = 0.0;
					    u_xlat0.xyz = (bool(u_xlatb1)) ? u_xlat0.xyz : u_xlat2.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = u_xlat0.x;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
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
						vec4 unused_0_0[9];
						float _BuildupBGTime;
						vec4 unused_0_2;
						float _MinRadius;
						float _MaxRadius;
						float _Angle;
						float _OutlineWidth;
						vec4 unused_0_7;
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
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD3;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat4;
					float u_xlat5;
					float u_xlat6;
					vec2 u_xlat7;
					vec2 u_xlat8;
					vec2 u_xlat9;
					vec2 u_xlat10;
					float u_xlat14;
					float u_xlat15;
					float u_xlat16;
					float u_xlat21;
					int u_xlati21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    vs_TEXCOORD0.xy = u_xlat0.xy;
					    u_xlat0.xw = (-u_xlat0.xy) + in_TEXCOORD0.xy;
					    u_xlat1.x = dot(u_xlat0.xw, u_xlat0.xw);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat0.z = in_TEXCOORD0.x + -0.5;
					    u_xlat8.xy = in_TEXCOORD0.xy * vec2(2.0, 1.0) + vec2(-1.0, -0.0);
					    u_xlat7.xy = u_xlat0.zy + (-u_xlat8.xy);
					    u_xlat2.xy = abs(u_xlat0.xw) + abs(u_xlat0.xw);
					    u_xlat0.yz = u_xlat2.yy * u_xlat7.xy + u_xlat8.xy;
					    vs_TEXCOORD2.xy = (bool(u_xlatb1)) ? u_xlat0.yz : u_xlat8.xy;
					    u_xlati21 = int((0.0<u_xlat0.x) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0 = int((u_xlat0.x<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0 = (-u_xlati21) + u_xlati0;
					    u_xlat0.x = float(u_xlati0);
					    u_xlat21 = u_xlat0.x * _OutlineWidth;
					    u_xlat22 = inversesqrt(_BuildupBGTime);
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat3 = u_xlat22 * 0.899999976 + 0.100000001;
					    u_xlat3 = u_xlat3 * _Angle;
					    u_xlat3 = u_xlat3 * 0.00872638915;
					    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat3);
					    u_xlat4 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat10.x = u_xlat21 * u_xlat4;
					    u_xlat10.y = (-u_xlat0.x);
					    u_xlat2.z = float(1.0);
					    u_xlat2.w = float(-1.0);
					    u_xlat0.xw = u_xlat2.xz * u_xlat10.xy;
					    u_xlat16 = dot(vec2(_MinRadius, _MaxRadius), vec2(0.100000001, 0.899999976));
					    u_xlat10.x = (-u_xlat16) + _MaxRadius;
					    u_xlat22 = u_xlat22 * u_xlat10.x + u_xlat16;
					    u_xlat16 = u_xlat2.y * _OutlineWidth + u_xlat22;
					    u_xlat22 = u_xlat22 + (-_MinRadius);
					    u_xlat15 = u_xlat8.y * u_xlat22 + _MinRadius;
					    u_xlat8.x = u_xlat8.x * u_xlat3;
					    u_xlat3 = sin(u_xlat0.y);
					    u_xlat4 = cos(u_xlat0.y);
					    u_xlat5 = sin(u_xlat8.x);
					    u_xlat6 = cos(u_xlat8.x);
					    u_xlat7.x = (-u_xlat2.y) * _OutlineWidth + _MinRadius;
					    u_xlat8.x = (-u_xlat7.x) + u_xlat16;
					    u_xlat7.x = u_xlat0.z * u_xlat8.x + u_xlat7.x;
					    u_xlat14 = u_xlat3 * u_xlat7.x;
					    u_xlat9.y = u_xlat4 * u_xlat7.x;
					    u_xlat9.x = (-u_xlat14);
					    u_xlat0.yz = u_xlat2.wx * u_xlat0.xw + u_xlat9.xy;
					    u_xlat21 = u_xlat15 * u_xlat5;
					    u_xlat2.z = u_xlat15 * u_xlat6;
					    u_xlat2.y = (-u_xlat21);
					    u_xlat0.x = 1.0;
					    u_xlat2.x = 0.0;
					    u_xlat0.xyz = (bool(u_xlatb1)) ? u_xlat0.xyz : u_xlat2.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = u_xlat0.x;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
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
						vec4 _ColorOutlineBG;
						vec4 _ColorOutlineFG;
						vec4 _ColorMiddle;
						vec4 unused_0_4;
						vec4 _OutlineMaskOffsetAndRatio;
						vec4 unused_0_6;
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 _MainTex_ST;
						vec4 unused_0_10;
						float _OutlineSpeed;
						float _TilingOpacity;
						float _TilingSpeed;
						float _TilingPow;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _OutlineMaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					float u_xlat3;
					bool u_xlatb3;
					bool u_xlatb4;
					vec2 u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy + vec2(-0.0, -0.5);
					    u_xlat0.xy = u_xlat0.xy + (-_OutlineMaskOffsetAndRatio.xy);
					    u_xlat3 = u_xlat0.y * _OutlineMaskOffsetAndRatio.z;
					    u_xlat6.x = _OutlineSpeed * _Time.y;
					    u_xlat1.x = sin(u_xlat6.x);
					    u_xlat2.x = cos(u_xlat6.x);
					    u_xlat6.x = u_xlat3 * u_xlat2.x;
					    u_xlat3 = u_xlat3 * u_xlat1.x;
					    u_xlat3 = u_xlat0.x * u_xlat2.x + (-u_xlat3);
					    u_xlat0.x = u_xlat0.x * u_xlat1.x + u_xlat6.x;
					    u_xlat6.x = max(abs(u_xlat3), abs(u_xlat0.x));
					    u_xlat6.x = float(1.0) / u_xlat6.x;
					    u_xlat9 = min(abs(u_xlat3), abs(u_xlat0.x));
					    u_xlat6.x = u_xlat6.x * u_xlat9;
					    u_xlat9 = u_xlat6.x * u_xlat6.x;
					    u_xlat1.x = u_xlat9 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat9 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat9 * u_xlat1.x + -0.330299497;
					    u_xlat9 = u_xlat9 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat9 * u_xlat6.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					    u_xlatb4 = abs(u_xlat3)<abs(u_xlat0.x);
					    u_xlat1.x = u_xlatb4 ? u_xlat1.x : float(0.0);
					    u_xlat6.x = u_xlat6.x * u_xlat9 + u_xlat1.x;
					    u_xlatb9 = u_xlat3<(-u_xlat3);
					    u_xlat9 = u_xlatb9 ? -3.14159274 : float(0.0);
					    u_xlat6.x = u_xlat9 + u_xlat6.x;
					    u_xlat9 = min(u_xlat3, u_xlat0.x);
					    u_xlat0.x = max(u_xlat3, u_xlat0.x);
					    u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlatb3 = u_xlat9<(-u_xlat9);
					    u_xlatb0 = u_xlatb0 && u_xlatb3;
					    u_xlat0.x = (u_xlatb0) ? (-u_xlat6.x) : u_xlat6.x;
					    u_xlat6.x = u_xlat0.x * 0.159154937 + 0.5;
					    u_xlat0.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat1 = texture(_OutlineMaskTex, u_xlat6.xy);
					    u_xlat2 = (-_ColorOutlineBG) + _ColorOutlineFG;
					    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _ColorOutlineBG;
					    u_xlat6.x = log2(vs_TEXCOORD0.y);
					    u_xlat6.x = u_xlat6.x * _TilingPow;
					    u_xlat2.y = exp2(u_xlat6.x);
					    u_xlat2.x = vs_TEXCOORD0.x;
					    u_xlat6.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.y = _TilingSpeed * (-_Time.y);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 + (-vec4(vec4(_TilingOpacity, _TilingOpacity, _TilingOpacity, _TilingOpacity)));
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat2.x = _BuildupBGTime * _BuildupBGTime;
					    u_xlat0 = u_xlat2.xxxx * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = texture(_GradientTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2 = (-u_xlat0) * _ColorMiddle + u_xlat1;
					    u_xlat1.x = u_xlat1.w * vs_TEXCOORD3;
					    u_xlat0 = u_xlat0 * _ColorMiddle;
					    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _ColorBuildupBG.xyz;
					    u_xlat1.w = _ColorBuildupBG.w * u_xlat0.w + (-u_xlat0.w);
					    u_xlatb2 = _BuildupBGTime>=vs_TEXCOORD0.y;
					    u_xlat2.x = (u_xlatb2) ? 0.0 : 1.0;
					    SV_Target0 = u_xlat2.xxxx * u_xlat1 + u_xlat0;
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
						vec4 _ColorOutlineBG;
						vec4 _ColorOutlineFG;
						vec4 _ColorMiddle;
						vec4 unused_0_4;
						vec4 _OutlineMaskOffsetAndRatio;
						vec4 unused_0_6;
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 _MainTex_ST;
						vec4 unused_0_10;
						float _OutlineSpeed;
						float _TilingOpacity;
						float _TilingSpeed;
						float _TilingPow;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _OutlineMaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					float u_xlat3;
					bool u_xlatb3;
					bool u_xlatb4;
					vec2 u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy + vec2(-0.0, -0.5);
					    u_xlat0.xy = u_xlat0.xy + (-_OutlineMaskOffsetAndRatio.xy);
					    u_xlat3 = u_xlat0.y * _OutlineMaskOffsetAndRatio.z;
					    u_xlat6.x = _OutlineSpeed * _Time.y;
					    u_xlat1.x = sin(u_xlat6.x);
					    u_xlat2.x = cos(u_xlat6.x);
					    u_xlat6.x = u_xlat3 * u_xlat2.x;
					    u_xlat3 = u_xlat3 * u_xlat1.x;
					    u_xlat3 = u_xlat0.x * u_xlat2.x + (-u_xlat3);
					    u_xlat0.x = u_xlat0.x * u_xlat1.x + u_xlat6.x;
					    u_xlat6.x = max(abs(u_xlat3), abs(u_xlat0.x));
					    u_xlat6.x = float(1.0) / u_xlat6.x;
					    u_xlat9 = min(abs(u_xlat3), abs(u_xlat0.x));
					    u_xlat6.x = u_xlat6.x * u_xlat9;
					    u_xlat9 = u_xlat6.x * u_xlat6.x;
					    u_xlat1.x = u_xlat9 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat9 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat9 * u_xlat1.x + -0.330299497;
					    u_xlat9 = u_xlat9 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat9 * u_xlat6.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					    u_xlatb4 = abs(u_xlat3)<abs(u_xlat0.x);
					    u_xlat1.x = u_xlatb4 ? u_xlat1.x : float(0.0);
					    u_xlat6.x = u_xlat6.x * u_xlat9 + u_xlat1.x;
					    u_xlatb9 = u_xlat3<(-u_xlat3);
					    u_xlat9 = u_xlatb9 ? -3.14159274 : float(0.0);
					    u_xlat6.x = u_xlat9 + u_xlat6.x;
					    u_xlat9 = min(u_xlat3, u_xlat0.x);
					    u_xlat0.x = max(u_xlat3, u_xlat0.x);
					    u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlatb3 = u_xlat9<(-u_xlat9);
					    u_xlatb0 = u_xlatb0 && u_xlatb3;
					    u_xlat0.x = (u_xlatb0) ? (-u_xlat6.x) : u_xlat6.x;
					    u_xlat6.x = u_xlat0.x * 0.159154937 + 0.5;
					    u_xlat0.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat1 = texture(_OutlineMaskTex, u_xlat6.xy);
					    u_xlat2 = (-_ColorOutlineBG) + _ColorOutlineFG;
					    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _ColorOutlineBG;
					    u_xlat6.x = log2(vs_TEXCOORD0.y);
					    u_xlat6.x = u_xlat6.x * _TilingPow;
					    u_xlat2.y = exp2(u_xlat6.x);
					    u_xlat2.x = vs_TEXCOORD0.x;
					    u_xlat6.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.y = _TilingSpeed * (-_Time.y);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 + (-vec4(vec4(_TilingOpacity, _TilingOpacity, _TilingOpacity, _TilingOpacity)));
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat2.x = _BuildupBGTime * _BuildupBGTime;
					    u_xlat0 = u_xlat2.xxxx * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = texture(_GradientTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2 = (-u_xlat0) * _ColorMiddle + u_xlat1;
					    u_xlat1.x = u_xlat1.w * vs_TEXCOORD3;
					    u_xlat0 = u_xlat0 * _ColorMiddle;
					    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _ColorBuildupBG.xyz;
					    u_xlat1.w = _ColorBuildupBG.w * u_xlat0.w + (-u_xlat0.w);
					    u_xlatb2 = _BuildupBGTime>=vs_TEXCOORD0.y;
					    u_xlat2.x = (u_xlatb2) ? 0.0 : 1.0;
					    SV_Target0 = u_xlat2.xxxx * u_xlat1 + u_xlat0;
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
						vec4 _ColorOutlineBG;
						vec4 _ColorOutlineFG;
						vec4 _ColorMiddle;
						vec4 unused_0_4;
						vec4 _OutlineMaskOffsetAndRatio;
						vec4 unused_0_6;
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 _MainTex_ST;
						vec4 unused_0_10;
						float _OutlineSpeed;
						float _TilingOpacity;
						float _TilingSpeed;
						float _TilingPow;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _OutlineMaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					float u_xlat3;
					bool u_xlatb3;
					bool u_xlatb4;
					vec2 u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy + vec2(-0.0, -0.5);
					    u_xlat0.xy = u_xlat0.xy + (-_OutlineMaskOffsetAndRatio.xy);
					    u_xlat3 = u_xlat0.y * _OutlineMaskOffsetAndRatio.z;
					    u_xlat6.x = _OutlineSpeed * _Time.y;
					    u_xlat1.x = sin(u_xlat6.x);
					    u_xlat2.x = cos(u_xlat6.x);
					    u_xlat6.x = u_xlat3 * u_xlat2.x;
					    u_xlat3 = u_xlat3 * u_xlat1.x;
					    u_xlat3 = u_xlat0.x * u_xlat2.x + (-u_xlat3);
					    u_xlat0.x = u_xlat0.x * u_xlat1.x + u_xlat6.x;
					    u_xlat6.x = max(abs(u_xlat3), abs(u_xlat0.x));
					    u_xlat6.x = float(1.0) / u_xlat6.x;
					    u_xlat9 = min(abs(u_xlat3), abs(u_xlat0.x));
					    u_xlat6.x = u_xlat6.x * u_xlat9;
					    u_xlat9 = u_xlat6.x * u_xlat6.x;
					    u_xlat1.x = u_xlat9 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat9 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat9 * u_xlat1.x + -0.330299497;
					    u_xlat9 = u_xlat9 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat9 * u_xlat6.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					    u_xlatb4 = abs(u_xlat3)<abs(u_xlat0.x);
					    u_xlat1.x = u_xlatb4 ? u_xlat1.x : float(0.0);
					    u_xlat6.x = u_xlat6.x * u_xlat9 + u_xlat1.x;
					    u_xlatb9 = u_xlat3<(-u_xlat3);
					    u_xlat9 = u_xlatb9 ? -3.14159274 : float(0.0);
					    u_xlat6.x = u_xlat9 + u_xlat6.x;
					    u_xlat9 = min(u_xlat3, u_xlat0.x);
					    u_xlat0.x = max(u_xlat3, u_xlat0.x);
					    u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlatb3 = u_xlat9<(-u_xlat9);
					    u_xlatb0 = u_xlatb0 && u_xlatb3;
					    u_xlat0.x = (u_xlatb0) ? (-u_xlat6.x) : u_xlat6.x;
					    u_xlat6.x = u_xlat0.x * 0.159154937 + 0.5;
					    u_xlat0.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat1 = texture(_OutlineMaskTex, u_xlat6.xy);
					    u_xlat2 = (-_ColorOutlineBG) + _ColorOutlineFG;
					    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _ColorOutlineBG;
					    u_xlat6.x = log2(vs_TEXCOORD0.y);
					    u_xlat6.x = u_xlat6.x * _TilingPow;
					    u_xlat2.y = exp2(u_xlat6.x);
					    u_xlat2.x = vs_TEXCOORD0.x;
					    u_xlat6.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.y = _TilingSpeed * (-_Time.y);
					    u_xlat0.xy = u_xlat0.xy + u_xlat6.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 + (-vec4(vec4(_TilingOpacity, _TilingOpacity, _TilingOpacity, _TilingOpacity)));
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat2.x = _BuildupBGTime * _BuildupBGTime;
					    u_xlat0 = u_xlat2.xxxx * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = texture(_GradientTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2 = (-u_xlat0) * _ColorMiddle + u_xlat1;
					    u_xlat1.x = u_xlat1.w * vs_TEXCOORD3;
					    u_xlat0 = u_xlat0 * _ColorMiddle;
					    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _ColorBuildupBG.xyz;
					    u_xlat1.w = _ColorBuildupBG.w * u_xlat0.w + (-u_xlat0.w);
					    u_xlatb2 = _BuildupBGTime>=vs_TEXCOORD0.y;
					    u_xlat2.x = (u_xlatb2) ? 0.0 : 1.0;
					    SV_Target0 = u_xlat2.xxxx * u_xlat1 + u_xlat0;
					    return;
					}"
				}
			}
		}
	}
}