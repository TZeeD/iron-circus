Shader "SteelCircus/FX/Skills/AoePreviews/AoeWarsongShader" {
	Properties {
		[NoScaleOffset] _MainTex ("R = Gradient, G = EQ Thresholds, B = EQ Mask", 2D) = "white" {}
		_AlphaScale ("Alpha", Range(0, 1)) = 1
		_ColorMiddle ("Middle Color", Vector) = (1,1,1,1)
		_ColorDark ("Dark Color", Vector) = (1,1,1,1)
		_GradientMultTex ("Mult. Gradient", 2D) = "white" {}
		_GradientMultColor ("Mult. Gradient Color", Vector) = (1,1,1,1)
		_GradientMultSpeed ("Mult. Gradient Speed", Float) = 1
		_NumSegments ("Segments", Float) = 12
		_ColorOutlineFG ("Outline Color", Vector) = (1,1,1,1)
		_OutlineWidth ("Outline Width (units div by scale)", Range(0, 1)) = 0.01
		_OutlineModAngle ("Outline offset: angle threshold", Float) = 0.9
		_OutlineModOffset ("Outline offset: intensity", Float) = 0.1
		[NoScaleOffset] _EQAnimationTex ("EQ Animation Tex (cols = num segments, rows = anim data)", 2D) = "white" {}
		_EQAnimationSpeed ("EQ Animation Speed", Float) = 1
		_EQMultColorBase ("EQ Mult. Color, base", Vector) = (1,1,1,1)
		_EQMultColorActive ("EQ Mult. Color, active", Vector) = (1,1,1,1)
		_ColorBuildupBG ("Buildup BG Color", Vector) = (1,0,0,1)
		_BuildupBGTime ("Buildup Time", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 9623
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
						vec4 unused_0_0[3];
						vec4 _ColorOutlineFG;
						vec4 _ColorMiddle;
						vec4 unused_0_3[3];
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 _GradientMultColor;
						vec4 _EQMultColorBase;
						vec4 _EQMultColorActive;
						float _NumSegments;
						float _OutlineWidth;
						float _EQAnimationSpeed;
						float _GradientMultSpeed;
						float _OutlineModAngle;
						float _OutlineModOffset;
						float _AlphaScale;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _GradientMultTex;
					uniform  sampler2D _EQAnimationTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					vec2 u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat12.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat12.x = dot(u_xlat12.xy, u_xlat12.xy);
					    u_xlat12.x = sqrt(u_xlat12.x);
					    u_xlatb18 = 1.0<u_xlat12.x;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat18 = _BuildupBGTime * 0.5 + 0.5;
					    u_xlat12.x = log2(u_xlat12.x);
					    u_xlat12.x = u_xlat12.x * u_xlat18;
					    u_xlat12.x = exp2(u_xlat12.x);
					    u_xlat1.xy = abs(u_xlat0.xy);
					    u_xlat18 = min(u_xlat1.y, u_xlat1.x);
					    u_xlat13 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat18 = u_xlat18 * u_xlat13;
					    u_xlat13 = u_xlat18 * u_xlat18;
					    u_xlat19 = u_xlat13 * 0.0208350997 + -0.0851330012;
					    u_xlat19 = u_xlat13 * u_xlat19 + 0.180141002;
					    u_xlat19 = u_xlat13 * u_xlat19 + -0.330299497;
					    u_xlat13 = u_xlat13 * u_xlat19 + 0.999866009;
					    u_xlat19 = u_xlat18 * u_xlat13;
					    u_xlatb1 = u_xlat1.y<u_xlat1.x;
					    u_xlat7 = u_xlat19 * -2.0 + 1.57079637;
					    u_xlat1.x = u_xlatb1 ? u_xlat7 : float(0.0);
					    u_xlat18 = u_xlat18 * u_xlat13 + u_xlat1.x;
					    u_xlatb1 = (-u_xlat0.y)<u_xlat0.y;
					    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat1.x;
					    u_xlat1.x = min((-u_xlat0.y), (-u_xlat0.x));
					    u_xlat0.x = max((-u_xlat0.y), (-u_xlat0.x));
					    u_xlatb6 = u_xlat1.x<(-u_xlat1.x);
					    u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlatb0 = u_xlatb0 && u_xlatb6;
					    u_xlat0.x = (u_xlatb0) ? (-u_xlat18) : u_xlat18;
					    u_xlat6 = u_xlat0.x * 0.318309873;
					    u_xlat0.x = u_xlat0.x * 0.159154937 + 0.5;
					    u_xlat1.x = u_xlat0.x * _NumSegments;
					    u_xlat18 = ceil(u_xlat1.x);
					    u_xlat13 = float(1.0) / _NumSegments;
					    u_xlat0.x = u_xlat0.x / u_xlat13;
					    u_xlatb19 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlat0.x = fract(abs(u_xlat0.x));
					    u_xlat0.x = (u_xlatb19) ? u_xlat0.x : (-u_xlat0.x);
					    u_xlat0.x = u_xlat13 * u_xlat0.x;
					    u_xlat19 = _OutlineModAngle / _NumSegments;
					    u_xlatb0 = u_xlat19<u_xlat0.x;
					    u_xlat19 = _OutlineModOffset + 1.0;
					    u_xlat19 = u_xlat12.x * u_xlat19;
					    u_xlat1.y = (u_xlatb0) ? u_xlat19 : u_xlat12.x;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat3 = _ColorMiddle * vec4(vec4(_AlphaScale, _AlphaScale, _AlphaScale, _AlphaScale));
					    u_xlat2.w = 1.0;
					    u_xlat3 = u_xlat3 * u_xlat2.xxxw;
					    u_xlat0.x = _GradientMultSpeed * (-_Time.y);
					    u_xlatb12 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlat0.x = fract(abs(u_xlat0.x));
					    u_xlat4.y = (u_xlatb12) ? u_xlat0.x : (-u_xlat0.x);
					    u_xlat4.x = 0.0;
					    u_xlat0.xz = u_xlat1.xy + u_xlat4.xy;
					    u_xlat4 = texture(_GradientMultTex, u_xlat0.xz);
					    u_xlat4.xyz = u_xlat4.xyz + _GradientMultColor.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat0.x = _BuildupBGTime * 2.0 + -1.0;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlatb0 = _BuildupBGTime>=abs(u_xlat6);
					    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
					    u_xlat4.w = u_xlat3.w * _ColorBuildupBG.w;
					    u_xlat4.xyz = _ColorBuildupBG.xyz;
					    u_xlat4 = (-u_xlat3) + u_xlat4;
					    u_xlat3 = u_xlat0.xxxx * u_xlat4 + u_xlat3;
					    u_xlat0.x = u_xlat18 + 0.5;
					    u_xlat4.x = u_xlat0.x * u_xlat13;
					    u_xlat4.y = _EQAnimationSpeed * _Time.y;
					    u_xlat4 = texture(_EQAnimationTex, u_xlat4.xy);
					    u_xlat0.x = u_xlat4.x * 7.0;
					    u_xlat12.x = u_xlat2.y * 7.0;
					    u_xlat12.x = floor(u_xlat12.x);
					    u_xlatb0 = u_xlat0.x>=u_xlat12.x;
					    u_xlat5 = _ColorOutlineFG * _EQMultColorActive;
					    u_xlat12.x = u_xlat4.x * 7.0 + (-u_xlat12.x);
					    u_xlat12.x = floor(u_xlat12.x);
					    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
					    u_xlat4 = _ColorMiddle * _EQMultColorBase + (-u_xlat5);
					    u_xlat4 = u_xlat12.xxxx * u_xlat4 + u_xlat5;
					    u_xlat4 = u_xlat4 * vec4(vec4(_AlphaScale, _AlphaScale, _AlphaScale, _AlphaScale)) + (-u_xlat3);
					    u_xlat2 = u_xlat2.zzzz * u_xlat4 + u_xlat3;
					    u_xlat2 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat3;
					    u_xlat0.x = (-_OutlineWidth) + 1.0;
					    u_xlatb0 = u_xlat1.y>=u_xlat0.x;
					    u_xlat1 = (bool(u_xlatb0)) ? _ColorOutlineFG : u_xlat2;
					    u_xlat0.x = inversesqrt(_BuildupBGTime);
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=abs(u_xlat6);
					    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
					    u_xlat2.w = u_xlat1.w * _ColorBuildupBG.w;
					    u_xlat2.xyz = _ColorBuildupBG.xyz;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
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
						vec4 unused_0_3[3];
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 _GradientMultColor;
						vec4 _EQMultColorBase;
						vec4 _EQMultColorActive;
						float _NumSegments;
						float _OutlineWidth;
						float _EQAnimationSpeed;
						float _GradientMultSpeed;
						float _OutlineModAngle;
						float _OutlineModOffset;
						float _AlphaScale;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _GradientMultTex;
					uniform  sampler2D _EQAnimationTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					vec2 u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat12.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat12.x = dot(u_xlat12.xy, u_xlat12.xy);
					    u_xlat12.x = sqrt(u_xlat12.x);
					    u_xlatb18 = 1.0<u_xlat12.x;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat18 = _BuildupBGTime * 0.5 + 0.5;
					    u_xlat12.x = log2(u_xlat12.x);
					    u_xlat12.x = u_xlat12.x * u_xlat18;
					    u_xlat12.x = exp2(u_xlat12.x);
					    u_xlat1.xy = abs(u_xlat0.xy);
					    u_xlat18 = min(u_xlat1.y, u_xlat1.x);
					    u_xlat13 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat18 = u_xlat18 * u_xlat13;
					    u_xlat13 = u_xlat18 * u_xlat18;
					    u_xlat19 = u_xlat13 * 0.0208350997 + -0.0851330012;
					    u_xlat19 = u_xlat13 * u_xlat19 + 0.180141002;
					    u_xlat19 = u_xlat13 * u_xlat19 + -0.330299497;
					    u_xlat13 = u_xlat13 * u_xlat19 + 0.999866009;
					    u_xlat19 = u_xlat18 * u_xlat13;
					    u_xlatb1 = u_xlat1.y<u_xlat1.x;
					    u_xlat7 = u_xlat19 * -2.0 + 1.57079637;
					    u_xlat1.x = u_xlatb1 ? u_xlat7 : float(0.0);
					    u_xlat18 = u_xlat18 * u_xlat13 + u_xlat1.x;
					    u_xlatb1 = (-u_xlat0.y)<u_xlat0.y;
					    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat1.x;
					    u_xlat1.x = min((-u_xlat0.y), (-u_xlat0.x));
					    u_xlat0.x = max((-u_xlat0.y), (-u_xlat0.x));
					    u_xlatb6 = u_xlat1.x<(-u_xlat1.x);
					    u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlatb0 = u_xlatb0 && u_xlatb6;
					    u_xlat0.x = (u_xlatb0) ? (-u_xlat18) : u_xlat18;
					    u_xlat6 = u_xlat0.x * 0.318309873;
					    u_xlat0.x = u_xlat0.x * 0.159154937 + 0.5;
					    u_xlat1.x = u_xlat0.x * _NumSegments;
					    u_xlat18 = ceil(u_xlat1.x);
					    u_xlat13 = float(1.0) / _NumSegments;
					    u_xlat0.x = u_xlat0.x / u_xlat13;
					    u_xlatb19 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlat0.x = fract(abs(u_xlat0.x));
					    u_xlat0.x = (u_xlatb19) ? u_xlat0.x : (-u_xlat0.x);
					    u_xlat0.x = u_xlat13 * u_xlat0.x;
					    u_xlat19 = _OutlineModAngle / _NumSegments;
					    u_xlatb0 = u_xlat19<u_xlat0.x;
					    u_xlat19 = _OutlineModOffset + 1.0;
					    u_xlat19 = u_xlat12.x * u_xlat19;
					    u_xlat1.y = (u_xlatb0) ? u_xlat19 : u_xlat12.x;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat3 = _ColorMiddle * vec4(vec4(_AlphaScale, _AlphaScale, _AlphaScale, _AlphaScale));
					    u_xlat2.w = 1.0;
					    u_xlat3 = u_xlat3 * u_xlat2.xxxw;
					    u_xlat0.x = _GradientMultSpeed * (-_Time.y);
					    u_xlatb12 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlat0.x = fract(abs(u_xlat0.x));
					    u_xlat4.y = (u_xlatb12) ? u_xlat0.x : (-u_xlat0.x);
					    u_xlat4.x = 0.0;
					    u_xlat0.xz = u_xlat1.xy + u_xlat4.xy;
					    u_xlat4 = texture(_GradientMultTex, u_xlat0.xz);
					    u_xlat4.xyz = u_xlat4.xyz + _GradientMultColor.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat0.x = _BuildupBGTime * 2.0 + -1.0;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlatb0 = _BuildupBGTime>=abs(u_xlat6);
					    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
					    u_xlat4.w = u_xlat3.w * _ColorBuildupBG.w;
					    u_xlat4.xyz = _ColorBuildupBG.xyz;
					    u_xlat4 = (-u_xlat3) + u_xlat4;
					    u_xlat3 = u_xlat0.xxxx * u_xlat4 + u_xlat3;
					    u_xlat0.x = u_xlat18 + 0.5;
					    u_xlat4.x = u_xlat0.x * u_xlat13;
					    u_xlat4.y = _EQAnimationSpeed * _Time.y;
					    u_xlat4 = texture(_EQAnimationTex, u_xlat4.xy);
					    u_xlat0.x = u_xlat4.x * 7.0;
					    u_xlat12.x = u_xlat2.y * 7.0;
					    u_xlat12.x = floor(u_xlat12.x);
					    u_xlatb0 = u_xlat0.x>=u_xlat12.x;
					    u_xlat5 = _ColorOutlineFG * _EQMultColorActive;
					    u_xlat12.x = u_xlat4.x * 7.0 + (-u_xlat12.x);
					    u_xlat12.x = floor(u_xlat12.x);
					    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
					    u_xlat4 = _ColorMiddle * _EQMultColorBase + (-u_xlat5);
					    u_xlat4 = u_xlat12.xxxx * u_xlat4 + u_xlat5;
					    u_xlat4 = u_xlat4 * vec4(vec4(_AlphaScale, _AlphaScale, _AlphaScale, _AlphaScale)) + (-u_xlat3);
					    u_xlat2 = u_xlat2.zzzz * u_xlat4 + u_xlat3;
					    u_xlat2 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat3;
					    u_xlat0.x = (-_OutlineWidth) + 1.0;
					    u_xlatb0 = u_xlat1.y>=u_xlat0.x;
					    u_xlat1 = (bool(u_xlatb0)) ? _ColorOutlineFG : u_xlat2;
					    u_xlat0.x = inversesqrt(_BuildupBGTime);
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=abs(u_xlat6);
					    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
					    u_xlat2.w = u_xlat1.w * _ColorBuildupBG.w;
					    u_xlat2.xyz = _ColorBuildupBG.xyz;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
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
						vec4 unused_0_3[3];
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 _GradientMultColor;
						vec4 _EQMultColorBase;
						vec4 _EQMultColorActive;
						float _NumSegments;
						float _OutlineWidth;
						float _EQAnimationSpeed;
						float _GradientMultSpeed;
						float _OutlineModAngle;
						float _OutlineModOffset;
						float _AlphaScale;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _GradientMultTex;
					uniform  sampler2D _EQAnimationTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					vec2 u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat12.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat12.x = dot(u_xlat12.xy, u_xlat12.xy);
					    u_xlat12.x = sqrt(u_xlat12.x);
					    u_xlatb18 = 1.0<u_xlat12.x;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat18 = _BuildupBGTime * 0.5 + 0.5;
					    u_xlat12.x = log2(u_xlat12.x);
					    u_xlat12.x = u_xlat12.x * u_xlat18;
					    u_xlat12.x = exp2(u_xlat12.x);
					    u_xlat1.xy = abs(u_xlat0.xy);
					    u_xlat18 = min(u_xlat1.y, u_xlat1.x);
					    u_xlat13 = max(u_xlat1.y, u_xlat1.x);
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat18 = u_xlat18 * u_xlat13;
					    u_xlat13 = u_xlat18 * u_xlat18;
					    u_xlat19 = u_xlat13 * 0.0208350997 + -0.0851330012;
					    u_xlat19 = u_xlat13 * u_xlat19 + 0.180141002;
					    u_xlat19 = u_xlat13 * u_xlat19 + -0.330299497;
					    u_xlat13 = u_xlat13 * u_xlat19 + 0.999866009;
					    u_xlat19 = u_xlat18 * u_xlat13;
					    u_xlatb1 = u_xlat1.y<u_xlat1.x;
					    u_xlat7 = u_xlat19 * -2.0 + 1.57079637;
					    u_xlat1.x = u_xlatb1 ? u_xlat7 : float(0.0);
					    u_xlat18 = u_xlat18 * u_xlat13 + u_xlat1.x;
					    u_xlatb1 = (-u_xlat0.y)<u_xlat0.y;
					    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
					    u_xlat18 = u_xlat18 + u_xlat1.x;
					    u_xlat1.x = min((-u_xlat0.y), (-u_xlat0.x));
					    u_xlat0.x = max((-u_xlat0.y), (-u_xlat0.x));
					    u_xlatb6 = u_xlat1.x<(-u_xlat1.x);
					    u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlatb0 = u_xlatb0 && u_xlatb6;
					    u_xlat0.x = (u_xlatb0) ? (-u_xlat18) : u_xlat18;
					    u_xlat6 = u_xlat0.x * 0.318309873;
					    u_xlat0.x = u_xlat0.x * 0.159154937 + 0.5;
					    u_xlat1.x = u_xlat0.x * _NumSegments;
					    u_xlat18 = ceil(u_xlat1.x);
					    u_xlat13 = float(1.0) / _NumSegments;
					    u_xlat0.x = u_xlat0.x / u_xlat13;
					    u_xlatb19 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlat0.x = fract(abs(u_xlat0.x));
					    u_xlat0.x = (u_xlatb19) ? u_xlat0.x : (-u_xlat0.x);
					    u_xlat0.x = u_xlat13 * u_xlat0.x;
					    u_xlat19 = _OutlineModAngle / _NumSegments;
					    u_xlatb0 = u_xlat19<u_xlat0.x;
					    u_xlat19 = _OutlineModOffset + 1.0;
					    u_xlat19 = u_xlat12.x * u_xlat19;
					    u_xlat1.y = (u_xlatb0) ? u_xlat19 : u_xlat12.x;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat3 = _ColorMiddle * vec4(vec4(_AlphaScale, _AlphaScale, _AlphaScale, _AlphaScale));
					    u_xlat2.w = 1.0;
					    u_xlat3 = u_xlat3 * u_xlat2.xxxw;
					    u_xlat0.x = _GradientMultSpeed * (-_Time.y);
					    u_xlatb12 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlat0.x = fract(abs(u_xlat0.x));
					    u_xlat4.y = (u_xlatb12) ? u_xlat0.x : (-u_xlat0.x);
					    u_xlat4.x = 0.0;
					    u_xlat0.xz = u_xlat1.xy + u_xlat4.xy;
					    u_xlat4 = texture(_GradientMultTex, u_xlat0.xz);
					    u_xlat4.xyz = u_xlat4.xyz + _GradientMultColor.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat0.x = _BuildupBGTime * 2.0 + -1.0;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlatb0 = _BuildupBGTime>=abs(u_xlat6);
					    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
					    u_xlat4.w = u_xlat3.w * _ColorBuildupBG.w;
					    u_xlat4.xyz = _ColorBuildupBG.xyz;
					    u_xlat4 = (-u_xlat3) + u_xlat4;
					    u_xlat3 = u_xlat0.xxxx * u_xlat4 + u_xlat3;
					    u_xlat0.x = u_xlat18 + 0.5;
					    u_xlat4.x = u_xlat0.x * u_xlat13;
					    u_xlat4.y = _EQAnimationSpeed * _Time.y;
					    u_xlat4 = texture(_EQAnimationTex, u_xlat4.xy);
					    u_xlat0.x = u_xlat4.x * 7.0;
					    u_xlat12.x = u_xlat2.y * 7.0;
					    u_xlat12.x = floor(u_xlat12.x);
					    u_xlatb0 = u_xlat0.x>=u_xlat12.x;
					    u_xlat5 = _ColorOutlineFG * _EQMultColorActive;
					    u_xlat12.x = u_xlat4.x * 7.0 + (-u_xlat12.x);
					    u_xlat12.x = floor(u_xlat12.x);
					    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
					    u_xlat4 = _ColorMiddle * _EQMultColorBase + (-u_xlat5);
					    u_xlat4 = u_xlat12.xxxx * u_xlat4 + u_xlat5;
					    u_xlat4 = u_xlat4 * vec4(vec4(_AlphaScale, _AlphaScale, _AlphaScale, _AlphaScale)) + (-u_xlat3);
					    u_xlat2 = u_xlat2.zzzz * u_xlat4 + u_xlat3;
					    u_xlat2 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat3;
					    u_xlat0.x = (-_OutlineWidth) + 1.0;
					    u_xlatb0 = u_xlat1.y>=u_xlat0.x;
					    u_xlat1 = (bool(u_xlatb0)) ? _ColorOutlineFG : u_xlat2;
					    u_xlat0.x = inversesqrt(_BuildupBGTime);
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=abs(u_xlat6);
					    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
					    u_xlat2.w = u_xlat1.w * _ColorBuildupBG.w;
					    u_xlat2.xyz = _ColorBuildupBG.xyz;
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    SV_Target0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
					    return;
					}"
				}
			}
		}
	}
}