Shader "SteelCircus/FX/Skills/AoePreviews/AoeTackleShader" {
	Properties {
		[NoScaleOffset] _MainTex ("Texture (Tiling)", 2D) = "white" {}
		[NoScaleOffset] _MaskTex ("Mask. R = Outline, G = Alpha, B = Outline Position", 2D) = "white" {}
		_ColorMiddle ("Middle Color", Vector) = (1,0.5,0,1)
		_ScrollSpeed ("Scroll Speed", Float) = 1
		_OutlineSpeed ("Outline Speed", Float) = 1
		_ArrowHeadParams ("Arrow Head Remap. x = uv.y start, y = stretched uv.y start", Vector) = (0.5,0.5,0,0)
		_ColorBuildupBG ("Buildup BG Color", Vector) = (1,0,0,1)
		_BuildupBGTime ("Buildup Time", Range(0, 1)) = 0.5
		_ColorOutlineBG ("Outline BG", Vector) = (1,0,1,1)
		_ColorOutlineFG ("Outline FG", Vector) = (1,1,0,1)
		[NoScaleOffset] _OutlineMaskTex ("Outline Mask Texture (1D, red channel)", 2D) = "white" {}
		_OutlineMaskOffsetAndRatio ("Outline Mask Center (UV space, xy) and Aspect Ratio (z)", Vector) = (0.5,0.5,1,1)
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 7777
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
						vec4 _ColorOutlineBG;
						vec4 _ColorOutlineFG;
						vec4 _ColorMiddle;
						vec4 unused_0_4[3];
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 _ArrowHeadParams;
						float _ScrollSpeed;
						float _OutlineSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _OutlineMaskTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat8;
					bool u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.y / _ArrowHeadParams.y;
					    u_xlat0.x = u_xlat0.x * _ArrowHeadParams.x;
					    u_xlat4.x = (-_ArrowHeadParams.y) + _ArrowHeadParams.x;
					    u_xlat8.xy = (-_ArrowHeadParams.xy) + vec2(1.0, 1.0);
					    u_xlat4.x = u_xlat8.x * vs_TEXCOORD0.y + u_xlat4.x;
					    u_xlat4.x = u_xlat4.x / u_xlat8.y;
					    u_xlat1.y = u_xlat8.x / u_xlat8.y;
					    u_xlatb8 = _ArrowHeadParams.y>=vs_TEXCOORD0.y;
					    u_xlat0.y = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
					    u_xlat0.x = vs_TEXCOORD0.x;
					    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
					    u_xlat2.w = u_xlat0.y * _ColorBuildupBG.w;
					    u_xlat1.x = float(1.0);
					    u_xlat9.x = float(0.0);
					    u_xlat9.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat1.xy = vs_TEXCOORD0.xy * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * _ColorMiddle.xyz;
					    u_xlat1.w = u_xlat0.y;
					    u_xlat2.xyz = _ColorBuildupBG.xyz;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlatb4 = _BuildupBGTime>=vs_TEXCOORD0.y;
					    u_xlat4.x = (u_xlatb4) ? 0.0 : 1.0;
					    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
					    u_xlat2.x = _Time.y * _OutlineSpeed + u_xlat0.z;
					    u_xlat2.y = 0.0;
					    u_xlat2 = texture(_OutlineMaskTex, u_xlat2.xy);
					    u_xlat3 = (-_ColorOutlineBG) + _ColorOutlineFG;
					    u_xlat2 = u_xlat2.xxxx * u_xlat3 + _ColorOutlineBG;
					    u_xlat4.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat1.xyz;
					    u_xlat0.w = u_xlat1.w * _ColorBuildupBG.w;
					    u_xlat0.xyz = _ColorBuildupBG.xyz;
					    u_xlat0 = u_xlat0 + (-u_xlat1);
					    u_xlat2.x = log2(_BuildupBGTime);
					    u_xlat2.x = u_xlat2.x * 0.330000013;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlatb2 = u_xlat2.x>=vs_TEXCOORD0.y;
					    u_xlat2.x = (u_xlatb2) ? 0.0 : 1.0;
					    SV_Target0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
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
						vec4 _ColorOutlineBG;
						vec4 _ColorOutlineFG;
						vec4 _ColorMiddle;
						vec4 unused_0_4[3];
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 _ArrowHeadParams;
						float _ScrollSpeed;
						float _OutlineSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _OutlineMaskTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat8;
					bool u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.y / _ArrowHeadParams.y;
					    u_xlat0.x = u_xlat0.x * _ArrowHeadParams.x;
					    u_xlat4.x = (-_ArrowHeadParams.y) + _ArrowHeadParams.x;
					    u_xlat8.xy = (-_ArrowHeadParams.xy) + vec2(1.0, 1.0);
					    u_xlat4.x = u_xlat8.x * vs_TEXCOORD0.y + u_xlat4.x;
					    u_xlat4.x = u_xlat4.x / u_xlat8.y;
					    u_xlat1.y = u_xlat8.x / u_xlat8.y;
					    u_xlatb8 = _ArrowHeadParams.y>=vs_TEXCOORD0.y;
					    u_xlat0.y = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
					    u_xlat0.x = vs_TEXCOORD0.x;
					    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
					    u_xlat2.w = u_xlat0.y * _ColorBuildupBG.w;
					    u_xlat1.x = float(1.0);
					    u_xlat9.x = float(0.0);
					    u_xlat9.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat1.xy = vs_TEXCOORD0.xy * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * _ColorMiddle.xyz;
					    u_xlat1.w = u_xlat0.y;
					    u_xlat2.xyz = _ColorBuildupBG.xyz;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlatb4 = _BuildupBGTime>=vs_TEXCOORD0.y;
					    u_xlat4.x = (u_xlatb4) ? 0.0 : 1.0;
					    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
					    u_xlat2.x = _Time.y * _OutlineSpeed + u_xlat0.z;
					    u_xlat2.y = 0.0;
					    u_xlat2 = texture(_OutlineMaskTex, u_xlat2.xy);
					    u_xlat3 = (-_ColorOutlineBG) + _ColorOutlineFG;
					    u_xlat2 = u_xlat2.xxxx * u_xlat3 + _ColorOutlineBG;
					    u_xlat4.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat1.xyz;
					    u_xlat0.w = u_xlat1.w * _ColorBuildupBG.w;
					    u_xlat0.xyz = _ColorBuildupBG.xyz;
					    u_xlat0 = u_xlat0 + (-u_xlat1);
					    u_xlat2.x = log2(_BuildupBGTime);
					    u_xlat2.x = u_xlat2.x * 0.330000013;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlatb2 = u_xlat2.x>=vs_TEXCOORD0.y;
					    u_xlat2.x = (u_xlatb2) ? 0.0 : 1.0;
					    SV_Target0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
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
						vec4 _ColorOutlineBG;
						vec4 _ColorOutlineFG;
						vec4 _ColorMiddle;
						vec4 unused_0_4[3];
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 _ArrowHeadParams;
						float _ScrollSpeed;
						float _OutlineSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _OutlineMaskTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat8;
					bool u_xlatb8;
					vec2 u_xlat9;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD0.y / _ArrowHeadParams.y;
					    u_xlat0.x = u_xlat0.x * _ArrowHeadParams.x;
					    u_xlat4.x = (-_ArrowHeadParams.y) + _ArrowHeadParams.x;
					    u_xlat8.xy = (-_ArrowHeadParams.xy) + vec2(1.0, 1.0);
					    u_xlat4.x = u_xlat8.x * vs_TEXCOORD0.y + u_xlat4.x;
					    u_xlat4.x = u_xlat4.x / u_xlat8.y;
					    u_xlat1.y = u_xlat8.x / u_xlat8.y;
					    u_xlatb8 = _ArrowHeadParams.y>=vs_TEXCOORD0.y;
					    u_xlat0.y = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
					    u_xlat0.x = vs_TEXCOORD0.x;
					    u_xlat0 = texture(_MaskTex, u_xlat0.xy);
					    u_xlat2.w = u_xlat0.y * _ColorBuildupBG.w;
					    u_xlat1.x = float(1.0);
					    u_xlat9.x = float(0.0);
					    u_xlat9.y = (-_ScrollSpeed) * _Time.y;
					    u_xlat1.xy = vs_TEXCOORD0.xy * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * _ColorMiddle.xyz;
					    u_xlat1.w = u_xlat0.y;
					    u_xlat2.xyz = _ColorBuildupBG.xyz;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlatb4 = _BuildupBGTime>=vs_TEXCOORD0.y;
					    u_xlat4.x = (u_xlatb4) ? 0.0 : 1.0;
					    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
					    u_xlat2.x = _Time.y * _OutlineSpeed + u_xlat0.z;
					    u_xlat2.y = 0.0;
					    u_xlat2 = texture(_OutlineMaskTex, u_xlat2.xy);
					    u_xlat3 = (-_ColorOutlineBG) + _ColorOutlineFG;
					    u_xlat2 = u_xlat2.xxxx * u_xlat3 + _ColorOutlineBG;
					    u_xlat4.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat1.xyz;
					    u_xlat0.w = u_xlat1.w * _ColorBuildupBG.w;
					    u_xlat0.xyz = _ColorBuildupBG.xyz;
					    u_xlat0 = u_xlat0 + (-u_xlat1);
					    u_xlat2.x = log2(_BuildupBGTime);
					    u_xlat2.x = u_xlat2.x * 0.330000013;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlatb2 = u_xlat2.x>=vs_TEXCOORD0.y;
					    u_xlat2.x = (u_xlatb2) ? 0.0 : 1.0;
					    SV_Target0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
					    return;
					}"
				}
			}
		}
	}
}