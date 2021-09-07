Shader "SteelCircus/FX/Skills/BarrierShader" {
	Properties {
		_Tint ("Animate: Tint", Vector) = (1,1,1,1)
		_UVScrollU ("Animate: UV.u Scroll", Float) = 0
		_UVScrollVSpeed ("UV.v Scroll Speed", Float) = 1
		_BrightnessScale ("Animate: Brightness Scale", Float) = 1
		_DispScaleU ("Animate: Displacement Strength U", Float) = 0
		_DispScaleV ("Animate: Displacement Strength V", Float) = 0
		_MainTex ("Texture", 2D) = "white" {}
		_DispTex ("Displacement", 2D) = "white" {}
		_OverlayTex ("Overlay", 2D) = "white" {}
		_GradientTex ("Gradient Overlay (1D)", 2D) = "white" {}
	}
	SubShader {
		LOD 100
		Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ZWrite Off
			Cull Off
			GpuProgramID 56959
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
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 _DispTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _DispTex_ST.xy + _DispTex_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = in_POSITION0;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 _DispTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _DispTex_ST.xy + _DispTex_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = in_POSITION0;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 _DispTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _DispTex_ST.xy + _DispTex_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = in_POSITION0;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
						float _UVScrollU;
						float _UVScrollVSpeed;
						float _BrightnessScale;
						float _DispScaleU;
						float _DispScaleV;
						vec4 _Tint;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _DispTex;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _OverlayTex;
					uniform  sampler2D _GrabBlurTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					vec2 u_xlat8;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.x + _UVScrollU;
					    u_xlat0.y = _UVScrollVSpeed * _Time.y + vs_TEXCOORD0.y;
					    u_xlat1 = texture(_DispTex, vs_TEXCOORD0.zw);
					    u_xlat8.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1.x = u_xlat8.x * _DispScaleU;
					    u_xlat1.y = u_xlat8.y * _DispScaleV;
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_BrightnessScale, _BrightnessScale, _BrightnessScale));
					    u_xlat2.x = vs_TEXCOORD1.y + 0.5;
					    u_xlat2.y = 0.0;
					    u_xlat2 = texture(_GradientTex, u_xlat2.xy);
					    u_xlat3 = texture(_OverlayTex, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat0, u_xlat0);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat1.x = vs_TEXCOORD1.y;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat5.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_GrabTexture, u_xlat5.xy);
					    u_xlat3 = texture(_GrabBlurTexture, u_xlat5.xy);
					    u_xlat5.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat2.xyz = u_xlat2.xyz;
					    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _Tint.xyz + (-u_xlat2.xyz);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    SV_Target0.w = 1.0;
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
						float _UVScrollU;
						float _UVScrollVSpeed;
						float _BrightnessScale;
						float _DispScaleU;
						float _DispScaleV;
						vec4 _Tint;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _DispTex;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _OverlayTex;
					uniform  sampler2D _GrabBlurTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					vec2 u_xlat8;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.x + _UVScrollU;
					    u_xlat0.y = _UVScrollVSpeed * _Time.y + vs_TEXCOORD0.y;
					    u_xlat1 = texture(_DispTex, vs_TEXCOORD0.zw);
					    u_xlat8.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1.x = u_xlat8.x * _DispScaleU;
					    u_xlat1.y = u_xlat8.y * _DispScaleV;
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_BrightnessScale, _BrightnessScale, _BrightnessScale));
					    u_xlat2.x = vs_TEXCOORD1.y + 0.5;
					    u_xlat2.y = 0.0;
					    u_xlat2 = texture(_GradientTex, u_xlat2.xy);
					    u_xlat3 = texture(_OverlayTex, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat0, u_xlat0);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat1.x = vs_TEXCOORD1.y;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat5.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_GrabTexture, u_xlat5.xy);
					    u_xlat3 = texture(_GrabBlurTexture, u_xlat5.xy);
					    u_xlat5.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat2.xyz = u_xlat2.xyz;
					    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _Tint.xyz + (-u_xlat2.xyz);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    SV_Target0.w = 1.0;
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
						float _UVScrollU;
						float _UVScrollVSpeed;
						float _BrightnessScale;
						float _DispScaleU;
						float _DispScaleV;
						vec4 _Tint;
						vec4 unused_0_7[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _DispTex;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _OverlayTex;
					uniform  sampler2D _GrabBlurTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					vec2 u_xlat8;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.x + _UVScrollU;
					    u_xlat0.y = _UVScrollVSpeed * _Time.y + vs_TEXCOORD0.y;
					    u_xlat1 = texture(_DispTex, vs_TEXCOORD0.zw);
					    u_xlat8.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1.x = u_xlat8.x * _DispScaleU;
					    u_xlat1.y = u_xlat8.y * _DispScaleV;
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_BrightnessScale, _BrightnessScale, _BrightnessScale));
					    u_xlat2.x = vs_TEXCOORD1.y + 0.5;
					    u_xlat2.y = 0.0;
					    u_xlat2 = texture(_GradientTex, u_xlat2.xy);
					    u_xlat3 = texture(_OverlayTex, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat0, u_xlat0);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat1.x = vs_TEXCOORD1.y;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat5.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_GrabTexture, u_xlat5.xy);
					    u_xlat3 = texture(_GrabBlurTexture, u_xlat5.xy);
					    u_xlat5.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
					    u_xlat2.xyz = u_xlat2.xyz;
					    u_xlat2.xyz = clamp(u_xlat2.xyz, 0.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _Tint.xyz + (-u_xlat2.xyz);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}