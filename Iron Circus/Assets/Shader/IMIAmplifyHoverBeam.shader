Shader "IMI/Amplify/HoverBeam" {
	Properties {
		_Storm_Tex_01 ("Storm_Tex_01", 2D) = "white" {}
		[HDR] _Color ("Color", Vector) = (0.9254902,0.7058824,1,0)
		_base_tex_tiling ("base_tex_tiling", Vector) = (1,1,0,0)
		_scrolling_speed ("scrolling_speed", Vector) = (-1,0,0,0)
		_MaskTopBottom ("MaskTopBottom", 2D) = "white" {}
		_noise_tiling ("noise_tiling", Float) = 0
		_noise_amount ("noise_amount", Range(0, 1)) = 0
		_dissolve_amount ("dissolve_amount", Range(0, 1)) = 0
		_background_transparency ("background_transparency", Range(0.001, 0.01)) = 0
		[HideInInspector] _texcoord ("", 2D) = "white" {}
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
		Pass {
			Name "SubShader 0 Pass 0"
			LOD 100
			Tags { "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
			Blend One One, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 16618
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
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
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
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
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
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
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
						vec2 _base_tex_tiling;
						float _noise_tiling;
						vec2 _scrolling_speed;
						float _noise_amount;
						float _dissolve_amount;
						float _background_transparency;
						vec4 _Color;
						vec4 _MaskTopBottom_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _Storm_Tex_01;
					uniform  sampler2D _MaskTopBottom;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat7;
					float u_xlat14;
					vec2 u_xlat15;
					vec2 u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(1.0);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _base_tex_tiling.xy + vec2(0.5, 0.0);
					    u_xlat15.xy = _Time.yy * _scrolling_speed.xy + u_xlat1.xy;
					    u_xlat2.xy = u_xlat15.xy * vec2(vec2(_noise_tiling, _noise_tiling));
					    u_xlat21 = dot(u_xlat2.xy, vec2(0.366025418, 0.366025418));
					    u_xlat2.xy = vec2(vec2(_noise_tiling, _noise_tiling)) * u_xlat15.xy + vec2(u_xlat21);
					    u_xlat2.xy = floor(u_xlat2.xy);
					    u_xlat16.xy = u_xlat2.xy * vec2(0.00346020772, 0.00346020772);
					    u_xlat16.xy = floor(u_xlat16.xy);
					    u_xlat16.xy = (-u_xlat16.xy) * vec2(289.0, 289.0) + u_xlat2.xy;
					    u_xlat15.xy = vec2(vec2(_noise_tiling, _noise_tiling)) * u_xlat15.xy + (-u_xlat2.xy);
					    u_xlat21 = dot(u_xlat2.xy, vec2(0.211324871, 0.211324871));
					    u_xlat15.xy = vec2(u_xlat21) + u_xlat15.xy;
					    u_xlatb21 = u_xlat15.y<u_xlat15.x;
					    u_xlat3 = (bool(u_xlatb21)) ? vec4(1.0, 0.0, -1.0, -0.0) : vec4(0.0, 1.0, -0.0, -1.0);
					    u_xlat0.y = u_xlat3.y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat16.yyy;
					    u_xlat2.xyw = u_xlat0.xyz * vec3(34.0, 34.0, 34.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw;
					    u_xlat2.xyw = u_xlat0.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat2.xyw = floor(u_xlat2.xyw);
					    u_xlat0.xyz = (-u_xlat2.xyw) * vec3(289.0, 289.0, 289.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat16.xxx + u_xlat0.xyz;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(1.0);
					    u_xlat2.y = u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(34.0, 34.0, 34.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat2.xyz = floor(u_xlat2.xyz);
					    u_xlat0.xyz = (-u_xlat2.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.024390243, 0.024390243, 0.024390243);
					    u_xlat0.xyz = fract(u_xlat0.xyz);
					    u_xlat2.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-0.5, -0.5, -0.5);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat2.xyz = floor(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat0.xyz = abs(u_xlat0.xyz) + vec3(-0.5, -0.5, -0.5);
					    u_xlat4.xyz = u_xlat0.xyz * u_xlat0.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat2.xyz + u_xlat4.xyz;
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(0.853734732, 0.853734732, 0.853734732) + vec3(1.79284286, 1.79284286, 1.79284286);
					    u_xlat5.x = dot(u_xlat15.xy, u_xlat15.xy);
					    u_xlat6 = u_xlat15.xyxy + vec4(0.211324871, 0.211324871, -0.577350259, -0.577350259);
					    u_xlat6.xy = u_xlat3.zw + u_xlat6.xy;
					    u_xlat5.y = dot(u_xlat6.xy, u_xlat6.xy);
					    u_xlat5.z = dot(u_xlat6.zw, u_xlat6.zw);
					    u_xlat3.xyz = (-u_xlat5.xyz) + vec3(0.5, 0.5, 0.5);
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat0.x = u_xlat15.y * u_xlat0.x;
					    u_xlat7.xy = u_xlat0.yz * u_xlat6.yw;
					    u_xlat4.yz = u_xlat2.yz * u_xlat6.xz + u_xlat7.xy;
					    u_xlat4.x = u_xlat2.x * u_xlat15.x + u_xlat0.x;
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat7.xy = u_xlat0.xx * vec2(130.0, 130.0) + (-u_xlat1.xy);
					    u_xlat0.x = u_xlat0.x * 130.0;
					    u_xlat7.xy = vec2(vec2(_noise_amount, _noise_amount)) * u_xlat7.xy + u_xlat1.xy;
					    u_xlat1 = texture(_Storm_Tex_01, u_xlat7.xy);
					    u_xlat7.x = u_xlat0.x * u_xlat1.x + (-u_xlat1.x);
					    u_xlat7.x = _dissolve_amount * u_xlat7.x + u_xlat1.x;
					    u_xlat14 = u_xlat0.x * _background_transparency;
					    u_xlat0.x = (-u_xlat0.x) * _background_transparency + 1.0;
					    u_xlat0.x = u_xlat7.x * u_xlat0.x + u_xlat14;
					    u_xlat1 = vs_COLOR0.wwww * vs_COLOR0;
					    u_xlat0 = u_xlat0.xxxx * u_xlat1;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * _Color;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTopBottom_ST.xy + _MaskTopBottom_ST.zw;
					    u_xlat1 = texture(_MaskTopBottom, u_xlat1.xy);
					    SV_Target0 = u_xlat0 * u_xlat1.wwww;
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
						vec2 _base_tex_tiling;
						float _noise_tiling;
						vec2 _scrolling_speed;
						float _noise_amount;
						float _dissolve_amount;
						float _background_transparency;
						vec4 _Color;
						vec4 _MaskTopBottom_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _Storm_Tex_01;
					uniform  sampler2D _MaskTopBottom;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat7;
					float u_xlat14;
					vec2 u_xlat15;
					vec2 u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(1.0);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _base_tex_tiling.xy + vec2(0.5, 0.0);
					    u_xlat15.xy = _Time.yy * _scrolling_speed.xy + u_xlat1.xy;
					    u_xlat2.xy = u_xlat15.xy * vec2(vec2(_noise_tiling, _noise_tiling));
					    u_xlat21 = dot(u_xlat2.xy, vec2(0.366025418, 0.366025418));
					    u_xlat2.xy = vec2(vec2(_noise_tiling, _noise_tiling)) * u_xlat15.xy + vec2(u_xlat21);
					    u_xlat2.xy = floor(u_xlat2.xy);
					    u_xlat16.xy = u_xlat2.xy * vec2(0.00346020772, 0.00346020772);
					    u_xlat16.xy = floor(u_xlat16.xy);
					    u_xlat16.xy = (-u_xlat16.xy) * vec2(289.0, 289.0) + u_xlat2.xy;
					    u_xlat15.xy = vec2(vec2(_noise_tiling, _noise_tiling)) * u_xlat15.xy + (-u_xlat2.xy);
					    u_xlat21 = dot(u_xlat2.xy, vec2(0.211324871, 0.211324871));
					    u_xlat15.xy = vec2(u_xlat21) + u_xlat15.xy;
					    u_xlatb21 = u_xlat15.y<u_xlat15.x;
					    u_xlat3 = (bool(u_xlatb21)) ? vec4(1.0, 0.0, -1.0, -0.0) : vec4(0.0, 1.0, -0.0, -1.0);
					    u_xlat0.y = u_xlat3.y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat16.yyy;
					    u_xlat2.xyw = u_xlat0.xyz * vec3(34.0, 34.0, 34.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw;
					    u_xlat2.xyw = u_xlat0.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat2.xyw = floor(u_xlat2.xyw);
					    u_xlat0.xyz = (-u_xlat2.xyw) * vec3(289.0, 289.0, 289.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat16.xxx + u_xlat0.xyz;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(1.0);
					    u_xlat2.y = u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(34.0, 34.0, 34.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat2.xyz = floor(u_xlat2.xyz);
					    u_xlat0.xyz = (-u_xlat2.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.024390243, 0.024390243, 0.024390243);
					    u_xlat0.xyz = fract(u_xlat0.xyz);
					    u_xlat2.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-0.5, -0.5, -0.5);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat2.xyz = floor(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat0.xyz = abs(u_xlat0.xyz) + vec3(-0.5, -0.5, -0.5);
					    u_xlat4.xyz = u_xlat0.xyz * u_xlat0.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat2.xyz + u_xlat4.xyz;
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(0.853734732, 0.853734732, 0.853734732) + vec3(1.79284286, 1.79284286, 1.79284286);
					    u_xlat5.x = dot(u_xlat15.xy, u_xlat15.xy);
					    u_xlat6 = u_xlat15.xyxy + vec4(0.211324871, 0.211324871, -0.577350259, -0.577350259);
					    u_xlat6.xy = u_xlat3.zw + u_xlat6.xy;
					    u_xlat5.y = dot(u_xlat6.xy, u_xlat6.xy);
					    u_xlat5.z = dot(u_xlat6.zw, u_xlat6.zw);
					    u_xlat3.xyz = (-u_xlat5.xyz) + vec3(0.5, 0.5, 0.5);
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat0.x = u_xlat15.y * u_xlat0.x;
					    u_xlat7.xy = u_xlat0.yz * u_xlat6.yw;
					    u_xlat4.yz = u_xlat2.yz * u_xlat6.xz + u_xlat7.xy;
					    u_xlat4.x = u_xlat2.x * u_xlat15.x + u_xlat0.x;
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat7.xy = u_xlat0.xx * vec2(130.0, 130.0) + (-u_xlat1.xy);
					    u_xlat0.x = u_xlat0.x * 130.0;
					    u_xlat7.xy = vec2(vec2(_noise_amount, _noise_amount)) * u_xlat7.xy + u_xlat1.xy;
					    u_xlat1 = texture(_Storm_Tex_01, u_xlat7.xy);
					    u_xlat7.x = u_xlat0.x * u_xlat1.x + (-u_xlat1.x);
					    u_xlat7.x = _dissolve_amount * u_xlat7.x + u_xlat1.x;
					    u_xlat14 = u_xlat0.x * _background_transparency;
					    u_xlat0.x = (-u_xlat0.x) * _background_transparency + 1.0;
					    u_xlat0.x = u_xlat7.x * u_xlat0.x + u_xlat14;
					    u_xlat1 = vs_COLOR0.wwww * vs_COLOR0;
					    u_xlat0 = u_xlat0.xxxx * u_xlat1;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * _Color;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTopBottom_ST.xy + _MaskTopBottom_ST.zw;
					    u_xlat1 = texture(_MaskTopBottom, u_xlat1.xy);
					    SV_Target0 = u_xlat0 * u_xlat1.wwww;
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
						vec2 _base_tex_tiling;
						float _noise_tiling;
						vec2 _scrolling_speed;
						float _noise_amount;
						float _dissolve_amount;
						float _background_transparency;
						vec4 _Color;
						vec4 _MaskTopBottom_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _Storm_Tex_01;
					uniform  sampler2D _MaskTopBottom;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat7;
					float u_xlat14;
					vec2 u_xlat15;
					vec2 u_xlat16;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.x = float(0.0);
					    u_xlat0.z = float(1.0);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _base_tex_tiling.xy + vec2(0.5, 0.0);
					    u_xlat15.xy = _Time.yy * _scrolling_speed.xy + u_xlat1.xy;
					    u_xlat2.xy = u_xlat15.xy * vec2(vec2(_noise_tiling, _noise_tiling));
					    u_xlat21 = dot(u_xlat2.xy, vec2(0.366025418, 0.366025418));
					    u_xlat2.xy = vec2(vec2(_noise_tiling, _noise_tiling)) * u_xlat15.xy + vec2(u_xlat21);
					    u_xlat2.xy = floor(u_xlat2.xy);
					    u_xlat16.xy = u_xlat2.xy * vec2(0.00346020772, 0.00346020772);
					    u_xlat16.xy = floor(u_xlat16.xy);
					    u_xlat16.xy = (-u_xlat16.xy) * vec2(289.0, 289.0) + u_xlat2.xy;
					    u_xlat15.xy = vec2(vec2(_noise_tiling, _noise_tiling)) * u_xlat15.xy + (-u_xlat2.xy);
					    u_xlat21 = dot(u_xlat2.xy, vec2(0.211324871, 0.211324871));
					    u_xlat15.xy = vec2(u_xlat21) + u_xlat15.xy;
					    u_xlatb21 = u_xlat15.y<u_xlat15.x;
					    u_xlat3 = (bool(u_xlatb21)) ? vec4(1.0, 0.0, -1.0, -0.0) : vec4(0.0, 1.0, -0.0, -1.0);
					    u_xlat0.y = u_xlat3.y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat16.yyy;
					    u_xlat2.xyw = u_xlat0.xyz * vec3(34.0, 34.0, 34.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw;
					    u_xlat2.xyw = u_xlat0.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat2.xyw = floor(u_xlat2.xyw);
					    u_xlat0.xyz = (-u_xlat2.xyw) * vec3(289.0, 289.0, 289.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat16.xxx + u_xlat0.xyz;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(1.0);
					    u_xlat2.y = u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(34.0, 34.0, 34.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
					    u_xlat2.xyz = floor(u_xlat2.xyz);
					    u_xlat0.xyz = (-u_xlat2.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.024390243, 0.024390243, 0.024390243);
					    u_xlat0.xyz = fract(u_xlat0.xyz);
					    u_xlat2.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-0.5, -0.5, -0.5);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat2.xyz = floor(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat0.xyz = abs(u_xlat0.xyz) + vec3(-0.5, -0.5, -0.5);
					    u_xlat4.xyz = u_xlat0.xyz * u_xlat0.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat2.xyz + u_xlat4.xyz;
					    u_xlat4.xyz = (-u_xlat4.xyz) * vec3(0.853734732, 0.853734732, 0.853734732) + vec3(1.79284286, 1.79284286, 1.79284286);
					    u_xlat5.x = dot(u_xlat15.xy, u_xlat15.xy);
					    u_xlat6 = u_xlat15.xyxy + vec4(0.211324871, 0.211324871, -0.577350259, -0.577350259);
					    u_xlat6.xy = u_xlat3.zw + u_xlat6.xy;
					    u_xlat5.y = dot(u_xlat6.xy, u_xlat6.xy);
					    u_xlat5.z = dot(u_xlat6.zw, u_xlat6.zw);
					    u_xlat3.xyz = (-u_xlat5.xyz) + vec3(0.5, 0.5, 0.5);
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat0.x = u_xlat15.y * u_xlat0.x;
					    u_xlat7.xy = u_xlat0.yz * u_xlat6.yw;
					    u_xlat4.yz = u_xlat2.yz * u_xlat6.xz + u_xlat7.xy;
					    u_xlat4.x = u_xlat2.x * u_xlat15.x + u_xlat0.x;
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat4.xyz);
					    u_xlat7.xy = u_xlat0.xx * vec2(130.0, 130.0) + (-u_xlat1.xy);
					    u_xlat0.x = u_xlat0.x * 130.0;
					    u_xlat7.xy = vec2(vec2(_noise_amount, _noise_amount)) * u_xlat7.xy + u_xlat1.xy;
					    u_xlat1 = texture(_Storm_Tex_01, u_xlat7.xy);
					    u_xlat7.x = u_xlat0.x * u_xlat1.x + (-u_xlat1.x);
					    u_xlat7.x = _dissolve_amount * u_xlat7.x + u_xlat1.x;
					    u_xlat14 = u_xlat0.x * _background_transparency;
					    u_xlat0.x = (-u_xlat0.x) * _background_transparency + 1.0;
					    u_xlat0.x = u_xlat7.x * u_xlat0.x + u_xlat14;
					    u_xlat1 = vs_COLOR0.wwww * vs_COLOR0;
					    u_xlat0 = u_xlat0.xxxx * u_xlat1;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * _Color;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTopBottom_ST.xy + _MaskTopBottom_ST.zw;
					    u_xlat1 = texture(_MaskTopBottom, u_xlat1.xy);
					    SV_Target0 = u_xlat0 * u_xlat1.wwww;
					    return;
					}"
				}
			}
		}
	}
	CustomEditor "ASEMaterialInspector"
}