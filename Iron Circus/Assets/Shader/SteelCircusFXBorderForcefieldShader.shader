Shader "SteelCircus/FX/BorderForcefieldShader" {
	Properties {
		_NoiseTex ("Noise", 2D) = "white" {}
		_NoiseOffsetTex ("Offset Noise", 2D) = "white" {}
		_NoiseOffsetSpeed ("Offset Noise Speed", Float) = 1
		_NoiseOffsetIntensity ("Offset Noise Intensity", Float) = 1
		_GradientTex ("Gradient (1D)", 2D) = "white" {}
		_GradientOverlayTex ("Gradient Overlay (1D)", 2D) = "white" {}
		_LightningSpeed ("LightningSpeed", Float) = 1
		_LightningPow ("LightningPow", Float) = 10
		_LightningScrollY ("LightningScrollY", Float) = 1
		_LightningColor ("LightningColor", Vector) = (1,1,1,1)
		_BrightnessParams ("Brightness Params (experimental)", Vector) = (1,1,1,1)
		_HitTex ("Hit Gradient (x = brightness over dist., y = time)", 2D) = "white" {}
		_HitInfo ("Hit Info (experimental - pos.xyz, hit progress = w)", Vector) = (1,1,1,0)
		_HitRadius ("Max Hit Radius", Float) = 1
		_HitBrightness ("Hit Brightness", Float) = 1
		_HitLightningBrightness ("Hit Lightning Brightness", Float) = 40
		_FresnelAmount ("FresnelAmount", Range(0, 1)) = 1
		_LightmapScale ("Lightmap Intensity Scale", Float) = 1
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 107942
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
						vec4 _NoiseTex_ST;
						vec4 _NoiseOffsetTex_ST;
						vec4 unused_0_3[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
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
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseOffsetTex_ST.xy + _NoiseOffsetTex_ST.zw;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.xyz = in_NORMAL0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
					    vs_NORMAL0.xyz = unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
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
						vec4 _NoiseTex_ST;
						vec4 _NoiseOffsetTex_ST;
						vec4 unused_0_3[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
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
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseOffsetTex_ST.xy + _NoiseOffsetTex_ST.zw;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.xyz = in_NORMAL0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
					    vs_NORMAL0.xyz = unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
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
						vec4 _NoiseTex_ST;
						vec4 _NoiseOffsetTex_ST;
						vec4 unused_0_3[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
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
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _NoiseOffsetTex_ST.xy + _NoiseOffsetTex_ST.zw;
					    vs_TEXCOORD3 = u_xlat0;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat0.xyz = in_NORMAL0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
					    vs_NORMAL0.xyz = unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
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
						float _NoiseOffsetSpeed;
						float _NoiseOffsetIntensity;
						float _FresnelAmount;
						float _LightningSpeed;
						float _LightningPow;
						float _LightningScrollY;
						vec4 _LightningColor;
						vec4 _BrightnessParams;
						vec4 _HitInfo;
						float _HitRadius;
						float _HitBrightness;
						float _HitLightningBrightness;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _HitTex;
					uniform  sampler2D _NoiseOffsetTex;
					uniform  sampler2D _NoiseTex;
					uniform  sampler2D _GradientOverlayTex;
					uniform  sampler2D _GradientTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat8;
					vec2 u_xlat9;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _LightningScrollY * _Time.y;
					    u_xlat1.y = (-_NoiseOffsetSpeed) * _Time.y;
					    u_xlat1.x = float(0.0);
					    u_xlat9.x = float(0.0);
					    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD2.xy;
					    u_xlat2 = texture(_NoiseOffsetTex, u_xlat4.xy);
					    u_xlat9.y = (-u_xlat2.x) * _NoiseOffsetIntensity + (-u_xlat0.x);
					    u_xlat0.x = u_xlat2.y * u_xlat2.y;
					    u_xlat4.xy = u_xlat9.xy + vs_TEXCOORD1.xy;
					    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
					    u_xlat4.x = _Time.x * _LightningSpeed + u_xlat1.x;
					    u_xlat4.x = u_xlat4.x * 18.849556;
					    u_xlat4.x = cos(u_xlat4.x);
					    u_xlat4.x = (-u_xlat4.x) * 0.5 + 0.5;
					    u_xlat4.x = log2(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _LightningPow;
					    u_xlat8 = exp2(u_xlat4.x);
					    u_xlat12 = vs_TEXCOORD0.y * 0.75 + 0.25;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * 0.25;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat0.x = u_xlat0.x * u_xlat12;
					    u_xlat9.x = u_xlat0.x * u_xlat8 + vs_TEXCOORD0.y;
					    u_xlat1.y = float(0.0);
					    u_xlat9.y = float(0.0);
					    u_xlat2 = texture(_GradientTex, u_xlat9.xy);
					    u_xlat0.xzw = vs_TEXCOORD3.xyz + (-_HitInfo.xyz);
					    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _HitRadius;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat3.x = (-u_xlat0.x);
					    u_xlat3.y = (-_HitInfo.w);
					    u_xlat0.xz = u_xlat3.xy + vec2(1.0, 1.0);
					    u_xlat3 = texture(_HitTex, u_xlat0.xz);
					    u_xlat0.x = u_xlat3.x * 10.0 + 15.0;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(vec3(_HitLightningBrightness, _HitLightningBrightness, _HitLightningBrightness)) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_HitBrightness, _HitBrightness, _HitBrightness)) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * _LightningColor.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _BrightnessParams.xxx;
					    u_xlat12 = (-vs_TEXCOORD0.y) + 1.0;
					    u_xlat9.x = u_xlat12 * u_xlat12 + -1.0;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat2.w = _BrightnessParams.w * u_xlat12 + _BrightnessParams.z;
					    u_xlat12 = _BrightnessParams.y * u_xlat9.x + 1.0;
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.x = vs_TEXCOORD0.y;
					    u_xlat1 = texture(_GradientOverlayTex, u_xlat1.xy);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.20000005;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + -1.0;
					    u_xlat0.x = _FresnelAmount * u_xlat0.x + 1.0;
					    SV_Target0 = u_xlat0.xxxx * u_xlat2;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
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
						float _NoiseOffsetSpeed;
						float _NoiseOffsetIntensity;
						float _FresnelAmount;
						float _LightningSpeed;
						float _LightningPow;
						float _LightningScrollY;
						vec4 _LightningColor;
						vec4 _BrightnessParams;
						vec4 _HitInfo;
						float _HitRadius;
						float _HitBrightness;
						float _HitLightningBrightness;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _HitTex;
					uniform  sampler2D _NoiseOffsetTex;
					uniform  sampler2D _NoiseTex;
					uniform  sampler2D _GradientOverlayTex;
					uniform  sampler2D _GradientTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat8;
					vec2 u_xlat9;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _LightningScrollY * _Time.y;
					    u_xlat1.y = (-_NoiseOffsetSpeed) * _Time.y;
					    u_xlat1.x = float(0.0);
					    u_xlat9.x = float(0.0);
					    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD2.xy;
					    u_xlat2 = texture(_NoiseOffsetTex, u_xlat4.xy);
					    u_xlat9.y = (-u_xlat2.x) * _NoiseOffsetIntensity + (-u_xlat0.x);
					    u_xlat0.x = u_xlat2.y * u_xlat2.y;
					    u_xlat4.xy = u_xlat9.xy + vs_TEXCOORD1.xy;
					    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
					    u_xlat4.x = _Time.x * _LightningSpeed + u_xlat1.x;
					    u_xlat4.x = u_xlat4.x * 18.849556;
					    u_xlat4.x = cos(u_xlat4.x);
					    u_xlat4.x = (-u_xlat4.x) * 0.5 + 0.5;
					    u_xlat4.x = log2(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _LightningPow;
					    u_xlat8 = exp2(u_xlat4.x);
					    u_xlat12 = vs_TEXCOORD0.y * 0.75 + 0.25;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * 0.25;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat0.x = u_xlat0.x * u_xlat12;
					    u_xlat9.x = u_xlat0.x * u_xlat8 + vs_TEXCOORD0.y;
					    u_xlat1.y = float(0.0);
					    u_xlat9.y = float(0.0);
					    u_xlat2 = texture(_GradientTex, u_xlat9.xy);
					    u_xlat0.xzw = vs_TEXCOORD3.xyz + (-_HitInfo.xyz);
					    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _HitRadius;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat3.x = (-u_xlat0.x);
					    u_xlat3.y = (-_HitInfo.w);
					    u_xlat0.xz = u_xlat3.xy + vec2(1.0, 1.0);
					    u_xlat3 = texture(_HitTex, u_xlat0.xz);
					    u_xlat0.x = u_xlat3.x * 10.0 + 15.0;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(vec3(_HitLightningBrightness, _HitLightningBrightness, _HitLightningBrightness)) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_HitBrightness, _HitBrightness, _HitBrightness)) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * _LightningColor.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _BrightnessParams.xxx;
					    u_xlat12 = (-vs_TEXCOORD0.y) + 1.0;
					    u_xlat9.x = u_xlat12 * u_xlat12 + -1.0;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat2.w = _BrightnessParams.w * u_xlat12 + _BrightnessParams.z;
					    u_xlat12 = _BrightnessParams.y * u_xlat9.x + 1.0;
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.x = vs_TEXCOORD0.y;
					    u_xlat1 = texture(_GradientOverlayTex, u_xlat1.xy);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.20000005;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + -1.0;
					    u_xlat0.x = _FresnelAmount * u_xlat0.x + 1.0;
					    SV_Target0 = u_xlat0.xxxx * u_xlat2;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
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
						float _NoiseOffsetSpeed;
						float _NoiseOffsetIntensity;
						float _FresnelAmount;
						float _LightningSpeed;
						float _LightningPow;
						float _LightningScrollY;
						vec4 _LightningColor;
						vec4 _BrightnessParams;
						vec4 _HitInfo;
						float _HitRadius;
						float _HitBrightness;
						float _HitLightningBrightness;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _HitTex;
					uniform  sampler2D _NoiseOffsetTex;
					uniform  sampler2D _NoiseTex;
					uniform  sampler2D _GradientOverlayTex;
					uniform  sampler2D _GradientTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat8;
					vec2 u_xlat9;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _LightningScrollY * _Time.y;
					    u_xlat1.y = (-_NoiseOffsetSpeed) * _Time.y;
					    u_xlat1.x = float(0.0);
					    u_xlat9.x = float(0.0);
					    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD2.xy;
					    u_xlat2 = texture(_NoiseOffsetTex, u_xlat4.xy);
					    u_xlat9.y = (-u_xlat2.x) * _NoiseOffsetIntensity + (-u_xlat0.x);
					    u_xlat0.x = u_xlat2.y * u_xlat2.y;
					    u_xlat4.xy = u_xlat9.xy + vs_TEXCOORD1.xy;
					    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
					    u_xlat4.x = _Time.x * _LightningSpeed + u_xlat1.x;
					    u_xlat4.x = u_xlat4.x * 18.849556;
					    u_xlat4.x = cos(u_xlat4.x);
					    u_xlat4.x = (-u_xlat4.x) * 0.5 + 0.5;
					    u_xlat4.x = log2(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _LightningPow;
					    u_xlat8 = exp2(u_xlat4.x);
					    u_xlat12 = vs_TEXCOORD0.y * 0.75 + 0.25;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * 0.25;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat0.x = u_xlat0.x * u_xlat12;
					    u_xlat9.x = u_xlat0.x * u_xlat8 + vs_TEXCOORD0.y;
					    u_xlat1.y = float(0.0);
					    u_xlat9.y = float(0.0);
					    u_xlat2 = texture(_GradientTex, u_xlat9.xy);
					    u_xlat0.xzw = vs_TEXCOORD3.xyz + (-_HitInfo.xyz);
					    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _HitRadius;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat3.x = (-u_xlat0.x);
					    u_xlat3.y = (-_HitInfo.w);
					    u_xlat0.xz = u_xlat3.xy + vec2(1.0, 1.0);
					    u_xlat3 = texture(_HitTex, u_xlat0.xz);
					    u_xlat0.x = u_xlat3.x * 10.0 + 15.0;
					    u_xlat0.x = u_xlat4.x * u_xlat0.x;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(vec3(_HitLightningBrightness, _HitLightningBrightness, _HitLightningBrightness)) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_HitBrightness, _HitBrightness, _HitBrightness)) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * _LightningColor.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _BrightnessParams.xxx;
					    u_xlat12 = (-vs_TEXCOORD0.y) + 1.0;
					    u_xlat9.x = u_xlat12 * u_xlat12 + -1.0;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat2.w = _BrightnessParams.w * u_xlat12 + _BrightnessParams.z;
					    u_xlat12 = _BrightnessParams.y * u_xlat9.x + 1.0;
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.x = vs_TEXCOORD0.y;
					    u_xlat1 = texture(_GradientOverlayTex, u_xlat1.xy);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_NORMAL0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.20000005;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + -1.0;
					    u_xlat0.x = _FresnelAmount * u_xlat0.x + 1.0;
					    SV_Target0 = u_xlat0.xxxx * u_xlat2;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
			}
		}
	}
}