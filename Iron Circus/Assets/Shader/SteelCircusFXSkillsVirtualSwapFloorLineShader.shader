Shader "SteelCircus/FX/Skills/VirtualSwapFloorLineShader" {
	Properties {
		[NoScaleOffset] _MainTex ("Texture", 2D) = "white" {}
		_TilingY ("y-tiling", Float) = 1
		_TilingScrollSpeed ("y-speed", Float) = 1
		[Toggle] _Blink ("Blink", Float) = 0
		_BlinkSpeed ("blink speed", Float) = 1
		_BlinkRatio ("blink fraction", Range(0, 1)) = 0.5
		_ColorMiddle ("Middle Color", Vector) = (1,1,1,1)
		_ColorDark ("Dark Color", Vector) = (1,1,1,1)
		_ColorMiddleOther ("Middle Color, other team", Vector) = (1,1,1,1)
		_ColorDarkOther ("Dark Color, other team", Vector) = (1,1,1,1)
		_OwnTeamRatio ("Own Team vs other, ratio", Range(0, 1)) = 0.01
		_ColorOutlineFG ("Outline Color", Vector) = (1,1,1,1)
		_OutlineWidth ("Outline Width (units div by scale)", Range(0, 1)) = 0.01
		[NoScaleOffset] _CharTex ("Charset", 2D) = "white" {}
		_CharDim ("Charset Dimensions (x=columns, y=rows, z=ws width, w=ws height)", Vector) = (16,16,0.5,0.75)
		_GridDim ("Output Grid Dimensions (x=columns, y=rows)", Vector) = (16,8,0,0)
		[NoScaleOffset] _CharAnimTex ("Charset animation", 2D) = "white" {}
		_CharAnimSpeed ("Charset animation speed", Float) = 1
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 48670
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
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
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
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
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
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
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
						vec4 unused_0_0[3];
						vec4 _ColorOutlineFG;
						vec4 _ColorMiddle;
						vec4 _ColorDark;
						vec4 unused_0_4[4];
						vec4 _CharDim;
						vec4 _GridDim;
						float _CharAnimSpeed;
						float _OutlineWidth;
						float _OwnTeamRatio;
						vec4 _ColorMiddleOther;
						vec4 _ColorDarkOther;
						float _TilingY;
						float _TilingScrollSpeed;
						float _BlinkSpeed;
						float _Blink;
						float _BlinkRatio;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CharAnimTex;
					uniform  sampler2D _CharTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					vec2 u_xlat12;
					bvec2 u_xlatb12;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.zx * vec2(1.0, -1.0);
					    u_xlat0.xy = u_xlat0.xy / _CharDim.zw;
					    u_xlat0.xy = u_xlat0.xy + vec2(1000.0, 1000.0);
					    u_xlat12.xy = floor(u_xlat0.xy);
					    u_xlat0.xy = (-u_xlat12.xy) + u_xlat0.xy;
					    u_xlat1.xy = u_xlat12.xy / _GridDim.xy;
					    u_xlat12.x = u_xlat12.y * 0.100000001;
					    u_xlat2.y = _Time.y * _CharAnimSpeed + u_xlat12.x;
					    u_xlatb12.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
					    u_xlat1.xy = fract(abs(u_xlat1.xy));
					    u_xlat12.x = (u_xlatb12.x) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat12.y = (u_xlatb12.y) ? u_xlat1.y : (-u_xlat1.y);
					    u_xlat12.xy = u_xlat12.xy * _GridDim.xy;
					    u_xlat12.x = u_xlat12.y * _GridDim.x + u_xlat12.x;
					    u_xlat18 = _GridDim.y * _GridDim.x;
					    u_xlat2.x = u_xlat12.x / u_xlat18;
					    u_xlat1 = texture(_CharAnimTex, u_xlat2.xy);
					    u_xlat12.x = _CharDim.y * _CharDim.x;
					    u_xlat18 = u_xlat1.x / u_xlat12.x;
					    u_xlat1.x = _CharDim.x * _CharDim.y + -1.0;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat12.x = u_xlat12.x * u_xlat18;
					    u_xlat0.z = floor(u_xlat12.x);
					    u_xlat0.xyw = u_xlat0.xyz / _CharDim.xyx;
					    u_xlatb12.x = 0.0>=u_xlat0.z;
					    u_xlat12.x = (u_xlatb12.x) ? 0.0 : 1.0;
					    u_xlatb1 = u_xlat0.w>=(-u_xlat0.w);
					    u_xlat7 = fract(abs(u_xlat0.w));
					    u_xlat2.y = floor(u_xlat0.w);
					    u_xlat18 = (u_xlatb1) ? u_xlat7 : (-u_xlat7);
					    u_xlat2.x = u_xlat18 * _CharDim.x;
					    u_xlat1.xy = u_xlat2.xy / _CharDim.xy;
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat1 = texture(_CharTex, u_xlat0.xy);
					    u_xlat2 = _ColorMiddle + (-_ColorDark);
					    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _ColorDark;
					    u_xlat0.x = u_xlat12.x * u_xlat1.w;
					    u_xlat2.y = vs_TEXCOORD0.y;
					    u_xlat3.y = (-vs_TEXCOORD0.y);
					    u_xlat6 = (-_OutlineWidth) * 0.5 + vs_TEXCOORD0.x;
					    u_xlat12.xy = (-vec2(_OutlineWidth, _OwnTeamRatio)) + vec2(1.0, 1.0);
					    u_xlat6 = u_xlat6 / u_xlat12.x;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat19 = u_xlat6 + (-_OwnTeamRatio);
					    u_xlat3.x = u_xlat19 / u_xlat12.y;
					    u_xlat2.x = u_xlat6 / _OwnTeamRatio;
					    u_xlatb6 = _OwnTeamRatio>=u_xlat6;
					    u_xlat2.xy = (bool(u_xlatb6)) ? u_xlat2.xy : u_xlat3.xy;
					    u_xlat3.xy = vec2(_TilingScrollSpeed, _BlinkSpeed) * _Time.yy;
					    u_xlat2.z = u_xlat2.y * _TilingY + (-u_xlat3.x);
					    u_xlat2 = texture(_MainTex, u_xlat2.xz);
					    u_xlat4 = (bool(u_xlatb6)) ? _ColorMiddle : _ColorMiddleOther;
					    u_xlat5 = (bool(u_xlatb6)) ? _ColorDark : _ColorDarkOther;
					    u_xlat4 = u_xlat4 + (-u_xlat5);
					    u_xlat2 = u_xlat2.xxxx * u_xlat4 + u_xlat5;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1 = (-u_xlat2) + vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlatb0 = u_xlat3.y>=(-u_xlat3.y);
					    u_xlat6 = fract(abs(u_xlat3.y));
					    u_xlat0.x = (u_xlatb0) ? u_xlat6 : (-u_xlat6);
					    u_xlatb0 = _BlinkRatio>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x * _Blink;
					    u_xlat1 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
					    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlatb0 = abs(u_xlat0.x)>=u_xlat12.x;
					    SV_Target0 = (bool(u_xlatb0)) ? _ColorOutlineFG : u_xlat1;
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
						vec4 unused_0_0[3];
						vec4 _ColorOutlineFG;
						vec4 _ColorMiddle;
						vec4 _ColorDark;
						vec4 unused_0_4[4];
						vec4 _CharDim;
						vec4 _GridDim;
						float _CharAnimSpeed;
						float _OutlineWidth;
						float _OwnTeamRatio;
						vec4 _ColorMiddleOther;
						vec4 _ColorDarkOther;
						float _TilingY;
						float _TilingScrollSpeed;
						float _BlinkSpeed;
						float _Blink;
						float _BlinkRatio;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CharAnimTex;
					uniform  sampler2D _CharTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					vec2 u_xlat12;
					bvec2 u_xlatb12;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.zx * vec2(1.0, -1.0);
					    u_xlat0.xy = u_xlat0.xy / _CharDim.zw;
					    u_xlat0.xy = u_xlat0.xy + vec2(1000.0, 1000.0);
					    u_xlat12.xy = floor(u_xlat0.xy);
					    u_xlat0.xy = (-u_xlat12.xy) + u_xlat0.xy;
					    u_xlat1.xy = u_xlat12.xy / _GridDim.xy;
					    u_xlat12.x = u_xlat12.y * 0.100000001;
					    u_xlat2.y = _Time.y * _CharAnimSpeed + u_xlat12.x;
					    u_xlatb12.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
					    u_xlat1.xy = fract(abs(u_xlat1.xy));
					    u_xlat12.x = (u_xlatb12.x) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat12.y = (u_xlatb12.y) ? u_xlat1.y : (-u_xlat1.y);
					    u_xlat12.xy = u_xlat12.xy * _GridDim.xy;
					    u_xlat12.x = u_xlat12.y * _GridDim.x + u_xlat12.x;
					    u_xlat18 = _GridDim.y * _GridDim.x;
					    u_xlat2.x = u_xlat12.x / u_xlat18;
					    u_xlat1 = texture(_CharAnimTex, u_xlat2.xy);
					    u_xlat12.x = _CharDim.y * _CharDim.x;
					    u_xlat18 = u_xlat1.x / u_xlat12.x;
					    u_xlat1.x = _CharDim.x * _CharDim.y + -1.0;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat12.x = u_xlat12.x * u_xlat18;
					    u_xlat0.z = floor(u_xlat12.x);
					    u_xlat0.xyw = u_xlat0.xyz / _CharDim.xyx;
					    u_xlatb12.x = 0.0>=u_xlat0.z;
					    u_xlat12.x = (u_xlatb12.x) ? 0.0 : 1.0;
					    u_xlatb1 = u_xlat0.w>=(-u_xlat0.w);
					    u_xlat7 = fract(abs(u_xlat0.w));
					    u_xlat2.y = floor(u_xlat0.w);
					    u_xlat18 = (u_xlatb1) ? u_xlat7 : (-u_xlat7);
					    u_xlat2.x = u_xlat18 * _CharDim.x;
					    u_xlat1.xy = u_xlat2.xy / _CharDim.xy;
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat1 = texture(_CharTex, u_xlat0.xy);
					    u_xlat2 = _ColorMiddle + (-_ColorDark);
					    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _ColorDark;
					    u_xlat0.x = u_xlat12.x * u_xlat1.w;
					    u_xlat2.y = vs_TEXCOORD0.y;
					    u_xlat3.y = (-vs_TEXCOORD0.y);
					    u_xlat6 = (-_OutlineWidth) * 0.5 + vs_TEXCOORD0.x;
					    u_xlat12.xy = (-vec2(_OutlineWidth, _OwnTeamRatio)) + vec2(1.0, 1.0);
					    u_xlat6 = u_xlat6 / u_xlat12.x;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat19 = u_xlat6 + (-_OwnTeamRatio);
					    u_xlat3.x = u_xlat19 / u_xlat12.y;
					    u_xlat2.x = u_xlat6 / _OwnTeamRatio;
					    u_xlatb6 = _OwnTeamRatio>=u_xlat6;
					    u_xlat2.xy = (bool(u_xlatb6)) ? u_xlat2.xy : u_xlat3.xy;
					    u_xlat3.xy = vec2(_TilingScrollSpeed, _BlinkSpeed) * _Time.yy;
					    u_xlat2.z = u_xlat2.y * _TilingY + (-u_xlat3.x);
					    u_xlat2 = texture(_MainTex, u_xlat2.xz);
					    u_xlat4 = (bool(u_xlatb6)) ? _ColorMiddle : _ColorMiddleOther;
					    u_xlat5 = (bool(u_xlatb6)) ? _ColorDark : _ColorDarkOther;
					    u_xlat4 = u_xlat4 + (-u_xlat5);
					    u_xlat2 = u_xlat2.xxxx * u_xlat4 + u_xlat5;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1 = (-u_xlat2) + vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlatb0 = u_xlat3.y>=(-u_xlat3.y);
					    u_xlat6 = fract(abs(u_xlat3.y));
					    u_xlat0.x = (u_xlatb0) ? u_xlat6 : (-u_xlat6);
					    u_xlatb0 = _BlinkRatio>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x * _Blink;
					    u_xlat1 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
					    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlatb0 = abs(u_xlat0.x)>=u_xlat12.x;
					    SV_Target0 = (bool(u_xlatb0)) ? _ColorOutlineFG : u_xlat1;
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
						vec4 unused_0_0[3];
						vec4 _ColorOutlineFG;
						vec4 _ColorMiddle;
						vec4 _ColorDark;
						vec4 unused_0_4[4];
						vec4 _CharDim;
						vec4 _GridDim;
						float _CharAnimSpeed;
						float _OutlineWidth;
						float _OwnTeamRatio;
						vec4 _ColorMiddleOther;
						vec4 _ColorDarkOther;
						float _TilingY;
						float _TilingScrollSpeed;
						float _BlinkSpeed;
						float _Blink;
						float _BlinkRatio;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _CharAnimTex;
					uniform  sampler2D _CharTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					vec2 u_xlat12;
					bvec2 u_xlatb12;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.zx * vec2(1.0, -1.0);
					    u_xlat0.xy = u_xlat0.xy / _CharDim.zw;
					    u_xlat0.xy = u_xlat0.xy + vec2(1000.0, 1000.0);
					    u_xlat12.xy = floor(u_xlat0.xy);
					    u_xlat0.xy = (-u_xlat12.xy) + u_xlat0.xy;
					    u_xlat1.xy = u_xlat12.xy / _GridDim.xy;
					    u_xlat12.x = u_xlat12.y * 0.100000001;
					    u_xlat2.y = _Time.y * _CharAnimSpeed + u_xlat12.x;
					    u_xlatb12.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
					    u_xlat1.xy = fract(abs(u_xlat1.xy));
					    u_xlat12.x = (u_xlatb12.x) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat12.y = (u_xlatb12.y) ? u_xlat1.y : (-u_xlat1.y);
					    u_xlat12.xy = u_xlat12.xy * _GridDim.xy;
					    u_xlat12.x = u_xlat12.y * _GridDim.x + u_xlat12.x;
					    u_xlat18 = _GridDim.y * _GridDim.x;
					    u_xlat2.x = u_xlat12.x / u_xlat18;
					    u_xlat1 = texture(_CharAnimTex, u_xlat2.xy);
					    u_xlat12.x = _CharDim.y * _CharDim.x;
					    u_xlat18 = u_xlat1.x / u_xlat12.x;
					    u_xlat1.x = _CharDim.x * _CharDim.y + -1.0;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat12.x = u_xlat12.x * u_xlat18;
					    u_xlat0.z = floor(u_xlat12.x);
					    u_xlat0.xyw = u_xlat0.xyz / _CharDim.xyx;
					    u_xlatb12.x = 0.0>=u_xlat0.z;
					    u_xlat12.x = (u_xlatb12.x) ? 0.0 : 1.0;
					    u_xlatb1 = u_xlat0.w>=(-u_xlat0.w);
					    u_xlat7 = fract(abs(u_xlat0.w));
					    u_xlat2.y = floor(u_xlat0.w);
					    u_xlat18 = (u_xlatb1) ? u_xlat7 : (-u_xlat7);
					    u_xlat2.x = u_xlat18 * _CharDim.x;
					    u_xlat1.xy = u_xlat2.xy / _CharDim.xy;
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
					    u_xlat1 = texture(_CharTex, u_xlat0.xy);
					    u_xlat2 = _ColorMiddle + (-_ColorDark);
					    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _ColorDark;
					    u_xlat0.x = u_xlat12.x * u_xlat1.w;
					    u_xlat2.y = vs_TEXCOORD0.y;
					    u_xlat3.y = (-vs_TEXCOORD0.y);
					    u_xlat6 = (-_OutlineWidth) * 0.5 + vs_TEXCOORD0.x;
					    u_xlat12.xy = (-vec2(_OutlineWidth, _OwnTeamRatio)) + vec2(1.0, 1.0);
					    u_xlat6 = u_xlat6 / u_xlat12.x;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat19 = u_xlat6 + (-_OwnTeamRatio);
					    u_xlat3.x = u_xlat19 / u_xlat12.y;
					    u_xlat2.x = u_xlat6 / _OwnTeamRatio;
					    u_xlatb6 = _OwnTeamRatio>=u_xlat6;
					    u_xlat2.xy = (bool(u_xlatb6)) ? u_xlat2.xy : u_xlat3.xy;
					    u_xlat3.xy = vec2(_TilingScrollSpeed, _BlinkSpeed) * _Time.yy;
					    u_xlat2.z = u_xlat2.y * _TilingY + (-u_xlat3.x);
					    u_xlat2 = texture(_MainTex, u_xlat2.xz);
					    u_xlat4 = (bool(u_xlatb6)) ? _ColorMiddle : _ColorMiddleOther;
					    u_xlat5 = (bool(u_xlatb6)) ? _ColorDark : _ColorDarkOther;
					    u_xlat4 = u_xlat4 + (-u_xlat5);
					    u_xlat2 = u_xlat2.xxxx * u_xlat4 + u_xlat5;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1 = (-u_xlat2) + vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlatb0 = u_xlat3.y>=(-u_xlat3.y);
					    u_xlat6 = fract(abs(u_xlat3.y));
					    u_xlat0.x = (u_xlatb0) ? u_xlat6 : (-u_xlat6);
					    u_xlatb0 = _BlinkRatio>=u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat0.x * _Blink;
					    u_xlat1 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
					    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlatb0 = abs(u_xlat0.x)>=u_xlat12.x;
					    SV_Target0 = (bool(u_xlatb0)) ? _ColorOutlineFG : u_xlat1;
					    return;
					}"
				}
			}
		}
	}
}