Shader "IMI/Amplify/FireTrailParticleShader" {
	Properties {
		_ScrollSpeed1 ("Scroll Speed 1", Float) = 1
		_ScrollSpeed2 ("Scroll Speed 2", Float) = 1
		_DisplacementScrollSpeed ("Displacement Scroll Speed", Float) = 1
		_DisplacementIntensity ("Displacement Intensity", Float) = 1
		_MaskDisplacementIntensity ("Mask Displacement Intensity", Float) = 0.1
		_MaskYOffset ("Mask Y Offset", Float) = 0
		_MainTex ("Main Tex (R,G = noise, B = displacement)", 2D) = "white" {}
		_DisplacementTilingScale ("Displacement Tiling Scale", Float) = 1
		_GlobalAnimationSpeedScale ("Global Animation Speed Scale", Float) = 1
		[NoScaleOffset] _MaskTex ("Mask Tex", 2D) = "white" {}
		[NoScaleOffset] _ColorRamp ("Color Ramp", 2D) = "white" {}
		_BrightnessScale ("Brightness Scale", Float) = 1
		_Color ("Color", Vector) = (0,0,0,0)
		_ColorRampDisplacement ("Color Ramp Displacement", Float) = 1
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "Unlit"
			LOD 100
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One OneMinusSrcAlpha, One One
			ZWrite Off
			Cull Off
			GpuProgramID 8253
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
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
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
					    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
					    vs_TEXCOORD0.w = 0.0;
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
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
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
					    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
					    vs_TEXCOORD0.w = 0.0;
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
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
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
					    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
					    vs_TEXCOORD0.w = 0.0;
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
						float _ScrollSpeed1;
						float _GlobalAnimationSpeedScale;
						vec4 _MainTex_ST;
						float _DisplacementScrollSpeed;
						float _DisplacementTilingScale;
						float _DisplacementIntensity;
						float _ScrollSpeed2;
						vec4 _MaskTex_ST;
						float _MaskDisplacementIntensity;
						float _MaskYOffset;
						float _ColorRampDisplacement;
						float _BrightnessScale;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _ColorRamp;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat11;
					vec2 u_xlat13;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.y = vs_TEXCOORD0.z;
					    u_xlat1.x = float(0.0);
					    u_xlat11.x = float(0.0);
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat2.xy = vec2(vec2(_GlobalAnimationSpeedScale, _GlobalAnimationSpeedScale)) * vec2(_DisplacementScrollSpeed, _ScrollSpeed2);
					    u_xlat2.z = 0.0;
					    u_xlat10.xy = _Time.yy * u_xlat2.zy + u_xlat0.xy;
					    u_xlat1.xy = u_xlat2.zx * _Time.yy;
					    u_xlat1.xy = u_xlat0.xy * vec2(vec2(_DisplacementTilingScale, _DisplacementTilingScale)) + u_xlat1.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat3.y = u_xlat2.z * _DisplacementIntensity;
					    u_xlat3.x = float(0.0);
					    u_xlat13.x = float(0.0);
					    u_xlat10.xy = u_xlat10.xy + u_xlat3.xy;
					    u_xlat4 = texture(_MainTex, u_xlat10.xy);
					    u_xlat11.y = _GlobalAnimationSpeedScale * _ScrollSpeed1;
					    u_xlat0.xy = _Time.yy * u_xlat11.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat3.xy + u_xlat0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat4.y + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat13.y = u_xlat2.y * _MaskDisplacementIntensity + _MaskYOffset;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat5.xz = u_xlat13.xy + u_xlat5.xy;
					    u_xlat1.y = u_xlat2.z * _ColorRampDisplacement + u_xlat5.y;
					    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
					    u_xlat2 = texture(_MaskTex, u_xlat5.xz);
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat1.x = u_xlat0.x * vs_COLOR0.w;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0 = texture(_ColorRamp, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BrightnessScale, _BrightnessScale, _BrightnessScale));
					    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz;
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
						float _ScrollSpeed1;
						float _GlobalAnimationSpeedScale;
						vec4 _MainTex_ST;
						float _DisplacementScrollSpeed;
						float _DisplacementTilingScale;
						float _DisplacementIntensity;
						float _ScrollSpeed2;
						vec4 _MaskTex_ST;
						float _MaskDisplacementIntensity;
						float _MaskYOffset;
						float _ColorRampDisplacement;
						float _BrightnessScale;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _ColorRamp;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat11;
					vec2 u_xlat13;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.y = vs_TEXCOORD0.z;
					    u_xlat1.x = float(0.0);
					    u_xlat11.x = float(0.0);
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat2.xy = vec2(vec2(_GlobalAnimationSpeedScale, _GlobalAnimationSpeedScale)) * vec2(_DisplacementScrollSpeed, _ScrollSpeed2);
					    u_xlat2.z = 0.0;
					    u_xlat10.xy = _Time.yy * u_xlat2.zy + u_xlat0.xy;
					    u_xlat1.xy = u_xlat2.zx * _Time.yy;
					    u_xlat1.xy = u_xlat0.xy * vec2(vec2(_DisplacementTilingScale, _DisplacementTilingScale)) + u_xlat1.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat3.y = u_xlat2.z * _DisplacementIntensity;
					    u_xlat3.x = float(0.0);
					    u_xlat13.x = float(0.0);
					    u_xlat10.xy = u_xlat10.xy + u_xlat3.xy;
					    u_xlat4 = texture(_MainTex, u_xlat10.xy);
					    u_xlat11.y = _GlobalAnimationSpeedScale * _ScrollSpeed1;
					    u_xlat0.xy = _Time.yy * u_xlat11.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat3.xy + u_xlat0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat4.y + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat13.y = u_xlat2.y * _MaskDisplacementIntensity + _MaskYOffset;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat5.xz = u_xlat13.xy + u_xlat5.xy;
					    u_xlat1.y = u_xlat2.z * _ColorRampDisplacement + u_xlat5.y;
					    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
					    u_xlat2 = texture(_MaskTex, u_xlat5.xz);
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat1.x = u_xlat0.x * vs_COLOR0.w;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0 = texture(_ColorRamp, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BrightnessScale, _BrightnessScale, _BrightnessScale));
					    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz;
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
						float _ScrollSpeed1;
						float _GlobalAnimationSpeedScale;
						vec4 _MainTex_ST;
						float _DisplacementScrollSpeed;
						float _DisplacementTilingScale;
						float _DisplacementIntensity;
						float _ScrollSpeed2;
						vec4 _MaskTex_ST;
						float _MaskDisplacementIntensity;
						float _MaskYOffset;
						float _ColorRampDisplacement;
						float _BrightnessScale;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _ColorRamp;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat11;
					vec2 u_xlat13;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.y = vs_TEXCOORD0.z;
					    u_xlat1.x = float(0.0);
					    u_xlat11.x = float(0.0);
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat2.xy = vec2(vec2(_GlobalAnimationSpeedScale, _GlobalAnimationSpeedScale)) * vec2(_DisplacementScrollSpeed, _ScrollSpeed2);
					    u_xlat2.z = 0.0;
					    u_xlat10.xy = _Time.yy * u_xlat2.zy + u_xlat0.xy;
					    u_xlat1.xy = u_xlat2.zx * _Time.yy;
					    u_xlat1.xy = u_xlat0.xy * vec2(vec2(_DisplacementTilingScale, _DisplacementTilingScale)) + u_xlat1.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat3.y = u_xlat2.z * _DisplacementIntensity;
					    u_xlat3.x = float(0.0);
					    u_xlat13.x = float(0.0);
					    u_xlat10.xy = u_xlat10.xy + u_xlat3.xy;
					    u_xlat4 = texture(_MainTex, u_xlat10.xy);
					    u_xlat11.y = _GlobalAnimationSpeedScale * _ScrollSpeed1;
					    u_xlat0.xy = _Time.yy * u_xlat11.xy + u_xlat0.xy;
					    u_xlat0.xy = u_xlat3.xy + u_xlat0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0.x = u_xlat4.y + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat13.y = u_xlat2.y * _MaskDisplacementIntensity + _MaskYOffset;
					    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat5.xz = u_xlat13.xy + u_xlat5.xy;
					    u_xlat1.y = u_xlat2.z * _ColorRampDisplacement + u_xlat5.y;
					    u_xlat1.y = clamp(u_xlat1.y, 0.0, 1.0);
					    u_xlat2 = texture(_MaskTex, u_xlat5.xz);
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat1.x = u_xlat0.x * vs_COLOR0.w;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0 = texture(_ColorRamp, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_BrightnessScale, _BrightnessScale, _BrightnessScale));
					    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz;
					    SV_Target0 = u_xlat0 * _Color;
					    return;
					}"
				}
			}
		}
	}
	CustomEditor "ASEMaterialInspector"
}