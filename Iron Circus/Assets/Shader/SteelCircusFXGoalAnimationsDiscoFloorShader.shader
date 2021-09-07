Shader "SteelCircus/FX/GoalAnimations/DiscoFloorShader" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		[NoScaleOffset] _AnimTex ("Animation Texture", 2D) = "white" {}
		_AnimSpeed ("Animation Speed", Float) = 1
		_LerpRange ("Color lerp range", Range(0, 1)) = 0.5
		_BuildupBGTime ("Buildup Time", Range(0, 1)) = 0.5
		_BuildupBGAmp ("Buildup Amplitude", Range(0, 0.2)) = 0.02
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 64415
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
					out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_2[2];
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
					out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_2[2];
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
					out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
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
						vec4 _MainTex_ST;
						vec4 _AnimTex_TexelSize;
						float _AnimSpeed;
						float _LerpRange;
						float _BuildupBGTime;
						float _BuildupBGAmp;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AnimTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec2 u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _AnimSpeed * _Time.y;
					    u_xlat0.x = u_xlat0.x * _AnimTex_TexelSize.w;
					    u_xlat0.x = u_xlat0.x * 0.00999999978;
					    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlat3 = (u_xlatb3) ? 1.0 : -1.0;
					    u_xlat6.x = u_xlat3 * u_xlat0.x;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + 0.5;
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat0.y = u_xlat6.x * u_xlat3;
					    u_xlat0.xz = u_xlat0.xy / _AnimTex_TexelSize.ww;
					    u_xlat6.x = u_xlat0.z + u_xlat0.x;
					    u_xlat9 = (-_LerpRange) + 1.0;
					    u_xlatb3 = u_xlat0.y>=u_xlat9;
					    u_xlat0.y = (u_xlatb3) ? u_xlat6.x : u_xlat0.x;
					    u_xlat6.xy = floor(vs_TEXCOORD0.yx);
					    u_xlat1 = u_xlat6.xxyy * vec4(8.0, 8.0, 8.0, 8.0);
					    u_xlatb1 = greaterThanEqual(u_xlat1, (-u_xlat1.yyww));
					    u_xlat1.x = (u_xlatb1.x) ? float(8.0) : float(-8.0);
					    u_xlat1.y = (u_xlatb1.y) ? float(0.125) : float(-0.125);
					    u_xlat1.z = (u_xlatb1.z) ? float(8.0) : float(-8.0);
					    u_xlat1.w = (u_xlatb1.w) ? float(0.125) : float(-0.125);
					    u_xlat4.xz = u_xlat6.xy * u_xlat1.yw;
					    u_xlat6.xy = u_xlat6.yx + vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy / _MainTex_ST.xy;
					    u_xlat4.xz = fract(u_xlat4.xz);
					    u_xlat1.xy = u_xlat4.xz * u_xlat1.xz;
					    u_xlat1.x = u_xlat1.x * 8.0 + u_xlat1.y;
					    u_xlat1.x = u_xlat1.x + 0.5;
					    u_xlat0.x = u_xlat1.x * 0.015625;
					    u_xlat1 = texture(_AnimTex, u_xlat0.xy);
					    u_xlat0.x = _Time.y * 5.0;
					    u_xlat0.x = u_xlat6.x * 20.0 + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = _BuildupBGTime * _BuildupBGTime;
					    u_xlat3 = dot(vec2(u_xlat3), vec2(u_xlat3));
					    u_xlat0.x = u_xlat0.x * _BuildupBGAmp + (-u_xlat3);
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat3 = (-_BuildupBGAmp) * 2.0 + 1.0;
					    u_xlat3 = u_xlat6.y * u_xlat3 + _BuildupBGAmp;
					    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.100000001;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3 = (-u_xlat0.x) + 1.0;
					    u_xlatb0 = u_xlat0.x>=9.99999975e-05;
					    SV_Target0.w = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat3 + u_xlat3;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xxx;
					    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
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
						vec4 _AnimTex_TexelSize;
						float _AnimSpeed;
						float _LerpRange;
						float _BuildupBGTime;
						float _BuildupBGAmp;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AnimTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec2 u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _AnimSpeed * _Time.y;
					    u_xlat0.x = u_xlat0.x * _AnimTex_TexelSize.w;
					    u_xlat0.x = u_xlat0.x * 0.00999999978;
					    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlat3 = (u_xlatb3) ? 1.0 : -1.0;
					    u_xlat6.x = u_xlat3 * u_xlat0.x;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + 0.5;
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat0.y = u_xlat6.x * u_xlat3;
					    u_xlat0.xz = u_xlat0.xy / _AnimTex_TexelSize.ww;
					    u_xlat6.x = u_xlat0.z + u_xlat0.x;
					    u_xlat9 = (-_LerpRange) + 1.0;
					    u_xlatb3 = u_xlat0.y>=u_xlat9;
					    u_xlat0.y = (u_xlatb3) ? u_xlat6.x : u_xlat0.x;
					    u_xlat6.xy = floor(vs_TEXCOORD0.yx);
					    u_xlat1 = u_xlat6.xxyy * vec4(8.0, 8.0, 8.0, 8.0);
					    u_xlatb1 = greaterThanEqual(u_xlat1, (-u_xlat1.yyww));
					    u_xlat1.x = (u_xlatb1.x) ? float(8.0) : float(-8.0);
					    u_xlat1.y = (u_xlatb1.y) ? float(0.125) : float(-0.125);
					    u_xlat1.z = (u_xlatb1.z) ? float(8.0) : float(-8.0);
					    u_xlat1.w = (u_xlatb1.w) ? float(0.125) : float(-0.125);
					    u_xlat4.xz = u_xlat6.xy * u_xlat1.yw;
					    u_xlat6.xy = u_xlat6.yx + vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy / _MainTex_ST.xy;
					    u_xlat4.xz = fract(u_xlat4.xz);
					    u_xlat1.xy = u_xlat4.xz * u_xlat1.xz;
					    u_xlat1.x = u_xlat1.x * 8.0 + u_xlat1.y;
					    u_xlat1.x = u_xlat1.x + 0.5;
					    u_xlat0.x = u_xlat1.x * 0.015625;
					    u_xlat1 = texture(_AnimTex, u_xlat0.xy);
					    u_xlat0.x = _Time.y * 5.0;
					    u_xlat0.x = u_xlat6.x * 20.0 + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = _BuildupBGTime * _BuildupBGTime;
					    u_xlat3 = dot(vec2(u_xlat3), vec2(u_xlat3));
					    u_xlat0.x = u_xlat0.x * _BuildupBGAmp + (-u_xlat3);
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat3 = (-_BuildupBGAmp) * 2.0 + 1.0;
					    u_xlat3 = u_xlat6.y * u_xlat3 + _BuildupBGAmp;
					    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.100000001;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3 = (-u_xlat0.x) + 1.0;
					    u_xlatb0 = u_xlat0.x>=9.99999975e-05;
					    SV_Target0.w = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat3 + u_xlat3;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xxx;
					    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
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
						vec4 _AnimTex_TexelSize;
						float _AnimSpeed;
						float _LerpRange;
						float _BuildupBGTime;
						float _BuildupBGAmp;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _AnimTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					vec2 u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _AnimSpeed * _Time.y;
					    u_xlat0.x = u_xlat0.x * _AnimTex_TexelSize.w;
					    u_xlat0.x = u_xlat0.x * 0.00999999978;
					    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlat3 = (u_xlatb3) ? 1.0 : -1.0;
					    u_xlat6.x = u_xlat3 * u_xlat0.x;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + 0.5;
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat0.y = u_xlat6.x * u_xlat3;
					    u_xlat0.xz = u_xlat0.xy / _AnimTex_TexelSize.ww;
					    u_xlat6.x = u_xlat0.z + u_xlat0.x;
					    u_xlat9 = (-_LerpRange) + 1.0;
					    u_xlatb3 = u_xlat0.y>=u_xlat9;
					    u_xlat0.y = (u_xlatb3) ? u_xlat6.x : u_xlat0.x;
					    u_xlat6.xy = floor(vs_TEXCOORD0.yx);
					    u_xlat1 = u_xlat6.xxyy * vec4(8.0, 8.0, 8.0, 8.0);
					    u_xlatb1 = greaterThanEqual(u_xlat1, (-u_xlat1.yyww));
					    u_xlat1.x = (u_xlatb1.x) ? float(8.0) : float(-8.0);
					    u_xlat1.y = (u_xlatb1.y) ? float(0.125) : float(-0.125);
					    u_xlat1.z = (u_xlatb1.z) ? float(8.0) : float(-8.0);
					    u_xlat1.w = (u_xlatb1.w) ? float(0.125) : float(-0.125);
					    u_xlat4.xz = u_xlat6.xy * u_xlat1.yw;
					    u_xlat6.xy = u_xlat6.yx + vec2(0.5, 0.5);
					    u_xlat6.xy = u_xlat6.xy / _MainTex_ST.xy;
					    u_xlat4.xz = fract(u_xlat4.xz);
					    u_xlat1.xy = u_xlat4.xz * u_xlat1.xz;
					    u_xlat1.x = u_xlat1.x * 8.0 + u_xlat1.y;
					    u_xlat1.x = u_xlat1.x + 0.5;
					    u_xlat0.x = u_xlat1.x * 0.015625;
					    u_xlat1 = texture(_AnimTex, u_xlat0.xy);
					    u_xlat0.x = _Time.y * 5.0;
					    u_xlat0.x = u_xlat6.x * 20.0 + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = _BuildupBGTime * _BuildupBGTime;
					    u_xlat3 = dot(vec2(u_xlat3), vec2(u_xlat3));
					    u_xlat0.x = u_xlat0.x * _BuildupBGAmp + (-u_xlat3);
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat3 = (-_BuildupBGAmp) * 2.0 + 1.0;
					    u_xlat3 = u_xlat6.y * u_xlat3 + _BuildupBGAmp;
					    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.100000001;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3 = (-u_xlat0.x) + 1.0;
					    u_xlatb0 = u_xlat0.x>=9.99999975e-05;
					    SV_Target0.w = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat3 + u_xlat3;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xxx;
					    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
					    return;
					}"
				}
			}
		}
	}
}