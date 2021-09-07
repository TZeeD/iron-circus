Shader "SteelCircus/WavyPlantShader" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_Color ("Color", Vector) = (1,1,1,1)
		_Cutoff ("Base Alpha cutoff", Range(0.01, 1)) = 0.5
		_WaveSpeed ("Wave Speed", Float) = 1
		_WaveIntensity ("Wave Strength", Float) = 1
		_NoiseTex ("Noise Texture (for random bend angles)", 2D) = "white" {}
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
			Cull Off
			GpuProgramID 60899
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
						vec4 _NoiseTex_ST;
						float _WaveSpeed;
						float _WaveIntensity;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _NoiseTex;
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = _WaveSpeed * _Time.y;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat3.xy = u_xlat1.xz * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
					    u_xlat2 = textureLod(_NoiseTex, u_xlat3.xy, 0.0);
					    u_xlat0.x = u_xlat2.z * 6.28318548 + u_xlat0.x;
					    u_xlat2.xz = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _WaveIntensity;
					    u_xlat3.x = in_TEXCOORD1.y;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat3.x = dot(u_xlat2.xz, u_xlat2.xz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat2.y = 0.0;
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
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
						vec4 _NoiseTex_ST;
						float _WaveSpeed;
						float _WaveIntensity;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _NoiseTex;
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = _WaveSpeed * _Time.y;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat3.xy = u_xlat1.xz * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
					    u_xlat2 = textureLod(_NoiseTex, u_xlat3.xy, 0.0);
					    u_xlat0.x = u_xlat2.z * 6.28318548 + u_xlat0.x;
					    u_xlat2.xz = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _WaveIntensity;
					    u_xlat3.x = in_TEXCOORD1.y;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat3.x = dot(u_xlat2.xz, u_xlat2.xz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat2.y = 0.0;
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
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
						vec4 _NoiseTex_ST;
						float _WaveSpeed;
						float _WaveIntensity;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _NoiseTex;
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = _WaveSpeed * _Time.y;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat3.xy = u_xlat1.xz * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
					    u_xlat2 = textureLod(_NoiseTex, u_xlat3.xy, 0.0);
					    u_xlat0.x = u_xlat2.z * 6.28318548 + u_xlat0.x;
					    u_xlat2.xz = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _WaveIntensity;
					    u_xlat3.x = in_TEXCOORD1.y;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat3.x = dot(u_xlat2.xz, u_xlat2.xz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat2.y = 0.0;
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
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
						vec4 _Color;
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb1 = _Cutoff>=u_xlat0.w;
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1 = vs_COLOR0 * _Color;
					    SV_Target0 = u_xlat0 * u_xlat1;
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
						vec4 _Color;
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb1 = _Cutoff>=u_xlat0.w;
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1 = vs_COLOR0 * _Color;
					    SV_Target0 = u_xlat0 * u_xlat1;
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
						vec4 _Color;
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb1 = _Cutoff>=u_xlat0.w;
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1 = vs_COLOR0 * _Color;
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
			}
		}
	}
}