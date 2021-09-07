Shader "SteelCircus/FX/Skills/FloorCircularWaveNormalShader" {
	Properties {
		_Scale ("Normal Scale (warps away from up direction)", Float) = 1
		_AnimProgress ("Anim Progress", Range(0, 1)) = 1
		_StartRadius ("Start Radius", Range(0, 1)) = 1
		_EndRadius ("End Radius", Range(0, 1)) = 1
		_StartPow ("Start Pow", Float) = 1
		_EndPow ("End Pow", Float) = 1
		_AlphaPow ("Alpha Pow (Ring radius)", Float) = 1
		_AnimTimePow ("Anim time pow", Float) = 1
		_FadeInEnd ("Fade-in end radius", Range(0, 1)) = 0.3
		_FadeOutStart ("Fade-out start radius", Range(0, 1)) = 0.8
	}
	SubShader {
		Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 40077
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
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TANGENT0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
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
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TANGENT0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
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
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TANGENT0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
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
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_0[2];
						float _Scale;
						float _AnimProgress;
						float _StartRadius;
						float _EndRadius;
						float _AnimTimePow;
						float _StartPow;
						float _EndPow;
						float _AlphaPow;
						float _FadeOutStart;
						float _FadeInEnd;
					};
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = log2(_AnimProgress);
					    u_xlat0 = u_xlat0 * _AnimTimePow;
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat3 = (-_EndRadius) + 1.0;
					    u_xlat3 = u_xlat3 + (-_StartRadius);
					    u_xlat3 = u_xlat0 * u_xlat3 + _StartRadius;
					    u_xlat6.x = (-_StartRadius) + _EndRadius;
					    u_xlat6.x = u_xlat0 * u_xlat6.x + _StartRadius;
					    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat1.xy = u_xlat1.xy + u_xlat1.xy;
					    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat7 = sqrt(u_xlat9);
					    u_xlat10 = (-_StartPow) + _EndPow;
					    u_xlat10 = u_xlat0 * u_xlat10 + _StartPow;
					    u_xlat7 = log2(u_xlat7);
					    u_xlat7 = u_xlat7 * u_xlat10;
					    u_xlat7 = exp2(u_xlat7);
					    u_xlat3 = (-u_xlat3) + u_xlat7;
					    u_xlat3 = u_xlat3 / u_xlat6.x;
					    u_xlatb6 = 1.0<abs(u_xlat3);
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlat6.x = inversesqrt(u_xlat9);
					    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
					    u_xlat1.x = u_xlat3 * 3.1415;
					    u_xlat1.x = cos(u_xlat1.x);
					    u_xlat3 = u_xlat3 * 0.5 + 0.5;
					    u_xlat3 = u_xlat3 * 3.1415;
					    u_xlat3 = sin(u_xlat3);
					    u_xlat1.x = u_xlat3 * (-u_xlat1.x);
					    u_xlat1.xy = u_xlat6.xy * u_xlat1.xx;
					    u_xlat3 = log2(u_xlat3);
					    u_xlat3 = u_xlat3 * _AlphaPow;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat6.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat6.x);
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6.x = inversesqrt(u_xlat6.x);
					    u_xlat6.xy = u_xlat6.xx * u_xlat2.xz;
					    u_xlat1.xy = u_xlat6.xy * vec2(_Scale);
					    u_xlat6.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat6.x = (-u_xlat1.y) * u_xlat1.y + u_xlat6.x;
					    u_xlat6.x = max(u_xlat6.x, 0.0);
					    u_xlat1.z = sqrt(u_xlat6.x);
					    u_xlat6.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6.x = inversesqrt(u_xlat6.x);
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat6.x = u_xlat0 + (-_FadeOutStart);
					    u_xlat9 = (-_FadeOutStart) + 1.0;
					    u_xlat6.x = u_xlat6.x / u_xlat9;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat3 = u_xlat6.x * u_xlat3;
					    u_xlat0 = u_xlat0 / _FadeInEnd;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    SV_Target0.w = u_xlat0 * u_xlat3;
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
						float _Scale;
						float _AnimProgress;
						float _StartRadius;
						float _EndRadius;
						float _AnimTimePow;
						float _StartPow;
						float _EndPow;
						float _AlphaPow;
						float _FadeOutStart;
						float _FadeInEnd;
					};
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = log2(_AnimProgress);
					    u_xlat0 = u_xlat0 * _AnimTimePow;
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat3 = (-_EndRadius) + 1.0;
					    u_xlat3 = u_xlat3 + (-_StartRadius);
					    u_xlat3 = u_xlat0 * u_xlat3 + _StartRadius;
					    u_xlat6.x = (-_StartRadius) + _EndRadius;
					    u_xlat6.x = u_xlat0 * u_xlat6.x + _StartRadius;
					    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat1.xy = u_xlat1.xy + u_xlat1.xy;
					    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat7 = sqrt(u_xlat9);
					    u_xlat10 = (-_StartPow) + _EndPow;
					    u_xlat10 = u_xlat0 * u_xlat10 + _StartPow;
					    u_xlat7 = log2(u_xlat7);
					    u_xlat7 = u_xlat7 * u_xlat10;
					    u_xlat7 = exp2(u_xlat7);
					    u_xlat3 = (-u_xlat3) + u_xlat7;
					    u_xlat3 = u_xlat3 / u_xlat6.x;
					    u_xlatb6 = 1.0<abs(u_xlat3);
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlat6.x = inversesqrt(u_xlat9);
					    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
					    u_xlat1.x = u_xlat3 * 3.1415;
					    u_xlat1.x = cos(u_xlat1.x);
					    u_xlat3 = u_xlat3 * 0.5 + 0.5;
					    u_xlat3 = u_xlat3 * 3.1415;
					    u_xlat3 = sin(u_xlat3);
					    u_xlat1.x = u_xlat3 * (-u_xlat1.x);
					    u_xlat1.xy = u_xlat6.xy * u_xlat1.xx;
					    u_xlat3 = log2(u_xlat3);
					    u_xlat3 = u_xlat3 * _AlphaPow;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat6.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat6.x);
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6.x = inversesqrt(u_xlat6.x);
					    u_xlat6.xy = u_xlat6.xx * u_xlat2.xz;
					    u_xlat1.xy = u_xlat6.xy * vec2(_Scale);
					    u_xlat6.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat6.x = (-u_xlat1.y) * u_xlat1.y + u_xlat6.x;
					    u_xlat6.x = max(u_xlat6.x, 0.0);
					    u_xlat1.z = sqrt(u_xlat6.x);
					    u_xlat6.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6.x = inversesqrt(u_xlat6.x);
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat6.x = u_xlat0 + (-_FadeOutStart);
					    u_xlat9 = (-_FadeOutStart) + 1.0;
					    u_xlat6.x = u_xlat6.x / u_xlat9;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat3 = u_xlat6.x * u_xlat3;
					    u_xlat0 = u_xlat0 / _FadeInEnd;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    SV_Target0.w = u_xlat0 * u_xlat3;
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
						float _Scale;
						float _AnimProgress;
						float _StartRadius;
						float _EndRadius;
						float _AnimTimePow;
						float _StartPow;
						float _EndPow;
						float _AlphaPow;
						float _FadeOutStart;
						float _FadeInEnd;
					};
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = log2(_AnimProgress);
					    u_xlat0 = u_xlat0 * _AnimTimePow;
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat3 = (-_EndRadius) + 1.0;
					    u_xlat3 = u_xlat3 + (-_StartRadius);
					    u_xlat3 = u_xlat0 * u_xlat3 + _StartRadius;
					    u_xlat6.x = (-_StartRadius) + _EndRadius;
					    u_xlat6.x = u_xlat0 * u_xlat6.x + _StartRadius;
					    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat1.xy = u_xlat1.xy + u_xlat1.xy;
					    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat7 = sqrt(u_xlat9);
					    u_xlat10 = (-_StartPow) + _EndPow;
					    u_xlat10 = u_xlat0 * u_xlat10 + _StartPow;
					    u_xlat7 = log2(u_xlat7);
					    u_xlat7 = u_xlat7 * u_xlat10;
					    u_xlat7 = exp2(u_xlat7);
					    u_xlat3 = (-u_xlat3) + u_xlat7;
					    u_xlat3 = u_xlat3 / u_xlat6.x;
					    u_xlatb6 = 1.0<abs(u_xlat3);
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlat6.x = inversesqrt(u_xlat9);
					    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
					    u_xlat1.x = u_xlat3 * 3.1415;
					    u_xlat1.x = cos(u_xlat1.x);
					    u_xlat3 = u_xlat3 * 0.5 + 0.5;
					    u_xlat3 = u_xlat3 * 3.1415;
					    u_xlat3 = sin(u_xlat3);
					    u_xlat1.x = u_xlat3 * (-u_xlat1.x);
					    u_xlat1.xy = u_xlat6.xy * u_xlat1.xx;
					    u_xlat3 = log2(u_xlat3);
					    u_xlat3 = u_xlat3 * _AlphaPow;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat6.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat6.x);
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6.x = inversesqrt(u_xlat6.x);
					    u_xlat6.xy = u_xlat6.xx * u_xlat2.xz;
					    u_xlat1.xy = u_xlat6.xy * vec2(_Scale);
					    u_xlat6.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat6.x = (-u_xlat1.y) * u_xlat1.y + u_xlat6.x;
					    u_xlat6.x = max(u_xlat6.x, 0.0);
					    u_xlat1.z = sqrt(u_xlat6.x);
					    u_xlat6.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6.x = inversesqrt(u_xlat6.x);
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat6.x = u_xlat0 + (-_FadeOutStart);
					    u_xlat9 = (-_FadeOutStart) + 1.0;
					    u_xlat6.x = u_xlat6.x / u_xlat9;
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat3 = u_xlat6.x * u_xlat3;
					    u_xlat0 = u_xlat0 / _FadeInEnd;
					    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
					    SV_Target0.w = u_xlat0 * u_xlat3;
					    return;
					}"
				}
			}
		}
	}
}