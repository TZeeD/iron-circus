Shader "Amplify/Glass" {
	Properties {
		_spec_color ("spec_color", Vector) = (0.7311321,0.9438568,1,0)
		_smoothness ("smoothness", Range(0, 1)) = 0.5
		[HideInInspector] __dirty ("", Float) = 1
	}
	SubShader {
		Tags { "QUEUE" = "Transparent+0" "RenderType" = "Custom" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+0" "RenderType" = "Custom" "SHADOWSUPPORT" = "true" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 39082
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_2_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_3_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					int u_xlati4;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati4 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati4] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati4].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 2)].xyz);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat4.xyz;
					    u_xlat1.x = u_xlat4.y * u_xlat4.y;
					    u_xlat1.x = u_xlat4.x * u_xlat4.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat3.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat2);
					    u_xlat3.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat2);
					    u_xlat3.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_2_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_3_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					int u_xlati4;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati4 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati4] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati4].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 2)].xyz);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat4.xyz;
					    u_xlat1.x = u_xlat4.y * u_xlat4.y;
					    u_xlat1.x = u_xlat4.x * u_xlat4.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat3.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat2);
					    u_xlat3.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat2);
					    u_xlat3.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_2_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_3_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					int u_xlati4;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati4 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati4] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati4].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 2)].xyz);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat4.xyz;
					    u_xlat1.x = u_xlat4.y * u_xlat4.y;
					    u_xlat1.x = u_xlat4.x * u_xlat4.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat3.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat2);
					    u_xlat3.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat2);
					    u_xlat3.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat2);
					    u_xlat0.y = dot(unity_SHBg, u_xlat2);
					    u_xlat0.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat2);
					    u_xlat0.y = dot(unity_SHBg, u_xlat2);
					    u_xlat0.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat2);
					    u_xlat0.y = dot(unity_SHBg, u_xlat2);
					    u_xlat0.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_4_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					int u_xlati5;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati5 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati5] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati5].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 1)].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 2)].xyz);
					    u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat5.xyz;
					    u_xlat2.x = u_xlat5.y * u_xlat5.y;
					    u_xlat2.x = u_xlat5.x * u_xlat5.x + (-u_xlat2.x);
					    u_xlat3 = u_xlat5.yzzx * u_xlat5.xyzz;
					    u_xlat4.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat3);
					    u_xlat4.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat3);
					    u_xlat4.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat3);
					    vs_TEXCOORD2.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat2.xxx + u_xlat4.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_4_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					int u_xlati5;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati5 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati5] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati5].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 1)].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 2)].xyz);
					    u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat5.xyz;
					    u_xlat2.x = u_xlat5.y * u_xlat5.y;
					    u_xlat2.x = u_xlat5.x * u_xlat5.x + (-u_xlat2.x);
					    u_xlat3 = u_xlat5.yzzx * u_xlat5.xyzz;
					    u_xlat4.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat3);
					    u_xlat4.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat3);
					    u_xlat4.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat3);
					    vs_TEXCOORD2.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat2.xxx + u_xlat4.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_4_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					int u_xlati5;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati5 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati5] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati5].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 1)].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 2)].xyz);
					    u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat5.xyz;
					    u_xlat2.x = u_xlat5.y * u_xlat5.y;
					    u_xlat2.x = u_xlat5.x * u_xlat5.x + (-u_xlat2.x);
					    u_xlat3 = u_xlat5.yzzx * u_xlat5.xyzz;
					    u_xlat4.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat3);
					    u_xlat4.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat3);
					    u_xlat4.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat3);
					    vs_TEXCOORD2.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat2.xxx + u_xlat4.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_4_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					int u_xlati5;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati5 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati5] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati5].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 1)].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 2)].xyz);
					    u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat5.xyz;
					    u_xlat2.x = u_xlat5.y * u_xlat5.y;
					    u_xlat2.x = u_xlat5.x * u_xlat5.x + (-u_xlat2.x);
					    u_xlat3 = u_xlat5.yzzx * u_xlat5.xyzz;
					    u_xlat4.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat3);
					    u_xlat4.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat3);
					    u_xlat4.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat3);
					    vs_TEXCOORD2.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat2.xxx + u_xlat4.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_4_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					int u_xlati5;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati5 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati5] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati5].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 1)].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 2)].xyz);
					    u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat5.xyz;
					    u_xlat2.x = u_xlat5.y * u_xlat5.y;
					    u_xlat2.x = u_xlat5.x * u_xlat5.x + (-u_xlat2.x);
					    u_xlat3 = u_xlat5.yzzx * u_xlat5.xyzz;
					    u_xlat4.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat3);
					    u_xlat4.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat3);
					    u_xlat4.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat3);
					    vs_TEXCOORD2.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat2.xxx + u_xlat4.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_4_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					int u_xlati5;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati5 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati5] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati5].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 1)].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 2)].xyz);
					    u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat5.xyz;
					    u_xlat2.x = u_xlat5.y * u_xlat5.y;
					    u_xlat2.x = u_xlat5.x * u_xlat5.x + (-u_xlat2.x);
					    u_xlat3 = u_xlat5.yzzx * u_xlat5.xyzz;
					    u_xlat4.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat3);
					    u_xlat4.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat3);
					    u_xlat4.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat3);
					    vs_TEXCOORD2.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat2.xxx + u_xlat4.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
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
						vec4 _spec_color;
						float _smoothness;
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
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat11;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb30 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb30){
					        u_xlatb30 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb30)) ? u_xlat1.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat30 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat30, u_xlat11);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat30 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat1.xw = (-vec2(_smoothness)) + vec2(1.0, 1.0);
					    u_xlat2.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat0.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * _LightColor0.xyz;
					    u_xlatb30 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb30){
					        u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat30 = inversesqrt(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat30) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat30 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat30 = min(u_xlat5.z, u_xlat30);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat30 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat30 = u_xlat30 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat30);
					    u_xlat1.x = u_xlat4.w + -1.0;
					    u_xlat1.x = unity_SpecCube0_HDR.w * u_xlat1.x + 1.0;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.y;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * u_xlat1.xxx;
					    u_xlatb32 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb32){
					        u_xlatb32 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb32){
					            u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat32 = inversesqrt(u_xlat32);
					            u_xlat6.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat32 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat32 = min(u_xlat7.z, u_xlat32);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat32) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat30);
					        u_xlat30 = u_xlat2.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
					    u_xlat30 = max(_spec_color.y, _spec_color.x);
					    u_xlat30 = max(u_xlat30, _spec_color.z);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat32 = u_xlat1.x + u_xlat1.x;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat32)) + u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat4.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat4.y = (-u_xlat1.x) + 1.0;
					    u_xlat4.zw = u_xlat4.xy * u_xlat4.xy;
					    u_xlat0.xy = u_xlat4.xy * u_xlat4.xw;
					    u_xlat1.yz = u_xlat4.zy * u_xlat0.xy;
					    u_xlat0.x = (-u_xlat30) + 1.0;
					    u_xlat0.x = u_xlat0.x + _smoothness;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4 = texture(unity_NHxRoughness, u_xlat1.yw);
					    u_xlat10.x = u_xlat4.x * 16.0;
					    u_xlat10.xyz = u_xlat10.xxx * _spec_color.xyz;
					    u_xlat1.xyw = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat0.xxx + (-_spec_color.xyz);
					    u_xlat2.xyz = u_xlat1.zzz * u_xlat2.xyz + _spec_color.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat10.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    SV_Target0.w = 1.0;
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
						vec4 _spec_color;
						float _smoothness;
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
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat5.xy = (-u_xlat2.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat31 = u_xlat2.x * u_xlat5.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = u_xlat10 * u_xlat10;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21 = u_xlat2.x * u_xlat2.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat10 = (-u_xlat10) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat31) + 1.0;
					    u_xlat20 = u_xlat20 + _smoothness;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * _spec_color.xyz;
					    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xyz;
					    u_xlat2.xyz = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat0.x = (-u_xlat1.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat3.xyz = vec3(u_xlat20) + (-_spec_color.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
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
						vec4 _spec_color;
						float _smoothness;
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
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat31 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat10 = max(u_xlat10, 0.00200000009);
					    u_xlat20 = (-u_xlat10) + 1.0;
					    u_xlat21 = abs(u_xlat30) * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat1.x * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat20 * abs(u_xlat30);
					    u_xlat20 = u_xlat1.x * u_xlat21 + u_xlat20;
					    u_xlat20 = u_xlat20 + 9.99999975e-06;
					    u_xlat20 = 0.5 / u_xlat20;
					    u_xlat21 = u_xlat10 * u_xlat10;
					    u_xlat2.x = u_xlat11.x * u_xlat21 + (-u_xlat11.x);
					    u_xlat11.x = u_xlat2.x * u_xlat11.x + 1.0;
					    u_xlat21 = u_xlat21 * 0.318309873;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x + 1.00000001e-07;
					    u_xlat11.x = u_xlat21 / u_xlat11.x;
					    u_xlat20 = u_xlat20 * u_xlat11.x;
					    u_xlat20 = u_xlat20 * 3.14159274;
					    u_xlat20 = u_xlat1.x * u_xlat20;
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat10 = u_xlat10 * u_xlat10 + 1.0;
					    u_xlat10 = float(1.0) / u_xlat10;
					    u_xlat1.x = dot(_spec_color.xyz, _spec_color.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat20 = u_xlat20 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat31) + 1.0;
					    u_xlat1.x = u_xlat1.x + _smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat3.xyz * vec3(u_xlat20);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat20 = u_xlat0.x * u_xlat0.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat0.x = u_xlat0.x * u_xlat20;
					    u_xlat2.xyz = (-_spec_color.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * vec3(u_xlat10);
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat30 * u_xlat30;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat30 = u_xlat30 * u_xlat32;
					    u_xlat3.xyz = u_xlat1.xxx + (-_spec_color.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
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
						vec4 _spec_color;
						float _smoothness;
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
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat11;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb30 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb30){
					        u_xlatb30 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb30)) ? u_xlat1.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat30 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat30, u_xlat11);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat30 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat1.xw = (-vec2(_smoothness)) + vec2(1.0, 1.0);
					    u_xlat2.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat0.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * _LightColor0.xyz;
					    u_xlatb30 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb30){
					        u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat30 = inversesqrt(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat30) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat30 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat30 = min(u_xlat5.z, u_xlat30);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat30 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat30 = u_xlat30 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat30);
					    u_xlat1.x = u_xlat4.w + -1.0;
					    u_xlat1.x = unity_SpecCube0_HDR.w * u_xlat1.x + 1.0;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.y;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * u_xlat1.xxx;
					    u_xlatb32 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb32){
					        u_xlatb32 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb32){
					            u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat32 = inversesqrt(u_xlat32);
					            u_xlat6.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat32 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat32 = min(u_xlat7.z, u_xlat32);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat32) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat30);
					        u_xlat30 = u_xlat2.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
					    u_xlat30 = max(_spec_color.y, _spec_color.x);
					    u_xlat30 = max(u_xlat30, _spec_color.z);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat32 = u_xlat1.x + u_xlat1.x;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat32)) + u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat4.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat4.y = (-u_xlat1.x) + 1.0;
					    u_xlat4.zw = u_xlat4.xy * u_xlat4.xy;
					    u_xlat0.xy = u_xlat4.xy * u_xlat4.xw;
					    u_xlat1.yz = u_xlat4.zy * u_xlat0.xy;
					    u_xlat0.x = (-u_xlat30) + 1.0;
					    u_xlat0.x = u_xlat0.x + _smoothness;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4 = texture(unity_NHxRoughness, u_xlat1.yw);
					    u_xlat10.x = u_xlat4.x * 16.0;
					    u_xlat10.xyz = u_xlat10.xxx * _spec_color.xyz;
					    u_xlat1.xyw = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat0.xxx + (-_spec_color.xyz);
					    u_xlat2.xyz = u_xlat1.zzz * u_xlat2.xyz + _spec_color.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat10.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    SV_Target0.w = 1.0;
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
						vec4 _spec_color;
						float _smoothness;
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
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat5.xy = (-u_xlat2.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat31 = u_xlat2.x * u_xlat5.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = u_xlat10 * u_xlat10;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21 = u_xlat2.x * u_xlat2.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat10 = (-u_xlat10) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat31) + 1.0;
					    u_xlat20 = u_xlat20 + _smoothness;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * _spec_color.xyz;
					    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xyz;
					    u_xlat2.xyz = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat0.x = (-u_xlat1.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat3.xyz = vec3(u_xlat20) + (-_spec_color.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
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
						vec4 _spec_color;
						float _smoothness;
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
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat31 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat10 = max(u_xlat10, 0.00200000009);
					    u_xlat20 = (-u_xlat10) + 1.0;
					    u_xlat21 = abs(u_xlat30) * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat1.x * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat20 * abs(u_xlat30);
					    u_xlat20 = u_xlat1.x * u_xlat21 + u_xlat20;
					    u_xlat20 = u_xlat20 + 9.99999975e-06;
					    u_xlat20 = 0.5 / u_xlat20;
					    u_xlat21 = u_xlat10 * u_xlat10;
					    u_xlat2.x = u_xlat11.x * u_xlat21 + (-u_xlat11.x);
					    u_xlat11.x = u_xlat2.x * u_xlat11.x + 1.0;
					    u_xlat21 = u_xlat21 * 0.318309873;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x + 1.00000001e-07;
					    u_xlat11.x = u_xlat21 / u_xlat11.x;
					    u_xlat20 = u_xlat20 * u_xlat11.x;
					    u_xlat20 = u_xlat20 * 3.14159274;
					    u_xlat20 = u_xlat1.x * u_xlat20;
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat10 = u_xlat10 * u_xlat10 + 1.0;
					    u_xlat10 = float(1.0) / u_xlat10;
					    u_xlat1.x = dot(_spec_color.xyz, _spec_color.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat20 = u_xlat20 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat31) + 1.0;
					    u_xlat1.x = u_xlat1.x + _smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat3.xyz * vec3(u_xlat20);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat20 = u_xlat0.x * u_xlat0.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat0.x = u_xlat0.x * u_xlat20;
					    u_xlat2.xyz = (-_spec_color.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * vec3(u_xlat10);
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat30 * u_xlat30;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat30 = u_xlat30 * u_xlat32;
					    u_xlat3.xyz = u_xlat1.xxx + (-_spec_color.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bool u_xlatb10;
					vec2 u_xlat20;
					float u_xlat30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat10.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = (-u_xlat0.x) + u_xlat10.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat10.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb10 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb10){
					        u_xlatb10 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb10)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat20.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat20.x, u_xlat10.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat10.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat20.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_ShadowMapTexture, u_xlat20.xy);
					    u_xlat10.x = u_xlat10.x + (-u_xlat2.x);
					    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat2.x;
					    u_xlat2.xw = (-vec2(_smoothness)) + vec2(1.0, 1.0);
					    u_xlat10.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat10.x = u_xlat10.x + u_xlat10.x;
					    u_xlat10.xyz = vs_TEXCOORD0.xyz * (-u_xlat10.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlatb0 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb0){
					        u_xlat0.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat4.xyz = u_xlat0.xxx * u_xlat10.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat0.x = min(u_xlat5.y, u_xlat5.x);
					        u_xlat0.x = min(u_xlat5.z, u_xlat0.x);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat10.xyz;
					    }
					    u_xlat0.x = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat0.x);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb2 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb2){
					        u_xlatb2 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb2){
					            u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					            u_xlat2.x = inversesqrt(u_xlat2.x);
					            u_xlat6.xyz = u_xlat10.xyz * u_xlat2.xxx;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat2.x = min(u_xlat7.y, u_xlat7.x);
					            u_xlat2.x = min(u_xlat7.z, u_xlat2.x);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat10.xyz = u_xlat6.xyz * u_xlat2.xxx + u_xlat7.xyz;
					        }
					        u_xlat0 = textureLod(unity_SpecCube1, u_xlat10.xyz, u_xlat0.x);
					        u_xlat30 = u_xlat0.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat0.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
					    u_xlat30 = max(_spec_color.y, _spec_color.x);
					    u_xlat30 = max(u_xlat30, _spec_color.z);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat31 = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.x = u_xlat31 + u_xlat31;
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat2.xxx) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat31 = u_xlat31;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat4.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat4.y = (-u_xlat31) + 1.0;
					    u_xlat4.zw = u_xlat4.xy * u_xlat4.xy;
					    u_xlat10.xy = u_xlat4.xy * u_xlat4.xw;
					    u_xlat2.yz = u_xlat4.zy * u_xlat10.xy;
					    u_xlat10.x = (-u_xlat30) + 1.0;
					    u_xlat10.x = u_xlat10.x + _smoothness;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat2.yw);
					    u_xlat20.x = u_xlat1.x * 16.0;
					    u_xlat1.xyz = u_xlat20.xxx * _spec_color.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat2.xyw = u_xlat10.xxx + (-_spec_color.xyz);
					    u_xlat2.xyz = u_xlat2.zzz * u_xlat2.xyw + _spec_color.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat0.xzw + u_xlat2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat31) + u_xlat2.x;
					    u_xlat31 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat31;
					    u_xlat31 = u_xlat31 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat12.xy);
					    u_xlat2.x = u_xlat2.x + (-u_xlat3.x);
					    u_xlat31 = u_xlat31 * u_xlat2.x + u_xlat3.x;
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat5.xy = (-u_xlat2.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat31 = u_xlat2.x * u_xlat5.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = u_xlat10 * u_xlat10;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21 = u_xlat2.x * u_xlat2.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat10 = (-u_xlat10) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat31) + 1.0;
					    u_xlat20 = u_xlat20 + _smoothness;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * _spec_color.xyz;
					    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xyz;
					    u_xlat2.xyz = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat0.x = (-u_xlat1.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat3.xyz = vec3(u_xlat20) + (-_spec_color.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat31) + u_xlat2.x;
					    u_xlat31 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat31;
					    u_xlat31 = u_xlat31 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat12.xy);
					    u_xlat2.x = u_xlat2.x + (-u_xlat3.x);
					    u_xlat31 = u_xlat31 * u_xlat2.x + u_xlat3.x;
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat31 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat10 = max(u_xlat10, 0.00200000009);
					    u_xlat20 = (-u_xlat10) + 1.0;
					    u_xlat21 = abs(u_xlat30) * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat1.x * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat20 * abs(u_xlat30);
					    u_xlat20 = u_xlat1.x * u_xlat21 + u_xlat20;
					    u_xlat20 = u_xlat20 + 9.99999975e-06;
					    u_xlat20 = 0.5 / u_xlat20;
					    u_xlat21 = u_xlat10 * u_xlat10;
					    u_xlat2.x = u_xlat11.x * u_xlat21 + (-u_xlat11.x);
					    u_xlat11.x = u_xlat2.x * u_xlat11.x + 1.0;
					    u_xlat21 = u_xlat21 * 0.318309873;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x + 1.00000001e-07;
					    u_xlat11.x = u_xlat21 / u_xlat11.x;
					    u_xlat20 = u_xlat20 * u_xlat11.x;
					    u_xlat20 = u_xlat20 * 3.14159274;
					    u_xlat20 = u_xlat1.x * u_xlat20;
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat10 = u_xlat10 * u_xlat10 + 1.0;
					    u_xlat10 = float(1.0) / u_xlat10;
					    u_xlat1.x = dot(_spec_color.xyz, _spec_color.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat20 = u_xlat20 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat31) + 1.0;
					    u_xlat1.x = u_xlat1.x + _smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat3.xyz * vec3(u_xlat20);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat20 = u_xlat0.x * u_xlat0.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat0.x = u_xlat0.x * u_xlat20;
					    u_xlat2.xyz = (-_spec_color.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * vec3(u_xlat10);
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat30 * u_xlat30;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat30 = u_xlat30 * u_xlat32;
					    u_xlat3.xyz = u_xlat1.xxx + (-_spec_color.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bool u_xlatb10;
					vec2 u_xlat20;
					float u_xlat30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat10.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = (-u_xlat0.x) + u_xlat10.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat10.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb10 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb10){
					        u_xlatb10 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb10)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat20.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat20.x, u_xlat10.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat10.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat20.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_ShadowMapTexture, u_xlat20.xy);
					    u_xlat10.x = u_xlat10.x + (-u_xlat2.x);
					    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat2.x;
					    u_xlat2.xw = (-vec2(_smoothness)) + vec2(1.0, 1.0);
					    u_xlat10.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat10.x = u_xlat10.x + u_xlat10.x;
					    u_xlat10.xyz = vs_TEXCOORD0.xyz * (-u_xlat10.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlatb0 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb0){
					        u_xlat0.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat4.xyz = u_xlat0.xxx * u_xlat10.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat0.x = min(u_xlat5.y, u_xlat5.x);
					        u_xlat0.x = min(u_xlat5.z, u_xlat0.x);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat10.xyz;
					    }
					    u_xlat0.x = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat0.x);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb2 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb2){
					        u_xlatb2 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb2){
					            u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					            u_xlat2.x = inversesqrt(u_xlat2.x);
					            u_xlat6.xyz = u_xlat10.xyz * u_xlat2.xxx;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat2.x = min(u_xlat7.y, u_xlat7.x);
					            u_xlat2.x = min(u_xlat7.z, u_xlat2.x);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat10.xyz = u_xlat6.xyz * u_xlat2.xxx + u_xlat7.xyz;
					        }
					        u_xlat0 = textureLod(unity_SpecCube1, u_xlat10.xyz, u_xlat0.x);
					        u_xlat30 = u_xlat0.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat0.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
					    u_xlat30 = max(_spec_color.y, _spec_color.x);
					    u_xlat30 = max(u_xlat30, _spec_color.z);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat31 = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.x = u_xlat31 + u_xlat31;
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat2.xxx) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat31 = u_xlat31;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat4.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat4.y = (-u_xlat31) + 1.0;
					    u_xlat4.zw = u_xlat4.xy * u_xlat4.xy;
					    u_xlat10.xy = u_xlat4.xy * u_xlat4.xw;
					    u_xlat2.yz = u_xlat4.zy * u_xlat10.xy;
					    u_xlat10.x = (-u_xlat30) + 1.0;
					    u_xlat10.x = u_xlat10.x + _smoothness;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat2.yw);
					    u_xlat20.x = u_xlat1.x * 16.0;
					    u_xlat1.xyz = u_xlat20.xxx * _spec_color.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat2.xyw = u_xlat10.xxx + (-_spec_color.xyz);
					    u_xlat2.xyz = u_xlat2.zzz * u_xlat2.xyw + _spec_color.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat0.xzw + u_xlat2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat31) + u_xlat2.x;
					    u_xlat31 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat31;
					    u_xlat31 = u_xlat31 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat12.xy);
					    u_xlat2.x = u_xlat2.x + (-u_xlat3.x);
					    u_xlat31 = u_xlat31 * u_xlat2.x + u_xlat3.x;
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat5.xy = (-u_xlat2.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat31 = u_xlat2.x * u_xlat5.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = u_xlat10 * u_xlat10;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21 = u_xlat2.x * u_xlat2.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat10 = (-u_xlat10) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat31) + 1.0;
					    u_xlat20 = u_xlat20 + _smoothness;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * _spec_color.xyz;
					    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xyz;
					    u_xlat2.xyz = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat0.x = (-u_xlat1.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat3.xyz = vec3(u_xlat20) + (-_spec_color.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat31) + u_xlat2.x;
					    u_xlat31 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat31;
					    u_xlat31 = u_xlat31 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat12.xy);
					    u_xlat2.x = u_xlat2.x + (-u_xlat3.x);
					    u_xlat31 = u_xlat31 * u_xlat2.x + u_xlat3.x;
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat31 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat10 = max(u_xlat10, 0.00200000009);
					    u_xlat20 = (-u_xlat10) + 1.0;
					    u_xlat21 = abs(u_xlat30) * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat1.x * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat20 * abs(u_xlat30);
					    u_xlat20 = u_xlat1.x * u_xlat21 + u_xlat20;
					    u_xlat20 = u_xlat20 + 9.99999975e-06;
					    u_xlat20 = 0.5 / u_xlat20;
					    u_xlat21 = u_xlat10 * u_xlat10;
					    u_xlat2.x = u_xlat11.x * u_xlat21 + (-u_xlat11.x);
					    u_xlat11.x = u_xlat2.x * u_xlat11.x + 1.0;
					    u_xlat21 = u_xlat21 * 0.318309873;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x + 1.00000001e-07;
					    u_xlat11.x = u_xlat21 / u_xlat11.x;
					    u_xlat20 = u_xlat20 * u_xlat11.x;
					    u_xlat20 = u_xlat20 * 3.14159274;
					    u_xlat20 = u_xlat1.x * u_xlat20;
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat10 = u_xlat10 * u_xlat10 + 1.0;
					    u_xlat10 = float(1.0) / u_xlat10;
					    u_xlat1.x = dot(_spec_color.xyz, _spec_color.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat20 = u_xlat20 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat31) + 1.0;
					    u_xlat1.x = u_xlat1.x + _smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat3.xyz * vec3(u_xlat20);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat20 = u_xlat0.x * u_xlat0.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat0.x = u_xlat0.x * u_xlat20;
					    u_xlat2.xyz = (-_spec_color.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * vec3(u_xlat10);
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat30 * u_xlat30;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat30 = u_xlat30 * u_xlat32;
					    u_xlat3.xyz = u_xlat1.xxx + (-_spec_color.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bool u_xlatb10;
					vec2 u_xlat20;
					float u_xlat30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat10.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = (-u_xlat0.x) + u_xlat10.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat10.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb10 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb10){
					        u_xlatb10 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb10)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat20.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat20.x, u_xlat10.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat10.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat20.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_ShadowMapTexture, u_xlat20.xy);
					    u_xlat0.x = u_xlat0.x + u_xlat2.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = min(u_xlat10.x, u_xlat0.x);
					    u_xlat2.xw = (-vec2(_smoothness)) + vec2(1.0, 1.0);
					    u_xlat10.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat10.x = u_xlat10.x + u_xlat10.x;
					    u_xlat10.xyz = vs_TEXCOORD0.xyz * (-u_xlat10.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlatb0 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb0){
					        u_xlat0.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat4.xyz = u_xlat0.xxx * u_xlat10.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat0.x = min(u_xlat5.y, u_xlat5.x);
					        u_xlat0.x = min(u_xlat5.z, u_xlat0.x);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat10.xyz;
					    }
					    u_xlat0.x = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat0.x);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb2 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb2){
					        u_xlatb2 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb2){
					            u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					            u_xlat2.x = inversesqrt(u_xlat2.x);
					            u_xlat6.xyz = u_xlat10.xyz * u_xlat2.xxx;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat2.x = min(u_xlat7.y, u_xlat7.x);
					            u_xlat2.x = min(u_xlat7.z, u_xlat2.x);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat10.xyz = u_xlat6.xyz * u_xlat2.xxx + u_xlat7.xyz;
					        }
					        u_xlat0 = textureLod(unity_SpecCube1, u_xlat10.xyz, u_xlat0.x);
					        u_xlat30 = u_xlat0.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat0.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
					    u_xlat30 = max(_spec_color.y, _spec_color.x);
					    u_xlat30 = max(u_xlat30, _spec_color.z);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat31 = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.x = u_xlat31 + u_xlat31;
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat2.xxx) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat31 = u_xlat31;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat4.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat4.y = (-u_xlat31) + 1.0;
					    u_xlat4.zw = u_xlat4.xy * u_xlat4.xy;
					    u_xlat10.xy = u_xlat4.xy * u_xlat4.xw;
					    u_xlat2.yz = u_xlat4.zy * u_xlat10.xy;
					    u_xlat10.x = (-u_xlat30) + 1.0;
					    u_xlat10.x = u_xlat10.x + _smoothness;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat2.yw);
					    u_xlat20.x = u_xlat1.x * 16.0;
					    u_xlat1.xyz = u_xlat20.xxx * _spec_color.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat2.xyw = u_xlat10.xxx + (-_spec_color.xyz);
					    u_xlat2.xyz = u_xlat2.zzz * u_xlat2.xyw + _spec_color.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat0.xzw + u_xlat2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat31) + u_xlat2.x;
					    u_xlat31 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat31;
					    u_xlat31 = u_xlat31 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat12.xy);
					    u_xlat31 = u_xlat31 + u_xlat3.x;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat31 = min(u_xlat2.x, u_xlat31);
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat5.xy = (-u_xlat2.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat31 = u_xlat2.x * u_xlat5.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = u_xlat10 * u_xlat10;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21 = u_xlat2.x * u_xlat2.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat10 = (-u_xlat10) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat31) + 1.0;
					    u_xlat20 = u_xlat20 + _smoothness;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * _spec_color.xyz;
					    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xyz;
					    u_xlat2.xyz = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat0.x = (-u_xlat1.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat3.xyz = vec3(u_xlat20) + (-_spec_color.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat31) + u_xlat2.x;
					    u_xlat31 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat31;
					    u_xlat31 = u_xlat31 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat12.xy);
					    u_xlat31 = u_xlat31 + u_xlat3.x;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat31 = min(u_xlat2.x, u_xlat31);
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat31 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat10 = max(u_xlat10, 0.00200000009);
					    u_xlat20 = (-u_xlat10) + 1.0;
					    u_xlat21 = abs(u_xlat30) * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat1.x * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat20 * abs(u_xlat30);
					    u_xlat20 = u_xlat1.x * u_xlat21 + u_xlat20;
					    u_xlat20 = u_xlat20 + 9.99999975e-06;
					    u_xlat20 = 0.5 / u_xlat20;
					    u_xlat21 = u_xlat10 * u_xlat10;
					    u_xlat2.x = u_xlat11.x * u_xlat21 + (-u_xlat11.x);
					    u_xlat11.x = u_xlat2.x * u_xlat11.x + 1.0;
					    u_xlat21 = u_xlat21 * 0.318309873;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x + 1.00000001e-07;
					    u_xlat11.x = u_xlat21 / u_xlat11.x;
					    u_xlat20 = u_xlat20 * u_xlat11.x;
					    u_xlat20 = u_xlat20 * 3.14159274;
					    u_xlat20 = u_xlat1.x * u_xlat20;
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat10 = u_xlat10 * u_xlat10 + 1.0;
					    u_xlat10 = float(1.0) / u_xlat10;
					    u_xlat1.x = dot(_spec_color.xyz, _spec_color.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat20 = u_xlat20 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat31) + 1.0;
					    u_xlat1.x = u_xlat1.x + _smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat3.xyz * vec3(u_xlat20);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat20 = u_xlat0.x * u_xlat0.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat0.x = u_xlat0.x * u_xlat20;
					    u_xlat2.xyz = (-_spec_color.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * vec3(u_xlat10);
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat30 * u_xlat30;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat30 = u_xlat30 * u_xlat32;
					    u_xlat3.xyz = u_xlat1.xxx + (-_spec_color.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat11;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb30 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb30){
					        u_xlatb30 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb30)) ? u_xlat1.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat30 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat30, u_xlat11);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat30 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat1.xw = (-vec2(_smoothness)) + vec2(1.0, 1.0);
					    u_xlat2.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat0.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * _LightColor0.xyz;
					    u_xlatb30 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb30){
					        u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat30 = inversesqrt(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat30) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat30 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat30 = min(u_xlat5.z, u_xlat30);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat30 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat30 = u_xlat30 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat30);
					    u_xlat1.x = u_xlat4.w + -1.0;
					    u_xlat1.x = unity_SpecCube0_HDR.w * u_xlat1.x + 1.0;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.y;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * u_xlat1.xxx;
					    u_xlatb32 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb32){
					        u_xlatb32 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb32){
					            u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat32 = inversesqrt(u_xlat32);
					            u_xlat6.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat32 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat32 = min(u_xlat7.z, u_xlat32);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat32) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat30);
					        u_xlat30 = u_xlat2.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
					    u_xlat30 = max(_spec_color.y, _spec_color.x);
					    u_xlat30 = max(u_xlat30, _spec_color.z);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat32 = u_xlat1.x + u_xlat1.x;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat32)) + u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat4.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat4.y = (-u_xlat1.x) + 1.0;
					    u_xlat4.zw = u_xlat4.xy * u_xlat4.xy;
					    u_xlat0.xy = u_xlat4.xy * u_xlat4.xw;
					    u_xlat1.yz = u_xlat4.zy * u_xlat0.xy;
					    u_xlat0.x = (-u_xlat30) + 1.0;
					    u_xlat0.x = u_xlat0.x + _smoothness;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4 = texture(unity_NHxRoughness, u_xlat1.yw);
					    u_xlat10.x = u_xlat4.x * 16.0;
					    u_xlat10.xyz = u_xlat10.xxx * _spec_color.xyz;
					    u_xlat1.xyw = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat0.xxx + (-_spec_color.xyz);
					    u_xlat2.xyz = u_xlat1.zzz * u_xlat2.xyz + _spec_color.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat10.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat5.xy = (-u_xlat2.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat31 = u_xlat2.x * u_xlat5.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = u_xlat10 * u_xlat10;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21 = u_xlat2.x * u_xlat2.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat10 = (-u_xlat10) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat31) + 1.0;
					    u_xlat20 = u_xlat20 + _smoothness;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * _spec_color.xyz;
					    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xyz;
					    u_xlat2.xyz = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat0.x = (-u_xlat1.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat3.xyz = vec3(u_xlat20) + (-_spec_color.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat31 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat10 = max(u_xlat10, 0.00200000009);
					    u_xlat20 = (-u_xlat10) + 1.0;
					    u_xlat21 = abs(u_xlat30) * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat1.x * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat20 * abs(u_xlat30);
					    u_xlat20 = u_xlat1.x * u_xlat21 + u_xlat20;
					    u_xlat20 = u_xlat20 + 9.99999975e-06;
					    u_xlat20 = 0.5 / u_xlat20;
					    u_xlat21 = u_xlat10 * u_xlat10;
					    u_xlat2.x = u_xlat11.x * u_xlat21 + (-u_xlat11.x);
					    u_xlat11.x = u_xlat2.x * u_xlat11.x + 1.0;
					    u_xlat21 = u_xlat21 * 0.318309873;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x + 1.00000001e-07;
					    u_xlat11.x = u_xlat21 / u_xlat11.x;
					    u_xlat20 = u_xlat20 * u_xlat11.x;
					    u_xlat20 = u_xlat20 * 3.14159274;
					    u_xlat20 = u_xlat1.x * u_xlat20;
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat10 = u_xlat10 * u_xlat10 + 1.0;
					    u_xlat10 = float(1.0) / u_xlat10;
					    u_xlat1.x = dot(_spec_color.xyz, _spec_color.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat20 = u_xlat20 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat31) + 1.0;
					    u_xlat1.x = u_xlat1.x + _smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat3.xyz * vec3(u_xlat20);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat20 = u_xlat0.x * u_xlat0.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat0.x = u_xlat0.x * u_xlat20;
					    u_xlat2.xyz = (-_spec_color.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * vec3(u_xlat10);
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat30 * u_xlat30;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat30 = u_xlat30 * u_xlat32;
					    u_xlat3.xyz = u_xlat1.xxx + (-_spec_color.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_6_1[14];
					};
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat11;
					float u_xlat30;
					int u_xlati30;
					bool u_xlatb30;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb30 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb30){
					        u_xlatb30 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb30)) ? u_xlat1.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat30 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat30, u_xlat11);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlati30 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					        u_xlati30 = u_xlati30 * 7;
					        u_xlat1 = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.wwww;
					    }
					    u_xlat30 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat1.xw = (-vec2(_smoothness)) + vec2(1.0, 1.0);
					    u_xlat2.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat0.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * _LightColor0.xyz;
					    u_xlatb30 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb30){
					        u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat30 = inversesqrt(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat30) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat30 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat30 = min(u_xlat5.z, u_xlat30);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat30 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat30 = u_xlat30 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat30);
					    u_xlat1.x = u_xlat4.w + -1.0;
					    u_xlat1.x = unity_SpecCube0_HDR.w * u_xlat1.x + 1.0;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.y;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * u_xlat1.xxx;
					    u_xlatb32 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb32){
					        u_xlatb32 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb32){
					            u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat32 = inversesqrt(u_xlat32);
					            u_xlat6.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat32 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat32 = min(u_xlat7.z, u_xlat32);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat32) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat30);
					        u_xlat30 = u_xlat2.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
					    u_xlat30 = max(_spec_color.y, _spec_color.x);
					    u_xlat30 = max(u_xlat30, _spec_color.z);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat32 = u_xlat1.x + u_xlat1.x;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat32)) + u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat4.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat4.y = (-u_xlat1.x) + 1.0;
					    u_xlat4.zw = u_xlat4.xy * u_xlat4.xy;
					    u_xlat0.xy = u_xlat4.xy * u_xlat4.xw;
					    u_xlat1.yz = u_xlat4.zy * u_xlat0.xy;
					    u_xlat0.x = (-u_xlat30) + 1.0;
					    u_xlat0.x = u_xlat0.x + _smoothness;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4 = texture(unity_NHxRoughness, u_xlat1.yw);
					    u_xlat10.x = u_xlat4.x * 16.0;
					    u_xlat10.xyz = u_xlat10.xxx * _spec_color.xyz;
					    u_xlat1.xyw = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat0.xxx + (-_spec_color.xyz);
					    u_xlat2.xyz = u_xlat1.zzz * u_xlat2.xyz + _spec_color.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat10.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_6_1[14];
					};
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					int u_xlati31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlati31 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					        u_xlati31 = u_xlati31 * 7;
					        u_xlat2 = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.wwww;
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat5.xy = (-u_xlat2.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat31 = u_xlat2.x * u_xlat5.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = u_xlat10 * u_xlat10;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21 = u_xlat2.x * u_xlat2.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat10 = (-u_xlat10) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat31) + 1.0;
					    u_xlat20 = u_xlat20 + _smoothness;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * _spec_color.xyz;
					    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xyz;
					    u_xlat2.xyz = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat0.x = (-u_xlat1.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat3.xyz = vec3(u_xlat20) + (-_spec_color.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_6_1[14];
					};
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					int u_xlati31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlati31 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					        u_xlati31 = u_xlati31 * 7;
					        u_xlat2 = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.wwww;
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat31 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat10 = max(u_xlat10, 0.00200000009);
					    u_xlat20 = (-u_xlat10) + 1.0;
					    u_xlat21 = abs(u_xlat30) * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat1.x * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat20 * abs(u_xlat30);
					    u_xlat20 = u_xlat1.x * u_xlat21 + u_xlat20;
					    u_xlat20 = u_xlat20 + 9.99999975e-06;
					    u_xlat20 = 0.5 / u_xlat20;
					    u_xlat21 = u_xlat10 * u_xlat10;
					    u_xlat2.x = u_xlat11.x * u_xlat21 + (-u_xlat11.x);
					    u_xlat11.x = u_xlat2.x * u_xlat11.x + 1.0;
					    u_xlat21 = u_xlat21 * 0.318309873;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x + 1.00000001e-07;
					    u_xlat11.x = u_xlat21 / u_xlat11.x;
					    u_xlat20 = u_xlat20 * u_xlat11.x;
					    u_xlat20 = u_xlat20 * 3.14159274;
					    u_xlat20 = u_xlat1.x * u_xlat20;
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat10 = u_xlat10 * u_xlat10 + 1.0;
					    u_xlat10 = float(1.0) / u_xlat10;
					    u_xlat1.x = dot(_spec_color.xyz, _spec_color.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat20 = u_xlat20 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat31) + 1.0;
					    u_xlat1.x = u_xlat1.x + _smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat3.xyz * vec3(u_xlat20);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat20 = u_xlat0.x * u_xlat0.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat0.x = u_xlat0.x * u_xlat20;
					    u_xlat2.xyz = (-_spec_color.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * vec3(u_xlat10);
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat30 * u_xlat30;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat30 = u_xlat30 * u_xlat32;
					    u_xlat3.xyz = u_xlat1.xxx + (-_spec_color.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bool u_xlatb10;
					vec2 u_xlat20;
					float u_xlat30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat10.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = (-u_xlat0.x) + u_xlat10.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat10.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb10 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb10){
					        u_xlatb10 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb10)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat20.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat20.x, u_xlat10.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat10.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat20.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_ShadowMapTexture, u_xlat20.xy);
					    u_xlat10.x = u_xlat10.x + (-u_xlat2.x);
					    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat2.x;
					    u_xlat2.xw = (-vec2(_smoothness)) + vec2(1.0, 1.0);
					    u_xlat10.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat10.x = u_xlat10.x + u_xlat10.x;
					    u_xlat10.xyz = vs_TEXCOORD0.xyz * (-u_xlat10.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlatb0 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb0){
					        u_xlat0.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat4.xyz = u_xlat0.xxx * u_xlat10.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat0.x = min(u_xlat5.y, u_xlat5.x);
					        u_xlat0.x = min(u_xlat5.z, u_xlat0.x);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat10.xyz;
					    }
					    u_xlat0.x = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat0.x);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb2 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb2){
					        u_xlatb2 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb2){
					            u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					            u_xlat2.x = inversesqrt(u_xlat2.x);
					            u_xlat6.xyz = u_xlat10.xyz * u_xlat2.xxx;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat2.x = min(u_xlat7.y, u_xlat7.x);
					            u_xlat2.x = min(u_xlat7.z, u_xlat2.x);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat10.xyz = u_xlat6.xyz * u_xlat2.xxx + u_xlat7.xyz;
					        }
					        u_xlat0 = textureLod(unity_SpecCube1, u_xlat10.xyz, u_xlat0.x);
					        u_xlat30 = u_xlat0.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat0.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
					    u_xlat30 = max(_spec_color.y, _spec_color.x);
					    u_xlat30 = max(u_xlat30, _spec_color.z);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat31 = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.x = u_xlat31 + u_xlat31;
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat2.xxx) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat31 = u_xlat31;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat4.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat4.y = (-u_xlat31) + 1.0;
					    u_xlat4.zw = u_xlat4.xy * u_xlat4.xy;
					    u_xlat10.xy = u_xlat4.xy * u_xlat4.xw;
					    u_xlat2.yz = u_xlat4.zy * u_xlat10.xy;
					    u_xlat10.x = (-u_xlat30) + 1.0;
					    u_xlat10.x = u_xlat10.x + _smoothness;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat2.yw);
					    u_xlat20.x = u_xlat1.x * 16.0;
					    u_xlat1.xyz = u_xlat20.xxx * _spec_color.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat2.xyw = u_xlat10.xxx + (-_spec_color.xyz);
					    u_xlat2.xyz = u_xlat2.zzz * u_xlat2.xyw + _spec_color.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat0.xzw + u_xlat2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat31) + u_xlat2.x;
					    u_xlat31 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat31;
					    u_xlat31 = u_xlat31 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat12.xy);
					    u_xlat2.x = u_xlat2.x + (-u_xlat3.x);
					    u_xlat31 = u_xlat31 * u_xlat2.x + u_xlat3.x;
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat5.xy = (-u_xlat2.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat31 = u_xlat2.x * u_xlat5.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = u_xlat10 * u_xlat10;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21 = u_xlat2.x * u_xlat2.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat10 = (-u_xlat10) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat31) + 1.0;
					    u_xlat20 = u_xlat20 + _smoothness;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * _spec_color.xyz;
					    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xyz;
					    u_xlat2.xyz = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat0.x = (-u_xlat1.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat3.xyz = vec3(u_xlat20) + (-_spec_color.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat31) + u_xlat2.x;
					    u_xlat31 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat31;
					    u_xlat31 = u_xlat31 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat12.xy);
					    u_xlat2.x = u_xlat2.x + (-u_xlat3.x);
					    u_xlat31 = u_xlat31 * u_xlat2.x + u_xlat3.x;
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat31 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat10 = max(u_xlat10, 0.00200000009);
					    u_xlat20 = (-u_xlat10) + 1.0;
					    u_xlat21 = abs(u_xlat30) * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat1.x * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat20 * abs(u_xlat30);
					    u_xlat20 = u_xlat1.x * u_xlat21 + u_xlat20;
					    u_xlat20 = u_xlat20 + 9.99999975e-06;
					    u_xlat20 = 0.5 / u_xlat20;
					    u_xlat21 = u_xlat10 * u_xlat10;
					    u_xlat2.x = u_xlat11.x * u_xlat21 + (-u_xlat11.x);
					    u_xlat11.x = u_xlat2.x * u_xlat11.x + 1.0;
					    u_xlat21 = u_xlat21 * 0.318309873;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x + 1.00000001e-07;
					    u_xlat11.x = u_xlat21 / u_xlat11.x;
					    u_xlat20 = u_xlat20 * u_xlat11.x;
					    u_xlat20 = u_xlat20 * 3.14159274;
					    u_xlat20 = u_xlat1.x * u_xlat20;
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat10 = u_xlat10 * u_xlat10 + 1.0;
					    u_xlat10 = float(1.0) / u_xlat10;
					    u_xlat1.x = dot(_spec_color.xyz, _spec_color.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat20 = u_xlat20 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat31) + 1.0;
					    u_xlat1.x = u_xlat1.x + _smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat3.xyz * vec3(u_xlat20);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat20 = u_xlat0.x * u_xlat0.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat0.x = u_xlat0.x * u_xlat20;
					    u_xlat2.xyz = (-_spec_color.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * vec3(u_xlat10);
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat30 * u_xlat30;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat30 = u_xlat30 * u_xlat32;
					    u_xlat3.xyz = u_xlat1.xxx + (-_spec_color.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_8_1[14];
					};
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					int u_xlati10;
					bool u_xlatb10;
					vec2 u_xlat20;
					float u_xlat30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat10.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = (-u_xlat0.x) + u_xlat10.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat10.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb10 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb10){
					        u_xlatb10 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb10)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat20.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat20.x, u_xlat10.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					        u_xlati10 = u_xlati10 * 7;
					        u_xlat2 = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.wwww;
					    }
					    u_xlat10.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat20.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_ShadowMapTexture, u_xlat20.xy);
					    u_xlat10.x = u_xlat10.x + (-u_xlat2.x);
					    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat2.x;
					    u_xlat2.xw = (-vec2(_smoothness)) + vec2(1.0, 1.0);
					    u_xlat10.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat10.x = u_xlat10.x + u_xlat10.x;
					    u_xlat10.xyz = vs_TEXCOORD0.xyz * (-u_xlat10.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlatb0 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb0){
					        u_xlat0.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat4.xyz = u_xlat0.xxx * u_xlat10.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat0.x = min(u_xlat5.y, u_xlat5.x);
					        u_xlat0.x = min(u_xlat5.z, u_xlat0.x);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat10.xyz;
					    }
					    u_xlat0.x = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat0.x);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb2 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb2){
					        u_xlatb2 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb2){
					            u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					            u_xlat2.x = inversesqrt(u_xlat2.x);
					            u_xlat6.xyz = u_xlat10.xyz * u_xlat2.xxx;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat2.x = min(u_xlat7.y, u_xlat7.x);
					            u_xlat2.x = min(u_xlat7.z, u_xlat2.x);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat10.xyz = u_xlat6.xyz * u_xlat2.xxx + u_xlat7.xyz;
					        }
					        u_xlat0 = textureLod(unity_SpecCube1, u_xlat10.xyz, u_xlat0.x);
					        u_xlat30 = u_xlat0.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat0.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
					    u_xlat30 = max(_spec_color.y, _spec_color.x);
					    u_xlat30 = max(u_xlat30, _spec_color.z);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat31 = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.x = u_xlat31 + u_xlat31;
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat2.xxx) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat31 = u_xlat31;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat4.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat4.y = (-u_xlat31) + 1.0;
					    u_xlat4.zw = u_xlat4.xy * u_xlat4.xy;
					    u_xlat10.xy = u_xlat4.xy * u_xlat4.xw;
					    u_xlat2.yz = u_xlat4.zy * u_xlat10.xy;
					    u_xlat10.x = (-u_xlat30) + 1.0;
					    u_xlat10.x = u_xlat10.x + _smoothness;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat2.yw);
					    u_xlat20.x = u_xlat1.x * 16.0;
					    u_xlat1.xyz = u_xlat20.xxx * _spec_color.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat2.xyw = u_xlat10.xxx + (-_spec_color.xyz);
					    u_xlat2.xyz = u_xlat2.zzz * u_xlat2.xyw + _spec_color.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat0.xzw + u_xlat2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_8_1[14];
					};
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					int u_xlati3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat31) + u_xlat2.x;
					    u_xlat31 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat31;
					    u_xlat31 = u_xlat31 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					        u_xlati3 = u_xlati3 * 7;
					        u_xlat2 = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.wwww;
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat12.xy);
					    u_xlat2.x = u_xlat2.x + (-u_xlat3.x);
					    u_xlat31 = u_xlat31 * u_xlat2.x + u_xlat3.x;
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat5.xy = (-u_xlat2.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat31 = u_xlat2.x * u_xlat5.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = u_xlat10 * u_xlat10;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21 = u_xlat2.x * u_xlat2.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat10 = (-u_xlat10) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat31) + 1.0;
					    u_xlat20 = u_xlat20 + _smoothness;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * _spec_color.xyz;
					    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xyz;
					    u_xlat2.xyz = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat0.x = (-u_xlat1.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat3.xyz = vec3(u_xlat20) + (-_spec_color.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_8_1[14];
					};
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					int u_xlati3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat31) + u_xlat2.x;
					    u_xlat31 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat31;
					    u_xlat31 = u_xlat31 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					        u_xlati3 = u_xlati3 * 7;
					        u_xlat2 = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.wwww;
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat12.xy);
					    u_xlat2.x = u_xlat2.x + (-u_xlat3.x);
					    u_xlat31 = u_xlat31 * u_xlat2.x + u_xlat3.x;
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat31 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat10 = max(u_xlat10, 0.00200000009);
					    u_xlat20 = (-u_xlat10) + 1.0;
					    u_xlat21 = abs(u_xlat30) * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat1.x * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat20 * abs(u_xlat30);
					    u_xlat20 = u_xlat1.x * u_xlat21 + u_xlat20;
					    u_xlat20 = u_xlat20 + 9.99999975e-06;
					    u_xlat20 = 0.5 / u_xlat20;
					    u_xlat21 = u_xlat10 * u_xlat10;
					    u_xlat2.x = u_xlat11.x * u_xlat21 + (-u_xlat11.x);
					    u_xlat11.x = u_xlat2.x * u_xlat11.x + 1.0;
					    u_xlat21 = u_xlat21 * 0.318309873;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x + 1.00000001e-07;
					    u_xlat11.x = u_xlat21 / u_xlat11.x;
					    u_xlat20 = u_xlat20 * u_xlat11.x;
					    u_xlat20 = u_xlat20 * 3.14159274;
					    u_xlat20 = u_xlat1.x * u_xlat20;
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat10 = u_xlat10 * u_xlat10 + 1.0;
					    u_xlat10 = float(1.0) / u_xlat10;
					    u_xlat1.x = dot(_spec_color.xyz, _spec_color.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat20 = u_xlat20 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat31) + 1.0;
					    u_xlat1.x = u_xlat1.x + _smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat3.xyz * vec3(u_xlat20);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat20 = u_xlat0.x * u_xlat0.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat0.x = u_xlat0.x * u_xlat20;
					    u_xlat2.xyz = (-_spec_color.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * vec3(u_xlat10);
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat30 * u_xlat30;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat30 = u_xlat30 * u_xlat32;
					    u_xlat3.xyz = u_xlat1.xxx + (-_spec_color.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_8_1[14];
					};
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					int u_xlati10;
					bool u_xlatb10;
					vec2 u_xlat20;
					float u_xlat30;
					float u_xlat31;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat10.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = (-u_xlat0.x) + u_xlat10.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat10.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb10 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb10){
					        u_xlatb10 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb10)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat20.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat20.x, u_xlat10.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					        u_xlati10 = u_xlati10 * 7;
					        u_xlat2 = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.wwww;
					    }
					    u_xlat10.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat20.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_ShadowMapTexture, u_xlat20.xy);
					    u_xlat0.x = u_xlat0.x + u_xlat2.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = min(u_xlat10.x, u_xlat0.x);
					    u_xlat2.xw = (-vec2(_smoothness)) + vec2(1.0, 1.0);
					    u_xlat10.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat10.x = u_xlat10.x + u_xlat10.x;
					    u_xlat10.xyz = vs_TEXCOORD0.xyz * (-u_xlat10.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlatb0 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb0){
					        u_xlat0.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat4.xyz = u_xlat0.xxx * u_xlat10.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat0.x = min(u_xlat5.y, u_xlat5.x);
					        u_xlat0.x = min(u_xlat5.z, u_xlat0.x);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat10.xyz;
					    }
					    u_xlat0.x = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat0.x);
					    u_xlat31 = u_xlat4.w + -1.0;
					    u_xlat31 = unity_SpecCube0_HDR.w * u_xlat31 + 1.0;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.y;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat31);
					    u_xlatb2 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb2){
					        u_xlatb2 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb2){
					            u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					            u_xlat2.x = inversesqrt(u_xlat2.x);
					            u_xlat6.xyz = u_xlat10.xyz * u_xlat2.xxx;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat2.x = min(u_xlat7.y, u_xlat7.x);
					            u_xlat2.x = min(u_xlat7.z, u_xlat2.x);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat10.xyz = u_xlat6.xyz * u_xlat2.xxx + u_xlat7.xyz;
					        }
					        u_xlat0 = textureLod(unity_SpecCube1, u_xlat10.xyz, u_xlat0.x);
					        u_xlat30 = u_xlat0.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat4.xyz + (-u_xlat0.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat0.xyz;
					    }
					    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
					    u_xlat30 = max(_spec_color.y, _spec_color.x);
					    u_xlat30 = max(u_xlat30, _spec_color.z);
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat31 = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.x = u_xlat31 + u_xlat31;
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat2.xxx) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat31 = u_xlat31;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat4.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat4.y = (-u_xlat31) + 1.0;
					    u_xlat4.zw = u_xlat4.xy * u_xlat4.xy;
					    u_xlat10.xy = u_xlat4.xy * u_xlat4.xw;
					    u_xlat2.yz = u_xlat4.zy * u_xlat10.xy;
					    u_xlat10.x = (-u_xlat30) + 1.0;
					    u_xlat10.x = u_xlat10.x + _smoothness;
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat2.yw);
					    u_xlat20.x = u_xlat1.x * 16.0;
					    u_xlat1.xyz = u_xlat20.xxx * _spec_color.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat2.xyw = u_xlat10.xxx + (-_spec_color.xyz);
					    u_xlat2.xyz = u_xlat2.zzz * u_xlat2.xyw + _spec_color.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat0.xzw + u_xlat2.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_8_1[14];
					};
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					int u_xlati3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat31) + u_xlat2.x;
					    u_xlat31 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat31;
					    u_xlat31 = u_xlat31 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					        u_xlati3 = u_xlati3 * 7;
					        u_xlat2 = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.wwww;
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat12.xy);
					    u_xlat31 = u_xlat31 + u_xlat3.x;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat31 = min(u_xlat2.x, u_xlat31);
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat5.xy = (-u_xlat2.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat31 = u_xlat2.x * u_xlat5.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = u_xlat10 * u_xlat10;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21 = u_xlat2.x * u_xlat2.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat10 = (-u_xlat10) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat31) + 1.0;
					    u_xlat20 = u_xlat20 + _smoothness;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * _spec_color.xyz;
					    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xyz;
					    u_xlat2.xyz = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat0.x = (-u_xlat1.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat3.xyz = vec3(u_xlat20) + (-_spec_color.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_8_1[14];
					};
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					int u_xlati3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat31 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat31) + u_xlat2.x;
					    u_xlat31 = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat31;
					    u_xlat31 = u_xlat31 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					        u_xlati3 = u_xlati3 * 7;
					        u_xlat2 = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.wwww;
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3 = texture(_ShadowMapTexture, u_xlat12.xy);
					    u_xlat31 = u_xlat31 + u_xlat3.x;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat31 = min(u_xlat2.x, u_xlat31);
					    u_xlat2.x = (-_smoothness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
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
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat31 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat31 = max(_spec_color.y, _spec_color.x);
					    u_xlat31 = max(u_xlat31, _spec_color.z);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.x = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat10 = max(u_xlat10, 0.00200000009);
					    u_xlat20 = (-u_xlat10) + 1.0;
					    u_xlat21 = abs(u_xlat30) * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat1.x * u_xlat20 + u_xlat10;
					    u_xlat20 = u_xlat20 * abs(u_xlat30);
					    u_xlat20 = u_xlat1.x * u_xlat21 + u_xlat20;
					    u_xlat20 = u_xlat20 + 9.99999975e-06;
					    u_xlat20 = 0.5 / u_xlat20;
					    u_xlat21 = u_xlat10 * u_xlat10;
					    u_xlat2.x = u_xlat11.x * u_xlat21 + (-u_xlat11.x);
					    u_xlat11.x = u_xlat2.x * u_xlat11.x + 1.0;
					    u_xlat21 = u_xlat21 * 0.318309873;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x + 1.00000001e-07;
					    u_xlat11.x = u_xlat21 / u_xlat11.x;
					    u_xlat20 = u_xlat20 * u_xlat11.x;
					    u_xlat20 = u_xlat20 * 3.14159274;
					    u_xlat20 = u_xlat1.x * u_xlat20;
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat10 = u_xlat10 * u_xlat10 + 1.0;
					    u_xlat10 = float(1.0) / u_xlat10;
					    u_xlat1.x = dot(_spec_color.xyz, _spec_color.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat20 = u_xlat20 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat31) + 1.0;
					    u_xlat1.x = u_xlat1.x + _smoothness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat3.xyz * vec3(u_xlat20);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat20 = u_xlat0.x * u_xlat0.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat0.x = u_xlat0.x * u_xlat20;
					    u_xlat2.xyz = (-_spec_color.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * vec3(u_xlat10);
					    u_xlat30 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat30 * u_xlat30;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat30 = u_xlat30 * u_xlat32;
					    u_xlat3.xyz = u_xlat1.xxx + (-_spec_color.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + _spec_color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Transparent+0" "RenderType" = "Custom" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 128027
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
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
					layout(std140) uniform UnityLighting {
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat6 = u_xlat0.y * u_xlat0.y;
					    u_xlat6 = u_xlat0.x * u_xlat0.x + (-u_xlat6);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "INSTANCING_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "INSTANCING_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "INSTANCING_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_2_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_3_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					flat out uint vs_SV_InstanceID0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					int u_xlati4;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati4 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati4] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati4].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 2)].xyz);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat4.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = u_xlat4.y * u_xlat4.y;
					    u_xlat1.x = u_xlat4.x * u_xlat4.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat3.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat2);
					    u_xlat3.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat2);
					    u_xlat3.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat2);
					    vs_TEXCOORD4.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_2_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_3_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					flat out uint vs_SV_InstanceID0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					int u_xlati4;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati4 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati4] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati4].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 2)].xyz);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat4.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = u_xlat4.y * u_xlat4.y;
					    u_xlat1.x = u_xlat4.x * u_xlat4.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat3.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat2);
					    u_xlat3.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat2);
					    u_xlat3.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat2);
					    vs_TEXCOORD4.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_2_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_3_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					flat out uint vs_SV_InstanceID0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					int u_xlati4;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati4 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati4] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati4].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 2)].xyz);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat4.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = u_xlat4.y * u_xlat4.y;
					    u_xlat1.x = u_xlat4.x * u_xlat4.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat3.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat2);
					    u_xlat3.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat2);
					    u_xlat3.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat2);
					    vs_TEXCOORD4.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_HDR_ON" "INSTANCING_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_HDR_ON" "INSTANCING_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_HDR_ON" "INSTANCING_ON" }
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
						vec4 unused_0_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_3_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_2_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_3_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					flat out uint vs_SV_InstanceID0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					int u_xlati4;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati4 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati4] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati4].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 2)].xyz);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat4.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = u_xlat4.y * u_xlat4.y;
					    u_xlat1.x = u_xlat4.x * u_xlat4.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat3.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat2);
					    u_xlat3.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat2);
					    u_xlat3.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat2);
					    vs_TEXCOORD4.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_2_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_3_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					flat out uint vs_SV_InstanceID0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					int u_xlati4;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati4 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati4] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati4].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 2)].xyz);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat4.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = u_xlat4.y * u_xlat4.y;
					    u_xlat1.x = u_xlat4.x * u_xlat4.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat3.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat2);
					    u_xlat3.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat2);
					    u_xlat3.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat2);
					    vs_TEXCOORD4.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
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
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_2_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_3_1[14];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					flat out uint vs_SV_InstanceID0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					int u_xlati4;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati4 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati4] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)];
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati4].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 1)].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 2)].xyz);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat4.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = u_xlat4.y * u_xlat4.y;
					    u_xlat1.x = u_xlat4.x * u_xlat4.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat4.yzzx * u_xlat4.xyzz;
					    u_xlat3.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat2);
					    u_xlat3.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat2);
					    u_xlat3.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat2);
					    vs_TEXCOORD4.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_HDR_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_HDR_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_HDR_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "UNITY_HDR_ON" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "UNITY_HDR_ON" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "UNITY_HDR_ON" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
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
						vec4 _spec_color;
						float _smoothness;
						vec4 unused_0_3;
					};
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
					    SV_Target1.xyz = _spec_color.xyz;
					    SV_Target1.w = _smoothness;
					    SV_Target2.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}