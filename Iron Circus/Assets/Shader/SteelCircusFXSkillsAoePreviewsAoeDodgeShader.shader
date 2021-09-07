Shader "SteelCircus/FX/Skills/AoePreviews/AoeDodgeShader" {
	Properties {
		[NoScaleOffset] _MainTex ("Gradient (1D, inner to outer)", 2D) = "white" {}
		_AspectRatio ("Aspect Ratio (z Scale / x Scale", Float) = 2
		_InnerAnimation ("Animation of inner circle (time)", Range(0, 1)) = 0
		_OutlineWidth ("Outline Width (percent of radius)", Range(0, 1)) = 0.01
		_ColorMiddle ("Middle Color", Vector) = (1,1,1,1)
		_ColorDark ("Dark Color", Vector) = (1,1,1,1)
		_ColorOutline ("Outline Color", Vector) = (1,1,1,1)
		_ColorBuildupBG ("Buildup BG Color", Vector) = (1,0,0,1)
		_BuildupBGTime ("Buildup Time", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 58466
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
						vec4 unused_0_0[4];
						vec4 _ColorMiddle;
						vec4 _ColorDark;
						vec4 unused_0_3[3];
						float _AspectRatio;
						float _OutlineWidth;
						float _InnerAnimation;
						vec4 _ColorOutline;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat14;
					float u_xlat15;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat1.x = 2.0;
					    u_xlat1.y = _AspectRatio;
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
					    u_xlat0.z = u_xlat0.y * 2.0;
					    u_xlat1.y = 0.0;
					    u_xlat1.xz = vec2(vec2(_AspectRatio, _AspectRatio)) + vec2(-1.0, -1.0);
					    u_xlat8.xy = abs(u_xlat0.xz) + (-u_xlat1.yz);
					    u_xlat21 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat21 = sqrt(u_xlat21);
					    u_xlatb8 = abs(u_xlat0.z)>=u_xlat1.x;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat21 = -abs(u_xlat0.x) + u_xlat21;
					    u_xlat2.x = u_xlat8.x * u_xlat21 + abs(u_xlat0.x);
					    u_xlatb21 = 1.0<u_xlat2.x;
					    if(((int(u_xlatb21) * int(0xffffffffu)))!=0){discard;}
					    u_xlat7 = u_xlat0.y + u_xlat0.y;
					    u_xlat2.y = 0.0;
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat4 = u_xlat3 * _ColorDark;
					    u_xlat21 = _InnerAnimation + _InnerAnimation;
					    u_xlat8.x = _InnerAnimation * 2.0 + -1.0;
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					    u_xlat15 = u_xlat1.x + u_xlat1.x;
					    u_xlat5.w = u_xlat8.x * u_xlat15 + (-u_xlat1.x);
					    u_xlat21 = u_xlat21;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat5.y = u_xlat21 * u_xlat15 + (-u_xlat1.x);
					    u_xlat5.x = float(0.0);
					    u_xlat5.z = float(0.0);
					    u_xlat6 = u_xlat0.xzxz + (-u_xlat5);
					    u_xlat14 = dot(u_xlat6.xy, u_xlat6.xy);
					    u_xlat14 = sqrt(u_xlat14);
					    u_xlatb21 = u_xlat7>=u_xlat5.y;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = -abs(u_xlat0.x) + u_xlat14;
					    u_xlat0.x = u_xlat21 * u_xlat14 + abs(u_xlat0.x);
					    u_xlat14 = dot(u_xlat6.zw, u_xlat6.zw);
					    u_xlat14 = sqrt(u_xlat14);
					    u_xlatb7 = u_xlat5.w>=u_xlat7;
					    u_xlat7 = u_xlatb7 ? 1.0 : float(0.0);
					    u_xlat14 = (-u_xlat0.x) + u_xlat14;
					    u_xlat0.x = u_xlat7 * u_xlat14 + u_xlat0.x;
					    u_xlatb0 = 1.0>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat3 = (-u_xlat3) * _ColorDark + _ColorMiddle;
					    u_xlat0 = u_xlat0.xxxx * u_xlat3 + u_xlat4;
					    u_xlat1.x = (-_OutlineWidth) + 1.0;
					    u_xlatb1 = u_xlat2.x>=u_xlat1.x;
					    u_xlat0 = (bool(u_xlatb1)) ? _ColorOutline : u_xlat0;
					    u_xlat1.x = u_xlat8.x * u_xlat8.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = (-u_xlat8.x) * u_xlat1.x + vs_TEXCOORD0.y;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    SV_Target0.w = u_xlat0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat0.xyz;
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
						vec4 _ColorMiddle;
						vec4 _ColorDark;
						vec4 unused_0_3[3];
						float _AspectRatio;
						float _OutlineWidth;
						float _InnerAnimation;
						vec4 _ColorOutline;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat14;
					float u_xlat15;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat1.x = 2.0;
					    u_xlat1.y = _AspectRatio;
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
					    u_xlat0.z = u_xlat0.y * 2.0;
					    u_xlat1.y = 0.0;
					    u_xlat1.xz = vec2(vec2(_AspectRatio, _AspectRatio)) + vec2(-1.0, -1.0);
					    u_xlat8.xy = abs(u_xlat0.xz) + (-u_xlat1.yz);
					    u_xlat21 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat21 = sqrt(u_xlat21);
					    u_xlatb8 = abs(u_xlat0.z)>=u_xlat1.x;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat21 = -abs(u_xlat0.x) + u_xlat21;
					    u_xlat2.x = u_xlat8.x * u_xlat21 + abs(u_xlat0.x);
					    u_xlatb21 = 1.0<u_xlat2.x;
					    if(((int(u_xlatb21) * int(0xffffffffu)))!=0){discard;}
					    u_xlat7 = u_xlat0.y + u_xlat0.y;
					    u_xlat2.y = 0.0;
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat4 = u_xlat3 * _ColorDark;
					    u_xlat21 = _InnerAnimation + _InnerAnimation;
					    u_xlat8.x = _InnerAnimation * 2.0 + -1.0;
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					    u_xlat15 = u_xlat1.x + u_xlat1.x;
					    u_xlat5.w = u_xlat8.x * u_xlat15 + (-u_xlat1.x);
					    u_xlat21 = u_xlat21;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat5.y = u_xlat21 * u_xlat15 + (-u_xlat1.x);
					    u_xlat5.x = float(0.0);
					    u_xlat5.z = float(0.0);
					    u_xlat6 = u_xlat0.xzxz + (-u_xlat5);
					    u_xlat14 = dot(u_xlat6.xy, u_xlat6.xy);
					    u_xlat14 = sqrt(u_xlat14);
					    u_xlatb21 = u_xlat7>=u_xlat5.y;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = -abs(u_xlat0.x) + u_xlat14;
					    u_xlat0.x = u_xlat21 * u_xlat14 + abs(u_xlat0.x);
					    u_xlat14 = dot(u_xlat6.zw, u_xlat6.zw);
					    u_xlat14 = sqrt(u_xlat14);
					    u_xlatb7 = u_xlat5.w>=u_xlat7;
					    u_xlat7 = u_xlatb7 ? 1.0 : float(0.0);
					    u_xlat14 = (-u_xlat0.x) + u_xlat14;
					    u_xlat0.x = u_xlat7 * u_xlat14 + u_xlat0.x;
					    u_xlatb0 = 1.0>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat3 = (-u_xlat3) * _ColorDark + _ColorMiddle;
					    u_xlat0 = u_xlat0.xxxx * u_xlat3 + u_xlat4;
					    u_xlat1.x = (-_OutlineWidth) + 1.0;
					    u_xlatb1 = u_xlat2.x>=u_xlat1.x;
					    u_xlat0 = (bool(u_xlatb1)) ? _ColorOutline : u_xlat0;
					    u_xlat1.x = u_xlat8.x * u_xlat8.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = (-u_xlat8.x) * u_xlat1.x + vs_TEXCOORD0.y;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    SV_Target0.w = u_xlat0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat0.xyz;
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
						vec4 _ColorMiddle;
						vec4 _ColorDark;
						vec4 unused_0_3[3];
						float _AspectRatio;
						float _OutlineWidth;
						float _InnerAnimation;
						vec4 _ColorOutline;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat7;
					bool u_xlatb7;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat14;
					float u_xlat15;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat1.x = 2.0;
					    u_xlat1.y = _AspectRatio;
					    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
					    u_xlat0.z = u_xlat0.y * 2.0;
					    u_xlat1.y = 0.0;
					    u_xlat1.xz = vec2(vec2(_AspectRatio, _AspectRatio)) + vec2(-1.0, -1.0);
					    u_xlat8.xy = abs(u_xlat0.xz) + (-u_xlat1.yz);
					    u_xlat21 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat21 = sqrt(u_xlat21);
					    u_xlatb8 = abs(u_xlat0.z)>=u_xlat1.x;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat21 = -abs(u_xlat0.x) + u_xlat21;
					    u_xlat2.x = u_xlat8.x * u_xlat21 + abs(u_xlat0.x);
					    u_xlatb21 = 1.0<u_xlat2.x;
					    if(((int(u_xlatb21) * int(0xffffffffu)))!=0){discard;}
					    u_xlat7 = u_xlat0.y + u_xlat0.y;
					    u_xlat2.y = 0.0;
					    u_xlat3 = texture(_MainTex, u_xlat2.xy);
					    u_xlat4 = u_xlat3 * _ColorDark;
					    u_xlat21 = _InnerAnimation + _InnerAnimation;
					    u_xlat8.x = _InnerAnimation * 2.0 + -1.0;
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					    u_xlat15 = u_xlat1.x + u_xlat1.x;
					    u_xlat5.w = u_xlat8.x * u_xlat15 + (-u_xlat1.x);
					    u_xlat21 = u_xlat21;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat5.y = u_xlat21 * u_xlat15 + (-u_xlat1.x);
					    u_xlat5.x = float(0.0);
					    u_xlat5.z = float(0.0);
					    u_xlat6 = u_xlat0.xzxz + (-u_xlat5);
					    u_xlat14 = dot(u_xlat6.xy, u_xlat6.xy);
					    u_xlat14 = sqrt(u_xlat14);
					    u_xlatb21 = u_xlat7>=u_xlat5.y;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = -abs(u_xlat0.x) + u_xlat14;
					    u_xlat0.x = u_xlat21 * u_xlat14 + abs(u_xlat0.x);
					    u_xlat14 = dot(u_xlat6.zw, u_xlat6.zw);
					    u_xlat14 = sqrt(u_xlat14);
					    u_xlatb7 = u_xlat5.w>=u_xlat7;
					    u_xlat7 = u_xlatb7 ? 1.0 : float(0.0);
					    u_xlat14 = (-u_xlat0.x) + u_xlat14;
					    u_xlat0.x = u_xlat7 * u_xlat14 + u_xlat0.x;
					    u_xlatb0 = 1.0>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat3 = (-u_xlat3) * _ColorDark + _ColorMiddle;
					    u_xlat0 = u_xlat0.xxxx * u_xlat3 + u_xlat4;
					    u_xlat1.x = (-_OutlineWidth) + 1.0;
					    u_xlatb1 = u_xlat2.x>=u_xlat1.x;
					    u_xlat0 = (bool(u_xlatb1)) ? _ColorOutline : u_xlat0;
					    u_xlat1.x = u_xlat8.x * u_xlat8.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = (-u_xlat8.x) * u_xlat1.x + vs_TEXCOORD0.y;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    SV_Target0.w = u_xlat0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}"
				}
			}
		}
	}
}