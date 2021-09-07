Shader "SteelCircus/FX/Skills/HildegardShieldImpactShader" {
	Properties {
		_Color ("Tint", Vector) = (1,1,1,1)
		_Brightness ("Brightness", Float) = 1
		[NoScaleOffset] _MainTex ("Texture (r=pattern, gb=displacement, a=mask)", 2D) = "white" {}
		[NoScaleOffset] _RampTex ("Ramp", 2D) = "white" {}
		_DispParams ("Displacement (x=h, y=v, z=scroll speed)", Vector) = (0.05,0.1,1,0)
		_ScrollSpeed ("Main Pattern scroll speed", Float) = 1
		_AnimTime ("Anim Time", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ZWrite Off
			Cull Off
			GpuProgramID 7840
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
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
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
						vec4 _DispParams;
						vec4 _Color;
						float _ScrollSpeed;
						float _AnimTime;
						float _Brightness;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RampTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					vec2 u_xlat4;
					void main()
					{
					    u_xlat0.y = _DispParams.z * _Time.y;
					    u_xlat0.x = float(0.0);
					    u_xlat4.x = float(0.0);
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat4.y = _ScrollSpeed * _Time.y;
					    u_xlat0.xy = u_xlat4.xy + vs_TEXCOORD1.xy;
					    u_xlat0.xy = u_xlat1.yz * _DispParams.xy + u_xlat0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat2 = log2(_AnimTime);
					    u_xlat2 = u_xlat2 * 0.75;
					    u_xlat1.y = exp2(u_xlat2);
					    u_xlat2 = u_xlat1.y + u_xlat1.y;
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat4.x = u_xlat1.y + -0.5;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat2 = (-u_xlat4.x) * 2.0 + u_xlat2;
					    u_xlat4.x = (-u_xlat4.x) * 2.0 + vs_TEXCOORD0.y;
					    u_xlat2 = max(u_xlat2, 9.99999975e-06);
					    u_xlat2 = u_xlat4.x / u_xlat2;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * 3.14159203;
					    u_xlat2 = sin(u_xlat2);
					    u_xlat1.x = u_xlat2 * u_xlat0.x;
					    u_xlat0 = texture(_RampTex, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat0.w = 1.0;
					    SV_Target0 = u_xlat0 * _Color;
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
						vec4 _DispParams;
						vec4 _Color;
						float _ScrollSpeed;
						float _AnimTime;
						float _Brightness;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RampTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					vec2 u_xlat4;
					void main()
					{
					    u_xlat0.y = _DispParams.z * _Time.y;
					    u_xlat0.x = float(0.0);
					    u_xlat4.x = float(0.0);
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat4.y = _ScrollSpeed * _Time.y;
					    u_xlat0.xy = u_xlat4.xy + vs_TEXCOORD1.xy;
					    u_xlat0.xy = u_xlat1.yz * _DispParams.xy + u_xlat0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat2 = log2(_AnimTime);
					    u_xlat2 = u_xlat2 * 0.75;
					    u_xlat1.y = exp2(u_xlat2);
					    u_xlat2 = u_xlat1.y + u_xlat1.y;
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat4.x = u_xlat1.y + -0.5;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat2 = (-u_xlat4.x) * 2.0 + u_xlat2;
					    u_xlat4.x = (-u_xlat4.x) * 2.0 + vs_TEXCOORD0.y;
					    u_xlat2 = max(u_xlat2, 9.99999975e-06);
					    u_xlat2 = u_xlat4.x / u_xlat2;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * 3.14159203;
					    u_xlat2 = sin(u_xlat2);
					    u_xlat1.x = u_xlat2 * u_xlat0.x;
					    u_xlat0 = texture(_RampTex, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat0.w = 1.0;
					    SV_Target0 = u_xlat0 * _Color;
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
						vec4 _DispParams;
						vec4 _Color;
						float _ScrollSpeed;
						float _AnimTime;
						float _Brightness;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RampTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					vec2 u_xlat4;
					void main()
					{
					    u_xlat0.y = _DispParams.z * _Time.y;
					    u_xlat0.x = float(0.0);
					    u_xlat4.x = float(0.0);
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat4.y = _ScrollSpeed * _Time.y;
					    u_xlat0.xy = u_xlat4.xy + vs_TEXCOORD1.xy;
					    u_xlat0.xy = u_xlat1.yz * _DispParams.xy + u_xlat0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat2 = log2(_AnimTime);
					    u_xlat2 = u_xlat2 * 0.75;
					    u_xlat1.y = exp2(u_xlat2);
					    u_xlat2 = u_xlat1.y + u_xlat1.y;
					    u_xlat2 = min(u_xlat2, 1.0);
					    u_xlat4.x = u_xlat1.y + -0.5;
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat2 = (-u_xlat4.x) * 2.0 + u_xlat2;
					    u_xlat4.x = (-u_xlat4.x) * 2.0 + vs_TEXCOORD0.y;
					    u_xlat2 = max(u_xlat2, 9.99999975e-06);
					    u_xlat2 = u_xlat4.x / u_xlat2;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat2 = u_xlat2 * 3.14159203;
					    u_xlat2 = sin(u_xlat2);
					    u_xlat1.x = u_xlat2 * u_xlat0.x;
					    u_xlat0 = texture(_RampTex, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
					    u_xlat0.w = 1.0;
					    SV_Target0 = u_xlat0 * _Color;
					    return;
					}"
				}
			}
		}
	}
}