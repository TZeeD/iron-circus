Shader "Custom/HologramShader" {
	Properties {
		_Brightness ("Brightness", Range(0.1, 6)) = 3
		_Alpha ("Alpha", Range(0, 1)) = 1
		_Direction ("Direction", Vector) = (0,1,0,0)
		_MainTex ("MainTexture", 2D) = "white" {}
		_MainColor ("MainColor", Vector) = (1,1,1,1)
		_RimColor ("Rim Color", Vector) = (1,1,1,1)
		_RimPower ("Rim Power", Range(0.1, 10)) = 5
		_ScanTiling ("Scan Tiling", Range(0.01, 100)) = 0.05
		_ScanTileSize ("Scan Tile Size", Range(0, 1)) = 0.5
		_ScanSpeed ("Scan Speed", Range(-2, 2)) = 1
		_ScanLineIntensity ("Scan Line Intensity", Range(-2, 2)) = 0.5
		_ScanLineTex ("Scan Line Texture", 2D) = "white" {}
		_GlowTiling ("Glow Tiling", Range(0.01, 1)) = 0.05
		_GlowSpeed ("Glow Speed", Range(-10, 10)) = 1
		_GlitchSpeed ("Glitch Speed", Range(0, 50)) = 1
		_GlitchIntensity ("Glitch Intensity", Float) = 0
		_FlickerTex ("Flicker Control Texture", 2D) = "white" {}
		_FlickerSpeed ("Flicker Speed", Range(0.01, 100)) = 1
		[HideInInspector] _Fold ("__fld", Float) = 1
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 39809
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
						vec4 unused_0_0[3];
						vec4 _MainTex_ST;
						vec4 unused_0_2[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_NORMAL0;
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
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
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
						vec4 unused_0_0[3];
						vec4 _MainTex_ST;
						vec4 unused_0_2[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_NORMAL0;
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
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
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
						vec4 unused_0_0[3];
						vec4 _MainTex_ST;
						vec4 unused_0_2[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_NORMAL0;
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
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "_SCAN_ON" }
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
						vec4 unused_0_0[3];
						vec4 _MainTex_ST;
						vec4 unused_0_2[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_NORMAL0;
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
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "_SCAN_ON" }
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
						vec4 unused_0_0[3];
						vec4 _MainTex_ST;
						vec4 unused_0_2[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_NORMAL0;
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
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "_SCAN_ON" }
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
						vec4 unused_0_0[3];
						vec4 _MainTex_ST;
						vec4 unused_0_2[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_NORMAL0;
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
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "_SCAN_ON" "_GLOW_ON" }
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
						vec4 unused_0_0[3];
						vec4 _MainTex_ST;
						vec4 unused_0_2[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_NORMAL0;
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
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "_SCAN_ON" "_GLOW_ON" }
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
						vec4 unused_0_0[3];
						vec4 _MainTex_ST;
						vec4 unused_0_2[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_NORMAL0;
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
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_NORMAL0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "_SCAN_ON" "_GLOW_ON" }
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
						vec4 unused_0_0[3];
						vec4 _MainTex_ST;
						vec4 unused_0_2[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_NORMAL0;
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
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
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
						vec4 unused_0_0[4];
						vec4 _MainColor;
						vec4 _RimColor;
						float _RimPower;
						float _Brightness;
						float _Alpha;
						vec4 unused_0_6;
						float _FlickerSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FlickerTex;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0 = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = (-u_xlat0) + 1.0;
					    u_xlat2.x = log2(u_xlat0);
					    u_xlat2.x = u_xlat2.x * _RimPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * _RimColor.xyz;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2.xyz = u_xlat1.xyz * _MainColor.xyz + u_xlat2.xyz;
					    u_xlat1.x = u_xlat1.w * _Alpha;
					    u_xlat0 = u_xlat0 * u_xlat1.x;
					    SV_Target0.xyz = u_xlat2.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat2.xy = unused_0_6.ww * _Time.xy;
					    u_xlat1 = texture(_FlickerTex, u_xlat2.xy);
					    SV_Target0.w = u_xlat0 * u_xlat1.x;
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
						vec4 _MainColor;
						vec4 _RimColor;
						float _RimPower;
						float _Brightness;
						float _Alpha;
						vec4 unused_0_6;
						float _FlickerSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FlickerTex;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0 = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = (-u_xlat0) + 1.0;
					    u_xlat2.x = log2(u_xlat0);
					    u_xlat2.x = u_xlat2.x * _RimPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * _RimColor.xyz;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2.xyz = u_xlat1.xyz * _MainColor.xyz + u_xlat2.xyz;
					    u_xlat1.x = u_xlat1.w * _Alpha;
					    u_xlat0 = u_xlat0 * u_xlat1.x;
					    SV_Target0.xyz = u_xlat2.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat2.xy = unused_0_6.ww * _Time.xy;
					    u_xlat1 = texture(_FlickerTex, u_xlat2.xy);
					    SV_Target0.w = u_xlat0 * u_xlat1.x;
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
						vec4 _MainColor;
						vec4 _RimColor;
						float _RimPower;
						float _Brightness;
						float _Alpha;
						vec4 unused_0_6;
						float _FlickerSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FlickerTex;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0 = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    u_xlat0 = (-u_xlat0) + 1.0;
					    u_xlat2.x = log2(u_xlat0);
					    u_xlat2.x = u_xlat2.x * _RimPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * _RimColor.xyz;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2.xyz = u_xlat1.xyz * _MainColor.xyz + u_xlat2.xyz;
					    u_xlat1.x = u_xlat1.w * _Alpha;
					    u_xlat0 = u_xlat0 * u_xlat1.x;
					    SV_Target0.xyz = u_xlat2.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat2.xy = unused_0_6.ww * _Time.xy;
					    u_xlat1 = texture(_FlickerTex, u_xlat2.xy);
					    SV_Target0.w = u_xlat0 * u_xlat1.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "_SCAN_ON" }
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
						vec4 _Direction;
						vec4 unused_0_2;
						vec4 _MainColor;
						vec4 _RimColor;
						float _RimPower;
						float _Brightness;
						float _Alpha;
						float _ScanTiling;
						float _ScanTileSize;
						float _ScanLineIntensity;
						float _ScanSpeed;
						float _FlickerSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ScanLineTex;
					uniform  sampler2D _FlickerTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					void main()
					{
					    u_xlat0.xyz = _Direction.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat1.x = dot(u_xlat0, u_xlat0);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0.x = dot(vs_TEXCOORD1, u_xlat0);
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat3.xyz = vec3(_ScanSpeed, _FlickerSpeed, _FlickerSpeed) * _Time.wxy;
					    u_xlat0.x = u_xlat0.x * _ScanTiling + u_xlat3.x;
					    u_xlat1 = texture(_FlickerTex, u_xlat3.yz);
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlatb0 = _ScanTileSize>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x * _ScanLineIntensity;
					    u_xlat2 = texture(_ScanLineTex, vs_TEXCOORD0.xy);
					    u_xlat3.x = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = (-u_xlat3.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x + u_xlat3.x;
					    u_xlat3.x = log2(u_xlat3.x);
					    u_xlat3.x = u_xlat3.x * _RimPower;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * _RimColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4 = u_xlat2.w * _Alpha;
					    u_xlat3.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat0.x = u_xlat0.x * u_xlat4;
					    SV_Target0.w = u_xlat1.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "_SCAN_ON" }
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
						vec4 _Direction;
						vec4 unused_0_2;
						vec4 _MainColor;
						vec4 _RimColor;
						float _RimPower;
						float _Brightness;
						float _Alpha;
						float _ScanTiling;
						float _ScanTileSize;
						float _ScanLineIntensity;
						float _ScanSpeed;
						float _FlickerSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ScanLineTex;
					uniform  sampler2D _FlickerTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					void main()
					{
					    u_xlat0.xyz = _Direction.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat1.x = dot(u_xlat0, u_xlat0);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0.x = dot(vs_TEXCOORD1, u_xlat0);
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat3.xyz = vec3(_ScanSpeed, _FlickerSpeed, _FlickerSpeed) * _Time.wxy;
					    u_xlat0.x = u_xlat0.x * _ScanTiling + u_xlat3.x;
					    u_xlat1 = texture(_FlickerTex, u_xlat3.yz);
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlatb0 = _ScanTileSize>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x * _ScanLineIntensity;
					    u_xlat2 = texture(_ScanLineTex, vs_TEXCOORD0.xy);
					    u_xlat3.x = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = (-u_xlat3.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x + u_xlat3.x;
					    u_xlat3.x = log2(u_xlat3.x);
					    u_xlat3.x = u_xlat3.x * _RimPower;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * _RimColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4 = u_xlat2.w * _Alpha;
					    u_xlat3.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat0.x = u_xlat0.x * u_xlat4;
					    SV_Target0.w = u_xlat1.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "_SCAN_ON" }
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
						vec4 _Direction;
						vec4 unused_0_2;
						vec4 _MainColor;
						vec4 _RimColor;
						float _RimPower;
						float _Brightness;
						float _Alpha;
						float _ScanTiling;
						float _ScanTileSize;
						float _ScanLineIntensity;
						float _ScanSpeed;
						float _FlickerSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ScanLineTex;
					uniform  sampler2D _FlickerTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					void main()
					{
					    u_xlat0.xyz = _Direction.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat1.x = dot(u_xlat0, u_xlat0);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0.x = dot(vs_TEXCOORD1, u_xlat0);
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat3.xyz = vec3(_ScanSpeed, _FlickerSpeed, _FlickerSpeed) * _Time.wxy;
					    u_xlat0.x = u_xlat0.x * _ScanTiling + u_xlat3.x;
					    u_xlat1 = texture(_FlickerTex, u_xlat3.yz);
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlatb0 = _ScanTileSize>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x * _ScanLineIntensity;
					    u_xlat2 = texture(_ScanLineTex, vs_TEXCOORD0.xy);
					    u_xlat3.x = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = (-u_xlat3.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x + u_xlat3.x;
					    u_xlat3.x = log2(u_xlat3.x);
					    u_xlat3.x = u_xlat3.x * _RimPower;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * _RimColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4 = u_xlat2.w * _Alpha;
					    u_xlat3.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat0.x = u_xlat0.x * u_xlat4;
					    SV_Target0.w = u_xlat1.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "_SCAN_ON" "_GLOW_ON" }
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
						vec4 _Direction;
						vec4 unused_0_2;
						vec4 _MainColor;
						vec4 _RimColor;
						float _RimPower;
						float _Brightness;
						float _Alpha;
						float _ScanTiling;
						float _ScanTileSize;
						float _ScanLineIntensity;
						float _ScanSpeed;
						float _GlowTiling;
						float _GlowSpeed;
						float _FlickerSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ScanLineTex;
					uniform  sampler2D _FlickerTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = _Direction.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat1.x = dot(u_xlat0, u_xlat0);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0.x = dot(vs_TEXCOORD1, u_xlat0);
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat1 = vec4(_ScanSpeed, _GlowSpeed, _FlickerSpeed, _FlickerSpeed) * _Time.wxxy;
					    u_xlat0.y = u_xlat0.x * _ScanTiling + u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * _GlowTiling + (-u_xlat1.y);
					    u_xlat1 = texture(_FlickerTex, u_xlat1.zw);
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlatb3 = _ScanTileSize>=u_xlat0.y;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat3 = u_xlat3 * _ScanLineIntensity;
					    u_xlat2 = texture(_ScanLineTex, vs_TEXCOORD0.xy);
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat3 * u_xlat2.x + u_xlat6;
					    u_xlat6 = log2(u_xlat6);
					    u_xlat6 = u_xlat6 * _RimPower;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat3 = u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat0.x * 0.349999994;
					    u_xlat4.xyz = u_xlat0.xxx * _MainColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat2.w * _Alpha;
					    u_xlat4.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat4.xyz;
					    u_xlat4.xyz = _RimColor.xyz * vec3(u_xlat6) + u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat0.x = u_xlat3 * u_xlat0.x;
					    SV_Target0.w = u_xlat1.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "_SCAN_ON" "_GLOW_ON" }
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
						vec4 _Direction;
						vec4 unused_0_2;
						vec4 _MainColor;
						vec4 _RimColor;
						float _RimPower;
						float _Brightness;
						float _Alpha;
						float _ScanTiling;
						float _ScanTileSize;
						float _ScanLineIntensity;
						float _ScanSpeed;
						float _GlowTiling;
						float _GlowSpeed;
						float _FlickerSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ScanLineTex;
					uniform  sampler2D _FlickerTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = _Direction.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat1.x = dot(u_xlat0, u_xlat0);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0.x = dot(vs_TEXCOORD1, u_xlat0);
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat1 = vec4(_ScanSpeed, _GlowSpeed, _FlickerSpeed, _FlickerSpeed) * _Time.wxxy;
					    u_xlat0.y = u_xlat0.x * _ScanTiling + u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * _GlowTiling + (-u_xlat1.y);
					    u_xlat1 = texture(_FlickerTex, u_xlat1.zw);
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlatb3 = _ScanTileSize>=u_xlat0.y;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat3 = u_xlat3 * _ScanLineIntensity;
					    u_xlat2 = texture(_ScanLineTex, vs_TEXCOORD0.xy);
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat3 * u_xlat2.x + u_xlat6;
					    u_xlat6 = log2(u_xlat6);
					    u_xlat6 = u_xlat6 * _RimPower;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat3 = u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat0.x * 0.349999994;
					    u_xlat4.xyz = u_xlat0.xxx * _MainColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat2.w * _Alpha;
					    u_xlat4.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat4.xyz;
					    u_xlat4.xyz = _RimColor.xyz * vec3(u_xlat6) + u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat0.x = u_xlat3 * u_xlat0.x;
					    SV_Target0.w = u_xlat1.x * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "_SCAN_ON" "_GLOW_ON" }
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
						vec4 _Direction;
						vec4 unused_0_2;
						vec4 _MainColor;
						vec4 _RimColor;
						float _RimPower;
						float _Brightness;
						float _Alpha;
						float _ScanTiling;
						float _ScanTileSize;
						float _ScanLineIntensity;
						float _ScanSpeed;
						float _GlowTiling;
						float _GlowSpeed;
						float _FlickerSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ScanLineTex;
					uniform  sampler2D _FlickerTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = _Direction.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat1.x = dot(u_xlat0, u_xlat0);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0.x = dot(vs_TEXCOORD1, u_xlat0);
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat1 = vec4(_ScanSpeed, _GlowSpeed, _FlickerSpeed, _FlickerSpeed) * _Time.wxxy;
					    u_xlat0.y = u_xlat0.x * _ScanTiling + u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * _GlowTiling + (-u_xlat1.y);
					    u_xlat1 = texture(_FlickerTex, u_xlat1.zw);
					    u_xlat0.xy = fract(u_xlat0.xy);
					    u_xlatb3 = _ScanTileSize>=u_xlat0.y;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat3 = u_xlat3 * _ScanLineIntensity;
					    u_xlat2 = texture(_ScanLineTex, vs_TEXCOORD0.xy);
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_NORMAL0.xyz);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat3 * u_xlat2.x + u_xlat6;
					    u_xlat6 = log2(u_xlat6);
					    u_xlat6 = u_xlat6 * _RimPower;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat3 = u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat0.x * 0.349999994;
					    u_xlat4.xyz = u_xlat0.xxx * _MainColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat2.w * _Alpha;
					    u_xlat4.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat4.xyz;
					    u_xlat4.xyz = _RimColor.xyz * vec3(u_xlat6) + u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat0.x = u_xlat3 * u_xlat0.x;
					    SV_Target0.w = u_xlat1.x * u_xlat0.x;
					    return;
					}"
				}
			}
		}
	}
	CustomEditor "HologramShaderGUI"
}