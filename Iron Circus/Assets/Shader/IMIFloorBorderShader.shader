Shader "IMI/FloorBorderShader" {
	Properties {
		_MainTex ("Texture 1 - Alpha Blend", 2D) = "white" {}
		_MainTex2 ("Texture 2 - Multiply", 2D) = "white" {}
		_Color ("Outer Color", Vector) = (1,0,0,1)
		_InnerColor ("Inner Color", Vector) = (0,0.5,1,1)
		_Expansion ("Expand to Center", Range(0, 1)) = 0
		_Mask ("Mask", Range(0, 1)) = 0
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 64062
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
						vec4 _MainTex2_ST;
						vec4 unused_0_3[2];
						float _Expansion;
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
					bool u_xlatb6;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
					    u_xlat0.x = (-_Expansion) + 1.0;
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlatb6 = in_TEXCOORD0.y<0.5;
					    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat0.xyz : in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
						vec4 _MainTex2_ST;
						vec4 unused_0_3[2];
						float _Expansion;
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
					bool u_xlatb6;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
					    u_xlat0.x = (-_Expansion) + 1.0;
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlatb6 = in_TEXCOORD0.y<0.5;
					    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat0.xyz : in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
						vec4 _MainTex2_ST;
						vec4 unused_0_3[2];
						float _Expansion;
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
					bool u_xlatb6;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
					    u_xlat0.x = (-_Expansion) + 1.0;
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlatb6 = in_TEXCOORD0.y<0.5;
					    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat0.xyz : in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
						vec4 _Color;
						vec4 _InnerColor;
						float _Expansion;
						float _Mask;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MainTex2;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat4;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = texture(_MainTex2, vs_TEXCOORD1.xy);
					    u_xlat1 = _Color + (-_InnerColor);
					    u_xlat1 = vs_TEXCOORD0.yyyy * u_xlat1 + _InnerColor;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9 = (-u_xlat2.w) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat2.www + u_xlat0.xyz;
					    u_xlat0.w = u_xlat1.w;
					    u_xlat1 = (-u_xlat0) + u_xlat1;
					    u_xlat2.x = _Expansion * 10.0;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat0 = u_xlat2.xxxx * u_xlat1 + u_xlat0;
					    u_xlat1.x = vs_TEXCOORD0.y + (-_Mask);
					    u_xlat4 = _Mask + 9.99999975e-06;
					    u_xlat1.x = u_xlat1.x / u_xlat4;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
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
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 _InnerColor;
						float _Expansion;
						float _Mask;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MainTex2;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat4;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = texture(_MainTex2, vs_TEXCOORD1.xy);
					    u_xlat1 = _Color + (-_InnerColor);
					    u_xlat1 = vs_TEXCOORD0.yyyy * u_xlat1 + _InnerColor;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9 = (-u_xlat2.w) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat2.www + u_xlat0.xyz;
					    u_xlat0.w = u_xlat1.w;
					    u_xlat1 = (-u_xlat0) + u_xlat1;
					    u_xlat2.x = _Expansion * 10.0;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat0 = u_xlat2.xxxx * u_xlat1 + u_xlat0;
					    u_xlat1.x = vs_TEXCOORD0.y + (-_Mask);
					    u_xlat4 = _Mask + 9.99999975e-06;
					    u_xlat1.x = u_xlat1.x / u_xlat4;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
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
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 _InnerColor;
						float _Expansion;
						float _Mask;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MainTex2;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat4;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = texture(_MainTex2, vs_TEXCOORD1.xy);
					    u_xlat1 = _Color + (-_InnerColor);
					    u_xlat1 = vs_TEXCOORD0.yyyy * u_xlat1 + _InnerColor;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9 = (-u_xlat2.w) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat2.www + u_xlat0.xyz;
					    u_xlat0.w = u_xlat1.w;
					    u_xlat1 = (-u_xlat0) + u_xlat1;
					    u_xlat2.x = _Expansion * 10.0;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat0 = u_xlat2.xxxx * u_xlat1 + u_xlat0;
					    u_xlat1.x = vs_TEXCOORD0.y + (-_Mask);
					    u_xlat4 = _Mask + 9.99999975e-06;
					    u_xlat1.x = u_xlat1.x / u_xlat4;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    SV_Target0 = u_xlat0 * u_xlat1.xxxx;
					    return;
					}"
				}
			}
		}
	}
}