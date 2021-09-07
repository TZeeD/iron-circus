Shader "SteelCircus/FX/Skills/BoostCloudShader" {
	Properties {
		_ColorInner ("Color Inner", Vector) = (1,1,1,1)
		_ColorOuter ("Color Outer", Vector) = (1,1,1,1)
		_FresnelPow ("Fresnel Power", Float) = 1
		_MainTex ("Texture", 2D) = "white" {}
		_VertTex ("Vertex Displacement", 2D) = "white" {}
		_MaxDisp ("Max Vert Displacement", Float) = 1
		_UVScrollYSpeed ("UV Scroll Y Speed", Float) = 1
		_Age ("Age", Range(0, 1)) = 0
		_Scale ("Total Scale", Float) = 1
	}
	SubShader {
		LOD 100
		Tags { "DisableBatching" = "true" "QUEUE" = "Transparent-20" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "DisableBatching" = "true" "QUEUE" = "Transparent-20" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 36829
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
						vec4 _VertTex_ST;
						float _Scale;
						float _MaxDisp;
						float _UVScrollYSpeed;
						vec4 unused_0_6[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
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
					uniform  sampler2D _VertTex;
					in  vec4 in_POSITION0;
					in  vec3 in_TEXCOORD0;
					in  vec3 in_TEXCOORD1;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.w = in_TEXCOORD0.z;
					    u_xlat0.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = u_xlat0.y + _Time.y;
					    vs_TEXCOORD0.xyz = u_xlat0.xzw;
					    u_xlat0.xy = in_TEXCOORD0.xy * _VertTex_ST.xy + _VertTex_ST.zw;
					    u_xlat0.z = _UVScrollYSpeed * in_TEXCOORD0.z + u_xlat0.y;
					    u_xlat0 = textureLod(_VertTex, u_xlat0.xz, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat1.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_MaxDisp, _MaxDisp, _MaxDisp)) + u_xlat1.xyz;
					    u_xlat9 = in_TEXCOORD0.z + 0.00100000005;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Scale, _Scale, _Scale)) + in_TEXCOORD1.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0 = in_NORMAL0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_NORMAL0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_NORMAL0.zzzz + u_xlat0;
					    u_xlat9 = dot(u_xlat0, u_xlat0);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
						vec4 _VertTex_ST;
						float _Scale;
						float _MaxDisp;
						float _UVScrollYSpeed;
						vec4 unused_0_6[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
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
					uniform  sampler2D _VertTex;
					in  vec4 in_POSITION0;
					in  vec3 in_TEXCOORD0;
					in  vec3 in_TEXCOORD1;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.w = in_TEXCOORD0.z;
					    u_xlat0.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = u_xlat0.y + _Time.y;
					    vs_TEXCOORD0.xyz = u_xlat0.xzw;
					    u_xlat0.xy = in_TEXCOORD0.xy * _VertTex_ST.xy + _VertTex_ST.zw;
					    u_xlat0.z = _UVScrollYSpeed * in_TEXCOORD0.z + u_xlat0.y;
					    u_xlat0 = textureLod(_VertTex, u_xlat0.xz, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat1.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_MaxDisp, _MaxDisp, _MaxDisp)) + u_xlat1.xyz;
					    u_xlat9 = in_TEXCOORD0.z + 0.00100000005;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Scale, _Scale, _Scale)) + in_TEXCOORD1.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0 = in_NORMAL0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_NORMAL0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_NORMAL0.zzzz + u_xlat0;
					    u_xlat9 = dot(u_xlat0, u_xlat0);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
						vec4 _VertTex_ST;
						float _Scale;
						float _MaxDisp;
						float _UVScrollYSpeed;
						vec4 unused_0_6[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
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
					uniform  sampler2D _VertTex;
					in  vec4 in_POSITION0;
					in  vec3 in_TEXCOORD0;
					in  vec3 in_TEXCOORD1;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.w = in_TEXCOORD0.z;
					    u_xlat0.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = u_xlat0.y + _Time.y;
					    vs_TEXCOORD0.xyz = u_xlat0.xzw;
					    u_xlat0.xy = in_TEXCOORD0.xy * _VertTex_ST.xy + _VertTex_ST.zw;
					    u_xlat0.z = _UVScrollYSpeed * in_TEXCOORD0.z + u_xlat0.y;
					    u_xlat0 = textureLod(_VertTex, u_xlat0.xz, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat1.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_MaxDisp, _MaxDisp, _MaxDisp)) + u_xlat1.xyz;
					    u_xlat9 = in_TEXCOORD0.z + 0.00100000005;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Scale, _Scale, _Scale)) + in_TEXCOORD1.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0 = in_NORMAL0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_NORMAL0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_NORMAL0.zzzz + u_xlat0;
					    u_xlat9 = dot(u_xlat0, u_xlat0);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "FOG_LINEAR" }
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
						vec4 _VertTex_ST;
						float _Scale;
						float _MaxDisp;
						float _UVScrollYSpeed;
						vec4 unused_0_6[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
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
					uniform  sampler2D _VertTex;
					in  vec4 in_POSITION0;
					in  vec3 in_TEXCOORD0;
					in  vec3 in_TEXCOORD1;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.w = in_TEXCOORD0.z;
					    u_xlat0.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = u_xlat0.y + _Time.y;
					    vs_TEXCOORD0.xyz = u_xlat0.xzw;
					    u_xlat0.xy = in_TEXCOORD0.xy * _VertTex_ST.xy + _VertTex_ST.zw;
					    u_xlat0.z = _UVScrollYSpeed * in_TEXCOORD0.z + u_xlat0.y;
					    u_xlat0 = textureLod(_VertTex, u_xlat0.xz, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat1.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_MaxDisp, _MaxDisp, _MaxDisp)) + u_xlat1.xyz;
					    u_xlat9 = in_TEXCOORD0.z + 0.00100000005;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Scale, _Scale, _Scale)) + in_TEXCOORD1.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0 = in_NORMAL0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_NORMAL0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_NORMAL0.zzzz + u_xlat0;
					    u_xlat9 = dot(u_xlat0, u_xlat0);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "FOG_LINEAR" }
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
						vec4 _VertTex_ST;
						float _Scale;
						float _MaxDisp;
						float _UVScrollYSpeed;
						vec4 unused_0_6[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
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
					uniform  sampler2D _VertTex;
					in  vec4 in_POSITION0;
					in  vec3 in_TEXCOORD0;
					in  vec3 in_TEXCOORD1;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.w = in_TEXCOORD0.z;
					    u_xlat0.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = u_xlat0.y + _Time.y;
					    vs_TEXCOORD0.xyz = u_xlat0.xzw;
					    u_xlat0.xy = in_TEXCOORD0.xy * _VertTex_ST.xy + _VertTex_ST.zw;
					    u_xlat0.z = _UVScrollYSpeed * in_TEXCOORD0.z + u_xlat0.y;
					    u_xlat0 = textureLod(_VertTex, u_xlat0.xz, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat1.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_MaxDisp, _MaxDisp, _MaxDisp)) + u_xlat1.xyz;
					    u_xlat9 = in_TEXCOORD0.z + 0.00100000005;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Scale, _Scale, _Scale)) + in_TEXCOORD1.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0 = in_NORMAL0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_NORMAL0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_NORMAL0.zzzz + u_xlat0;
					    u_xlat9 = dot(u_xlat0, u_xlat0);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "FOG_LINEAR" }
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
						vec4 _VertTex_ST;
						float _Scale;
						float _MaxDisp;
						float _UVScrollYSpeed;
						vec4 unused_0_6[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
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
					uniform  sampler2D _VertTex;
					in  vec4 in_POSITION0;
					in  vec3 in_TEXCOORD0;
					in  vec3 in_TEXCOORD1;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.w = in_TEXCOORD0.z;
					    u_xlat0.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = u_xlat0.y + _Time.y;
					    vs_TEXCOORD0.xyz = u_xlat0.xzw;
					    u_xlat0.xy = in_TEXCOORD0.xy * _VertTex_ST.xy + _VertTex_ST.zw;
					    u_xlat0.z = _UVScrollYSpeed * in_TEXCOORD0.z + u_xlat0.y;
					    u_xlat0 = textureLod(_VertTex, u_xlat0.xz, 0.0);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
					    u_xlat1.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_MaxDisp, _MaxDisp, _MaxDisp)) + u_xlat1.xyz;
					    u_xlat9 = in_TEXCOORD0.z + 0.00100000005;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Scale, _Scale, _Scale)) + in_TEXCOORD1.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0 = in_NORMAL0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_NORMAL0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_NORMAL0.zzzz + u_xlat0;
					    u_xlat9 = dot(u_xlat0, u_xlat0);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
						float _FresnelPow;
						vec4 _ColorInner;
						vec4 _ColorOuter;
					};
					uniform  sampler2D _MainTex;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _FresnelPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1 = _ColorInner + (-_ColorOuter);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _ColorOuter;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.x = (-u_xlat1.x) + vs_TEXCOORD0.z;
					    u_xlat1.x = u_xlat1.x + 0.100000001;
					    u_xlat1.x = (-u_xlat1.x) * 10.0 + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
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
						vec4 unused_0_0[5];
						float _FresnelPow;
						vec4 _ColorInner;
						vec4 _ColorOuter;
					};
					uniform  sampler2D _MainTex;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _FresnelPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1 = _ColorInner + (-_ColorOuter);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _ColorOuter;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.x = (-u_xlat1.x) + vs_TEXCOORD0.z;
					    u_xlat1.x = u_xlat1.x + 0.100000001;
					    u_xlat1.x = (-u_xlat1.x) * 10.0 + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
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
						vec4 unused_0_0[5];
						float _FresnelPow;
						vec4 _ColorInner;
						vec4 _ColorOuter;
					};
					uniform  sampler2D _MainTex;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _FresnelPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1 = _ColorInner + (-_ColorOuter);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _ColorOuter;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.x = (-u_xlat1.x) + vs_TEXCOORD0.z;
					    u_xlat1.x = u_xlat1.x + 0.100000001;
					    u_xlat1.x = (-u_xlat1.x) * 10.0 + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "FOG_LINEAR" }
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
						float _FresnelPow;
						vec4 _ColorInner;
						vec4 _ColorOuter;
					};
					uniform  sampler2D _MainTex;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _FresnelPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1 = _ColorInner + (-_ColorOuter);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _ColorOuter;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.x = (-u_xlat1.x) + vs_TEXCOORD0.z;
					    u_xlat1.x = u_xlat1.x + 0.100000001;
					    u_xlat1.x = (-u_xlat1.x) * 10.0 + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "FOG_LINEAR" }
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
						float _FresnelPow;
						vec4 _ColorInner;
						vec4 _ColorOuter;
					};
					uniform  sampler2D _MainTex;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _FresnelPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1 = _ColorInner + (-_ColorOuter);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _ColorOuter;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.x = (-u_xlat1.x) + vs_TEXCOORD0.z;
					    u_xlat1.x = u_xlat1.x + 0.100000001;
					    u_xlat1.x = (-u_xlat1.x) * 10.0 + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "FOG_LINEAR" }
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
						float _FresnelPow;
						vec4 _ColorInner;
						vec4 _ColorOuter;
					};
					uniform  sampler2D _MainTex;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = log2(abs(u_xlat0.x));
					    u_xlat0.x = u_xlat0.x * _FresnelPow;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat1 = _ColorInner + (-_ColorOuter);
					    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _ColorOuter;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.x = (-u_xlat1.x) + vs_TEXCOORD0.z;
					    u_xlat1.x = u_xlat1.x + 0.100000001;
					    u_xlat1.x = (-u_xlat1.x) * 10.0 + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}"
				}
			}
		}
	}
}