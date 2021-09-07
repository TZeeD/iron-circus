Shader "SteelCircus/FX/Skills/AoePreviews/AoeMeteoricDiveShader" {
	Properties {
		[NoScaleOffset] _GradientTex ("Gradient Texture", 2D) = "white" {}
		_ColorOutlineFG ("Outline FG", Vector) = (1,1,0,1)
		_ColorMiddle ("Middle Color", Vector) = (1,1,1,1)
		_ColorDark ("Dark Color", Vector) = (1,1,1,1)
		_OutlineWidth ("Outline Width", Float) = 0.1
		_MainTex ("Tiling Texture (blend dark -> middle)", 2D) = "white" {}
		_TilingSpeed ("Tiling Speed Y (uv/sec)", Float) = 0.1
		_TilingSpeedX ("Tiling Speed X (uv/sec)", Float) = 0
		_TilingOpacity ("Tiling Opacity", Range(0, 1)) = 1
		_TilingPow ("Tiling UV Pow", Float) = 1
		_TilingOffset ("Tiling UV Offset per y tile", Float) = 0
		_ColorBuildupBG ("Buildup BG Color", Vector) = (1,0,0,1)
		_BuildupBGTime ("Buildup Time", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 1605
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
						vec4 unused_0_4[2];
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						float _OutlineWidth;
						vec4 _MainTex_ST;
						float _TilingOpacity;
						float _TilingSpeed;
						float _TilingPow;
						float _TilingOffset;
						float _TilingSpeedX;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat9;
					bool u_xlatb9;
					vec2 u_xlat14;
					bool u_xlatb14;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat14.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat1.x = dot(u_xlat14.xy, u_xlat14.xy);
					    u_xlat1.y = sqrt(u_xlat1.x);
					    u_xlatb15 = 1.0<u_xlat1.y;
					    if(((int(u_xlatb15) * int(0xffffffffu)))!=0){discard;}
					    u_xlat15 = min(abs(u_xlat14.y), abs(u_xlat14.x));
					    u_xlat22 = max(abs(u_xlat14.y), abs(u_xlat14.x));
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat15 = u_xlat22 * u_xlat15;
					    u_xlat22 = u_xlat15 * u_xlat15;
					    u_xlat2.x = u_xlat22 * 0.0208350997 + -0.0851330012;
					    u_xlat2.x = u_xlat22 * u_xlat2.x + 0.180141002;
					    u_xlat2.x = u_xlat22 * u_xlat2.x + -0.330299497;
					    u_xlat22 = u_xlat22 * u_xlat2.x + 0.999866009;
					    u_xlat2.x = u_xlat22 * u_xlat15;
					    u_xlatb9 = abs(u_xlat14.y)<abs(u_xlat14.x);
					    u_xlat2.x = u_xlat2.x * -2.0 + 1.57079637;
					    u_xlat2.x = u_xlatb9 ? u_xlat2.x : float(0.0);
					    u_xlat15 = u_xlat15 * u_xlat22 + u_xlat2.x;
					    u_xlatb22 = u_xlat14.y<(-u_xlat14.y);
					    u_xlat22 = u_xlatb22 ? -3.14159274 : float(0.0);
					    u_xlat15 = u_xlat22 + u_xlat15;
					    u_xlat22 = min(u_xlat14.y, u_xlat14.x);
					    u_xlat14.x = max(u_xlat14.y, u_xlat14.x);
					    u_xlatb21 = u_xlat22<(-u_xlat22);
					    u_xlatb14 = u_xlat14.x>=(-u_xlat14.x);
					    u_xlatb14 = u_xlatb14 && u_xlatb21;
					    u_xlat14.x = (u_xlatb14) ? (-u_xlat15) : u_xlat15;
					    u_xlat1.x = u_xlat14.x * 0.159154937 + 0.5;
					    u_xlat2 = texture(_GradientTex, u_xlat1.xy);
					    u_xlat3.xyz = u_xlat2.xyz;
					    u_xlat3.w = 1.0;
					    u_xlat4 = u_xlat3 * _ColorDark;
					    u_xlat14.x = _MainTex_ST.x * _MainTex_ST.x;
					    u_xlat14.x = u_xlat1.x * u_xlat14.x;
					    u_xlat21 = log2(u_xlat1.y);
					    u_xlat21 = u_xlat21 * _TilingPow;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat9.x = u_xlat14.x * 0.25;
					    u_xlat9.y = u_xlat21 * _MainTex_ST.y;
					    u_xlat14.xy = u_xlat9.xy + _MainTex_ST.zw;
					    u_xlat9.y = _TilingSpeed * (-_Time.y);
					    u_xlat9.x = 0.0;
					    u_xlat2.yz = u_xlat14.xy + u_xlat9.xy;
					    u_xlat14.x = ceil(u_xlat2.z);
					    u_xlat14.x = u_xlat14.x * _TilingOffset + u_xlat2.y;
					    u_xlat2.x = _TilingSpeedX * _Time.y + u_xlat14.x;
					    u_xlat5 = texture(_MainTex, u_xlat2.xz);
					    u_xlat6 = _ColorMiddle + (-_ColorDark);
					    u_xlat5 = u_xlat5.xxxx * u_xlat6 + _ColorDark;
					    u_xlat14.x = u_xlat2.w * _TilingOpacity;
					    u_xlat2 = (-u_xlat3) * _ColorDark + u_xlat5;
					    u_xlat2 = u_xlat14.xxxx * u_xlat2 + u_xlat4;
					    u_xlat14.x = (-_OutlineWidth) + 1.0;
					    u_xlatb14 = u_xlat1.y>=u_xlat14.x;
					    u_xlat1 = (bool(u_xlatb14)) ? _ColorOutlineFG : u_xlat2;
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlatb0 = _BuildupBGTime>=u_xlat0.x;
					    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ColorBuildupBG.xyz;
					    u_xlat2.w = _ColorBuildupBG.w * u_xlat1.w + (-u_xlat1.w);
					    SV_Target0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
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
						vec4 unused_0_4[2];
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						float _OutlineWidth;
						vec4 _MainTex_ST;
						float _TilingOpacity;
						float _TilingSpeed;
						float _TilingPow;
						float _TilingOffset;
						float _TilingSpeedX;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat9;
					bool u_xlatb9;
					vec2 u_xlat14;
					bool u_xlatb14;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat14.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat1.x = dot(u_xlat14.xy, u_xlat14.xy);
					    u_xlat1.y = sqrt(u_xlat1.x);
					    u_xlatb15 = 1.0<u_xlat1.y;
					    if(((int(u_xlatb15) * int(0xffffffffu)))!=0){discard;}
					    u_xlat15 = min(abs(u_xlat14.y), abs(u_xlat14.x));
					    u_xlat22 = max(abs(u_xlat14.y), abs(u_xlat14.x));
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat15 = u_xlat22 * u_xlat15;
					    u_xlat22 = u_xlat15 * u_xlat15;
					    u_xlat2.x = u_xlat22 * 0.0208350997 + -0.0851330012;
					    u_xlat2.x = u_xlat22 * u_xlat2.x + 0.180141002;
					    u_xlat2.x = u_xlat22 * u_xlat2.x + -0.330299497;
					    u_xlat22 = u_xlat22 * u_xlat2.x + 0.999866009;
					    u_xlat2.x = u_xlat22 * u_xlat15;
					    u_xlatb9 = abs(u_xlat14.y)<abs(u_xlat14.x);
					    u_xlat2.x = u_xlat2.x * -2.0 + 1.57079637;
					    u_xlat2.x = u_xlatb9 ? u_xlat2.x : float(0.0);
					    u_xlat15 = u_xlat15 * u_xlat22 + u_xlat2.x;
					    u_xlatb22 = u_xlat14.y<(-u_xlat14.y);
					    u_xlat22 = u_xlatb22 ? -3.14159274 : float(0.0);
					    u_xlat15 = u_xlat22 + u_xlat15;
					    u_xlat22 = min(u_xlat14.y, u_xlat14.x);
					    u_xlat14.x = max(u_xlat14.y, u_xlat14.x);
					    u_xlatb21 = u_xlat22<(-u_xlat22);
					    u_xlatb14 = u_xlat14.x>=(-u_xlat14.x);
					    u_xlatb14 = u_xlatb14 && u_xlatb21;
					    u_xlat14.x = (u_xlatb14) ? (-u_xlat15) : u_xlat15;
					    u_xlat1.x = u_xlat14.x * 0.159154937 + 0.5;
					    u_xlat2 = texture(_GradientTex, u_xlat1.xy);
					    u_xlat3.xyz = u_xlat2.xyz;
					    u_xlat3.w = 1.0;
					    u_xlat4 = u_xlat3 * _ColorDark;
					    u_xlat14.x = _MainTex_ST.x * _MainTex_ST.x;
					    u_xlat14.x = u_xlat1.x * u_xlat14.x;
					    u_xlat21 = log2(u_xlat1.y);
					    u_xlat21 = u_xlat21 * _TilingPow;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat9.x = u_xlat14.x * 0.25;
					    u_xlat9.y = u_xlat21 * _MainTex_ST.y;
					    u_xlat14.xy = u_xlat9.xy + _MainTex_ST.zw;
					    u_xlat9.y = _TilingSpeed * (-_Time.y);
					    u_xlat9.x = 0.0;
					    u_xlat2.yz = u_xlat14.xy + u_xlat9.xy;
					    u_xlat14.x = ceil(u_xlat2.z);
					    u_xlat14.x = u_xlat14.x * _TilingOffset + u_xlat2.y;
					    u_xlat2.x = _TilingSpeedX * _Time.y + u_xlat14.x;
					    u_xlat5 = texture(_MainTex, u_xlat2.xz);
					    u_xlat6 = _ColorMiddle + (-_ColorDark);
					    u_xlat5 = u_xlat5.xxxx * u_xlat6 + _ColorDark;
					    u_xlat14.x = u_xlat2.w * _TilingOpacity;
					    u_xlat2 = (-u_xlat3) * _ColorDark + u_xlat5;
					    u_xlat2 = u_xlat14.xxxx * u_xlat2 + u_xlat4;
					    u_xlat14.x = (-_OutlineWidth) + 1.0;
					    u_xlatb14 = u_xlat1.y>=u_xlat14.x;
					    u_xlat1 = (bool(u_xlatb14)) ? _ColorOutlineFG : u_xlat2;
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlatb0 = _BuildupBGTime>=u_xlat0.x;
					    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ColorBuildupBG.xyz;
					    u_xlat2.w = _ColorBuildupBG.w * u_xlat1.w + (-u_xlat1.w);
					    SV_Target0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
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
						vec4 unused_0_4[2];
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						float _OutlineWidth;
						vec4 _MainTex_ST;
						float _TilingOpacity;
						float _TilingSpeed;
						float _TilingPow;
						float _TilingOffset;
						float _TilingSpeedX;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat9;
					bool u_xlatb9;
					vec2 u_xlat14;
					bool u_xlatb14;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat14.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat1.x = dot(u_xlat14.xy, u_xlat14.xy);
					    u_xlat1.y = sqrt(u_xlat1.x);
					    u_xlatb15 = 1.0<u_xlat1.y;
					    if(((int(u_xlatb15) * int(0xffffffffu)))!=0){discard;}
					    u_xlat15 = min(abs(u_xlat14.y), abs(u_xlat14.x));
					    u_xlat22 = max(abs(u_xlat14.y), abs(u_xlat14.x));
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat15 = u_xlat22 * u_xlat15;
					    u_xlat22 = u_xlat15 * u_xlat15;
					    u_xlat2.x = u_xlat22 * 0.0208350997 + -0.0851330012;
					    u_xlat2.x = u_xlat22 * u_xlat2.x + 0.180141002;
					    u_xlat2.x = u_xlat22 * u_xlat2.x + -0.330299497;
					    u_xlat22 = u_xlat22 * u_xlat2.x + 0.999866009;
					    u_xlat2.x = u_xlat22 * u_xlat15;
					    u_xlatb9 = abs(u_xlat14.y)<abs(u_xlat14.x);
					    u_xlat2.x = u_xlat2.x * -2.0 + 1.57079637;
					    u_xlat2.x = u_xlatb9 ? u_xlat2.x : float(0.0);
					    u_xlat15 = u_xlat15 * u_xlat22 + u_xlat2.x;
					    u_xlatb22 = u_xlat14.y<(-u_xlat14.y);
					    u_xlat22 = u_xlatb22 ? -3.14159274 : float(0.0);
					    u_xlat15 = u_xlat22 + u_xlat15;
					    u_xlat22 = min(u_xlat14.y, u_xlat14.x);
					    u_xlat14.x = max(u_xlat14.y, u_xlat14.x);
					    u_xlatb21 = u_xlat22<(-u_xlat22);
					    u_xlatb14 = u_xlat14.x>=(-u_xlat14.x);
					    u_xlatb14 = u_xlatb14 && u_xlatb21;
					    u_xlat14.x = (u_xlatb14) ? (-u_xlat15) : u_xlat15;
					    u_xlat1.x = u_xlat14.x * 0.159154937 + 0.5;
					    u_xlat2 = texture(_GradientTex, u_xlat1.xy);
					    u_xlat3.xyz = u_xlat2.xyz;
					    u_xlat3.w = 1.0;
					    u_xlat4 = u_xlat3 * _ColorDark;
					    u_xlat14.x = _MainTex_ST.x * _MainTex_ST.x;
					    u_xlat14.x = u_xlat1.x * u_xlat14.x;
					    u_xlat21 = log2(u_xlat1.y);
					    u_xlat21 = u_xlat21 * _TilingPow;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat9.x = u_xlat14.x * 0.25;
					    u_xlat9.y = u_xlat21 * _MainTex_ST.y;
					    u_xlat14.xy = u_xlat9.xy + _MainTex_ST.zw;
					    u_xlat9.y = _TilingSpeed * (-_Time.y);
					    u_xlat9.x = 0.0;
					    u_xlat2.yz = u_xlat14.xy + u_xlat9.xy;
					    u_xlat14.x = ceil(u_xlat2.z);
					    u_xlat14.x = u_xlat14.x * _TilingOffset + u_xlat2.y;
					    u_xlat2.x = _TilingSpeedX * _Time.y + u_xlat14.x;
					    u_xlat5 = texture(_MainTex, u_xlat2.xz);
					    u_xlat6 = _ColorMiddle + (-_ColorDark);
					    u_xlat5 = u_xlat5.xxxx * u_xlat6 + _ColorDark;
					    u_xlat14.x = u_xlat2.w * _TilingOpacity;
					    u_xlat2 = (-u_xlat3) * _ColorDark + u_xlat5;
					    u_xlat2 = u_xlat14.xxxx * u_xlat2 + u_xlat4;
					    u_xlat14.x = (-_OutlineWidth) + 1.0;
					    u_xlatb14 = u_xlat1.y>=u_xlat14.x;
					    u_xlat1 = (bool(u_xlatb14)) ? _ColorOutlineFG : u_xlat2;
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlatb0 = _BuildupBGTime>=u_xlat0.x;
					    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ColorBuildupBG.xyz;
					    u_xlat2.w = _ColorBuildupBG.w * u_xlat1.w + (-u_xlat1.w);
					    SV_Target0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
					    return;
					}"
				}
			}
		}
	}
}