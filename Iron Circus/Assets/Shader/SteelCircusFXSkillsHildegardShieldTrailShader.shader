Shader "SteelCircus/FX/Skills/HildegardShieldTrailShader" {
	Properties {
		[NoScaleOffset] _MainTex ("Texture", 2D) = "white" {}
		[NoScaleOffset] _RampTex ("Ramp", 2D) = "white" {}
		[NoScaleOffset] _MaskTex ("Mask", 2D) = "white" {}
		_Color ("Tint", Vector) = (1,1,1,1)
		_Brightness ("Brightness", Float) = 1
		_TrailLength ("Trail Length", Range(0, 1)) = 1
		_TrailPow ("Trail Pow", Float) = 1
		_NoiseTiling ("Noise Tiling (x,y)", Vector) = (1,1,1,1)
		_NoiseSpeed ("Noise Scroll Speed (xy, xy)", Vector) = (1,1,1,1)
		_LightningParams ("Lightning Params (x=Scroll Speed, y=Displacement, z=Tiling)", Vector) = (1,1,1,1)
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 34065
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
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						float _TrailLength;
						float _TrailPow;
						float _Brightness;
						vec2 _NoiseTiling;
						vec4 _NoiseSpeed;
						vec4 _LightningParams;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _RampTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					float u_xlat6;
					vec2 u_xlat7;
					void main()
					{
					    u_xlat0 = _NoiseSpeed.yxwz * _Time.yyyy;
					    u_xlat0 = vs_TEXCOORD0.yxyx * _NoiseTiling.yxyx + u_xlat0;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0.x = dot(u_xlat1.xx, u_xlat0.yy);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * _LightningParams.y;
					    u_xlat1.x = _LightningParams.x * _Time.y;
					    u_xlat1.y = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat3.xy = vs_TEXCOORD0.yx * _LightningParams.zz + u_xlat1.xy;
					    u_xlat3.xy = u_xlat7.xy + u_xlat3.xy;
					    u_xlat1 = texture(_MainTex, u_xlat3.xy);
					    u_xlat2 = texture(_MaskTex, vs_TEXCOORD0.xy);
					    u_xlat3.x = u_xlat1.z * u_xlat2.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat3.x = (-_TrailLength) + 1.0;
					    u_xlat3.x = (-u_xlat3.x) + vs_TEXCOORD0.y;
					    u_xlat6 = max(_TrailLength, 0.00100000005);
					    u_xlat3.x = u_xlat3.x / u_xlat6;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = log2(u_xlat3.x);
					    u_xlat3.x = u_xlat3.x * _TrailPow;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat1.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1.y = 0.0;
					    u_xlat1 = texture(_RampTex, u_xlat1.xy);
					    u_xlat1.w = 1.0;
					    u_xlat0 = u_xlat3.xxxx * u_xlat1;
					    u_xlat1 = vec4(vec4(_Brightness, _Brightness, _Brightness, _Brightness)) * _Color;
					    u_xlat0 = u_xlat0 * u_xlat1;
					    SV_Target0.w = u_xlat0.w;
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz;
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
						float _TrailLength;
						float _TrailPow;
						float _Brightness;
						vec2 _NoiseTiling;
						vec4 _NoiseSpeed;
						vec4 _LightningParams;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _RampTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					float u_xlat6;
					vec2 u_xlat7;
					void main()
					{
					    u_xlat0 = _NoiseSpeed.yxwz * _Time.yyyy;
					    u_xlat0 = vs_TEXCOORD0.yxyx * _NoiseTiling.yxyx + u_xlat0;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0.x = dot(u_xlat1.xx, u_xlat0.yy);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * _LightningParams.y;
					    u_xlat1.x = _LightningParams.x * _Time.y;
					    u_xlat1.y = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat3.xy = vs_TEXCOORD0.yx * _LightningParams.zz + u_xlat1.xy;
					    u_xlat3.xy = u_xlat7.xy + u_xlat3.xy;
					    u_xlat1 = texture(_MainTex, u_xlat3.xy);
					    u_xlat2 = texture(_MaskTex, vs_TEXCOORD0.xy);
					    u_xlat3.x = u_xlat1.z * u_xlat2.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat3.x = (-_TrailLength) + 1.0;
					    u_xlat3.x = (-u_xlat3.x) + vs_TEXCOORD0.y;
					    u_xlat6 = max(_TrailLength, 0.00100000005);
					    u_xlat3.x = u_xlat3.x / u_xlat6;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = log2(u_xlat3.x);
					    u_xlat3.x = u_xlat3.x * _TrailPow;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat1.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1.y = 0.0;
					    u_xlat1 = texture(_RampTex, u_xlat1.xy);
					    u_xlat1.w = 1.0;
					    u_xlat0 = u_xlat3.xxxx * u_xlat1;
					    u_xlat1 = vec4(vec4(_Brightness, _Brightness, _Brightness, _Brightness)) * _Color;
					    u_xlat0 = u_xlat0 * u_xlat1;
					    SV_Target0.w = u_xlat0.w;
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz;
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
						float _TrailLength;
						float _TrailPow;
						float _Brightness;
						vec2 _NoiseTiling;
						vec4 _NoiseSpeed;
						vec4 _LightningParams;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _RampTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					float u_xlat6;
					vec2 u_xlat7;
					void main()
					{
					    u_xlat0 = _NoiseSpeed.yxwz * _Time.yyyy;
					    u_xlat0 = vs_TEXCOORD0.yxyx * _NoiseTiling.yxyx + u_xlat0;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_MainTex, u_xlat0.zw);
					    u_xlat0.x = dot(u_xlat1.xx, u_xlat0.yy);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * _LightningParams.y;
					    u_xlat1.x = _LightningParams.x * _Time.y;
					    u_xlat1.y = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat3.xy = vs_TEXCOORD0.yx * _LightningParams.zz + u_xlat1.xy;
					    u_xlat3.xy = u_xlat7.xy + u_xlat3.xy;
					    u_xlat1 = texture(_MainTex, u_xlat3.xy);
					    u_xlat2 = texture(_MaskTex, vs_TEXCOORD0.xy);
					    u_xlat3.x = u_xlat1.z * u_xlat2.x;
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat3.x = (-_TrailLength) + 1.0;
					    u_xlat3.x = (-u_xlat3.x) + vs_TEXCOORD0.y;
					    u_xlat6 = max(_TrailLength, 0.00100000005);
					    u_xlat3.x = u_xlat3.x / u_xlat6;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = log2(u_xlat3.x);
					    u_xlat3.x = u_xlat3.x * _TrailPow;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat1.x = u_xlat3.x * u_xlat0.x;
					    u_xlat1.y = 0.0;
					    u_xlat1 = texture(_RampTex, u_xlat1.xy);
					    u_xlat1.w = 1.0;
					    u_xlat0 = u_xlat3.xxxx * u_xlat1;
					    u_xlat1 = vec4(vec4(_Brightness, _Brightness, _Brightness, _Brightness)) * _Color;
					    u_xlat0 = u_xlat0 * u_xlat1;
					    SV_Target0.w = u_xlat0.w;
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}"
				}
			}
		}
	}
}