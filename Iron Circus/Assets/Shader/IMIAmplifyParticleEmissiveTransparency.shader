Shader "IMI/Amplify/ParticleEmissiveTransparency" {
	Properties {
		_Texture ("Texture", 2D) = "white" {}
		_Emissive_Intensity ("Emissive_Intensity", Float) = 0
		_Emissive_Fade_1Off ("Emissive_Fade_1=Off", Range(0, 1)) = 1
		_Transparency ("Transparency", Range(0, 1)) = 0
		_Color ("Color", Vector) = (1,0.9005568,0.3915094,0)
		[HideInInspector] _tex4coord ("", 2D) = "white" {}
		[HideInInspector] _texcoord ("", 2D) = "white" {}
		[HideInInspector] __dirty ("", Float) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 12767
			Program "vp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat29;
					bool u_xlatb29;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1 = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * _Emissive_Intensity;
					    u_xlat10.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat10.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlatb27 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb27){
					        u_xlatb27 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat10.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat10.xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat10.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb27)) ? u_xlat10.xyz : vs_TEXCOORD3.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat27 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat10.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat27, u_xlat10.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat27 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat10.x = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat10.x = u_xlat10.x + u_xlat10.x;
					    u_xlat10.xyz = vs_TEXCOORD2.xyz * (-u_xlat10.xxx) + (-u_xlat0.xyz);
					    u_xlat2.xyz = vec3(u_xlat27) * _LightColor0.xyz;
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat10.xyz, u_xlat10.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat10.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat10.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb29 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb29){
					        u_xlatb29 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb29){
					            u_xlat29 = dot(u_xlat10.xyz, u_xlat10.xyz);
					            u_xlat29 = inversesqrt(u_xlat29);
					            u_xlat5.xyz = u_xlat10.xyz * vec3(u_xlat29);
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat29 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat29 = min(u_xlat6.z, u_xlat29);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat10.xyz = u_xlat5.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat10.xyz, 6.0);
					        u_xlat10.x = u_xlat5.w + -1.0;
					        u_xlat10.x = unity_SpecCube1_HDR.w * u_xlat10.x + 1.0;
					        u_xlat10.x = log2(u_xlat10.x);
					        u_xlat10.x = u_xlat10.x * unity_SpecCube1_HDR.y;
					        u_xlat10.x = exp2(u_xlat10.x);
					        u_xlat10.x = u_xlat10.x * unity_SpecCube1_HDR.x;
					        u_xlat10.xyz = u_xlat5.xyz * u_xlat10.xxx;
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat10.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat10.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat10.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat10.xyz);
					    u_xlat29 = u_xlat27 + u_xlat27;
					    u_xlat0.xyz = u_xlat10.xyz * (-vec3(u_xlat29)) + u_xlat0.xyz;
					    u_xlat10.x = dot(u_xlat10.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat27 = u_xlat27;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat3.y = (-u_xlat27) + 1.0;
					    u_xlat3.zw = u_xlat3.xy * u_xlat3.xy;
					    u_xlat0.xy = u_xlat3.xy * u_xlat3.xw;
					    u_xlat0.xy = u_xlat3.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat3.x * 0.639999986;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat9.x = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat9.xyz;
					    SV_Target0.xyz = _Color.xyz * vec3(u_xlat1) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat31 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat31 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat12.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat12.xy);
					    u_xlat31 = u_xlat31 * u_xlat3.x;
					    SV_Target0.w = u_xlat31 * _Transparency;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat12.xyz = (bool(u_xlatb31)) ? u_xlat12.xyz : vs_TEXCOORD3.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat12.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat31, u_xlat12.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD2.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb33 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb33){
					        u_xlatb33 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb33){
					            u_xlat33 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat33 = inversesqrt(u_xlat33);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat33);
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat33 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat33 = min(u_xlat7.z, u_xlat33);
					            u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, 6.0);
					        u_xlat12.x = u_xlat6.w + -1.0;
					        u_xlat12.x = unity_SpecCube1_HDR.w * u_xlat12.x + 1.0;
					        u_xlat12.x = log2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.y;
					        u_xlat12.x = exp2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * u_xlat12.xxx;
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat11.xyz = u_xlat5.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat1.xyz;
					    SV_Target0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat31 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat31 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat12.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat12.xy);
					    u_xlat31 = u_xlat31 * u_xlat3.x;
					    SV_Target0.w = u_xlat31 * _Transparency;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat12.xyz = (bool(u_xlatb31)) ? u_xlat12.xyz : vs_TEXCOORD3.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat12.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat31, u_xlat12.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD2.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb33 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb33){
					        u_xlatb33 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb33){
					            u_xlat33 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat33 = inversesqrt(u_xlat33);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat33);
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat33 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat33 = min(u_xlat7.z, u_xlat33);
					            u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, 6.0);
					        u_xlat12.x = u_xlat6.w + -1.0;
					        u_xlat12.x = unity_SpecCube1_HDR.w * u_xlat12.x + 1.0;
					        u_xlat12.x = log2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.y;
					        u_xlat12.x = exp2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * u_xlat12.xxx;
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = abs(u_xlat30) + u_xlat1.x;
					    u_xlat10.x = u_xlat10.x + 9.99999975e-06;
					    u_xlat10.x = 0.5 / u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * 0.999999881;
					    u_xlat10.x = u_xlat1.x * u_xlat10.x;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat10.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = u_xlat10.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat12.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat10.x = -abs(u_xlat30) + 1.0;
					    u_xlat20 = u_xlat10.x * u_xlat10.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat10.x = u_xlat10.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat10.xyz;
					    SV_Target0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat29;
					bool u_xlatb29;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1 = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * _Emissive_Intensity;
					    u_xlat10.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat10.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlatb27 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb27){
					        u_xlatb27 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat10.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat10.xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat10.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb27)) ? u_xlat10.xyz : vs_TEXCOORD3.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat27 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat10.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat27, u_xlat10.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat27 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat10.x = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat10.x = u_xlat10.x + u_xlat10.x;
					    u_xlat10.xyz = vs_TEXCOORD2.xyz * (-u_xlat10.xxx) + (-u_xlat0.xyz);
					    u_xlat2.xyz = vec3(u_xlat27) * _LightColor0.xyz;
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat10.xyz, u_xlat10.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat10.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat10.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb29 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb29){
					        u_xlatb29 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb29){
					            u_xlat29 = dot(u_xlat10.xyz, u_xlat10.xyz);
					            u_xlat29 = inversesqrt(u_xlat29);
					            u_xlat5.xyz = u_xlat10.xyz * vec3(u_xlat29);
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat29 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat29 = min(u_xlat6.z, u_xlat29);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat10.xyz = u_xlat5.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat10.xyz, 6.0);
					        u_xlat10.x = u_xlat5.w + -1.0;
					        u_xlat10.x = unity_SpecCube1_HDR.w * u_xlat10.x + 1.0;
					        u_xlat10.x = log2(u_xlat10.x);
					        u_xlat10.x = u_xlat10.x * unity_SpecCube1_HDR.y;
					        u_xlat10.x = exp2(u_xlat10.x);
					        u_xlat10.x = u_xlat10.x * unity_SpecCube1_HDR.x;
					        u_xlat10.xyz = u_xlat5.xyz * u_xlat10.xxx;
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat10.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat10.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat10.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat10.xyz);
					    u_xlat29 = u_xlat27 + u_xlat27;
					    u_xlat0.xyz = u_xlat10.xyz * (-vec3(u_xlat29)) + u_xlat0.xyz;
					    u_xlat10.x = dot(u_xlat10.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat27 = u_xlat27;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat3.y = (-u_xlat27) + 1.0;
					    u_xlat3.zw = u_xlat3.xy * u_xlat3.xy;
					    u_xlat0.xy = u_xlat3.xy * u_xlat3.xw;
					    u_xlat0.xy = u_xlat3.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat3.x * 0.639999986;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat9.x = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat9.xyz;
					    SV_Target0.xyz = _Color.xyz * vec3(u_xlat1) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat31 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat31 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat12.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat12.xy);
					    u_xlat31 = u_xlat31 * u_xlat3.x;
					    SV_Target0.w = u_xlat31 * _Transparency;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat12.xyz = (bool(u_xlatb31)) ? u_xlat12.xyz : vs_TEXCOORD3.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat12.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat31, u_xlat12.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD2.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb33 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb33){
					        u_xlatb33 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb33){
					            u_xlat33 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat33 = inversesqrt(u_xlat33);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat33);
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat33 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat33 = min(u_xlat7.z, u_xlat33);
					            u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, 6.0);
					        u_xlat12.x = u_xlat6.w + -1.0;
					        u_xlat12.x = unity_SpecCube1_HDR.w * u_xlat12.x + 1.0;
					        u_xlat12.x = log2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.y;
					        u_xlat12.x = exp2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * u_xlat12.xxx;
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat11.xyz = u_xlat5.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat1.xyz;
					    SV_Target0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat31 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat31 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat12.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat12.xy);
					    u_xlat31 = u_xlat31 * u_xlat3.x;
					    SV_Target0.w = u_xlat31 * _Transparency;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat12.xyz = (bool(u_xlatb31)) ? u_xlat12.xyz : vs_TEXCOORD3.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat12.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat31, u_xlat12.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD2.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb33 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb33){
					        u_xlatb33 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb33){
					            u_xlat33 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat33 = inversesqrt(u_xlat33);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat33);
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat33 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat33 = min(u_xlat7.z, u_xlat33);
					            u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, 6.0);
					        u_xlat12.x = u_xlat6.w + -1.0;
					        u_xlat12.x = unity_SpecCube1_HDR.w * u_xlat12.x + 1.0;
					        u_xlat12.x = log2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.y;
					        u_xlat12.x = exp2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * u_xlat12.xxx;
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = abs(u_xlat30) + u_xlat1.x;
					    u_xlat10.x = u_xlat10.x + 9.99999975e-06;
					    u_xlat10.x = 0.5 / u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * 0.999999881;
					    u_xlat10.x = u_xlat1.x * u_xlat10.x;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat10.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = u_xlat10.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat12.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat10.x = -abs(u_xlat30) + 1.0;
					    u_xlat20 = u_xlat10.x * u_xlat10.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat10.x = u_xlat10.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat10.xyz;
					    SV_Target0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat26;
					bool u_xlatb26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1 = u_xlat24 + _Emissive_Fade_1Off;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * _Emissive_Intensity;
					    u_xlat9.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat9.xy);
					    u_xlat24 = u_xlat24 * u_xlat2.x;
					    SV_Target0.w = u_xlat24 * _Transparency;
					    u_xlat24 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat24 = u_xlat24 + u_xlat24;
					    u_xlat9.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat24)) + (-u_xlat0.xyz);
					    u_xlatb24 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb24){
					        u_xlat24 = dot(u_xlat9.xyz, u_xlat9.xyz);
					        u_xlat24 = inversesqrt(u_xlat24);
					        u_xlat2.xyz = vec3(u_xlat24) * u_xlat9.xyz;
					        u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat3.xyz = u_xlat3.xyz / u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat2.xyz;
					        u_xlatb5.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat3;
					            hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat3.x : u_xlat4.x;
					            hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat3.y : u_xlat4.y;
					            hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat3.z : u_xlat4.z;
					            u_xlat3 = hlslcc_movcTemp;
					        }
					        u_xlat24 = min(u_xlat3.y, u_xlat3.x);
					        u_xlat24 = min(u_xlat3.z, u_xlat24);
					        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat3.xyz;
					    } else {
					        u_xlat2.xyz = u_xlat9.xyz;
					    }
					    u_xlat2 = textureLod(unity_SpecCube0, u_xlat2.xyz, 6.0);
					    u_xlat24 = u_xlat2.w + -1.0;
					    u_xlat24 = unity_SpecCube0_HDR.w * u_xlat24 + 1.0;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * unity_SpecCube0_HDR.y;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat24 * unity_SpecCube0_HDR.x;
					    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat24);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat9.xyz, u_xlat9.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat26);
					            u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					            u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat5;
					                hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					                hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					                hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					                u_xlat5 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat5.y, u_xlat5.x);
					            u_xlat26 = min(u_xlat5.z, u_xlat26);
					            u_xlat5.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat9.xyz = u_xlat4.xyz * vec3(u_xlat26) + u_xlat5.xyz;
					        }
					        u_xlat4 = textureLod(unity_SpecCube1, u_xlat9.xyz, 6.0);
					        u_xlat9.x = u_xlat4.w + -1.0;
					        u_xlat9.x = unity_SpecCube1_HDR.w * u_xlat9.x + 1.0;
					        u_xlat9.x = log2(u_xlat9.x);
					        u_xlat9.x = u_xlat9.x * unity_SpecCube1_HDR.y;
					        u_xlat9.x = exp2(u_xlat9.x);
					        u_xlat9.x = u_xlat9.x * unity_SpecCube1_HDR.x;
					        u_xlat9.xyz = u_xlat4.xyz * u_xlat9.xxx;
					        u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz + (-u_xlat9.xyz);
					        u_xlat3.xyz = unity_SpecCube0_BoxMin.www * u_xlat2.xyz + u_xlat9.xyz;
					    }
					    u_xlat24 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat9.xyz = vec3(u_xlat24) * vs_TEXCOORD2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat9.xyz);
					    u_xlat2.x = u_xlat24 + u_xlat24;
					    u_xlat0.xyz = u_xlat9.xyz * (-u_xlat2.xxx) + u_xlat0.xyz;
					    u_xlat9.x = dot(u_xlat9.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
					    u_xlat24 = u_xlat24;
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.y = (-u_xlat24) + 1.0;
					    u_xlat2.zw = u_xlat2.xy * u_xlat2.xy;
					    u_xlat0.xy = u_xlat2.xy * u_xlat2.xw;
					    u_xlat0.xy = u_xlat2.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat9.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat8.x = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat8.xyz = u_xlat8.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat8.xyz;
					    SV_Target0.xyz = _Color.xyz * vec3(u_xlat1) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat10;
					vec3 u_xlat11;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat28 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat28 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat11.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat11.xy);
					    u_xlat28 = u_xlat28 * u_xlat3.x;
					    SV_Target0.w = u_xlat28 * _Transparency;
					    u_xlat28 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat28 = u_xlat28 + u_xlat28;
					    u_xlat11.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat28)) + (-u_xlat1.xyz);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat11.xyz, u_xlat11.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat11.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat11.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat28 = u_xlat3.w + -1.0;
					    u_xlat28 = unity_SpecCube0_HDR.w * u_xlat28 + 1.0;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat11.xyz, u_xlat11.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat11.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat11.xyz, 6.0);
					        u_xlat11.x = u_xlat5.w + -1.0;
					        u_xlat11.x = unity_SpecCube1_HDR.w * u_xlat11.x + 1.0;
					        u_xlat11.x = log2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.y;
					        u_xlat11.x = exp2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.x;
					        u_xlat11.xyz = u_xlat5.xyz * u_xlat11.xxx;
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + (-u_xlat11.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat11.xyz;
					    }
					    u_xlat28 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat11.xyz = vec3(u_xlat28) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat11.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat11.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat1.xyz;
					    SV_Target0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					vec3 u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat28 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat28 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat11.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat11.xy);
					    u_xlat28 = u_xlat28 * u_xlat3.x;
					    SV_Target0.w = u_xlat28 * _Transparency;
					    u_xlat28 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat28 = u_xlat28 + u_xlat28;
					    u_xlat11.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat28)) + (-u_xlat1.xyz);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat11.xyz, u_xlat11.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat11.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat11.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat28 = u_xlat3.w + -1.0;
					    u_xlat28 = unity_SpecCube0_HDR.w * u_xlat28 + 1.0;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat11.xyz, u_xlat11.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat11.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat11.xyz, 6.0);
					        u_xlat11.x = u_xlat5.w + -1.0;
					        u_xlat11.x = unity_SpecCube1_HDR.w * u_xlat11.x + 1.0;
					        u_xlat11.x = log2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.y;
					        u_xlat11.x = exp2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.x;
					        u_xlat11.xyz = u_xlat5.xyz * u_xlat11.xxx;
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + (-u_xlat11.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat11.xyz;
					    }
					    u_xlat28 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat11.xyz = vec3(u_xlat28) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat11.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat11.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = abs(u_xlat27) + u_xlat1.x;
					    u_xlat9.x = u_xlat9.x + 9.99999975e-06;
					    u_xlat9.x = 0.5 / u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * 0.999999881;
					    u_xlat9.x = u_xlat1.x * u_xlat9.x;
					    u_xlat1.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat11.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat9.x = -abs(u_xlat27) + 1.0;
					    u_xlat18 = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat9.x = u_xlat9.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    SV_Target0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat26;
					bool u_xlatb26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1 = u_xlat24 + _Emissive_Fade_1Off;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * _Emissive_Intensity;
					    u_xlat9.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat9.xy);
					    u_xlat24 = u_xlat24 * u_xlat2.x;
					    SV_Target0.w = u_xlat24 * _Transparency;
					    u_xlat24 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat24 = u_xlat24 + u_xlat24;
					    u_xlat9.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat24)) + (-u_xlat0.xyz);
					    u_xlatb24 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb24){
					        u_xlat24 = dot(u_xlat9.xyz, u_xlat9.xyz);
					        u_xlat24 = inversesqrt(u_xlat24);
					        u_xlat2.xyz = vec3(u_xlat24) * u_xlat9.xyz;
					        u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat3.xyz = u_xlat3.xyz / u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat2.xyz;
					        u_xlatb5.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat3;
					            hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat3.x : u_xlat4.x;
					            hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat3.y : u_xlat4.y;
					            hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat3.z : u_xlat4.z;
					            u_xlat3 = hlslcc_movcTemp;
					        }
					        u_xlat24 = min(u_xlat3.y, u_xlat3.x);
					        u_xlat24 = min(u_xlat3.z, u_xlat24);
					        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat3.xyz;
					    } else {
					        u_xlat2.xyz = u_xlat9.xyz;
					    }
					    u_xlat2 = textureLod(unity_SpecCube0, u_xlat2.xyz, 6.0);
					    u_xlat24 = u_xlat2.w + -1.0;
					    u_xlat24 = unity_SpecCube0_HDR.w * u_xlat24 + 1.0;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * unity_SpecCube0_HDR.y;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat24 * unity_SpecCube0_HDR.x;
					    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat24);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat9.xyz, u_xlat9.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat26);
					            u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					            u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat5;
					                hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					                hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					                hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					                u_xlat5 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat5.y, u_xlat5.x);
					            u_xlat26 = min(u_xlat5.z, u_xlat26);
					            u_xlat5.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat9.xyz = u_xlat4.xyz * vec3(u_xlat26) + u_xlat5.xyz;
					        }
					        u_xlat4 = textureLod(unity_SpecCube1, u_xlat9.xyz, 6.0);
					        u_xlat9.x = u_xlat4.w + -1.0;
					        u_xlat9.x = unity_SpecCube1_HDR.w * u_xlat9.x + 1.0;
					        u_xlat9.x = log2(u_xlat9.x);
					        u_xlat9.x = u_xlat9.x * unity_SpecCube1_HDR.y;
					        u_xlat9.x = exp2(u_xlat9.x);
					        u_xlat9.x = u_xlat9.x * unity_SpecCube1_HDR.x;
					        u_xlat9.xyz = u_xlat4.xyz * u_xlat9.xxx;
					        u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz + (-u_xlat9.xyz);
					        u_xlat3.xyz = unity_SpecCube0_BoxMin.www * u_xlat2.xyz + u_xlat9.xyz;
					    }
					    u_xlat24 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat9.xyz = vec3(u_xlat24) * vs_TEXCOORD2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat9.xyz);
					    u_xlat2.x = u_xlat24 + u_xlat24;
					    u_xlat0.xyz = u_xlat9.xyz * (-u_xlat2.xxx) + u_xlat0.xyz;
					    u_xlat9.x = dot(u_xlat9.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
					    u_xlat24 = u_xlat24;
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.y = (-u_xlat24) + 1.0;
					    u_xlat2.zw = u_xlat2.xy * u_xlat2.xy;
					    u_xlat0.xy = u_xlat2.xy * u_xlat2.xw;
					    u_xlat0.xy = u_xlat2.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat9.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat8.x = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat8.xyz = u_xlat8.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat8.xyz;
					    SV_Target0.xyz = _Color.xyz * vec3(u_xlat1) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat10;
					vec3 u_xlat11;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat28 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat28 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat11.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat11.xy);
					    u_xlat28 = u_xlat28 * u_xlat3.x;
					    SV_Target0.w = u_xlat28 * _Transparency;
					    u_xlat28 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat28 = u_xlat28 + u_xlat28;
					    u_xlat11.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat28)) + (-u_xlat1.xyz);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat11.xyz, u_xlat11.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat11.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat11.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat28 = u_xlat3.w + -1.0;
					    u_xlat28 = unity_SpecCube0_HDR.w * u_xlat28 + 1.0;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat11.xyz, u_xlat11.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat11.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat11.xyz, 6.0);
					        u_xlat11.x = u_xlat5.w + -1.0;
					        u_xlat11.x = unity_SpecCube1_HDR.w * u_xlat11.x + 1.0;
					        u_xlat11.x = log2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.y;
					        u_xlat11.x = exp2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.x;
					        u_xlat11.xyz = u_xlat5.xyz * u_xlat11.xxx;
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + (-u_xlat11.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat11.xyz;
					    }
					    u_xlat28 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat11.xyz = vec3(u_xlat28) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat11.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat11.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat1.xyz;
					    SV_Target0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					vec3 u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat28 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat28 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat11.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat11.xy);
					    u_xlat28 = u_xlat28 * u_xlat3.x;
					    SV_Target0.w = u_xlat28 * _Transparency;
					    u_xlat28 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat28 = u_xlat28 + u_xlat28;
					    u_xlat11.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat28)) + (-u_xlat1.xyz);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat11.xyz, u_xlat11.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat11.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat11.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat28 = u_xlat3.w + -1.0;
					    u_xlat28 = unity_SpecCube0_HDR.w * u_xlat28 + 1.0;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat11.xyz, u_xlat11.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat11.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat11.xyz, 6.0);
					        u_xlat11.x = u_xlat5.w + -1.0;
					        u_xlat11.x = unity_SpecCube1_HDR.w * u_xlat11.x + 1.0;
					        u_xlat11.x = log2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.y;
					        u_xlat11.x = exp2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.x;
					        u_xlat11.xyz = u_xlat5.xyz * u_xlat11.xxx;
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + (-u_xlat11.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat11.xyz;
					    }
					    u_xlat28 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat11.xyz = vec3(u_xlat28) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat11.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat11.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = abs(u_xlat27) + u_xlat1.x;
					    u_xlat9.x = u_xlat9.x + 9.99999975e-06;
					    u_xlat9.x = 0.5 / u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * 0.999999881;
					    u_xlat9.x = u_xlat1.x * u_xlat9.x;
					    u_xlat1.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat11.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat9.x = -abs(u_xlat27) + 1.0;
					    u_xlat18 = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat9.x = u_xlat9.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    SV_Target0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					float u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.x = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * _Emissive_Intensity;
					    u_xlat1.xyz = u_xlat1.xxx * _Color.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9 = u_xlat0.x * u_xlat0.x;
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.x = u_xlat0.x * u_xlat9;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.x = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * _Emissive_Intensity;
					    u_xlat1.xyz = u_xlat1.xxx * _Color.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    SV_Target0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.x = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * _Emissive_Intensity;
					    u_xlat1.xyz = u_xlat1.xxx * _Color.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    SV_Target0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					float u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.x = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * _Emissive_Intensity;
					    u_xlat1.xyz = u_xlat1.xxx * _Color.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9 = u_xlat0.x * u_xlat0.x;
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.x = u_xlat0.x * u_xlat9;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.x = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * _Emissive_Intensity;
					    u_xlat1.xyz = u_xlat1.xxx * _Color.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    SV_Target0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.x = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * _Emissive_Intensity;
					    u_xlat1.xyz = u_xlat1.xxx * _Color.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    SV_Target0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat29;
					bool u_xlatb29;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1 = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * _Emissive_Intensity;
					    u_xlat10.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat10.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlatb27 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb27){
					        u_xlatb27 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat10.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat10.xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat10.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb27)) ? u_xlat10.xyz : vs_TEXCOORD3.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat27 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat10.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat27, u_xlat10.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat27 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat10.x = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat10.x = u_xlat10.x + u_xlat10.x;
					    u_xlat10.xyz = vs_TEXCOORD2.xyz * (-u_xlat10.xxx) + (-u_xlat0.xyz);
					    u_xlat2.xyz = vec3(u_xlat27) * _LightColor0.xyz;
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat10.xyz, u_xlat10.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat10.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat10.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb29 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb29){
					        u_xlatb29 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb29){
					            u_xlat29 = dot(u_xlat10.xyz, u_xlat10.xyz);
					            u_xlat29 = inversesqrt(u_xlat29);
					            u_xlat5.xyz = u_xlat10.xyz * vec3(u_xlat29);
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat29 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat29 = min(u_xlat6.z, u_xlat29);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat10.xyz = u_xlat5.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat10.xyz, 6.0);
					        u_xlat10.x = u_xlat5.w + -1.0;
					        u_xlat10.x = unity_SpecCube1_HDR.w * u_xlat10.x + 1.0;
					        u_xlat10.x = log2(u_xlat10.x);
					        u_xlat10.x = u_xlat10.x * unity_SpecCube1_HDR.y;
					        u_xlat10.x = exp2(u_xlat10.x);
					        u_xlat10.x = u_xlat10.x * unity_SpecCube1_HDR.x;
					        u_xlat10.xyz = u_xlat5.xyz * u_xlat10.xxx;
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat10.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat10.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat10.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat10.xyz);
					    u_xlat29 = u_xlat27 + u_xlat27;
					    u_xlat0.xyz = u_xlat10.xyz * (-vec3(u_xlat29)) + u_xlat0.xyz;
					    u_xlat10.x = dot(u_xlat10.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat27 = u_xlat27;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat3.y = (-u_xlat27) + 1.0;
					    u_xlat3.zw = u_xlat3.xy * u_xlat3.xy;
					    u_xlat0.xy = u_xlat3.xy * u_xlat3.xw;
					    u_xlat0.xy = u_xlat3.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat3.x * 0.639999986;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat9.x = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat9.xyz;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat1) + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat31 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat31 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat12.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat12.xy);
					    u_xlat31 = u_xlat31 * u_xlat3.x;
					    SV_Target0.w = u_xlat31 * _Transparency;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat12.xyz = (bool(u_xlatb31)) ? u_xlat12.xyz : vs_TEXCOORD3.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat12.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat31, u_xlat12.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD2.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb33 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb33){
					        u_xlatb33 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb33){
					            u_xlat33 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat33 = inversesqrt(u_xlat33);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat33);
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat33 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat33 = min(u_xlat7.z, u_xlat33);
					            u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, 6.0);
					        u_xlat12.x = u_xlat6.w + -1.0;
					        u_xlat12.x = unity_SpecCube1_HDR.w * u_xlat12.x + 1.0;
					        u_xlat12.x = log2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.y;
					        u_xlat12.x = exp2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * u_xlat12.xxx;
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat11.xyz = u_xlat5.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat1.xyz;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    u_xlat30 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat31 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat31 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat12.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat12.xy);
					    u_xlat31 = u_xlat31 * u_xlat3.x;
					    SV_Target0.w = u_xlat31 * _Transparency;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat12.xyz = (bool(u_xlatb31)) ? u_xlat12.xyz : vs_TEXCOORD3.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat12.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat31, u_xlat12.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD2.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb33 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb33){
					        u_xlatb33 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb33){
					            u_xlat33 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat33 = inversesqrt(u_xlat33);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat33);
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat33 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat33 = min(u_xlat7.z, u_xlat33);
					            u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, 6.0);
					        u_xlat12.x = u_xlat6.w + -1.0;
					        u_xlat12.x = unity_SpecCube1_HDR.w * u_xlat12.x + 1.0;
					        u_xlat12.x = log2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.y;
					        u_xlat12.x = exp2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * u_xlat12.xxx;
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = abs(u_xlat30) + u_xlat1.x;
					    u_xlat10.x = u_xlat10.x + 9.99999975e-06;
					    u_xlat10.x = 0.5 / u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * 0.999999881;
					    u_xlat10.x = u_xlat1.x * u_xlat10.x;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat10.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = u_xlat10.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat12.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat10.x = -abs(u_xlat30) + 1.0;
					    u_xlat20 = u_xlat10.x * u_xlat10.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat10.x = u_xlat10.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat10.xyz;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    u_xlat30 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat29;
					bool u_xlatb29;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1 = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * _Emissive_Intensity;
					    u_xlat10.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat10.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlatb27 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb27){
					        u_xlatb27 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat10.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat10.xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat10.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb27)) ? u_xlat10.xyz : vs_TEXCOORD3.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat27 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat10.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat27, u_xlat10.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat27 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat10.x = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat10.x = u_xlat10.x + u_xlat10.x;
					    u_xlat10.xyz = vs_TEXCOORD2.xyz * (-u_xlat10.xxx) + (-u_xlat0.xyz);
					    u_xlat2.xyz = vec3(u_xlat27) * _LightColor0.xyz;
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat10.xyz, u_xlat10.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat10.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat10.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb29 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb29){
					        u_xlatb29 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb29){
					            u_xlat29 = dot(u_xlat10.xyz, u_xlat10.xyz);
					            u_xlat29 = inversesqrt(u_xlat29);
					            u_xlat5.xyz = u_xlat10.xyz * vec3(u_xlat29);
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat29 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat29 = min(u_xlat6.z, u_xlat29);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat10.xyz = u_xlat5.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat10.xyz, 6.0);
					        u_xlat10.x = u_xlat5.w + -1.0;
					        u_xlat10.x = unity_SpecCube1_HDR.w * u_xlat10.x + 1.0;
					        u_xlat10.x = log2(u_xlat10.x);
					        u_xlat10.x = u_xlat10.x * unity_SpecCube1_HDR.y;
					        u_xlat10.x = exp2(u_xlat10.x);
					        u_xlat10.x = u_xlat10.x * unity_SpecCube1_HDR.x;
					        u_xlat10.xyz = u_xlat5.xyz * u_xlat10.xxx;
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat10.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat10.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat10.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat10.xyz);
					    u_xlat29 = u_xlat27 + u_xlat27;
					    u_xlat0.xyz = u_xlat10.xyz * (-vec3(u_xlat29)) + u_xlat0.xyz;
					    u_xlat10.x = dot(u_xlat10.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat27 = u_xlat27;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat3.y = (-u_xlat27) + 1.0;
					    u_xlat3.zw = u_xlat3.xy * u_xlat3.xy;
					    u_xlat0.xy = u_xlat3.xy * u_xlat3.xw;
					    u_xlat0.xy = u_xlat3.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat3.x * 0.639999986;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat9.x = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz + u_xlat9.xyz;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat1) + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat31 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat31 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat12.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat12.xy);
					    u_xlat31 = u_xlat31 * u_xlat3.x;
					    SV_Target0.w = u_xlat31 * _Transparency;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat12.xyz = (bool(u_xlatb31)) ? u_xlat12.xyz : vs_TEXCOORD3.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat12.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat31, u_xlat12.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD2.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb33 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb33){
					        u_xlatb33 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb33){
					            u_xlat33 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat33 = inversesqrt(u_xlat33);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat33);
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat33 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat33 = min(u_xlat7.z, u_xlat33);
					            u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, 6.0);
					        u_xlat12.x = u_xlat6.w + -1.0;
					        u_xlat12.x = unity_SpecCube1_HDR.w * u_xlat12.x + 1.0;
					        u_xlat12.x = log2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.y;
					        u_xlat12.x = exp2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * u_xlat12.xxx;
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat11.xyz = u_xlat5.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat1.xyz;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    u_xlat30 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat31 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat31 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat12.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat12.xy);
					    u_xlat31 = u_xlat31 * u_xlat3.x;
					    SV_Target0.w = u_xlat31 * _Transparency;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat12.xyz = (bool(u_xlatb31)) ? u_xlat12.xyz : vs_TEXCOORD3.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat12.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat31, u_xlat12.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD2.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb33 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb33){
					        u_xlatb33 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb33){
					            u_xlat33 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat33 = inversesqrt(u_xlat33);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat33);
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat33 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat33 = min(u_xlat7.z, u_xlat33);
					            u_xlat7.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, 6.0);
					        u_xlat12.x = u_xlat6.w + -1.0;
					        u_xlat12.x = unity_SpecCube1_HDR.w * u_xlat12.x + 1.0;
					        u_xlat12.x = log2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.y;
					        u_xlat12.x = exp2(u_xlat12.x);
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * u_xlat12.xxx;
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = abs(u_xlat30) + u_xlat1.x;
					    u_xlat10.x = u_xlat10.x + 9.99999975e-06;
					    u_xlat10.x = 0.5 / u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * 0.999999881;
					    u_xlat10.x = u_xlat1.x * u_xlat10.x;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat10.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = u_xlat10.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat12.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat10.x = -abs(u_xlat30) + 1.0;
					    u_xlat20 = u_xlat10.x * u_xlat10.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat10.x = u_xlat10.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat10.xyz;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    u_xlat30 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat26;
					bool u_xlatb26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1 = u_xlat24 + _Emissive_Fade_1Off;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * _Emissive_Intensity;
					    u_xlat9.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat9.xy);
					    u_xlat24 = u_xlat24 * u_xlat2.x;
					    SV_Target0.w = u_xlat24 * _Transparency;
					    u_xlat24 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat24 = u_xlat24 + u_xlat24;
					    u_xlat9.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat24)) + (-u_xlat0.xyz);
					    u_xlatb24 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb24){
					        u_xlat24 = dot(u_xlat9.xyz, u_xlat9.xyz);
					        u_xlat24 = inversesqrt(u_xlat24);
					        u_xlat2.xyz = vec3(u_xlat24) * u_xlat9.xyz;
					        u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat3.xyz = u_xlat3.xyz / u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat2.xyz;
					        u_xlatb5.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat3;
					            hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat3.x : u_xlat4.x;
					            hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat3.y : u_xlat4.y;
					            hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat3.z : u_xlat4.z;
					            u_xlat3 = hlslcc_movcTemp;
					        }
					        u_xlat24 = min(u_xlat3.y, u_xlat3.x);
					        u_xlat24 = min(u_xlat3.z, u_xlat24);
					        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat3.xyz;
					    } else {
					        u_xlat2.xyz = u_xlat9.xyz;
					    }
					    u_xlat2 = textureLod(unity_SpecCube0, u_xlat2.xyz, 6.0);
					    u_xlat24 = u_xlat2.w + -1.0;
					    u_xlat24 = unity_SpecCube0_HDR.w * u_xlat24 + 1.0;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * unity_SpecCube0_HDR.y;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat24 * unity_SpecCube0_HDR.x;
					    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat24);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat9.xyz, u_xlat9.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat26);
					            u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					            u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat5;
					                hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					                hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					                hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					                u_xlat5 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat5.y, u_xlat5.x);
					            u_xlat26 = min(u_xlat5.z, u_xlat26);
					            u_xlat5.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat9.xyz = u_xlat4.xyz * vec3(u_xlat26) + u_xlat5.xyz;
					        }
					        u_xlat4 = textureLod(unity_SpecCube1, u_xlat9.xyz, 6.0);
					        u_xlat9.x = u_xlat4.w + -1.0;
					        u_xlat9.x = unity_SpecCube1_HDR.w * u_xlat9.x + 1.0;
					        u_xlat9.x = log2(u_xlat9.x);
					        u_xlat9.x = u_xlat9.x * unity_SpecCube1_HDR.y;
					        u_xlat9.x = exp2(u_xlat9.x);
					        u_xlat9.x = u_xlat9.x * unity_SpecCube1_HDR.x;
					        u_xlat9.xyz = u_xlat4.xyz * u_xlat9.xxx;
					        u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz + (-u_xlat9.xyz);
					        u_xlat3.xyz = unity_SpecCube0_BoxMin.www * u_xlat2.xyz + u_xlat9.xyz;
					    }
					    u_xlat24 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat9.xyz = vec3(u_xlat24) * vs_TEXCOORD2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat9.xyz);
					    u_xlat2.x = u_xlat24 + u_xlat24;
					    u_xlat0.xyz = u_xlat9.xyz * (-u_xlat2.xxx) + u_xlat0.xyz;
					    u_xlat9.x = dot(u_xlat9.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
					    u_xlat24 = u_xlat24;
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.y = (-u_xlat24) + 1.0;
					    u_xlat2.zw = u_xlat2.xy * u_xlat2.xy;
					    u_xlat0.xy = u_xlat2.xy * u_xlat2.xw;
					    u_xlat0.xy = u_xlat2.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat9.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat8.x = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat8.xyz = u_xlat8.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat8.xyz;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat1) + u_xlat0.xyz;
					    u_xlat24 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat24 = u_xlat24 * _ProjectionParams.z;
					    u_xlat24 = max(u_xlat24, 0.0);
					    u_xlat24 = u_xlat24 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat10;
					vec3 u_xlat11;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat28 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat28 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat11.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat11.xy);
					    u_xlat28 = u_xlat28 * u_xlat3.x;
					    SV_Target0.w = u_xlat28 * _Transparency;
					    u_xlat28 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat28 = u_xlat28 + u_xlat28;
					    u_xlat11.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat28)) + (-u_xlat1.xyz);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat11.xyz, u_xlat11.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat11.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat11.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat28 = u_xlat3.w + -1.0;
					    u_xlat28 = unity_SpecCube0_HDR.w * u_xlat28 + 1.0;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat11.xyz, u_xlat11.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat11.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat11.xyz, 6.0);
					        u_xlat11.x = u_xlat5.w + -1.0;
					        u_xlat11.x = unity_SpecCube1_HDR.w * u_xlat11.x + 1.0;
					        u_xlat11.x = log2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.y;
					        u_xlat11.x = exp2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.x;
					        u_xlat11.xyz = u_xlat5.xyz * u_xlat11.xxx;
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + (-u_xlat11.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat11.xyz;
					    }
					    u_xlat28 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat11.xyz = vec3(u_xlat28) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat11.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat11.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat1.xyz;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					vec3 u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat28 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat28 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat11.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat11.xy);
					    u_xlat28 = u_xlat28 * u_xlat3.x;
					    SV_Target0.w = u_xlat28 * _Transparency;
					    u_xlat28 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat28 = u_xlat28 + u_xlat28;
					    u_xlat11.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat28)) + (-u_xlat1.xyz);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat11.xyz, u_xlat11.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat11.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat11.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat28 = u_xlat3.w + -1.0;
					    u_xlat28 = unity_SpecCube0_HDR.w * u_xlat28 + 1.0;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat11.xyz, u_xlat11.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat11.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat11.xyz, 6.0);
					        u_xlat11.x = u_xlat5.w + -1.0;
					        u_xlat11.x = unity_SpecCube1_HDR.w * u_xlat11.x + 1.0;
					        u_xlat11.x = log2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.y;
					        u_xlat11.x = exp2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.x;
					        u_xlat11.xyz = u_xlat5.xyz * u_xlat11.xxx;
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + (-u_xlat11.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat11.xyz;
					    }
					    u_xlat28 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat11.xyz = vec3(u_xlat28) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat11.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat11.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = abs(u_xlat27) + u_xlat1.x;
					    u_xlat9.x = u_xlat9.x + 9.99999975e-06;
					    u_xlat9.x = 0.5 / u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * 0.999999881;
					    u_xlat9.x = u_xlat1.x * u_xlat9.x;
					    u_xlat1.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat11.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat9.x = -abs(u_xlat27) + 1.0;
					    u_xlat18 = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat9.x = u_xlat9.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat26;
					bool u_xlatb26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1 = u_xlat24 + _Emissive_Fade_1Off;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * _Emissive_Intensity;
					    u_xlat9.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat9.xy);
					    u_xlat24 = u_xlat24 * u_xlat2.x;
					    SV_Target0.w = u_xlat24 * _Transparency;
					    u_xlat24 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat24 = u_xlat24 + u_xlat24;
					    u_xlat9.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat24)) + (-u_xlat0.xyz);
					    u_xlatb24 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb24){
					        u_xlat24 = dot(u_xlat9.xyz, u_xlat9.xyz);
					        u_xlat24 = inversesqrt(u_xlat24);
					        u_xlat2.xyz = vec3(u_xlat24) * u_xlat9.xyz;
					        u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat3.xyz = u_xlat3.xyz / u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat2.xyz;
					        u_xlatb5.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat3;
					            hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat3.x : u_xlat4.x;
					            hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat3.y : u_xlat4.y;
					            hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat3.z : u_xlat4.z;
					            u_xlat3 = hlslcc_movcTemp;
					        }
					        u_xlat24 = min(u_xlat3.y, u_xlat3.x);
					        u_xlat24 = min(u_xlat3.z, u_xlat24);
					        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat3.xyz;
					    } else {
					        u_xlat2.xyz = u_xlat9.xyz;
					    }
					    u_xlat2 = textureLod(unity_SpecCube0, u_xlat2.xyz, 6.0);
					    u_xlat24 = u_xlat2.w + -1.0;
					    u_xlat24 = unity_SpecCube0_HDR.w * u_xlat24 + 1.0;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * unity_SpecCube0_HDR.y;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat24 * unity_SpecCube0_HDR.x;
					    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat24);
					    u_xlatb26 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb26){
					        u_xlatb26 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb26){
					            u_xlat26 = dot(u_xlat9.xyz, u_xlat9.xyz);
					            u_xlat26 = inversesqrt(u_xlat26);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat26);
					            u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					            u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat5;
					                hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					                hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					                hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					                u_xlat5 = hlslcc_movcTemp;
					            }
					            u_xlat26 = min(u_xlat5.y, u_xlat5.x);
					            u_xlat26 = min(u_xlat5.z, u_xlat26);
					            u_xlat5.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat9.xyz = u_xlat4.xyz * vec3(u_xlat26) + u_xlat5.xyz;
					        }
					        u_xlat4 = textureLod(unity_SpecCube1, u_xlat9.xyz, 6.0);
					        u_xlat9.x = u_xlat4.w + -1.0;
					        u_xlat9.x = unity_SpecCube1_HDR.w * u_xlat9.x + 1.0;
					        u_xlat9.x = log2(u_xlat9.x);
					        u_xlat9.x = u_xlat9.x * unity_SpecCube1_HDR.y;
					        u_xlat9.x = exp2(u_xlat9.x);
					        u_xlat9.x = u_xlat9.x * unity_SpecCube1_HDR.x;
					        u_xlat9.xyz = u_xlat4.xyz * u_xlat9.xxx;
					        u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz + (-u_xlat9.xyz);
					        u_xlat3.xyz = unity_SpecCube0_BoxMin.www * u_xlat2.xyz + u_xlat9.xyz;
					    }
					    u_xlat24 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat9.xyz = vec3(u_xlat24) * vs_TEXCOORD2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat9.xyz);
					    u_xlat2.x = u_xlat24 + u_xlat24;
					    u_xlat0.xyz = u_xlat9.xyz * (-u_xlat2.xxx) + u_xlat0.xyz;
					    u_xlat9.x = dot(u_xlat9.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
					    u_xlat24 = u_xlat24;
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.y = (-u_xlat24) + 1.0;
					    u_xlat2.zw = u_xlat2.xy * u_xlat2.xy;
					    u_xlat0.xy = u_xlat2.xy * u_xlat2.xw;
					    u_xlat0.xy = u_xlat2.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat9.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat8.x = u_xlat0.y * 2.23517418e-08 + 0.0399999991;
					    u_xlat8.xyz = u_xlat8.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat8.xyz;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat1) + u_xlat0.xyz;
					    u_xlat24 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat24 = u_xlat24 * _ProjectionParams.z;
					    u_xlat24 = max(u_xlat24, 0.0);
					    u_xlat24 = u_xlat24 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat10;
					vec3 u_xlat11;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat28 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat28 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat11.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat11.xy);
					    u_xlat28 = u_xlat28 * u_xlat3.x;
					    SV_Target0.w = u_xlat28 * _Transparency;
					    u_xlat28 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat28 = u_xlat28 + u_xlat28;
					    u_xlat11.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat28)) + (-u_xlat1.xyz);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat11.xyz, u_xlat11.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat11.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat11.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat28 = u_xlat3.w + -1.0;
					    u_xlat28 = unity_SpecCube0_HDR.w * u_xlat28 + 1.0;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat11.xyz, u_xlat11.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat11.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat11.xyz, 6.0);
					        u_xlat11.x = u_xlat5.w + -1.0;
					        u_xlat11.x = unity_SpecCube1_HDR.w * u_xlat11.x + 1.0;
					        u_xlat11.x = log2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.y;
					        u_xlat11.x = exp2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.x;
					        u_xlat11.xyz = u_xlat5.xyz * u_xlat11.xxx;
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + (-u_xlat11.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat11.xyz;
					    }
					    u_xlat28 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat11.xyz = vec3(u_xlat28) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat11.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat11.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat1.xyz;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_8[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					vec3 u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat28 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2 = u_xlat28 + _Emissive_Fade_1Off;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * _Emissive_Intensity;
					    u_xlat11.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat11.xy);
					    u_xlat28 = u_xlat28 * u_xlat3.x;
					    SV_Target0.w = u_xlat28 * _Transparency;
					    u_xlat28 = dot((-u_xlat1.xyz), vs_TEXCOORD2.xyz);
					    u_xlat28 = u_xlat28 + u_xlat28;
					    u_xlat11.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat28)) + (-u_xlat1.xyz);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat11.xyz, u_xlat11.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat11.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat11.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat28 = u_xlat3.w + -1.0;
					    u_xlat28 = unity_SpecCube0_HDR.w * u_xlat28 + 1.0;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat11.xyz, u_xlat11.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat11.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat11.xyz, 6.0);
					        u_xlat11.x = u_xlat5.w + -1.0;
					        u_xlat11.x = unity_SpecCube1_HDR.w * u_xlat11.x + 1.0;
					        u_xlat11.x = log2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.y;
					        u_xlat11.x = exp2(u_xlat11.x);
					        u_xlat11.x = u_xlat11.x * unity_SpecCube1_HDR.x;
					        u_xlat11.xyz = u_xlat5.xyz * u_xlat11.xxx;
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + (-u_xlat11.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat11.xyz;
					    }
					    u_xlat28 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat11.xyz = vec3(u_xlat28) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat11.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat11.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = abs(u_xlat27) + u_xlat1.x;
					    u_xlat9.x = u_xlat9.x + 9.99999975e-06;
					    u_xlat9.x = 0.5 / u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * 0.999999881;
					    u_xlat9.x = u_xlat1.x * u_xlat9.x;
					    u_xlat1.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat11.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat9.x = -abs(u_xlat27) + 1.0;
					    u_xlat18 = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat9.x = u_xlat9.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat11.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat2) + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
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
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					float u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.x = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * _Emissive_Intensity;
					    u_xlat1.xyz = u_xlat1.xxx * _Color.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9 = u_xlat0.x * u_xlat0.x;
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.x = u_xlat0.x * u_xlat9;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat27 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
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
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.x = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * _Emissive_Intensity;
					    u_xlat1.xyz = u_xlat1.xxx * _Color.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat27 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
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
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.x = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * _Emissive_Intensity;
					    u_xlat1.xyz = u_xlat1.xxx * _Color.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat27 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					float u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.x = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * _Emissive_Intensity;
					    u_xlat1.xyz = u_xlat1.xxx * _Color.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9 = u_xlat0.x * u_xlat0.x;
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.x = u_xlat0.x * u_xlat9;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat27 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.x = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * _Emissive_Intensity;
					    u_xlat1.xyz = u_xlat1.xxx * _Color.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.479999959, 0.479999959, 0.479999959);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat27 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						float _Emissive_Intensity;
						float _Emissive_Fade_1Off;
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _Texture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.x = u_xlat27 + _Emissive_Fade_1Off;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x * _Emissive_Intensity;
					    u_xlat1.xyz = u_xlat1.xxx * _Color.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat27 = u_xlat27 * u_xlat2.x;
					    SV_Target0.w = u_xlat27 * _Transparency;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD2.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.y;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD3.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD3.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 2.23517418e-08 + 0.0399999991;
					    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat27 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 99981
			Program "vp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD4.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD4.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD4.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_0[8];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD4.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD4.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[6];
						vec4 _tex4coord_ST;
						vec4 _texcoord_ST;
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
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD4.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat12 = u_xlat12 * u_xlat2.x;
					    SV_Target0.w = u_xlat12 * _Transparency;
					    u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTexture0, vec2(u_xlat13));
					    u_xlat12 = u_xlat12 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					float u_xlat14;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat13 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    SV_Target0.w = u_xlat13 * _Transparency;
					    u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb13)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat13, u_xlat14);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat13) * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat3.xy);
					    u_xlat16 = u_xlat16 * u_xlat3.x;
					    SV_Target0.w = u_xlat16 * _Transparency;
					    u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb16)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat16, u_xlat17);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTexture0, vec2(u_xlat17));
					    u_xlat16 = u_xlat16 * u_xlat3.x;
					    u_xlat3.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat4.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = abs(u_xlat15) + u_xlat16;
					    u_xlat5.x = u_xlat5.x + 9.99999975e-06;
					    u_xlat5.x = 0.5 / u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * 0.999999881;
					    u_xlat5.x = u_xlat16 * u_xlat5.x;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat5.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat1 = texture(_Texture, u_xlat1.xy);
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    SV_Target0.w = u_xlat9 * _Transparency;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb9)) ? u_xlat1.xyz : vs_TEXCOORD3.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat4 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat9, u_xlat4);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat9 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat9) * _LightColor0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = u_xlat9 + u_xlat9;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat9)) + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat4;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.x = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat4.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat4.xy);
					    u_xlat1.x = u_xlat1.x * u_xlat2.x;
					    SV_Target0.w = u_xlat1.x * _Transparency;
					    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb1){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat4.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat4.x, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat1.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat10 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = max(u_xlat9, 0.00100000005);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat13 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    SV_Target0.w = u_xlat13 * _Transparency;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13, u_xlat6);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat2.xyz = vec3(u_xlat13) * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = abs(u_xlat12) + u_xlat1.x;
					    u_xlat4.x = u_xlat4.x + 9.99999975e-06;
					    u_xlat4.x = 0.5 / u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * 0.999999881;
					    u_xlat4.x = u_xlat1.x * u_xlat4.x;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat12 = u_xlat12 * u_xlat2.x;
					    SV_Target0.w = u_xlat12 * _Transparency;
					    u_xlat2 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat2 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat2;
					    u_xlat2 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_WorldToLight[3];
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlatb13 = 0.0<u_xlat2.z;
					    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
					    u_xlat3.xy = u_xlat2.xy / u_xlat2.ww;
					    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat13 = u_xlat13 * u_xlat3.w;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					vec2 u_xlat8;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    SV_Target0.w = u_xlat16 * _Transparency;
					    u_xlat2 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat2 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat2;
					    u_xlat2 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_WorldToLight[3];
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb16)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat8.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat8.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlatb3 = 0.0<u_xlat2.z;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat8.xy = u_xlat2.xy / u_xlat2.ww;
					    u_xlat8.xy = u_xlat8.xy + vec2(0.5, 0.5);
					    u_xlat4 = texture(_LightTexture0, u_xlat8.xy);
					    u_xlat17 = u_xlat3.x * u_xlat4.w;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat2.x = u_xlat17 * u_xlat3.x;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					bool u_xlatb17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat3.xy);
					    u_xlat16 = u_xlat16 * u_xlat3.x;
					    SV_Target0.w = u_xlat16 * _Transparency;
					    u_xlat3 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat3 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat3;
					    u_xlat3 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat3;
					    u_xlat3 = u_xlat3 + unity_WorldToLight[3];
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb16)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat16, u_xlat17);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlatb17 = 0.0<u_xlat3.z;
					    u_xlat17 = u_xlatb17 ? 1.0 : float(0.0);
					    u_xlat4.xy = u_xlat3.xy / u_xlat3.ww;
					    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xy);
					    u_xlat17 = u_xlat17 * u_xlat4.w;
					    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat3.xx);
					    u_xlat17 = u_xlat17 * u_xlat3.x;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat3.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat4.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = abs(u_xlat15) + u_xlat16;
					    u_xlat5.x = u_xlat5.x + 9.99999975e-06;
					    u_xlat5.x = 0.5 / u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * 0.999999881;
					    u_xlat5.x = u_xlat16 * u_xlat5.x;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat5.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat12 = u_xlat12 * u_xlat2.x;
					    SV_Target0.w = u_xlat12 * _Transparency;
					    u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat13));
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xyz);
					    u_xlat13 = u_xlat2.w * u_xlat3.x;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					float u_xlat14;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat13 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    SV_Target0.w = u_xlat13 * _Transparency;
					    u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb13)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat13, u_xlat14);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat14));
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xyz);
					    u_xlat2.x = u_xlat2.w * u_xlat3.x;
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat13) * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat3.xy);
					    u_xlat16 = u_xlat16 * u_xlat3.x;
					    SV_Target0.w = u_xlat16 * _Transparency;
					    u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb16)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat16, u_xlat17);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat17));
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xyz);
					    u_xlat17 = u_xlat3.w * u_xlat4.x;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat3.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat4.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = abs(u_xlat15) + u_xlat16;
					    u_xlat5.x = u_xlat5.x + 9.99999975e-06;
					    u_xlat5.x = 0.5 / u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * 0.999999881;
					    u_xlat5.x = u_xlat16 * u_xlat5.x;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat5.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat7;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat1 = texture(_Texture, u_xlat1.xy);
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    SV_Target0.w = u_xlat9 * _Transparency;
					    u_xlat1.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_WorldToLight[3].xy;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat7 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9, u_xlat7);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat9 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlat9 = u_xlat9 * u_xlat1.w;
					    u_xlat1.xyz = vec3(u_xlat9) * _LightColor0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = u_xlat9 + u_xlat9;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat9)) + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat4;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.x = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat4.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat4.xy);
					    u_xlat1.x = u_xlat1.x * u_xlat2.x;
					    SV_Target0.w = u_xlat1.x * _Transparency;
					    u_xlat1.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_WorldToLight[3].xy;
					    u_xlatb7 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb7){
					        u_xlatb7 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb7)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat7 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat10 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat10, u_xlat7);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat7 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlat1.x = u_xlat7 * u_xlat2.w;
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat10 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = max(u_xlat9, 0.00100000005);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat10;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat13 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    SV_Target0.w = u_xlat13 * _Transparency;
					    u_xlat2.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat2.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_WorldToLight[3].xy;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb13)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat10 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat13, u_xlat10);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xy);
					    u_xlat13 = u_xlat13 * u_xlat2.w;
					    u_xlat2.xyz = vec3(u_xlat13) * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = abs(u_xlat12) + u_xlat1.x;
					    u_xlat4.x = u_xlat4.x + 9.99999975e-06;
					    u_xlat4.x = 0.5 / u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * 0.999999881;
					    u_xlat4.x = u_xlat1.x * u_xlat4.x;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat12 = u_xlat12 * u_xlat2.x;
					    SV_Target0.w = u_xlat12 * _Transparency;
					    u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTexture0, vec2(u_xlat13));
					    u_xlat12 = u_xlat12 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					float u_xlat14;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat13 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    SV_Target0.w = u_xlat13 * _Transparency;
					    u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb13)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat13, u_xlat14);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat13) * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat3.xy);
					    u_xlat16 = u_xlat16 * u_xlat3.x;
					    SV_Target0.w = u_xlat16 * _Transparency;
					    u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb16)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat16, u_xlat17);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTexture0, vec2(u_xlat17));
					    u_xlat16 = u_xlat16 * u_xlat3.x;
					    u_xlat3.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat4.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = abs(u_xlat15) + u_xlat16;
					    u_xlat5.x = u_xlat5.x + 9.99999975e-06;
					    u_xlat5.x = 0.5 / u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * 0.999999881;
					    u_xlat5.x = u_xlat16 * u_xlat5.x;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat5.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    u_xlat15 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat1 = texture(_Texture, u_xlat1.xy);
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    SV_Target0.w = u_xlat9 * _Transparency;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb9)) ? u_xlat1.xyz : vs_TEXCOORD3.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat4 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat9, u_xlat4);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat9 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat9) * _LightColor0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = u_xlat9 + u_xlat9;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat9)) + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat9 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat4;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.x = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat4.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat4.xy);
					    u_xlat1.x = u_xlat1.x * u_xlat2.x;
					    SV_Target0.w = u_xlat1.x * _Transparency;
					    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb1){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat4.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat4.x, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat1.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat10 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = max(u_xlat9, 0.00100000005);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 _LightColor0;
						vec4 unused_0_2[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat13 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    SV_Target0.w = u_xlat13 * _Transparency;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13, u_xlat6);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat2.xyz = vec3(u_xlat13) * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = abs(u_xlat12) + u_xlat1.x;
					    u_xlat4.x = u_xlat4.x + 9.99999975e-06;
					    u_xlat4.x = 0.5 / u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * 0.999999881;
					    u_xlat4.x = u_xlat1.x * u_xlat4.x;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat12 = u_xlat12 * u_xlat2.x;
					    SV_Target0.w = u_xlat12 * _Transparency;
					    u_xlat2 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat2 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat2;
					    u_xlat2 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_WorldToLight[3];
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlatb13 = 0.0<u_xlat2.z;
					    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
					    u_xlat3.xy = u_xlat2.xy / u_xlat2.ww;
					    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat13 = u_xlat13 * u_xlat3.w;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					vec2 u_xlat8;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    SV_Target0.w = u_xlat16 * _Transparency;
					    u_xlat2 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat2 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat2;
					    u_xlat2 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_WorldToLight[3];
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb16)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat8.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat8.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlatb3 = 0.0<u_xlat2.z;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat8.xy = u_xlat2.xy / u_xlat2.ww;
					    u_xlat8.xy = u_xlat8.xy + vec2(0.5, 0.5);
					    u_xlat4 = texture(_LightTexture0, u_xlat8.xy);
					    u_xlat17 = u_xlat3.x * u_xlat4.w;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat2.x = u_xlat17 * u_xlat3.x;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					bool u_xlatb17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat3.xy);
					    u_xlat16 = u_xlat16 * u_xlat3.x;
					    SV_Target0.w = u_xlat16 * _Transparency;
					    u_xlat3 = vs_TEXCOORD3.yyyy * unity_WorldToLight[1];
					    u_xlat3 = unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat3;
					    u_xlat3 = unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat3;
					    u_xlat3 = u_xlat3 + unity_WorldToLight[3];
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb16)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat16, u_xlat17);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlatb17 = 0.0<u_xlat3.z;
					    u_xlat17 = u_xlatb17 ? 1.0 : float(0.0);
					    u_xlat4.xy = u_xlat3.xy / u_xlat3.ww;
					    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xy);
					    u_xlat17 = u_xlat17 * u_xlat4.w;
					    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat3.xx);
					    u_xlat17 = u_xlat17 * u_xlat3.x;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat3.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat4.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = abs(u_xlat15) + u_xlat16;
					    u_xlat5.x = u_xlat5.x + 9.99999975e-06;
					    u_xlat5.x = 0.5 / u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * 0.999999881;
					    u_xlat5.x = u_xlat16 * u_xlat5.x;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat5.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    u_xlat15 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat12 = u_xlat12 * u_xlat2.x;
					    SV_Target0.w = u_xlat12 * _Transparency;
					    u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat13));
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xyz);
					    u_xlat13 = u_xlat2.w * u_xlat3.x;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 0.639999986;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					float u_xlat14;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat13 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    SV_Target0.w = u_xlat13 * _Transparency;
					    u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb13)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat13, u_xlat14);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat14));
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xyz);
					    u_xlat2.x = u_xlat2.w * u_xlat3.x;
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat13) * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat3.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat3 = texture(_Texture, u_xlat3.xy);
					    u_xlat16 = u_xlat16 * u_xlat3.x;
					    SV_Target0.w = u_xlat16 * _Transparency;
					    u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb16)) ? u_xlat4.xyz : vs_TEXCOORD3.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat16, u_xlat17);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat17));
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xyz);
					    u_xlat17 = u_xlat3.w * u_xlat4.x;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat3.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat4.xyz = vec3(u_xlat16) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = abs(u_xlat15) + u_xlat16;
					    u_xlat5.x = u_xlat5.x + 9.99999975e-06;
					    u_xlat5.x = 0.5 / u_xlat5.x;
					    u_xlat5.x = u_xlat5.x * 0.999999881;
					    u_xlat5.x = u_xlat16 * u_xlat5.x;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat5.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    u_xlat15 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat7;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat1.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat1 = texture(_Texture, u_xlat1.xy);
					    u_xlat9 = u_xlat9 * u_xlat1.x;
					    SV_Target0.w = u_xlat9 * _Transparency;
					    u_xlat1.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_WorldToLight[3].xy;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat7 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9, u_xlat7);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat9 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlat9 = u_xlat9 * u_xlat1.w;
					    u_xlat1.xyz = vec3(u_xlat9) * _LightColor0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = u_xlat9 + u_xlat9;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat9)) + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 0.639999986;
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat9 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat4;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.x = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat4.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat4.xy);
					    u_xlat1.x = u_xlat1.x * u_xlat2.x;
					    SV_Target0.w = u_xlat1.x * _Transparency;
					    u_xlat1.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_WorldToLight[3].xy;
					    u_xlatb7 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb7){
					        u_xlatb7 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb7)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat7 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat10 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat10, u_xlat7);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat7 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlat1.x = u_xlat7 * u_xlat2.w;
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat10 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xyz = vec3(u_xlat10) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = max(u_xlat9, 0.00100000005);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat0.x = u_xlat0.x * 6.00012016;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0399999991;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						vec4 _Texture_ST;
						float _Transparency;
						vec4 unused_0_6[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _Texture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat10;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat13 = (-vs_TEXCOORD0.z) + 1.0;
					    u_xlat2.xy = vs_TEXCOORD1.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat2 = texture(_Texture, u_xlat2.xy);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    SV_Target0.w = u_xlat13 * _Transparency;
					    u_xlat2.xy = vs_TEXCOORD3.yy * unity_WorldToLight[1].xy;
					    u_xlat2.xy = unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_WorldToLight[3].xy;
					    u_xlatb13 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb13){
					        u_xlatb13 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD3.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb13)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat10 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat13, u_xlat10);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat13 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xy);
					    u_xlat13 = u_xlat13 * u_xlat2.w;
					    u_xlat2.xyz = vec3(u_xlat13) * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.x = abs(u_xlat12) + u_xlat1.x;
					    u_xlat4.x = u_xlat4.x + 9.99999975e-06;
					    u_xlat4.x = 0.5 / u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * 0.999999881;
					    u_xlat4.x = u_xlat1.x * u_xlat4.x;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 0.959999979 + 0.0399999991;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    return;
					}"
				}
			}
		}
		Pass {
			Name "ShadowCaster"
			Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			ColorMask RGB -1
			GpuProgramID 208897
			Program "vp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
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
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat6 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat6);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
					    vs_TEXCOORD1 = in_TEXCOORD0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
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
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat6 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat6);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
					    vs_TEXCOORD1 = in_TEXCOORD0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
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
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat6 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat6);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
					    vs_TEXCOORD1 = in_TEXCOORD0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
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
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_TEXCOORD1 = in_TEXCOORD0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
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
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_TEXCOORD1 = in_TEXCOORD0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
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
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_TEXCOORD1 = in_TEXCOORD0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
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
						vec4 unused_0_0[6];
						vec4 _Texture_ST;
						float _Transparency;
					};
					uniform  sampler2D _Texture;
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD2.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat0 = texture(_Texture, u_xlat0.xy);
					    u_xlat1 = (-vs_TEXCOORD1.z) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1;
					    u_xlat0.x = u_xlat0.x * _Transparency;
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
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
						vec4 unused_0_0[6];
						vec4 _Texture_ST;
						float _Transparency;
					};
					uniform  sampler2D _Texture;
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD2.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat0 = texture(_Texture, u_xlat0.xy);
					    u_xlat1 = (-vs_TEXCOORD1.z) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1;
					    u_xlat0.x = u_xlat0.x * _Transparency;
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
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
						vec4 unused_0_0[6];
						vec4 _Texture_ST;
						float _Transparency;
					};
					uniform  sampler2D _Texture;
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD2.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat0 = texture(_Texture, u_xlat0.xy);
					    u_xlat1 = (-vs_TEXCOORD1.z) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1;
					    u_xlat0.x = u_xlat0.x * _Transparency;
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
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
						vec4 unused_0_0[6];
						vec4 _Texture_ST;
						float _Transparency;
					};
					uniform  sampler2D _Texture;
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD2.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat0 = texture(_Texture, u_xlat0.xy);
					    u_xlat1 = (-vs_TEXCOORD1.z) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1;
					    u_xlat0.x = u_xlat0.x * _Transparency;
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
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
						vec4 unused_0_0[6];
						vec4 _Texture_ST;
						float _Transparency;
					};
					uniform  sampler2D _Texture;
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD2.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat0 = texture(_Texture, u_xlat0.xy);
					    u_xlat1 = (-vs_TEXCOORD1.z) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1;
					    u_xlat0.x = u_xlat0.x * _Transparency;
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
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
						vec4 unused_0_0[6];
						vec4 _Texture_ST;
						float _Transparency;
					};
					uniform  sampler2D _Texture;
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD2.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat0 = texture(_Texture, u_xlat0.xy);
					    u_xlat1 = (-vs_TEXCOORD1.z) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1;
					    u_xlat0.x = u_xlat0.x * _Transparency;
					    u_xlat0.z = u_xlat0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}