Shader "IMI/Amplify/FireExhaust" {
	Properties {
		_Tex_fire ("Tex_fire", 2D) = "white" {}
		_noise_01 ("noise_01", 2D) = "white" {}
		_noise_02 ("noise_02", 2D) = "white" {}
		_Intensity ("Intensity", Float) = 1
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "SubShader 0 Pass 0"
			LOD 100
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ZWrite Off
			Cull Off
			GpuProgramID 60711
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
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					in  vec3 in_NORMAL0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.w = 0.0;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					in  vec3 in_NORMAL0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.w = 0.0;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					in  vec3 in_NORMAL0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.w = 0.0;
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
						vec4 unused_0_0[2];
						float _Intensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _noise_01;
					uniform  sampler2D _noise_02;
					uniform  sampler2D _Tex_fire;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					float u_xlat7;
					void main()
					{
					    u_xlat0.xy = _Time.yy * vec2(-2.0, -0.300000012);
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + u_xlat0.xy;
					    u_xlat0 = texture(_noise_02, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xy = _Time.yy * vec2(-1.0, 0.300000012) + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_noise_01, u_xlat2.xy);
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x + u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * vs_TEXCOORD0.x;
					    u_xlat0.x = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.y = vs_TEXCOORD0.y;
					    u_xlat0 = texture(_Tex_fire, u_xlat0.xy);
					    u_xlat0 = u_xlat0.xyzx * vec4(_Intensity);
					    u_xlat1.x = vs_TEXCOORD0.x * 5.0;
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
					    u_xlat1.x = (-u_xlat1.x) + 1.14999998;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    SV_Target0 = u_xlat0 * vs_COLOR0.xyzx;
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
						float _Intensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _noise_01;
					uniform  sampler2D _noise_02;
					uniform  sampler2D _Tex_fire;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					float u_xlat7;
					void main()
					{
					    u_xlat0.xy = _Time.yy * vec2(-2.0, -0.300000012);
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + u_xlat0.xy;
					    u_xlat0 = texture(_noise_02, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xy = _Time.yy * vec2(-1.0, 0.300000012) + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_noise_01, u_xlat2.xy);
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x + u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * vs_TEXCOORD0.x;
					    u_xlat0.x = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.y = vs_TEXCOORD0.y;
					    u_xlat0 = texture(_Tex_fire, u_xlat0.xy);
					    u_xlat0 = u_xlat0.xyzx * vec4(_Intensity);
					    u_xlat1.x = vs_TEXCOORD0.x * 5.0;
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
					    u_xlat1.x = (-u_xlat1.x) + 1.14999998;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    SV_Target0 = u_xlat0 * vs_COLOR0.xyzx;
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
						float _Intensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _noise_01;
					uniform  sampler2D _noise_02;
					uniform  sampler2D _Tex_fire;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					float u_xlat7;
					void main()
					{
					    u_xlat0.xy = _Time.yy * vec2(-2.0, -0.300000012);
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + u_xlat0.xy;
					    u_xlat0 = texture(_noise_02, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xy = _Time.yy * vec2(-1.0, 0.300000012) + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_noise_01, u_xlat2.xy);
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x + u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * vs_TEXCOORD0.x;
					    u_xlat0.x = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.y = vs_TEXCOORD0.y;
					    u_xlat0 = texture(_Tex_fire, u_xlat0.xy);
					    u_xlat0 = u_xlat0.xyzx * vec4(_Intensity);
					    u_xlat1.x = vs_TEXCOORD0.x * 5.0;
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat1.xyz);
					    u_xlat1.x = (-u_xlat1.x) + 1.14999998;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    SV_Target0 = u_xlat0 * vs_COLOR0.xyzx;
					    return;
					}"
				}
			}
		}
	}
	CustomEditor "ASEMaterialInspector"
}