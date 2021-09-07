Shader "SteelCircus/FX/Skills/GalenaScrambleFloorShader" {
	Properties {
		_MainTex ("Noise Texture", 2D) = "white" {}
		_MaskTex ("Mask Texture", 2D) = "white" {}
		_Scale ("Normal Scale (warps away from up direction)", Float) = 1
		_Displacement ("Displacement", Float) = 0.5
		_Speed ("Speed", Float) = 1
		_Color ("Color (fade)", Vector) = (1,1,1,1)
	}
	SubShader {
		Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 11464
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
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TANGENT0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD1.y = u_xlat2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.y = u_xlat2.y;
					    vs_TEXCOORD3.y = u_xlat2.z;
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
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TANGENT0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD1.y = u_xlat2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.y = u_xlat2.y;
					    vs_TEXCOORD3.y = u_xlat2.z;
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
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TANGENT0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD1.y = u_xlat2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.y = u_xlat2.y;
					    vs_TEXCOORD3.y = u_xlat2.z;
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
						float _Scale;
						float _Displacement;
						float _Speed;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.y = _Speed * _Time.y;
					    u_xlat0.x = 0.0;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Displacement, _Displacement)) + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy).xywz;
					    u_xlat1.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat10 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10 = min(u_xlat10, 1.0);
					    u_xlat10 = (-u_xlat10) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xy = u_xlat1.xx * u_xlat2.xz;
					    u_xlat1.xy = u_xlat1.xy * vec2(_Scale);
					    u_xlat10 = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat10 = (-u_xlat1.y) * u_xlat1.y + u_xlat10;
					    u_xlat10 = max(u_xlat10, 0.0);
					    u_xlat1.z = sqrt(u_xlat10);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vs_COLOR0;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD4.xy);
					    u_xlat9 = u_xlat0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = u_xlat9 * _Color.x;
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
						float _Scale;
						float _Displacement;
						float _Speed;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.y = _Speed * _Time.y;
					    u_xlat0.x = 0.0;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Displacement, _Displacement)) + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy).xywz;
					    u_xlat1.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat10 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10 = min(u_xlat10, 1.0);
					    u_xlat10 = (-u_xlat10) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xy = u_xlat1.xx * u_xlat2.xz;
					    u_xlat1.xy = u_xlat1.xy * vec2(_Scale);
					    u_xlat10 = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat10 = (-u_xlat1.y) * u_xlat1.y + u_xlat10;
					    u_xlat10 = max(u_xlat10, 0.0);
					    u_xlat1.z = sqrt(u_xlat10);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vs_COLOR0;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD4.xy);
					    u_xlat9 = u_xlat0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = u_xlat9 * _Color.x;
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
						float _Scale;
						float _Displacement;
						float _Speed;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.y = _Speed * _Time.y;
					    u_xlat0.x = 0.0;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Displacement, _Displacement)) + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy).xywz;
					    u_xlat1.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat10 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10 = min(u_xlat10, 1.0);
					    u_xlat10 = (-u_xlat10) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xy = u_xlat1.xx * u_xlat2.xz;
					    u_xlat1.xy = u_xlat1.xy * vec2(_Scale);
					    u_xlat10 = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat10 = (-u_xlat1.y) * u_xlat1.y + u_xlat10;
					    u_xlat10 = max(u_xlat10, 0.0);
					    u_xlat1.z = sqrt(u_xlat10);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * vs_COLOR0;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD4.xy);
					    u_xlat9 = u_xlat0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = u_xlat9 * _Color.x;
					    return;
					}"
				}
			}
		}
	}
}