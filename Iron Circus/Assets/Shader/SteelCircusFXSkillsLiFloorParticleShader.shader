Shader "SteelCircus/FX/Skills/LiFloorParticleShader" {
	Properties {
		[NoScaleOffset] _MainTex ("Texture", 2D) = "white" {}
		_Color ("Color", Vector) = (1,1,1,1)
		_ColorMiddle ("Middle Color", Vector) = (1,1,1,1)
		_ColorDark ("Dark Color", Vector) = (1,1,1,1)
		[NoScaleOffset] _CharTex ("Charset", 2D) = "white" {}
		_CharDim ("Charset Dimensions (x=columns, y=rows, z=ws width, w=ws height)", Vector) = (16,16,0.5,0.75)
		_GridDim ("Output Grid Dimensions (x=columns, y=rows)", Vector) = (16,8,0,0)
		[NoScaleOffset] _CharAnimTex ("Charset animation", 2D) = "white" {}
		_CharAnimSpeed ("Charset animation speed", Float) = 1
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 1231
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
						vec4 unused_0_0[10];
						vec4 _CharDim;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xz = u_xlat0.xz / _CharDim.zw;
					    u_xlat0.xz = roundEven(u_xlat0.xz);
					    u_xlat0.xz = u_xlat0.xz * _CharDim.zw;
					    u_xlat1.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    vs_TEXCOORD2 = u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[10];
						vec4 _CharDim;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xz = u_xlat0.xz / _CharDim.zw;
					    u_xlat0.xz = roundEven(u_xlat0.xz);
					    u_xlat0.xz = u_xlat0.xz * _CharDim.zw;
					    u_xlat1.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    vs_TEXCOORD2 = u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[10];
						vec4 _CharDim;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xz = u_xlat0.xz / _CharDim.zw;
					    u_xlat0.xz = roundEven(u_xlat0.xz);
					    u_xlat0.xz = u_xlat0.xz * _CharDim.zw;
					    u_xlat1.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    vs_TEXCOORD2 = u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
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
						vec4 unused_0_0[4];
						vec4 _ColorMiddle;
						vec4 _ColorDark;
						vec4 unused_0_3[4];
						vec4 _CharDim;
						vec4 _GridDim;
						float _CharAnimSpeed;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CharAnimTex;
					uniform  sampler2D _CharTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat4;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.zx * vec2(1.0, -1.0);
					    u_xlat0.xy = u_xlat0.xy / _CharDim.zw;
					    u_xlat0.xy = u_xlat0.xy + vec2(1000.0, 1000.0);
					    u_xlat6.xy = floor(u_xlat0.xy);
					    u_xlat0.xy = (-u_xlat6.xy) + u_xlat0.xy;
					    u_xlat1.xy = u_xlat6.xy / _GridDim.xy;
					    u_xlat6.x = u_xlat6.y * 0.100000001;
					    u_xlat2.y = _Time.y * _CharAnimSpeed + u_xlat6.x;
					    u_xlatb6.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
					    u_xlat1.xy = fract(abs(u_xlat1.xy));
					    u_xlat6.x = (u_xlatb6.x) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat6.y = (u_xlatb6.y) ? u_xlat1.y : (-u_xlat1.y);
					    u_xlat6.xy = u_xlat6.xy * _GridDim.xy;
					    u_xlat6.x = u_xlat6.y * _GridDim.x + u_xlat6.x;
					    u_xlat9 = _GridDim.y * _GridDim.x;
					    u_xlat2.x = u_xlat6.x / u_xlat9;
					    u_xlat1 = texture(_CharAnimTex, u_xlat2.xy);
					    u_xlat6.x = _CharDim.y * _CharDim.x;
					    u_xlat9 = u_xlat1.x / u_xlat6.x;
					    u_xlat1.x = _CharDim.x * _CharDim.y + -1.0;
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    u_xlat6.x = u_xlat6.x * u_xlat9;
					    u_xlat0.z = floor(u_xlat6.x);
					    u_xlat0.xyw = u_xlat0.xyz / _CharDim.xyx;
					    u_xlatb6.x = 0.0>=u_xlat0.z;
					    u_xlat6.x = (u_xlatb6.x) ? 0.0 : 1.0;
					    u_xlatb1 = u_xlat0.w>=(-u_xlat0.w);
					    u_xlat4 = fract(abs(u_xlat0.w));
					    u_xlat2.y = floor(u_xlat0.w);
					    u_xlat9 = (u_xlatb1) ? u_xlat4 : (-u_xlat4);
					    u_xlat2.x = u_xlat9 * _CharDim.x;
					    u_xlat1.xy = u_xlat2.xy / _CharDim.xy;
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat1 = texture(_CharTex, u_xlat0.xy);
					    u_xlat2 = _ColorMiddle + (-_ColorDark);
					    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _ColorDark;
					    u_xlat1.w = u_xlat6.x * u_xlat1.w;
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = (-u_xlat0) * _Color + u_xlat1;
					    u_xlat0 = u_xlat0 * _Color;
					    u_xlat0 = u_xlat1.wwww * u_xlat2 + u_xlat0;
					    SV_Target0 = u_xlat0 * vs_COLOR0;
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
						vec4 unused_0_3[4];
						vec4 _CharDim;
						vec4 _GridDim;
						float _CharAnimSpeed;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CharAnimTex;
					uniform  sampler2D _CharTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat4;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.zx * vec2(1.0, -1.0);
					    u_xlat0.xy = u_xlat0.xy / _CharDim.zw;
					    u_xlat0.xy = u_xlat0.xy + vec2(1000.0, 1000.0);
					    u_xlat6.xy = floor(u_xlat0.xy);
					    u_xlat0.xy = (-u_xlat6.xy) + u_xlat0.xy;
					    u_xlat1.xy = u_xlat6.xy / _GridDim.xy;
					    u_xlat6.x = u_xlat6.y * 0.100000001;
					    u_xlat2.y = _Time.y * _CharAnimSpeed + u_xlat6.x;
					    u_xlatb6.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
					    u_xlat1.xy = fract(abs(u_xlat1.xy));
					    u_xlat6.x = (u_xlatb6.x) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat6.y = (u_xlatb6.y) ? u_xlat1.y : (-u_xlat1.y);
					    u_xlat6.xy = u_xlat6.xy * _GridDim.xy;
					    u_xlat6.x = u_xlat6.y * _GridDim.x + u_xlat6.x;
					    u_xlat9 = _GridDim.y * _GridDim.x;
					    u_xlat2.x = u_xlat6.x / u_xlat9;
					    u_xlat1 = texture(_CharAnimTex, u_xlat2.xy);
					    u_xlat6.x = _CharDim.y * _CharDim.x;
					    u_xlat9 = u_xlat1.x / u_xlat6.x;
					    u_xlat1.x = _CharDim.x * _CharDim.y + -1.0;
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    u_xlat6.x = u_xlat6.x * u_xlat9;
					    u_xlat0.z = floor(u_xlat6.x);
					    u_xlat0.xyw = u_xlat0.xyz / _CharDim.xyx;
					    u_xlatb6.x = 0.0>=u_xlat0.z;
					    u_xlat6.x = (u_xlatb6.x) ? 0.0 : 1.0;
					    u_xlatb1 = u_xlat0.w>=(-u_xlat0.w);
					    u_xlat4 = fract(abs(u_xlat0.w));
					    u_xlat2.y = floor(u_xlat0.w);
					    u_xlat9 = (u_xlatb1) ? u_xlat4 : (-u_xlat4);
					    u_xlat2.x = u_xlat9 * _CharDim.x;
					    u_xlat1.xy = u_xlat2.xy / _CharDim.xy;
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat1 = texture(_CharTex, u_xlat0.xy);
					    u_xlat2 = _ColorMiddle + (-_ColorDark);
					    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _ColorDark;
					    u_xlat1.w = u_xlat6.x * u_xlat1.w;
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = (-u_xlat0) * _Color + u_xlat1;
					    u_xlat0 = u_xlat0 * _Color;
					    u_xlat0 = u_xlat1.wwww * u_xlat2 + u_xlat0;
					    SV_Target0 = u_xlat0 * vs_COLOR0;
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
						vec4 unused_0_3[4];
						vec4 _CharDim;
						vec4 _GridDim;
						float _CharAnimSpeed;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CharAnimTex;
					uniform  sampler2D _CharTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat4;
					vec2 u_xlat6;
					bvec2 u_xlatb6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.zx * vec2(1.0, -1.0);
					    u_xlat0.xy = u_xlat0.xy / _CharDim.zw;
					    u_xlat0.xy = u_xlat0.xy + vec2(1000.0, 1000.0);
					    u_xlat6.xy = floor(u_xlat0.xy);
					    u_xlat0.xy = (-u_xlat6.xy) + u_xlat0.xy;
					    u_xlat1.xy = u_xlat6.xy / _GridDim.xy;
					    u_xlat6.x = u_xlat6.y * 0.100000001;
					    u_xlat2.y = _Time.y * _CharAnimSpeed + u_xlat6.x;
					    u_xlatb6.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
					    u_xlat1.xy = fract(abs(u_xlat1.xy));
					    u_xlat6.x = (u_xlatb6.x) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat6.y = (u_xlatb6.y) ? u_xlat1.y : (-u_xlat1.y);
					    u_xlat6.xy = u_xlat6.xy * _GridDim.xy;
					    u_xlat6.x = u_xlat6.y * _GridDim.x + u_xlat6.x;
					    u_xlat9 = _GridDim.y * _GridDim.x;
					    u_xlat2.x = u_xlat6.x / u_xlat9;
					    u_xlat1 = texture(_CharAnimTex, u_xlat2.xy);
					    u_xlat6.x = _CharDim.y * _CharDim.x;
					    u_xlat9 = u_xlat1.x / u_xlat6.x;
					    u_xlat1.x = _CharDim.x * _CharDim.y + -1.0;
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    u_xlat6.x = u_xlat6.x * u_xlat9;
					    u_xlat0.z = floor(u_xlat6.x);
					    u_xlat0.xyw = u_xlat0.xyz / _CharDim.xyx;
					    u_xlatb6.x = 0.0>=u_xlat0.z;
					    u_xlat6.x = (u_xlatb6.x) ? 0.0 : 1.0;
					    u_xlatb1 = u_xlat0.w>=(-u_xlat0.w);
					    u_xlat4 = fract(abs(u_xlat0.w));
					    u_xlat2.y = floor(u_xlat0.w);
					    u_xlat9 = (u_xlatb1) ? u_xlat4 : (-u_xlat4);
					    u_xlat2.x = u_xlat9 * _CharDim.x;
					    u_xlat1.xy = u_xlat2.xy / _CharDim.xy;
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat1 = texture(_CharTex, u_xlat0.xy);
					    u_xlat2 = _ColorMiddle + (-_ColorDark);
					    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _ColorDark;
					    u_xlat1.w = u_xlat6.x * u_xlat1.w;
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = (-u_xlat0) * _Color + u_xlat1;
					    u_xlat0 = u_xlat0 * _Color;
					    u_xlat0 = u_xlat1.wwww * u_xlat2 + u_xlat0;
					    SV_Target0 = u_xlat0 * vs_COLOR0;
					    return;
					}"
				}
			}
		}
	}
}