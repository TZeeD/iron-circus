Shader "SteelCircus/FX/Skills/AoePreviews/AoePutridDischargeShader" {
	Properties {
		_ColorMiddle ("Middle Color", Vector) = (1,1,1,1)
		[NoScaleOffset] _GradientTex ("Gradient Texture", 2D) = "white" {}
		_MinRadius ("Min Radius", Float) = 0.25
		_MaxRadius ("Max Radius", Float) = 6.5
		_Angle ("Angle", Float) = 90
		_OutlineWidth ("Outline Width (units!)", Float) = 0.1
		_OutlineSpeed ("Outline Speed (radians/sec!)", Float) = 1
		_NumTilesU ("Num Tiles U", Float) = 1
		_NumTilesV ("Num Tiles V", Float) = 1
		_Randomization ("Randomization", Vector) = (1.35232,1.54565,1.532697,1.229199)
		_BubbleDurationMin ("Bubble Min Duration", Float) = 0.5
		_BubbleDurationMax ("Bubble Max Duration", Float) = 0.5
		_BubbleParams ("Bubble params", Vector) = (1.75,2,0.5,0.5)
		_RandomizationPhase ("Bubble Phase Randomization", Vector) = (1.35232,1.54565,1.532697,1.229199)
		_Mask ("Mask out (percent)", Range(0, 1)) = 1
		_RandomizationMask ("Mask Randomization", Vector) = (1.35232,1.54565,1.532697,1.229199)
		_AnimIntensity ("Anim. Intensity", Range(0, 1)) = 0.2
		_AnimScale ("Global Anim. Scale", Range(0, 1)) = 1
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
			GpuProgramID 43156
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
						float _MinRadius;
						float _MaxRadius;
						float _Angle;
						float _OutlineWidth;
						vec4 unused_0_6[6];
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
					out vec3 vs_TEXCOORD1;
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
					    vs_TEXCOORD3 = u_xlat0.x;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.yyyy + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[9];
						float _BuildupBGTime;
						float _MinRadius;
						float _MaxRadius;
						float _Angle;
						float _OutlineWidth;
						vec4 unused_0_6[6];
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
					out vec3 vs_TEXCOORD1;
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
					    vs_TEXCOORD3 = u_xlat0.x;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.yyyy + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[9];
						float _BuildupBGTime;
						float _MinRadius;
						float _MaxRadius;
						float _Angle;
						float _OutlineWidth;
						vec4 unused_0_6[6];
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
					out vec3 vs_TEXCOORD1;
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
					    vs_TEXCOORD3 = u_xlat0.x;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.yyyy + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
						vec4 _ColorOutlineBG;
						vec4 _ColorOutlineFG;
						vec4 _ColorMiddle;
						vec4 unused_0_4;
						vec4 _OutlineMaskOffsetAndRatio;
						vec4 unused_0_6;
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 unused_0_9;
						float _OutlineSpeed;
						float _NumTilesU;
						float _NumTilesV;
						float _AnimIntensity;
						float _BubbleDurationMin;
						float _BubbleDurationMax;
						float _AnimScale;
						float _Mask;
						vec4 _Randomization;
						vec4 _RandomizationPhase;
						vec4 _BubbleParams;
						vec4 _RandomizationMask;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _OutlineMaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					float u_xlat3;
					vec2 u_xlat4;
					float u_xlat5;
					bool u_xlatb5;
					vec3 u_xlat6;
					bool u_xlatb6;
					bool u_xlatb7;
					vec2 u_xlat8;
					vec2 u_xlat10;
					bool u_xlatb10;
					float u_xlat11;
					float u_xlat12;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xz * unused_0_9.zw;
					    u_xlat0 = floor(u_xlat0.xyxy);
					    u_xlat1.x = dot(u_xlat0.zw, _RandomizationPhase.xy);
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
					    u_xlat1.x = _Time.y * _AnimScale + u_xlat1.x;
					    u_xlat6.x = dot(u_xlat0.zw, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat11 = (-_BubbleDurationMin) + _BubbleDurationMax;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat1.x = u_xlat1.x / u_xlat6.x;
					    u_xlat6.x = floor(u_xlat1.x);
					    u_xlat1.x = fract(u_xlat1.x);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _BubbleParams.w;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat16 = dot(u_xlat0.zw, _Randomization.xy);
					    u_xlat16 = u_xlat16 * _AnimIntensity + u_xlat6.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat2.x = u_xlat16 * 0.5 + u_xlat0.z;
					    u_xlat16 = dot(u_xlat0.wz, _Randomization.zw);
					    u_xlat16 = u_xlat16 * _AnimIntensity + u_xlat6.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat2.y = u_xlat16 * 0.5 + u_xlat0.w;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat16 = dot(u_xlat0.zw, _RandomizationMask.xy);
					    u_xlat6.x = u_xlat6.x + u_xlat16;
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlatb6 = u_xlat6.x<_Mask;
					    u_xlat6.xz = (bool(u_xlatb6)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat6.xz = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat6.xz;
					    u_xlat6.x = dot(u_xlat6.xz, u_xlat6.xz);
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat1.x = u_xlat1.x * _BubbleParams.x + u_xlat6.x;
					    u_xlat2 = u_xlat0.zwzw + vec4(-1.0, 0.0, 0.0, -1.0);
					    u_xlat6.x = dot(u_xlat2.xy, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.xy, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat3 = _AnimScale * _Time.y;
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat8.x = dot(u_xlat2.xy, _Randomization.xy);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.x = u_xlat8.x * 0.5 + u_xlat2.x;
					    u_xlat8.x = dot(u_xlat2.yx, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.y = u_xlat8.x * 0.5 + u_xlat2.y;
					    u_xlat8.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat2.x = dot(u_xlat2.xy, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat2.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat8.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat6.x = dot(u_xlat2.zw, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.zw, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat2.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat2.x = u_xlat2.x * _AnimIntensity + u_xlat16;
					    u_xlat2.x = sin(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 0.5 + u_xlat2.z;
					    u_xlat8.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat2.y = u_xlat8.x * 0.5 + u_xlat2.w;
					    u_xlat12 = dot(u_xlat2.zw, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat12;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat2 = u_xlat0.zwzw + vec4(-1.0, -1.0, 1.0, 0.0);
					    u_xlat6.x = dot(u_xlat2.xy, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.xy, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat8.x = dot(u_xlat2.xy, _Randomization.xy);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.x = u_xlat8.x * 0.5 + u_xlat2.x;
					    u_xlat8.x = dot(u_xlat2.yx, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.y = u_xlat8.x * 0.5 + u_xlat2.y;
					    u_xlat8.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat2.x = dot(u_xlat2.xy, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat2.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat8.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat6.x = dot(u_xlat2.zw, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.zw, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat2.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat2.x = u_xlat2.x * _AnimIntensity + u_xlat16;
					    u_xlat2.x = sin(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 0.5 + u_xlat2.z;
					    u_xlat8.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat2.y = u_xlat8.x * 0.5 + u_xlat2.w;
					    u_xlat12 = dot(u_xlat2.zw, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat12;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat2 = u_xlat0.zwzw + vec4(0.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 + vec4(-1.0, 1.0, 1.0, -1.0);
					    u_xlat6.x = dot(u_xlat2.xy, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.xy, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat8.x = dot(u_xlat2.xy, _Randomization.xy);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.x = u_xlat8.x * 0.5 + u_xlat2.x;
					    u_xlat8.x = dot(u_xlat2.yx, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.y = u_xlat8.x * 0.5 + u_xlat2.y;
					    u_xlat8.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat2.x = dot(u_xlat2.xy, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat2.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat8.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat6.x = dot(u_xlat2.zw, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.zw, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat2.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat2.x = u_xlat2.x * _AnimIntensity + u_xlat16;
					    u_xlat2.x = sin(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 0.5 + u_xlat2.z;
					    u_xlat8.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat2.y = u_xlat8.x * 0.5 + u_xlat2.w;
					    u_xlat12 = dot(u_xlat2.zw, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat12;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat6.x = dot(u_xlat0.xy, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat0.xy, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat2.x = dot(u_xlat0.xy, _Randomization.xy);
					    u_xlat2.x = u_xlat2.x * _AnimIntensity + u_xlat16;
					    u_xlat2.x = sin(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 0.5 + u_xlat0.x;
					    u_xlat12 = dot(u_xlat0.yx, _Randomization.zw);
					    u_xlat12 = u_xlat12 * _AnimIntensity + u_xlat16;
					    u_xlat12 = sin(u_xlat12);
					    u_xlat2.y = u_xlat12 * 0.5 + u_xlat0.y;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat0.x = dot(u_xlat0.xy, _RandomizationMask.xy);
					    u_xlat0.x = u_xlat16 + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
					    u_xlatb0 = u_xlat0.x<_Mask;
					    u_xlat0.xy = (bool(u_xlatb0)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat0.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat0.xy;
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat6.x * _BubbleParams.x + u_xlat0.x;
					    u_xlatb5 = u_xlat0.x<u_xlat1.x;
					    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : u_xlat1.x;
					    u_xlat5 = dot(u_xlat0.zw, _RandomizationPhase.zw);
					    u_xlat5 = sin(u_xlat5);
					    u_xlat5 = u_xlat5 * 0.5 + 0.5;
					    u_xlat5 = u_xlat5 * u_xlat11 + _BubbleDurationMin;
					    u_xlat1.x = dot(u_xlat0.zw, _RandomizationPhase.xy);
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 0.5 + u_xlat3;
					    u_xlat1.x = u_xlat1.x + 0.5;
					    u_xlat5 = u_xlat1.x / u_xlat5;
					    u_xlat1.x = floor(u_xlat5);
					    u_xlat5 = fract(u_xlat5);
					    u_xlat5 = log2(u_xlat5);
					    u_xlat5 = u_xlat5 * _BubbleParams.w;
					    u_xlat5 = exp2(u_xlat5);
					    u_xlat5 = (-u_xlat5) + 1.0;
					    u_xlat6.x = dot(u_xlat0.zw, _Randomization.xy);
					    u_xlat6.x = u_xlat6.x * _AnimIntensity + u_xlat1.x;
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat2.x = u_xlat6.x * 0.5 + u_xlat0.z;
					    u_xlat6.x = dot(u_xlat0.wz, _Randomization.zw);
					    u_xlat6.x = u_xlat6.x * _AnimIntensity + u_xlat1.x;
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat2.y = u_xlat6.x * 0.5 + u_xlat0.w;
					    u_xlat10.x = dot(u_xlat0.zw, _RandomizationMask.xy);
					    u_xlat10.x = u_xlat1.x + u_xlat10.x;
					    u_xlat10.x = sin(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * 0.5 + 0.5;
					    u_xlatb10 = u_xlat10.x<_Mask;
					    u_xlat1.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat10.xy = (bool(u_xlatb10)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat1.xy);
					    u_xlat10.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat10.xy;
					    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat5 = u_xlat5 * _BubbleParams.x + u_xlat10.x;
					    u_xlatb10 = u_xlat5<u_xlat0.x;
					    u_xlat0.x = (u_xlatb10) ? u_xlat5 : u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _BubbleParams.y;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1 = texture(_GradientTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat1 * _ColorMiddle;
					    u_xlat1 = (-u_xlat1) * _ColorMiddle + _ColorMiddle;
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
					    u_xlat1.xy = vs_TEXCOORD2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy + vec2(-0.0, -0.5);
					    u_xlat1.xy = u_xlat1.xy + (-_OutlineMaskOffsetAndRatio.xy);
					    u_xlat6.x = u_xlat1.y * _OutlineMaskOffsetAndRatio.z;
					    u_xlat11 = unused_0_9.y * _Time.y;
					    u_xlat2.x = sin(u_xlat11);
					    u_xlat3 = cos(u_xlat11);
					    u_xlat11 = u_xlat6.x * u_xlat3;
					    u_xlat6.x = u_xlat6.x * u_xlat2.x;
					    u_xlat6.x = u_xlat1.x * u_xlat3 + (-u_xlat6.x);
					    u_xlat1.x = u_xlat1.x * u_xlat2.x + u_xlat11;
					    u_xlat11 = max(abs(u_xlat6.x), abs(u_xlat1.x));
					    u_xlat11 = float(1.0) / u_xlat11;
					    u_xlat16 = min(abs(u_xlat6.x), abs(u_xlat1.x));
					    u_xlat11 = u_xlat11 * u_xlat16;
					    u_xlat16 = u_xlat11 * u_xlat11;
					    u_xlat2.x = u_xlat16 * 0.0208350997 + -0.0851330012;
					    u_xlat2.x = u_xlat16 * u_xlat2.x + 0.180141002;
					    u_xlat2.x = u_xlat16 * u_xlat2.x + -0.330299497;
					    u_xlat16 = u_xlat16 * u_xlat2.x + 0.999866009;
					    u_xlat2.x = u_xlat16 * u_xlat11;
					    u_xlat2.x = u_xlat2.x * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat6.x)<abs(u_xlat1.x);
					    u_xlat2.x = u_xlatb7 ? u_xlat2.x : float(0.0);
					    u_xlat11 = u_xlat11 * u_xlat16 + u_xlat2.x;
					    u_xlatb16 = u_xlat6.x<(-u_xlat6.x);
					    u_xlat16 = u_xlatb16 ? -3.14159274 : float(0.0);
					    u_xlat11 = u_xlat16 + u_xlat11;
					    u_xlat16 = min(u_xlat6.x, u_xlat1.x);
					    u_xlat1.x = max(u_xlat6.x, u_xlat1.x);
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					    u_xlatb6 = u_xlat16<(-u_xlat16);
					    u_xlatb1 = u_xlatb1 && u_xlatb6;
					    u_xlat1.x = (u_xlatb1) ? (-u_xlat11) : u_xlat11;
					    u_xlat1.x = u_xlat1.x * 0.159154937 + 0.5;
					    u_xlat1.y = 0.0;
					    u_xlat1 = texture(_OutlineMaskTex, u_xlat1.xy);
					    u_xlat2 = (-_ColorOutlineBG) + _ColorOutlineFG;
					    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _ColorOutlineBG;
					    u_xlat2 = (-u_xlat0) + u_xlat1;
					    u_xlat1.x = u_xlat1.w * vs_TEXCOORD3;
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
						vec4 unused_0_9;
						float _OutlineSpeed;
						float _NumTilesU;
						float _NumTilesV;
						float _AnimIntensity;
						float _BubbleDurationMin;
						float _BubbleDurationMax;
						float _AnimScale;
						float _Mask;
						vec4 _Randomization;
						vec4 _RandomizationPhase;
						vec4 _BubbleParams;
						vec4 _RandomizationMask;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _OutlineMaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					float u_xlat3;
					vec2 u_xlat4;
					float u_xlat5;
					bool u_xlatb5;
					vec3 u_xlat6;
					bool u_xlatb6;
					bool u_xlatb7;
					vec2 u_xlat8;
					vec2 u_xlat10;
					bool u_xlatb10;
					float u_xlat11;
					float u_xlat12;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xz * unused_0_9.zw;
					    u_xlat0 = floor(u_xlat0.xyxy);
					    u_xlat1.x = dot(u_xlat0.zw, _RandomizationPhase.xy);
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
					    u_xlat1.x = _Time.y * _AnimScale + u_xlat1.x;
					    u_xlat6.x = dot(u_xlat0.zw, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat11 = (-_BubbleDurationMin) + _BubbleDurationMax;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat1.x = u_xlat1.x / u_xlat6.x;
					    u_xlat6.x = floor(u_xlat1.x);
					    u_xlat1.x = fract(u_xlat1.x);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _BubbleParams.w;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat16 = dot(u_xlat0.zw, _Randomization.xy);
					    u_xlat16 = u_xlat16 * _AnimIntensity + u_xlat6.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat2.x = u_xlat16 * 0.5 + u_xlat0.z;
					    u_xlat16 = dot(u_xlat0.wz, _Randomization.zw);
					    u_xlat16 = u_xlat16 * _AnimIntensity + u_xlat6.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat2.y = u_xlat16 * 0.5 + u_xlat0.w;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat16 = dot(u_xlat0.zw, _RandomizationMask.xy);
					    u_xlat6.x = u_xlat6.x + u_xlat16;
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlatb6 = u_xlat6.x<_Mask;
					    u_xlat6.xz = (bool(u_xlatb6)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat6.xz = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat6.xz;
					    u_xlat6.x = dot(u_xlat6.xz, u_xlat6.xz);
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat1.x = u_xlat1.x * _BubbleParams.x + u_xlat6.x;
					    u_xlat2 = u_xlat0.zwzw + vec4(-1.0, 0.0, 0.0, -1.0);
					    u_xlat6.x = dot(u_xlat2.xy, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.xy, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat3 = _AnimScale * _Time.y;
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat8.x = dot(u_xlat2.xy, _Randomization.xy);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.x = u_xlat8.x * 0.5 + u_xlat2.x;
					    u_xlat8.x = dot(u_xlat2.yx, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.y = u_xlat8.x * 0.5 + u_xlat2.y;
					    u_xlat8.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat2.x = dot(u_xlat2.xy, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat2.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat8.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat6.x = dot(u_xlat2.zw, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.zw, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat2.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat2.x = u_xlat2.x * _AnimIntensity + u_xlat16;
					    u_xlat2.x = sin(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 0.5 + u_xlat2.z;
					    u_xlat8.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat2.y = u_xlat8.x * 0.5 + u_xlat2.w;
					    u_xlat12 = dot(u_xlat2.zw, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat12;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat2 = u_xlat0.zwzw + vec4(-1.0, -1.0, 1.0, 0.0);
					    u_xlat6.x = dot(u_xlat2.xy, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.xy, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat8.x = dot(u_xlat2.xy, _Randomization.xy);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.x = u_xlat8.x * 0.5 + u_xlat2.x;
					    u_xlat8.x = dot(u_xlat2.yx, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.y = u_xlat8.x * 0.5 + u_xlat2.y;
					    u_xlat8.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat2.x = dot(u_xlat2.xy, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat2.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat8.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat6.x = dot(u_xlat2.zw, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.zw, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat2.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat2.x = u_xlat2.x * _AnimIntensity + u_xlat16;
					    u_xlat2.x = sin(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 0.5 + u_xlat2.z;
					    u_xlat8.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat2.y = u_xlat8.x * 0.5 + u_xlat2.w;
					    u_xlat12 = dot(u_xlat2.zw, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat12;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat2 = u_xlat0.zwzw + vec4(0.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 + vec4(-1.0, 1.0, 1.0, -1.0);
					    u_xlat6.x = dot(u_xlat2.xy, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.xy, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat8.x = dot(u_xlat2.xy, _Randomization.xy);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.x = u_xlat8.x * 0.5 + u_xlat2.x;
					    u_xlat8.x = dot(u_xlat2.yx, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.y = u_xlat8.x * 0.5 + u_xlat2.y;
					    u_xlat8.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat2.x = dot(u_xlat2.xy, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat2.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat8.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat6.x = dot(u_xlat2.zw, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.zw, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat2.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat2.x = u_xlat2.x * _AnimIntensity + u_xlat16;
					    u_xlat2.x = sin(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 0.5 + u_xlat2.z;
					    u_xlat8.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat2.y = u_xlat8.x * 0.5 + u_xlat2.w;
					    u_xlat12 = dot(u_xlat2.zw, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat12;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat6.x = dot(u_xlat0.xy, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat0.xy, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat2.x = dot(u_xlat0.xy, _Randomization.xy);
					    u_xlat2.x = u_xlat2.x * _AnimIntensity + u_xlat16;
					    u_xlat2.x = sin(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 0.5 + u_xlat0.x;
					    u_xlat12 = dot(u_xlat0.yx, _Randomization.zw);
					    u_xlat12 = u_xlat12 * _AnimIntensity + u_xlat16;
					    u_xlat12 = sin(u_xlat12);
					    u_xlat2.y = u_xlat12 * 0.5 + u_xlat0.y;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat0.x = dot(u_xlat0.xy, _RandomizationMask.xy);
					    u_xlat0.x = u_xlat16 + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
					    u_xlatb0 = u_xlat0.x<_Mask;
					    u_xlat0.xy = (bool(u_xlatb0)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat0.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat0.xy;
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat6.x * _BubbleParams.x + u_xlat0.x;
					    u_xlatb5 = u_xlat0.x<u_xlat1.x;
					    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : u_xlat1.x;
					    u_xlat5 = dot(u_xlat0.zw, _RandomizationPhase.zw);
					    u_xlat5 = sin(u_xlat5);
					    u_xlat5 = u_xlat5 * 0.5 + 0.5;
					    u_xlat5 = u_xlat5 * u_xlat11 + _BubbleDurationMin;
					    u_xlat1.x = dot(u_xlat0.zw, _RandomizationPhase.xy);
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 0.5 + u_xlat3;
					    u_xlat1.x = u_xlat1.x + 0.5;
					    u_xlat5 = u_xlat1.x / u_xlat5;
					    u_xlat1.x = floor(u_xlat5);
					    u_xlat5 = fract(u_xlat5);
					    u_xlat5 = log2(u_xlat5);
					    u_xlat5 = u_xlat5 * _BubbleParams.w;
					    u_xlat5 = exp2(u_xlat5);
					    u_xlat5 = (-u_xlat5) + 1.0;
					    u_xlat6.x = dot(u_xlat0.zw, _Randomization.xy);
					    u_xlat6.x = u_xlat6.x * _AnimIntensity + u_xlat1.x;
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat2.x = u_xlat6.x * 0.5 + u_xlat0.z;
					    u_xlat6.x = dot(u_xlat0.wz, _Randomization.zw);
					    u_xlat6.x = u_xlat6.x * _AnimIntensity + u_xlat1.x;
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat2.y = u_xlat6.x * 0.5 + u_xlat0.w;
					    u_xlat10.x = dot(u_xlat0.zw, _RandomizationMask.xy);
					    u_xlat10.x = u_xlat1.x + u_xlat10.x;
					    u_xlat10.x = sin(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * 0.5 + 0.5;
					    u_xlatb10 = u_xlat10.x<_Mask;
					    u_xlat1.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat10.xy = (bool(u_xlatb10)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat1.xy);
					    u_xlat10.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat10.xy;
					    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat5 = u_xlat5 * _BubbleParams.x + u_xlat10.x;
					    u_xlatb10 = u_xlat5<u_xlat0.x;
					    u_xlat0.x = (u_xlatb10) ? u_xlat5 : u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _BubbleParams.y;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1 = texture(_GradientTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat1 * _ColorMiddle;
					    u_xlat1 = (-u_xlat1) * _ColorMiddle + _ColorMiddle;
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
					    u_xlat1.xy = vs_TEXCOORD2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy + vec2(-0.0, -0.5);
					    u_xlat1.xy = u_xlat1.xy + (-_OutlineMaskOffsetAndRatio.xy);
					    u_xlat6.x = u_xlat1.y * _OutlineMaskOffsetAndRatio.z;
					    u_xlat11 = unused_0_9.y * _Time.y;
					    u_xlat2.x = sin(u_xlat11);
					    u_xlat3 = cos(u_xlat11);
					    u_xlat11 = u_xlat6.x * u_xlat3;
					    u_xlat6.x = u_xlat6.x * u_xlat2.x;
					    u_xlat6.x = u_xlat1.x * u_xlat3 + (-u_xlat6.x);
					    u_xlat1.x = u_xlat1.x * u_xlat2.x + u_xlat11;
					    u_xlat11 = max(abs(u_xlat6.x), abs(u_xlat1.x));
					    u_xlat11 = float(1.0) / u_xlat11;
					    u_xlat16 = min(abs(u_xlat6.x), abs(u_xlat1.x));
					    u_xlat11 = u_xlat11 * u_xlat16;
					    u_xlat16 = u_xlat11 * u_xlat11;
					    u_xlat2.x = u_xlat16 * 0.0208350997 + -0.0851330012;
					    u_xlat2.x = u_xlat16 * u_xlat2.x + 0.180141002;
					    u_xlat2.x = u_xlat16 * u_xlat2.x + -0.330299497;
					    u_xlat16 = u_xlat16 * u_xlat2.x + 0.999866009;
					    u_xlat2.x = u_xlat16 * u_xlat11;
					    u_xlat2.x = u_xlat2.x * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat6.x)<abs(u_xlat1.x);
					    u_xlat2.x = u_xlatb7 ? u_xlat2.x : float(0.0);
					    u_xlat11 = u_xlat11 * u_xlat16 + u_xlat2.x;
					    u_xlatb16 = u_xlat6.x<(-u_xlat6.x);
					    u_xlat16 = u_xlatb16 ? -3.14159274 : float(0.0);
					    u_xlat11 = u_xlat16 + u_xlat11;
					    u_xlat16 = min(u_xlat6.x, u_xlat1.x);
					    u_xlat1.x = max(u_xlat6.x, u_xlat1.x);
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					    u_xlatb6 = u_xlat16<(-u_xlat16);
					    u_xlatb1 = u_xlatb1 && u_xlatb6;
					    u_xlat1.x = (u_xlatb1) ? (-u_xlat11) : u_xlat11;
					    u_xlat1.x = u_xlat1.x * 0.159154937 + 0.5;
					    u_xlat1.y = 0.0;
					    u_xlat1 = texture(_OutlineMaskTex, u_xlat1.xy);
					    u_xlat2 = (-_ColorOutlineBG) + _ColorOutlineFG;
					    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _ColorOutlineBG;
					    u_xlat2 = (-u_xlat0) + u_xlat1;
					    u_xlat1.x = u_xlat1.w * vs_TEXCOORD3;
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
						vec4 unused_0_9;
						float _OutlineSpeed;
						float _NumTilesU;
						float _NumTilesV;
						float _AnimIntensity;
						float _BubbleDurationMin;
						float _BubbleDurationMax;
						float _AnimScale;
						float _Mask;
						vec4 _Randomization;
						vec4 _RandomizationPhase;
						vec4 _BubbleParams;
						vec4 _RandomizationMask;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _OutlineMaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					float u_xlat3;
					vec2 u_xlat4;
					float u_xlat5;
					bool u_xlatb5;
					vec3 u_xlat6;
					bool u_xlatb6;
					bool u_xlatb7;
					vec2 u_xlat8;
					vec2 u_xlat10;
					bool u_xlatb10;
					float u_xlat11;
					float u_xlat12;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xz * unused_0_9.zw;
					    u_xlat0 = floor(u_xlat0.xyxy);
					    u_xlat1.x = dot(u_xlat0.zw, _RandomizationPhase.xy);
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 0.5 + 0.5;
					    u_xlat1.x = _Time.y * _AnimScale + u_xlat1.x;
					    u_xlat6.x = dot(u_xlat0.zw, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat11 = (-_BubbleDurationMin) + _BubbleDurationMax;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat1.x = u_xlat1.x / u_xlat6.x;
					    u_xlat6.x = floor(u_xlat1.x);
					    u_xlat1.x = fract(u_xlat1.x);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _BubbleParams.w;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat16 = dot(u_xlat0.zw, _Randomization.xy);
					    u_xlat16 = u_xlat16 * _AnimIntensity + u_xlat6.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat2.x = u_xlat16 * 0.5 + u_xlat0.z;
					    u_xlat16 = dot(u_xlat0.wz, _Randomization.zw);
					    u_xlat16 = u_xlat16 * _AnimIntensity + u_xlat6.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat2.y = u_xlat16 * 0.5 + u_xlat0.w;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat16 = dot(u_xlat0.zw, _RandomizationMask.xy);
					    u_xlat6.x = u_xlat6.x + u_xlat16;
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlatb6 = u_xlat6.x<_Mask;
					    u_xlat6.xz = (bool(u_xlatb6)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat6.xz = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat6.xz;
					    u_xlat6.x = dot(u_xlat6.xz, u_xlat6.xz);
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat1.x = u_xlat1.x * _BubbleParams.x + u_xlat6.x;
					    u_xlat2 = u_xlat0.zwzw + vec4(-1.0, 0.0, 0.0, -1.0);
					    u_xlat6.x = dot(u_xlat2.xy, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.xy, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat3 = _AnimScale * _Time.y;
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat8.x = dot(u_xlat2.xy, _Randomization.xy);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.x = u_xlat8.x * 0.5 + u_xlat2.x;
					    u_xlat8.x = dot(u_xlat2.yx, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.y = u_xlat8.x * 0.5 + u_xlat2.y;
					    u_xlat8.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat2.x = dot(u_xlat2.xy, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat2.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat8.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat6.x = dot(u_xlat2.zw, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.zw, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat2.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat2.x = u_xlat2.x * _AnimIntensity + u_xlat16;
					    u_xlat2.x = sin(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 0.5 + u_xlat2.z;
					    u_xlat8.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat2.y = u_xlat8.x * 0.5 + u_xlat2.w;
					    u_xlat12 = dot(u_xlat2.zw, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat12;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat2 = u_xlat0.zwzw + vec4(-1.0, -1.0, 1.0, 0.0);
					    u_xlat6.x = dot(u_xlat2.xy, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.xy, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat8.x = dot(u_xlat2.xy, _Randomization.xy);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.x = u_xlat8.x * 0.5 + u_xlat2.x;
					    u_xlat8.x = dot(u_xlat2.yx, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.y = u_xlat8.x * 0.5 + u_xlat2.y;
					    u_xlat8.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat2.x = dot(u_xlat2.xy, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat2.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat8.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat6.x = dot(u_xlat2.zw, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.zw, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat2.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat2.x = u_xlat2.x * _AnimIntensity + u_xlat16;
					    u_xlat2.x = sin(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 0.5 + u_xlat2.z;
					    u_xlat8.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat2.y = u_xlat8.x * 0.5 + u_xlat2.w;
					    u_xlat12 = dot(u_xlat2.zw, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat12;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat2 = u_xlat0.zwzw + vec4(0.0, 1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat0 + vec4(-1.0, 1.0, 1.0, -1.0);
					    u_xlat6.x = dot(u_xlat2.xy, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.xy, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat8.x = dot(u_xlat2.xy, _Randomization.xy);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.x = u_xlat8.x * 0.5 + u_xlat2.x;
					    u_xlat8.x = dot(u_xlat2.yx, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat4.y = u_xlat8.x * 0.5 + u_xlat2.y;
					    u_xlat8.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat2.x = dot(u_xlat2.xy, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat2.x;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat8.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat6.x = dot(u_xlat2.zw, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat2.zw, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat2.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat2.x = u_xlat2.x * _AnimIntensity + u_xlat16;
					    u_xlat2.x = sin(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 0.5 + u_xlat2.z;
					    u_xlat8.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat8.x = u_xlat8.x * _AnimIntensity + u_xlat16;
					    u_xlat8.x = sin(u_xlat8.x);
					    u_xlat2.y = u_xlat8.x * 0.5 + u_xlat2.w;
					    u_xlat12 = dot(u_xlat2.zw, _RandomizationMask.xy);
					    u_xlat16 = u_xlat16 + u_xlat12;
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + 0.5;
					    u_xlatb16 = u_xlat16<_Mask;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat2.xy = (bool(u_xlatb16)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat2.xy;
					    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat16 = sqrt(u_xlat16);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.x + u_xlat16;
					    u_xlatb16 = u_xlat6.x<u_xlat1.x;
					    u_xlat1.x = (u_xlatb16) ? u_xlat6.x : u_xlat1.x;
					    u_xlat6.x = dot(u_xlat0.xy, _RandomizationPhase.zw);
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * 0.5 + 0.5;
					    u_xlat6.x = u_xlat6.x * u_xlat11 + _BubbleDurationMin;
					    u_xlat16 = dot(u_xlat0.xy, _RandomizationPhase.xy);
					    u_xlat16 = sin(u_xlat16);
					    u_xlat16 = u_xlat16 * 0.5 + u_xlat3;
					    u_xlat16 = u_xlat16 + 0.5;
					    u_xlat6.x = u_xlat16 / u_xlat6.x;
					    u_xlat16 = floor(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _BubbleParams.w;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat2.x = dot(u_xlat0.xy, _Randomization.xy);
					    u_xlat2.x = u_xlat2.x * _AnimIntensity + u_xlat16;
					    u_xlat2.x = sin(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 0.5 + u_xlat0.x;
					    u_xlat12 = dot(u_xlat0.yx, _Randomization.zw);
					    u_xlat12 = u_xlat12 * _AnimIntensity + u_xlat16;
					    u_xlat12 = sin(u_xlat12);
					    u_xlat2.y = u_xlat12 * 0.5 + u_xlat0.y;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat0.x = dot(u_xlat0.xy, _RandomizationMask.xy);
					    u_xlat0.x = u_xlat16 + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
					    u_xlatb0 = u_xlat0.x<_Mask;
					    u_xlat0.xy = (bool(u_xlatb0)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat2.xy);
					    u_xlat0.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat0.xy;
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat6.x * _BubbleParams.x + u_xlat0.x;
					    u_xlatb5 = u_xlat0.x<u_xlat1.x;
					    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : u_xlat1.x;
					    u_xlat5 = dot(u_xlat0.zw, _RandomizationPhase.zw);
					    u_xlat5 = sin(u_xlat5);
					    u_xlat5 = u_xlat5 * 0.5 + 0.5;
					    u_xlat5 = u_xlat5 * u_xlat11 + _BubbleDurationMin;
					    u_xlat1.x = dot(u_xlat0.zw, _RandomizationPhase.xy);
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 0.5 + u_xlat3;
					    u_xlat1.x = u_xlat1.x + 0.5;
					    u_xlat5 = u_xlat1.x / u_xlat5;
					    u_xlat1.x = floor(u_xlat5);
					    u_xlat5 = fract(u_xlat5);
					    u_xlat5 = log2(u_xlat5);
					    u_xlat5 = u_xlat5 * _BubbleParams.w;
					    u_xlat5 = exp2(u_xlat5);
					    u_xlat5 = (-u_xlat5) + 1.0;
					    u_xlat6.x = dot(u_xlat0.zw, _Randomization.xy);
					    u_xlat6.x = u_xlat6.x * _AnimIntensity + u_xlat1.x;
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat2.x = u_xlat6.x * 0.5 + u_xlat0.z;
					    u_xlat6.x = dot(u_xlat0.wz, _Randomization.zw);
					    u_xlat6.x = u_xlat6.x * _AnimIntensity + u_xlat1.x;
					    u_xlat6.x = sin(u_xlat6.x);
					    u_xlat2.y = u_xlat6.x * 0.5 + u_xlat0.w;
					    u_xlat10.x = dot(u_xlat0.zw, _RandomizationMask.xy);
					    u_xlat10.x = u_xlat1.x + u_xlat10.x;
					    u_xlat10.x = sin(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * 0.5 + 0.5;
					    u_xlatb10 = u_xlat10.x<_Mask;
					    u_xlat1.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat10.xy = (bool(u_xlatb10)) ? vec2(-9999999.0, -9999999.0) : (-u_xlat1.xy);
					    u_xlat10.xy = vs_TEXCOORD1.xz * unused_0_9.zw + u_xlat10.xy;
					    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat5 = u_xlat5 * _BubbleParams.x + u_xlat10.x;
					    u_xlatb10 = u_xlat5<u_xlat0.x;
					    u_xlat0.x = (u_xlatb10) ? u_xlat5 : u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _BubbleParams.y;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1 = texture(_GradientTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat1 * _ColorMiddle;
					    u_xlat1 = (-u_xlat1) * _ColorMiddle + _ColorMiddle;
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
					    u_xlat1.xy = vs_TEXCOORD2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.xy = u_xlat1.xy + vec2(-0.0, -0.5);
					    u_xlat1.xy = u_xlat1.xy + (-_OutlineMaskOffsetAndRatio.xy);
					    u_xlat6.x = u_xlat1.y * _OutlineMaskOffsetAndRatio.z;
					    u_xlat11 = unused_0_9.y * _Time.y;
					    u_xlat2.x = sin(u_xlat11);
					    u_xlat3 = cos(u_xlat11);
					    u_xlat11 = u_xlat6.x * u_xlat3;
					    u_xlat6.x = u_xlat6.x * u_xlat2.x;
					    u_xlat6.x = u_xlat1.x * u_xlat3 + (-u_xlat6.x);
					    u_xlat1.x = u_xlat1.x * u_xlat2.x + u_xlat11;
					    u_xlat11 = max(abs(u_xlat6.x), abs(u_xlat1.x));
					    u_xlat11 = float(1.0) / u_xlat11;
					    u_xlat16 = min(abs(u_xlat6.x), abs(u_xlat1.x));
					    u_xlat11 = u_xlat11 * u_xlat16;
					    u_xlat16 = u_xlat11 * u_xlat11;
					    u_xlat2.x = u_xlat16 * 0.0208350997 + -0.0851330012;
					    u_xlat2.x = u_xlat16 * u_xlat2.x + 0.180141002;
					    u_xlat2.x = u_xlat16 * u_xlat2.x + -0.330299497;
					    u_xlat16 = u_xlat16 * u_xlat2.x + 0.999866009;
					    u_xlat2.x = u_xlat16 * u_xlat11;
					    u_xlat2.x = u_xlat2.x * -2.0 + 1.57079637;
					    u_xlatb7 = abs(u_xlat6.x)<abs(u_xlat1.x);
					    u_xlat2.x = u_xlatb7 ? u_xlat2.x : float(0.0);
					    u_xlat11 = u_xlat11 * u_xlat16 + u_xlat2.x;
					    u_xlatb16 = u_xlat6.x<(-u_xlat6.x);
					    u_xlat16 = u_xlatb16 ? -3.14159274 : float(0.0);
					    u_xlat11 = u_xlat16 + u_xlat11;
					    u_xlat16 = min(u_xlat6.x, u_xlat1.x);
					    u_xlat1.x = max(u_xlat6.x, u_xlat1.x);
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					    u_xlatb6 = u_xlat16<(-u_xlat16);
					    u_xlatb1 = u_xlatb1 && u_xlatb6;
					    u_xlat1.x = (u_xlatb1) ? (-u_xlat11) : u_xlat11;
					    u_xlat1.x = u_xlat1.x * 0.159154937 + 0.5;
					    u_xlat1.y = 0.0;
					    u_xlat1 = texture(_OutlineMaskTex, u_xlat1.xy);
					    u_xlat2 = (-_ColorOutlineBG) + _ColorOutlineFG;
					    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _ColorOutlineBG;
					    u_xlat2 = (-u_xlat0) + u_xlat1;
					    u_xlat1.x = u_xlat1.w * vs_TEXCOORD3;
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