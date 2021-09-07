Shader "SteelCircus/FX/BorderForcefieldShaderV2" {
	Properties {
		_IntensityScale ("Global intensity scale", Float) = 1
		_NumTilesU ("Num Tiles U", Float) = 1
		_NumTilesV ("Num Tiles V", Float) = 1
		_Randomization ("Randomization", Vector) = (1.35232,1.54565,1.532697,1.229199)
		_SpeedU ("Anim. Speed U", Float) = 5
		_SpeedV ("Anim. Speed V", Float) = 7
		_SpeedScroll ("Scroll Speed V", Float) = 1
		_SpeedScale ("Global Speed Scale", Float) = 1
		_AnimIntensity ("Anim. Intensity", Range(0, 1)) = 0.2
		_ActivationTime ("Activation time (0...1 = activate, 1 = active, 1...2 = deactivate)", Range(0, 2)) = 1
		_ActivationGradientTex ("Activation Gradient (1D, center = active, rgb 127 = fully lit)", 2D) = "white" {}
		_ActivationMaxIntensity ("Activation Max Intensity", Float) = 2
		_VoronoiMisc ("Voronoi Misc Params", Vector) = (5,50,0.01,0.02)
		_VoronoiMisc2 ("Voronoi Misc Params 2", Vector) = (0.1,1,1,1)
		_Displacement ("Displacement", Float) = 7
		_GradientTex ("Gradient (1D)", 2D) = "white" {}
		_GradientIntensity ("Gradient Intensity", Range(0, 1)) = 0.2
		_GradientOverlayTex ("Gradient Overlay (1D)", 2D) = "white" {}
		_GradientOverlayTint ("Gradient Overlay Tint", Vector) = (1,1,1,1)
		_HitTex ("Hit Gradient (x = brightness over dist., y = time)", 2D) = "white" {}
		_HitInfo ("Hit Info (experimental - pos.xyz, hit progress = w)", Vector) = (1,1,1,0)
		_HitRadius ("Max Hit Radius", Float) = 1
		_HitBrightness ("Hit Brightness", Float) = 1
		_PlayerProximityBrightness ("Player Proximity Brightness", Float) = 0.1
		_NoiseTex ("Noise", 2D) = "white" {}
		_NoiseIntensity ("Noise Intensity", Float) = 1
		_NoiseScrollSpeed ("Noise Scroll Speed", Float) = 1
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
			GpuProgramID 31235
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
						vec4 unused_0_0[8];
						float _ActivationTime;
						float _ActivationMaxIntensity;
						vec4 unused_0_3[10];
						vec4 _NoiseTex_ST;
						vec4 unused_0_5;
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
					uniform  sampler2D _ActivationGradientTex;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.x = _ActivationTime * 0.5;
					    u_xlat0.y = 0.0;
					    u_xlat0 = textureLod(_ActivationGradientTex, u_xlat0.xy, 0.0);
					    u_xlat1 = u_xlat0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat1 = u_xlat1 * vec4(vec4(_ActivationMaxIntensity, _ActivationMaxIntensity, _ActivationMaxIntensity, _ActivationMaxIntensity)) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = u_xlat0 + u_xlat0;
					    u_xlatb0 = lessThan(vec4(0.5, 0.5, 0.5, 0.5), u_xlat0);
					    vs_TEXCOORD4.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat2.x;
					    vs_TEXCOORD4.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat2.y;
					    vs_TEXCOORD4.z = (u_xlatb0.z) ? u_xlat1.z : u_xlat2.z;
					    vs_TEXCOORD4.w = (u_xlatb0.w) ? u_xlat1.w : u_xlat2.w;
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
						vec4 unused_0_0[8];
						float _ActivationTime;
						float _ActivationMaxIntensity;
						vec4 unused_0_3[10];
						vec4 _NoiseTex_ST;
						vec4 unused_0_5;
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
					uniform  sampler2D _ActivationGradientTex;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.x = _ActivationTime * 0.5;
					    u_xlat0.y = 0.0;
					    u_xlat0 = textureLod(_ActivationGradientTex, u_xlat0.xy, 0.0);
					    u_xlat1 = u_xlat0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat1 = u_xlat1 * vec4(vec4(_ActivationMaxIntensity, _ActivationMaxIntensity, _ActivationMaxIntensity, _ActivationMaxIntensity)) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = u_xlat0 + u_xlat0;
					    u_xlatb0 = lessThan(vec4(0.5, 0.5, 0.5, 0.5), u_xlat0);
					    vs_TEXCOORD4.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat2.x;
					    vs_TEXCOORD4.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat2.y;
					    vs_TEXCOORD4.z = (u_xlatb0.z) ? u_xlat1.z : u_xlat2.z;
					    vs_TEXCOORD4.w = (u_xlatb0.w) ? u_xlat1.w : u_xlat2.w;
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
						vec4 unused_0_0[8];
						float _ActivationTime;
						float _ActivationMaxIntensity;
						vec4 unused_0_3[10];
						vec4 _NoiseTex_ST;
						vec4 unused_0_5;
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
					uniform  sampler2D _ActivationGradientTex;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD3 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.x = _ActivationTime * 0.5;
					    u_xlat0.y = 0.0;
					    u_xlat0 = textureLod(_ActivationGradientTex, u_xlat0.xy, 0.0);
					    u_xlat1 = u_xlat0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat1 = u_xlat1 * vec4(vec4(_ActivationMaxIntensity, _ActivationMaxIntensity, _ActivationMaxIntensity, _ActivationMaxIntensity)) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = u_xlat0 + u_xlat0;
					    u_xlatb0 = lessThan(vec4(0.5, 0.5, 0.5, 0.5), u_xlat0);
					    vs_TEXCOORD4.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat2.x;
					    vs_TEXCOORD4.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat2.y;
					    vs_TEXCOORD4.z = (u_xlatb0.z) ? u_xlat1.z : u_xlat2.z;
					    vs_TEXCOORD4.w = (u_xlatb0.w) ? u_xlat1.w : u_xlat2.w;
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
						float _IntensityScale;
						float _NumTilesU;
						float _NumTilesV;
						float _SpeedU;
						float _SpeedV;
						float _AnimIntensity;
						float _SpeedScroll;
						float _SpeedScale;
						vec4 _Randomization;
						vec4 _VoronoiMisc;
						vec4 _VoronoiMisc2;
						vec4 _GradientOverlayTint;
						float _GradientIntensity;
						float _Displacement;
						vec4 _HitInfos[9];
						vec4 unused_0_16[8];
						float _HitRadius;
						float _HitBrightness;
						float _PlayerProximityBrightness;
						vec4 unused_0_20;
						float _NoiseIntensity;
						float _NoiseScrollSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[5];
						vec4 _ScreenParams;
						vec4 unused_1_3[2];
					};
					uniform  sampler2D _HitTex;
					uniform  sampler2D _NoiseTex;
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _GrabBlurTexture;
					uniform  sampler2D _GradientOverlayTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat7;
					float u_xlat8;
					bool u_xlatb8;
					vec3 u_xlat9;
					float u_xlat10;
					bool u_xlatb10;
					float u_xlat11;
					bool u_xlatb11;
					vec2 u_xlat16;
					bool u_xlatb17;
					vec2 u_xlat18;
					vec2 u_xlat19;
					bool u_xlatb19;
					vec2 u_xlat20;
					vec2 u_xlat21;
					vec2 u_xlat22;
					float u_xlat24;
					int u_xlati24;
					bool u_xlatb24;
					float u_xlat26;
					float u_xlat27;
					void main()
					{
					    u_xlat0.y = float(100000.0);
					    u_xlat0.z = float(0.0);
					    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
					    {
					        u_xlatb1 = -1.0!=_HitInfos[u_xlati_loop_1].w;
					        u_xlat9.xyz = vs_TEXCOORD3.xyz + (-_HitInfos[u_xlati_loop_1].xyz);
					        u_xlat9.x = dot(u_xlat9.xyz, u_xlat9.xyz);
					        u_xlat9.x = sqrt(u_xlat9.x);
					        u_xlatb17 = u_xlat9.x<u_xlat0.y;
					        u_xlat2.y = (u_xlatb17) ? _HitInfos[u_xlati_loop_1].w : u_xlat0.z;
					        u_xlat2.x = min(u_xlat0.y, u_xlat9.x);
					        u_xlat0.yz = (bool(u_xlatb1)) ? u_xlat2.xy : u_xlat0.yz;
					    }
					    u_xlat8 = u_xlat0.y / _HitRadius;
					    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat8) + 1.0;
					    u_xlat0.xy = (-u_xlat0.xz) + vec2(1.0, 1.0);
					    u_xlat0 = texture(_HitTex, u_xlat0.xy);
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_PlayerProximityBrightness, _PlayerProximityBrightness, _PlayerProximityBrightness));
					    u_xlatb24 = -1.0!=_HitInfos[8].w;
					    if(u_xlatb24){
					        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_HitInfos[8].xyz);
					        u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat24 = sqrt(u_xlat24);
					        u_xlat24 = u_xlat24 / _HitRadius;
					        u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					        u_xlat2.x = (-u_xlat24) + 1.0;
					        u_xlat2.y = _HitInfos[8].w;
					        u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
					        u_xlat2 = texture(_HitTex, u_xlat2.xy);
					        u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_PlayerProximityBrightness, _PlayerProximityBrightness, _PlayerProximityBrightness)) + u_xlat2.xyz;
					    }
					    u_xlat0.y = _NoiseScrollSpeed * _Time.y;
					    u_xlat0.x = float(0.0);
					    u_xlat16.y = float(0.0);
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
					    u_xlat2 = texture(_NoiseTex, u_xlat0.xy);
					    u_xlat0.xy = vec2(_SpeedScroll, _SpeedV) * _Time.yy;
					    u_xlat3.xy = u_xlat0.xy * vec2(vec2(_SpeedScale, _SpeedScale));
					    u_xlat3.z = 0.0;
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(_NumTilesU, _NumTilesV) + u_xlat3.zx;
					    u_xlat1 = u_xlat1.xxyz * vec4(vec4(_HitBrightness, _HitBrightness, _HitBrightness, _HitBrightness));
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * _NoiseIntensity;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xy = u_xlat2.xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat2 = floor(u_xlat0.xyxy);
					    u_xlat1.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat3.x = _SpeedU * _Time.y;
					    u_xlat3.x = u_xlat3.x * _SpeedScale;
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat4.x = u_xlat1.x * 0.5 + u_xlat2.z;
					    u_xlat1.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat4.y = u_xlat1.x * 0.5 + u_xlat2.w;
					    u_xlat19.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat4 = u_xlat2.zwzw + vec4(-1.0, 0.0, 0.0, -1.0);
					    u_xlat1.x = dot(u_xlat4.xy, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat5.x = u_xlat1.x * 0.5 + u_xlat4.x;
					    u_xlat1.x = dot(u_xlat4.yx, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat5.y = u_xlat1.x * 0.5 + u_xlat4.y;
					    u_xlat4.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat1.x = dot(u_xlat4.zw, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat5.x = u_xlat1.x * 0.5 + u_xlat4.z;
					    u_xlat1.x = dot(u_xlat4.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat5.y = u_xlat1.x * 0.5 + u_xlat4.w;
					    u_xlat20.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat5 = u_xlat2.zwzw + vec4(-1.0, -1.0, 1.0, 0.0);
					    u_xlat1.x = dot(u_xlat5.xy, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat6.x = u_xlat1.x * 0.5 + u_xlat5.x;
					    u_xlat1.x = dot(u_xlat5.yx, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat6.y = u_xlat1.x * 0.5 + u_xlat5.y;
					    u_xlat5.xy = u_xlat6.xy + vec2(0.5, 0.5);
					    u_xlat1.x = dot(u_xlat5.zw, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat6.x = u_xlat1.x * 0.5 + u_xlat5.z;
					    u_xlat1.x = dot(u_xlat5.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat6.y = u_xlat1.x * 0.5 + u_xlat5.w;
					    u_xlat21.xy = u_xlat6.xy + vec2(0.5, 0.5);
					    u_xlat6 = u_xlat2.zwzw + vec4(0.0, 1.0, 1.0, 1.0);
					    u_xlat1.x = dot(u_xlat6.xy, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 0.5 + u_xlat6.x;
					    u_xlat1.x = dot(u_xlat6.yx, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.y = u_xlat1.x * 0.5 + u_xlat6.y;
					    u_xlat6.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat1.x = dot(u_xlat6.zw, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 0.5 + u_xlat6.z;
					    u_xlat1.x = dot(u_xlat6.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.y = u_xlat1.x * 0.5 + u_xlat6.w;
					    u_xlat22.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat2 = u_xlat2 + vec4(-1.0, 1.0, 1.0, -1.0);
					    u_xlat1.x = dot(u_xlat2.xy, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 0.5 + u_xlat2.x;
					    u_xlat1.x = dot(u_xlat2.yx, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.y = u_xlat1.x * 0.5 + u_xlat2.y;
					    u_xlat2.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat1.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 0.5 + u_xlat2.z;
					    u_xlat1.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.y = u_xlat1.x * 0.5 + u_xlat2.w;
					    u_xlat18.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat3.xy = u_xlat0.xy + (-u_xlat19.xy);
					    u_xlat1.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat3.xy = u_xlat0.xy + (-u_xlat4.xy);
					    u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb11 = u_xlat3.x<u_xlat1.x;
					    u_xlat19.x = min(u_xlat3.x, 10000.0);
					    u_xlat11 = (u_xlatb11) ? u_xlat1.x : u_xlat19.x;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat20.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat5.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat21.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat6.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat22.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat2.xy = u_xlat0.xy + (-u_xlat2.xy);
					    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlatb10 = u_xlat2.x<u_xlat1.x;
					    u_xlat3.x = min(u_xlat2.x, u_xlat11);
					    u_xlat10 = (u_xlatb10) ? u_xlat1.x : u_xlat3.x;
					    u_xlat1.x = min(u_xlat1.x, u_xlat2.x);
					    u_xlat0.xy = u_xlat0.xy + (-u_xlat18.xy);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlatb8 = u_xlat0.x<u_xlat1.x;
					    u_xlat2.x = min(u_xlat0.x, u_xlat10);
					    u_xlat8 = (u_xlatb8) ? u_xlat1.x : u_xlat2.x;
					    u_xlat0.x = min(u_xlat0.x, u_xlat1.x);
					    u_xlat8 = (-u_xlat8) + u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
					    u_xlat0.x = abs(u_xlat8) / u_xlat0.x;
					    u_xlat8 = vs_TEXCOORD0.y;
					    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
					    u_xlat1.x = u_xlat8 * 0.99000001;
					    u_xlat16.x = u_xlat0.x * _VoronoiMisc2.y;
					    u_xlat16.x = u_xlat16.x;
					    u_xlat16.x = clamp(u_xlat16.x, 0.0, 1.0);
					    u_xlat2 = texture(_GradientTex, u_xlat16.xy);
					    u_xlat2.xyz = u_xlat2.xyz * _GradientOverlayTint.xyz;
					    u_xlat0.x = (-_VoronoiMisc2.x) * u_xlat0.x + 1.0;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.z = log2(u_xlat1.x);
					    u_xlat0.xz = u_xlat0.xz * _VoronoiMisc.xw;
					    u_xlat16.x = exp2(u_xlat0.z);
					    u_xlat24 = (-_VoronoiMisc.y) + _VoronoiMisc.z;
					    u_xlat16.x = u_xlat16.x * u_xlat24 + _VoronoiMisc.y;
					    u_xlat0.x = u_xlat0.x * u_xlat16.x;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat16.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat3 = texture(_GrabTexture, u_xlat16.xy);
					    u_xlat26 = (-u_xlat0.x) + 1.0;
					    u_xlat27 = _Displacement / _ScreenParams.y;
					    u_xlat4.y = u_xlat26 * u_xlat27;
					    u_xlat4.x = float(0.0);
					    u_xlat20.y = float(0.0);
					    u_xlat16.xy = u_xlat16.xy + u_xlat4.xy;
					    u_xlat5 = texture(_GrabBlurTexture, u_xlat16.xy);
					    u_xlat8 = (-u_xlat8) * 0.99000001 + 1.0;
					    u_xlat16.x = u_xlat8 * u_xlat26;
					    u_xlat5.xyz = (-u_xlat3.xyz) + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat16.xxx * u_xlat5.xyz + u_xlat3.xyz;
					    u_xlat9.xyz = u_xlat1.yzw * vs_TEXCOORD4.xyz + vec3(_GradientIntensity);
					    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
					    u_xlat9.xyz = u_xlat2.xyz * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _VoronoiMisc2.w;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _VoronoiMisc2.z;
					    u_xlat16.x = log2(u_xlat8);
					    u_xlat16.x = u_xlat16.x * 10.0;
					    u_xlat16.x = exp2(u_xlat16.x);
					    u_xlat20.x = (-u_xlat0.x) * u_xlat16.x + u_xlat1.x;
					    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
					    u_xlat2 = texture(_GradientOverlayTex, u_xlat20.xy);
					    u_xlat0.xzw = u_xlat2.xyz * _GradientOverlayTint.xyz + u_xlat9.xyz;
					    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw;
					    u_xlat0.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_IntensityScale);
					    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
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
						float _IntensityScale;
						float _NumTilesU;
						float _NumTilesV;
						float _SpeedU;
						float _SpeedV;
						float _AnimIntensity;
						float _SpeedScroll;
						float _SpeedScale;
						vec4 _Randomization;
						vec4 _VoronoiMisc;
						vec4 _VoronoiMisc2;
						vec4 _GradientOverlayTint;
						float _GradientIntensity;
						float _Displacement;
						vec4 _HitInfos[9];
						vec4 unused_0_16[8];
						float _HitRadius;
						float _HitBrightness;
						float _PlayerProximityBrightness;
						vec4 unused_0_20;
						float _NoiseIntensity;
						float _NoiseScrollSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[5];
						vec4 _ScreenParams;
						vec4 unused_1_3[2];
					};
					uniform  sampler2D _HitTex;
					uniform  sampler2D _NoiseTex;
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _GrabBlurTexture;
					uniform  sampler2D _GradientOverlayTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat7;
					float u_xlat8;
					bool u_xlatb8;
					vec3 u_xlat9;
					float u_xlat10;
					bool u_xlatb10;
					float u_xlat11;
					bool u_xlatb11;
					vec2 u_xlat16;
					bool u_xlatb17;
					vec2 u_xlat18;
					vec2 u_xlat19;
					bool u_xlatb19;
					vec2 u_xlat20;
					vec2 u_xlat21;
					vec2 u_xlat22;
					float u_xlat24;
					int u_xlati24;
					bool u_xlatb24;
					float u_xlat26;
					float u_xlat27;
					void main()
					{
					    u_xlat0.y = float(100000.0);
					    u_xlat0.z = float(0.0);
					    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
					    {
					        u_xlatb1 = -1.0!=_HitInfos[u_xlati_loop_1].w;
					        u_xlat9.xyz = vs_TEXCOORD3.xyz + (-_HitInfos[u_xlati_loop_1].xyz);
					        u_xlat9.x = dot(u_xlat9.xyz, u_xlat9.xyz);
					        u_xlat9.x = sqrt(u_xlat9.x);
					        u_xlatb17 = u_xlat9.x<u_xlat0.y;
					        u_xlat2.y = (u_xlatb17) ? _HitInfos[u_xlati_loop_1].w : u_xlat0.z;
					        u_xlat2.x = min(u_xlat0.y, u_xlat9.x);
					        u_xlat0.yz = (bool(u_xlatb1)) ? u_xlat2.xy : u_xlat0.yz;
					    }
					    u_xlat8 = u_xlat0.y / _HitRadius;
					    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat8) + 1.0;
					    u_xlat0.xy = (-u_xlat0.xz) + vec2(1.0, 1.0);
					    u_xlat0 = texture(_HitTex, u_xlat0.xy);
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_PlayerProximityBrightness, _PlayerProximityBrightness, _PlayerProximityBrightness));
					    u_xlatb24 = -1.0!=_HitInfos[8].w;
					    if(u_xlatb24){
					        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_HitInfos[8].xyz);
					        u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat24 = sqrt(u_xlat24);
					        u_xlat24 = u_xlat24 / _HitRadius;
					        u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					        u_xlat2.x = (-u_xlat24) + 1.0;
					        u_xlat2.y = _HitInfos[8].w;
					        u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
					        u_xlat2 = texture(_HitTex, u_xlat2.xy);
					        u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_PlayerProximityBrightness, _PlayerProximityBrightness, _PlayerProximityBrightness)) + u_xlat2.xyz;
					    }
					    u_xlat0.y = _NoiseScrollSpeed * _Time.y;
					    u_xlat0.x = float(0.0);
					    u_xlat16.y = float(0.0);
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
					    u_xlat2 = texture(_NoiseTex, u_xlat0.xy);
					    u_xlat0.xy = vec2(_SpeedScroll, _SpeedV) * _Time.yy;
					    u_xlat3.xy = u_xlat0.xy * vec2(vec2(_SpeedScale, _SpeedScale));
					    u_xlat3.z = 0.0;
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(_NumTilesU, _NumTilesV) + u_xlat3.zx;
					    u_xlat1 = u_xlat1.xxyz * vec4(vec4(_HitBrightness, _HitBrightness, _HitBrightness, _HitBrightness));
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * _NoiseIntensity;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xy = u_xlat2.xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat2 = floor(u_xlat0.xyxy);
					    u_xlat1.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat3.x = _SpeedU * _Time.y;
					    u_xlat3.x = u_xlat3.x * _SpeedScale;
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat4.x = u_xlat1.x * 0.5 + u_xlat2.z;
					    u_xlat1.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat4.y = u_xlat1.x * 0.5 + u_xlat2.w;
					    u_xlat19.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat4 = u_xlat2.zwzw + vec4(-1.0, 0.0, 0.0, -1.0);
					    u_xlat1.x = dot(u_xlat4.xy, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat5.x = u_xlat1.x * 0.5 + u_xlat4.x;
					    u_xlat1.x = dot(u_xlat4.yx, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat5.y = u_xlat1.x * 0.5 + u_xlat4.y;
					    u_xlat4.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat1.x = dot(u_xlat4.zw, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat5.x = u_xlat1.x * 0.5 + u_xlat4.z;
					    u_xlat1.x = dot(u_xlat4.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat5.y = u_xlat1.x * 0.5 + u_xlat4.w;
					    u_xlat20.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat5 = u_xlat2.zwzw + vec4(-1.0, -1.0, 1.0, 0.0);
					    u_xlat1.x = dot(u_xlat5.xy, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat6.x = u_xlat1.x * 0.5 + u_xlat5.x;
					    u_xlat1.x = dot(u_xlat5.yx, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat6.y = u_xlat1.x * 0.5 + u_xlat5.y;
					    u_xlat5.xy = u_xlat6.xy + vec2(0.5, 0.5);
					    u_xlat1.x = dot(u_xlat5.zw, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat6.x = u_xlat1.x * 0.5 + u_xlat5.z;
					    u_xlat1.x = dot(u_xlat5.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat6.y = u_xlat1.x * 0.5 + u_xlat5.w;
					    u_xlat21.xy = u_xlat6.xy + vec2(0.5, 0.5);
					    u_xlat6 = u_xlat2.zwzw + vec4(0.0, 1.0, 1.0, 1.0);
					    u_xlat1.x = dot(u_xlat6.xy, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 0.5 + u_xlat6.x;
					    u_xlat1.x = dot(u_xlat6.yx, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.y = u_xlat1.x * 0.5 + u_xlat6.y;
					    u_xlat6.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat1.x = dot(u_xlat6.zw, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 0.5 + u_xlat6.z;
					    u_xlat1.x = dot(u_xlat6.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.y = u_xlat1.x * 0.5 + u_xlat6.w;
					    u_xlat22.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat2 = u_xlat2 + vec4(-1.0, 1.0, 1.0, -1.0);
					    u_xlat1.x = dot(u_xlat2.xy, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 0.5 + u_xlat2.x;
					    u_xlat1.x = dot(u_xlat2.yx, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.y = u_xlat1.x * 0.5 + u_xlat2.y;
					    u_xlat2.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat1.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 0.5 + u_xlat2.z;
					    u_xlat1.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.y = u_xlat1.x * 0.5 + u_xlat2.w;
					    u_xlat18.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat3.xy = u_xlat0.xy + (-u_xlat19.xy);
					    u_xlat1.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat3.xy = u_xlat0.xy + (-u_xlat4.xy);
					    u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb11 = u_xlat3.x<u_xlat1.x;
					    u_xlat19.x = min(u_xlat3.x, 10000.0);
					    u_xlat11 = (u_xlatb11) ? u_xlat1.x : u_xlat19.x;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat20.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat5.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat21.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat6.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat22.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat2.xy = u_xlat0.xy + (-u_xlat2.xy);
					    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlatb10 = u_xlat2.x<u_xlat1.x;
					    u_xlat3.x = min(u_xlat2.x, u_xlat11);
					    u_xlat10 = (u_xlatb10) ? u_xlat1.x : u_xlat3.x;
					    u_xlat1.x = min(u_xlat1.x, u_xlat2.x);
					    u_xlat0.xy = u_xlat0.xy + (-u_xlat18.xy);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlatb8 = u_xlat0.x<u_xlat1.x;
					    u_xlat2.x = min(u_xlat0.x, u_xlat10);
					    u_xlat8 = (u_xlatb8) ? u_xlat1.x : u_xlat2.x;
					    u_xlat0.x = min(u_xlat0.x, u_xlat1.x);
					    u_xlat8 = (-u_xlat8) + u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
					    u_xlat0.x = abs(u_xlat8) / u_xlat0.x;
					    u_xlat8 = vs_TEXCOORD0.y;
					    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
					    u_xlat1.x = u_xlat8 * 0.99000001;
					    u_xlat16.x = u_xlat0.x * _VoronoiMisc2.y;
					    u_xlat16.x = u_xlat16.x;
					    u_xlat16.x = clamp(u_xlat16.x, 0.0, 1.0);
					    u_xlat2 = texture(_GradientTex, u_xlat16.xy);
					    u_xlat2.xyz = u_xlat2.xyz * _GradientOverlayTint.xyz;
					    u_xlat0.x = (-_VoronoiMisc2.x) * u_xlat0.x + 1.0;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.z = log2(u_xlat1.x);
					    u_xlat0.xz = u_xlat0.xz * _VoronoiMisc.xw;
					    u_xlat16.x = exp2(u_xlat0.z);
					    u_xlat24 = (-_VoronoiMisc.y) + _VoronoiMisc.z;
					    u_xlat16.x = u_xlat16.x * u_xlat24 + _VoronoiMisc.y;
					    u_xlat0.x = u_xlat0.x * u_xlat16.x;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat16.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat3 = texture(_GrabTexture, u_xlat16.xy);
					    u_xlat26 = (-u_xlat0.x) + 1.0;
					    u_xlat27 = _Displacement / _ScreenParams.y;
					    u_xlat4.y = u_xlat26 * u_xlat27;
					    u_xlat4.x = float(0.0);
					    u_xlat20.y = float(0.0);
					    u_xlat16.xy = u_xlat16.xy + u_xlat4.xy;
					    u_xlat5 = texture(_GrabBlurTexture, u_xlat16.xy);
					    u_xlat8 = (-u_xlat8) * 0.99000001 + 1.0;
					    u_xlat16.x = u_xlat8 * u_xlat26;
					    u_xlat5.xyz = (-u_xlat3.xyz) + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat16.xxx * u_xlat5.xyz + u_xlat3.xyz;
					    u_xlat9.xyz = u_xlat1.yzw * vs_TEXCOORD4.xyz + vec3(_GradientIntensity);
					    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
					    u_xlat9.xyz = u_xlat2.xyz * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _VoronoiMisc2.w;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _VoronoiMisc2.z;
					    u_xlat16.x = log2(u_xlat8);
					    u_xlat16.x = u_xlat16.x * 10.0;
					    u_xlat16.x = exp2(u_xlat16.x);
					    u_xlat20.x = (-u_xlat0.x) * u_xlat16.x + u_xlat1.x;
					    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
					    u_xlat2 = texture(_GradientOverlayTex, u_xlat20.xy);
					    u_xlat0.xzw = u_xlat2.xyz * _GradientOverlayTint.xyz + u_xlat9.xyz;
					    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw;
					    u_xlat0.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_IntensityScale);
					    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
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
						float _IntensityScale;
						float _NumTilesU;
						float _NumTilesV;
						float _SpeedU;
						float _SpeedV;
						float _AnimIntensity;
						float _SpeedScroll;
						float _SpeedScale;
						vec4 _Randomization;
						vec4 _VoronoiMisc;
						vec4 _VoronoiMisc2;
						vec4 _GradientOverlayTint;
						float _GradientIntensity;
						float _Displacement;
						vec4 _HitInfos[9];
						vec4 unused_0_16[8];
						float _HitRadius;
						float _HitBrightness;
						float _PlayerProximityBrightness;
						vec4 unused_0_20;
						float _NoiseIntensity;
						float _NoiseScrollSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[5];
						vec4 _ScreenParams;
						vec4 unused_1_3[2];
					};
					uniform  sampler2D _HitTex;
					uniform  sampler2D _NoiseTex;
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _GrabTexture;
					uniform  sampler2D _GrabBlurTexture;
					uniform  sampler2D _GradientOverlayTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat7;
					float u_xlat8;
					bool u_xlatb8;
					vec3 u_xlat9;
					float u_xlat10;
					bool u_xlatb10;
					float u_xlat11;
					bool u_xlatb11;
					vec2 u_xlat16;
					bool u_xlatb17;
					vec2 u_xlat18;
					vec2 u_xlat19;
					bool u_xlatb19;
					vec2 u_xlat20;
					vec2 u_xlat21;
					vec2 u_xlat22;
					float u_xlat24;
					int u_xlati24;
					bool u_xlatb24;
					float u_xlat26;
					float u_xlat27;
					void main()
					{
					    u_xlat0.y = float(100000.0);
					    u_xlat0.z = float(0.0);
					    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<8 ; u_xlati_loop_1++)
					    {
					        u_xlatb1 = -1.0!=_HitInfos[u_xlati_loop_1].w;
					        u_xlat9.xyz = vs_TEXCOORD3.xyz + (-_HitInfos[u_xlati_loop_1].xyz);
					        u_xlat9.x = dot(u_xlat9.xyz, u_xlat9.xyz);
					        u_xlat9.x = sqrt(u_xlat9.x);
					        u_xlatb17 = u_xlat9.x<u_xlat0.y;
					        u_xlat2.y = (u_xlatb17) ? _HitInfos[u_xlati_loop_1].w : u_xlat0.z;
					        u_xlat2.x = min(u_xlat0.y, u_xlat9.x);
					        u_xlat0.yz = (bool(u_xlatb1)) ? u_xlat2.xy : u_xlat0.yz;
					    }
					    u_xlat8 = u_xlat0.y / _HitRadius;
					    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat8) + 1.0;
					    u_xlat0.xy = (-u_xlat0.xz) + vec2(1.0, 1.0);
					    u_xlat0 = texture(_HitTex, u_xlat0.xy);
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_PlayerProximityBrightness, _PlayerProximityBrightness, _PlayerProximityBrightness));
					    u_xlatb24 = -1.0!=_HitInfos[8].w;
					    if(u_xlatb24){
					        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_HitInfos[8].xyz);
					        u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat24 = sqrt(u_xlat24);
					        u_xlat24 = u_xlat24 / _HitRadius;
					        u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					        u_xlat2.x = (-u_xlat24) + 1.0;
					        u_xlat2.y = _HitInfos[8].w;
					        u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
					        u_xlat2 = texture(_HitTex, u_xlat2.xy);
					        u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_PlayerProximityBrightness, _PlayerProximityBrightness, _PlayerProximityBrightness)) + u_xlat2.xyz;
					    }
					    u_xlat0.y = _NoiseScrollSpeed * _Time.y;
					    u_xlat0.x = float(0.0);
					    u_xlat16.y = float(0.0);
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
					    u_xlat2 = texture(_NoiseTex, u_xlat0.xy);
					    u_xlat0.xy = vec2(_SpeedScroll, _SpeedV) * _Time.yy;
					    u_xlat3.xy = u_xlat0.xy * vec2(vec2(_SpeedScale, _SpeedScale));
					    u_xlat3.z = 0.0;
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(_NumTilesU, _NumTilesV) + u_xlat3.zx;
					    u_xlat1 = u_xlat1.xxyz * vec4(vec4(_HitBrightness, _HitBrightness, _HitBrightness, _HitBrightness));
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * _NoiseIntensity;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xy = u_xlat2.xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat2 = floor(u_xlat0.xyxy);
					    u_xlat1.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat3.x = _SpeedU * _Time.y;
					    u_xlat3.x = u_xlat3.x * _SpeedScale;
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat4.x = u_xlat1.x * 0.5 + u_xlat2.z;
					    u_xlat1.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat4.y = u_xlat1.x * 0.5 + u_xlat2.w;
					    u_xlat19.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat4 = u_xlat2.zwzw + vec4(-1.0, 0.0, 0.0, -1.0);
					    u_xlat1.x = dot(u_xlat4.xy, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat5.x = u_xlat1.x * 0.5 + u_xlat4.x;
					    u_xlat1.x = dot(u_xlat4.yx, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat5.y = u_xlat1.x * 0.5 + u_xlat4.y;
					    u_xlat4.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat1.x = dot(u_xlat4.zw, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat5.x = u_xlat1.x * 0.5 + u_xlat4.z;
					    u_xlat1.x = dot(u_xlat4.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat5.y = u_xlat1.x * 0.5 + u_xlat4.w;
					    u_xlat20.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat5 = u_xlat2.zwzw + vec4(-1.0, -1.0, 1.0, 0.0);
					    u_xlat1.x = dot(u_xlat5.xy, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat6.x = u_xlat1.x * 0.5 + u_xlat5.x;
					    u_xlat1.x = dot(u_xlat5.yx, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat6.y = u_xlat1.x * 0.5 + u_xlat5.y;
					    u_xlat5.xy = u_xlat6.xy + vec2(0.5, 0.5);
					    u_xlat1.x = dot(u_xlat5.zw, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat6.x = u_xlat1.x * 0.5 + u_xlat5.z;
					    u_xlat1.x = dot(u_xlat5.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat6.y = u_xlat1.x * 0.5 + u_xlat5.w;
					    u_xlat21.xy = u_xlat6.xy + vec2(0.5, 0.5);
					    u_xlat6 = u_xlat2.zwzw + vec4(0.0, 1.0, 1.0, 1.0);
					    u_xlat1.x = dot(u_xlat6.xy, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 0.5 + u_xlat6.x;
					    u_xlat1.x = dot(u_xlat6.yx, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.y = u_xlat1.x * 0.5 + u_xlat6.y;
					    u_xlat6.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat1.x = dot(u_xlat6.zw, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 0.5 + u_xlat6.z;
					    u_xlat1.x = dot(u_xlat6.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.y = u_xlat1.x * 0.5 + u_xlat6.w;
					    u_xlat22.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat2 = u_xlat2 + vec4(-1.0, 1.0, 1.0, -1.0);
					    u_xlat1.x = dot(u_xlat2.xy, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 0.5 + u_xlat2.x;
					    u_xlat1.x = dot(u_xlat2.yx, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.y = u_xlat1.x * 0.5 + u_xlat2.y;
					    u_xlat2.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat1.x = dot(u_xlat2.zw, _Randomization.xy);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.x;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.x = u_xlat1.x * 0.5 + u_xlat2.z;
					    u_xlat1.x = dot(u_xlat2.wz, _Randomization.zw);
					    u_xlat1.x = u_xlat1.x * _AnimIntensity + u_xlat3.y;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7.y = u_xlat1.x * 0.5 + u_xlat2.w;
					    u_xlat18.xy = u_xlat7.xy + vec2(0.5, 0.5);
					    u_xlat3.xy = u_xlat0.xy + (-u_xlat19.xy);
					    u_xlat1.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat3.xy = u_xlat0.xy + (-u_xlat4.xy);
					    u_xlat3.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb11 = u_xlat3.x<u_xlat1.x;
					    u_xlat19.x = min(u_xlat3.x, 10000.0);
					    u_xlat11 = (u_xlatb11) ? u_xlat1.x : u_xlat19.x;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat20.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat5.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat21.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat6.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat3.xz = u_xlat0.xy + (-u_xlat22.xy);
					    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlatb19 = u_xlat3.x<u_xlat1.x;
					    u_xlat11 = min(u_xlat3.x, u_xlat11);
					    u_xlat11 = (u_xlatb19) ? u_xlat1.x : u_xlat11;
					    u_xlat1.x = min(u_xlat1.x, u_xlat3.x);
					    u_xlat2.xy = u_xlat0.xy + (-u_xlat2.xy);
					    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlatb10 = u_xlat2.x<u_xlat1.x;
					    u_xlat3.x = min(u_xlat2.x, u_xlat11);
					    u_xlat10 = (u_xlatb10) ? u_xlat1.x : u_xlat3.x;
					    u_xlat1.x = min(u_xlat1.x, u_xlat2.x);
					    u_xlat0.xy = u_xlat0.xy + (-u_xlat18.xy);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlatb8 = u_xlat0.x<u_xlat1.x;
					    u_xlat2.x = min(u_xlat0.x, u_xlat10);
					    u_xlat8 = (u_xlatb8) ? u_xlat1.x : u_xlat2.x;
					    u_xlat0.x = min(u_xlat0.x, u_xlat1.x);
					    u_xlat8 = (-u_xlat8) + u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
					    u_xlat0.x = abs(u_xlat8) / u_xlat0.x;
					    u_xlat8 = vs_TEXCOORD0.y;
					    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
					    u_xlat1.x = u_xlat8 * 0.99000001;
					    u_xlat16.x = u_xlat0.x * _VoronoiMisc2.y;
					    u_xlat16.x = u_xlat16.x;
					    u_xlat16.x = clamp(u_xlat16.x, 0.0, 1.0);
					    u_xlat2 = texture(_GradientTex, u_xlat16.xy);
					    u_xlat2.xyz = u_xlat2.xyz * _GradientOverlayTint.xyz;
					    u_xlat0.x = (-_VoronoiMisc2.x) * u_xlat0.x + 1.0;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.z = log2(u_xlat1.x);
					    u_xlat0.xz = u_xlat0.xz * _VoronoiMisc.xw;
					    u_xlat16.x = exp2(u_xlat0.z);
					    u_xlat24 = (-_VoronoiMisc.y) + _VoronoiMisc.z;
					    u_xlat16.x = u_xlat16.x * u_xlat24 + _VoronoiMisc.y;
					    u_xlat0.x = u_xlat0.x * u_xlat16.x;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat16.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat3 = texture(_GrabTexture, u_xlat16.xy);
					    u_xlat26 = (-u_xlat0.x) + 1.0;
					    u_xlat27 = _Displacement / _ScreenParams.y;
					    u_xlat4.y = u_xlat26 * u_xlat27;
					    u_xlat4.x = float(0.0);
					    u_xlat20.y = float(0.0);
					    u_xlat16.xy = u_xlat16.xy + u_xlat4.xy;
					    u_xlat5 = texture(_GrabBlurTexture, u_xlat16.xy);
					    u_xlat8 = (-u_xlat8) * 0.99000001 + 1.0;
					    u_xlat16.x = u_xlat8 * u_xlat26;
					    u_xlat5.xyz = (-u_xlat3.xyz) + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat16.xxx * u_xlat5.xyz + u_xlat3.xyz;
					    u_xlat9.xyz = u_xlat1.yzw * vs_TEXCOORD4.xyz + vec3(_GradientIntensity);
					    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
					    u_xlat9.xyz = u_xlat2.xyz * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _VoronoiMisc2.w;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _VoronoiMisc2.z;
					    u_xlat16.x = log2(u_xlat8);
					    u_xlat16.x = u_xlat16.x * 10.0;
					    u_xlat16.x = exp2(u_xlat16.x);
					    u_xlat20.x = (-u_xlat0.x) * u_xlat16.x + u_xlat1.x;
					    u_xlat20.x = clamp(u_xlat20.x, 0.0, 1.0);
					    u_xlat2 = texture(_GradientOverlayTex, u_xlat20.xy);
					    u_xlat0.xzw = u_xlat2.xyz * _GradientOverlayTint.xyz + u_xlat9.xyz;
					    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw;
					    u_xlat0.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_IntensityScale);
					    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}