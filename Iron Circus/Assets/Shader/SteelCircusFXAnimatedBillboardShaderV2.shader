Shader "SteelCircus/FX/AnimatedBillboardShaderV2" {
	Properties {
		_Color ("Color", Vector) = (1,1,1,1)
		_RandomTint ("Random Tint", Vector) = (1,1,1,1)
		[NoScaleOffset] _MainTex ("Variation 1 - Albedo (RGB)", 2D) = "white" {}
		_GIScale ("Global Illumination Scale", Float) = 1
		[NoScaleOffset] _RGBNormalMap ("Variation 1 - Normal Map (Texture settings: default type, no srgb)", 2D) = "white" {}
		[NoScaleOffset] _MainTex2 ("Variation 2 - Albedo (RGB)", 2D) = "white" {}
		[NoScaleOffset] _RGBNormalMap2 ("Variation 2 - Normal Map (Texture settings: default type, no srgb)", 2D) = "white" {}
		[NoScaleOffset] _MainTex3 ("Variation 3 - Albedo (RGB)", 2D) = "white" {}
		[NoScaleOffset] _RGBNormalMap3 ("Variation 3 - Normal Map (Texture settings: default type, no srgb)", 2D) = "white" {}
		_Scale ("Scale", Float) = 1
		_Glossiness ("Smoothness", Range(0, 1)) = 0.5
		_Cutoff ("Alpha Cutoff", Float) = 0.5
		[NoScaleOffset] _RandTex ("Random Values (1D)", 2D) = "white" {}
		_NumTiles ("Number of Tiles (X, int)", Float) = 8
		_NumFrames ("Number of Frames (Y, int)", Float) = 8
		_Speed ("Animation speed (fps)", Float) = 30
	}
	SubShader {
		LOD 200
		Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
		Pass {
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
			Cull Off
			GpuProgramID 63669
			Program "vp" {
				SubProgram "d3d11 hw_tier00 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform  sampler2D _RandTex;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_NORMAL0;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = float(uint(gl_VertexID));
					    u_xlat0.x = u_xlat0.x * 0.001953125;
					    u_xlat0.y = 0.0;
					    vs_TEXCOORD1 = textureLod(_RandTex, u_xlat0.xy, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform  sampler2D _RandTex;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_NORMAL0;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = float(uint(gl_VertexID));
					    u_xlat0.x = u_xlat0.x * 0.001953125;
					    u_xlat0.y = 0.0;
					    vs_TEXCOORD1 = textureLod(_RandTex, u_xlat0.xy, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform  sampler2D _RandTex;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_NORMAL0;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position = in_POSITION0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = float(uint(gl_VertexID));
					    u_xlat0.x = u_xlat0.x * 0.001953125;
					    u_xlat0.y = 0.0;
					    vs_TEXCOORD1 = textureLod(_RandTex, u_xlat0.xy, 0.0);
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
						vec4 _LightColor0;
						vec4 unused_0_2[2];
						vec4 _Color;
						vec4 _RandomTint;
						float _Cutoff;
						float _NumTiles;
						float _NumFrames;
						float _Speed;
						float _GIScale;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RGBNormalMap;
					uniform  sampler2D _MainTex2;
					uniform  sampler2D _RGBNormalMap2;
					uniform  sampler2D _MainTex3;
					uniform  sampler2D _RGBNormalMap3;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb8;
					bool u_xlatb12;
					float u_xlat13;
					bool u_xlatb13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w * 0.5 + 0.5;
					    u_xlat0.x = u_xlat0.x * _NumTiles;
					    u_xlat0.x = roundEven(u_xlat0.x);
					    u_xlat6.x = _Speed * _Time.y;
					    u_xlat6.x = vs_TEXCOORD1.y * _NumFrames + u_xlat6.x;
					    u_xlat6.x = u_xlat6.x / _NumFrames;
					    u_xlatb12 = u_xlat6.x>=(-u_xlat6.x);
					    u_xlat6.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (u_xlatb12) ? u_xlat6.x : (-u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _NumFrames;
					    u_xlat0.z = floor(u_xlat6.x);
					    u_xlat0.w = ceil(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_NumTiles, _NumFrames);
					    u_xlat2.xyz = u_xlat0.xzw / vec3(_NumTiles, _NumFrames, _NumFrames);
					    u_xlat0.xz = u_xlat1.xy + u_xlat2.xy;
					    u_xlatb13 = vs_TEXCOORD1.x>=(-vs_TEXCOORD1.x);
					    u_xlat19 = fract(abs(vs_TEXCOORD1.x));
					    u_xlat13 = (u_xlatb13) ? u_xlat19 : (-u_xlat19);
					    u_xlatb19 = u_xlat13<0.300000012;
					    if(u_xlatb19){
					        u_xlat3 = texture(_MainTex, u_xlat0.xz);
					        u_xlat4 = texture(_RGBNormalMap, u_xlat0.xz);
					    } else {
					        u_xlatb8 = u_xlat13<0.600000024;
					        if(u_xlatb8){
					            u_xlat3 = texture(_MainTex2, u_xlat0.xz);
					            u_xlat4 = texture(_RGBNormalMap2, u_xlat0.xz);
					        } else {
					            u_xlat3 = texture(_MainTex3, u_xlat0.xz);
					            u_xlat4 = texture(_RGBNormalMap3, u_xlat0.xz);
					        }
					    }
					    u_xlat0.xz = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.ww * u_xlat0.xz;
					    u_xlat0.x = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat4.z = sqrt(u_xlat0.x);
					    u_xlat0.xz = u_xlat1.xy + u_xlat2.xz;
					    if(u_xlatb19){
					        u_xlat2 = texture(_MainTex, u_xlat0.xz);
					        u_xlat5 = texture(_RGBNormalMap, u_xlat0.xz);
					    } else {
					        u_xlatb18 = u_xlat13<0.600000024;
					        if(u_xlatb18){
					            u_xlat2 = texture(_MainTex2, u_xlat0.xz);
					            u_xlat5 = texture(_RGBNormalMap2, u_xlat0.xz);
					        } else {
					            u_xlat2 = texture(_MainTex3, u_xlat0.xz);
					            u_xlat5 = texture(_RGBNormalMap3, u_xlat0.xz);
					        }
					    }
					    u_xlat0.xz = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1.xy = u_xlat5.ww * u_xlat0.xz;
					    u_xlat0.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat0.x);
					    u_xlat2 = (-u_xlat3) + u_xlat2;
					    u_xlat3 = u_xlat6.xxxx * u_xlat2 + u_xlat3;
					    u_xlat0.x = u_xlat6.x + u_xlat2.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.xyz = (-u_xlat4.xyz) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + u_xlat4.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat18 = max(u_xlat18, 9.99999975e-06);
					    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat18);
					    u_xlat1.x = dot(unity_MatrixV[0].xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(unity_MatrixV[1].xyz, u_xlat0.xyz);
					    u_xlat1.z = dot(unity_MatrixV[2].xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = max(u_xlat0.x, 9.99999975e-06);
					    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xxx;
					    u_xlat0.w = u_xlat0.y + unity_MatrixVP[1].w;
					    u_xlat6.x = dot(u_xlat0.xzw, u_xlat0.xzw);
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat6.x = max(u_xlat6.x, 9.99999975e-06);
					    u_xlat0.xyz = u_xlat0.xwz / u_xlat6.xxx;
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * _WorldSpaceLightPos0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat4 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat5.x = dot(unity_SHBr, u_xlat4);
					    u_xlat5.y = dot(unity_SHBg, u_xlat4);
					    u_xlat5.z = dot(unity_SHBb, u_xlat4);
					    u_xlat6.x = u_xlat0.y * u_xlat0.y;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x + (-u_xlat6.x);
					    u_xlat0.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_GIScale, _GIScale, _GIScale));
					    u_xlat0.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * _RandomTint.xyz + (-u_xlat0.xyz);
					    SV_Target0.xyz = vs_TEXCOORD1.zzz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
					    u_xlat0.x = u_xlat3.w + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0.w = u_xlat3.w;
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
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
						vec4 _LightColor0;
						vec4 unused_0_2[2];
						vec4 _Color;
						vec4 _RandomTint;
						float _Cutoff;
						float _NumTiles;
						float _NumFrames;
						float _Speed;
						float _GIScale;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RGBNormalMap;
					uniform  sampler2D _MainTex2;
					uniform  sampler2D _RGBNormalMap2;
					uniform  sampler2D _MainTex3;
					uniform  sampler2D _RGBNormalMap3;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb8;
					bool u_xlatb12;
					float u_xlat13;
					bool u_xlatb13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w * 0.5 + 0.5;
					    u_xlat0.x = u_xlat0.x * _NumTiles;
					    u_xlat0.x = roundEven(u_xlat0.x);
					    u_xlat6.x = _Speed * _Time.y;
					    u_xlat6.x = vs_TEXCOORD1.y * _NumFrames + u_xlat6.x;
					    u_xlat6.x = u_xlat6.x / _NumFrames;
					    u_xlatb12 = u_xlat6.x>=(-u_xlat6.x);
					    u_xlat6.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (u_xlatb12) ? u_xlat6.x : (-u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _NumFrames;
					    u_xlat0.z = floor(u_xlat6.x);
					    u_xlat0.w = ceil(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_NumTiles, _NumFrames);
					    u_xlat2.xyz = u_xlat0.xzw / vec3(_NumTiles, _NumFrames, _NumFrames);
					    u_xlat0.xz = u_xlat1.xy + u_xlat2.xy;
					    u_xlatb13 = vs_TEXCOORD1.x>=(-vs_TEXCOORD1.x);
					    u_xlat19 = fract(abs(vs_TEXCOORD1.x));
					    u_xlat13 = (u_xlatb13) ? u_xlat19 : (-u_xlat19);
					    u_xlatb19 = u_xlat13<0.300000012;
					    if(u_xlatb19){
					        u_xlat3 = texture(_MainTex, u_xlat0.xz);
					        u_xlat4 = texture(_RGBNormalMap, u_xlat0.xz);
					    } else {
					        u_xlatb8 = u_xlat13<0.600000024;
					        if(u_xlatb8){
					            u_xlat3 = texture(_MainTex2, u_xlat0.xz);
					            u_xlat4 = texture(_RGBNormalMap2, u_xlat0.xz);
					        } else {
					            u_xlat3 = texture(_MainTex3, u_xlat0.xz);
					            u_xlat4 = texture(_RGBNormalMap3, u_xlat0.xz);
					        }
					    }
					    u_xlat0.xz = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.ww * u_xlat0.xz;
					    u_xlat0.x = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat4.z = sqrt(u_xlat0.x);
					    u_xlat0.xz = u_xlat1.xy + u_xlat2.xz;
					    if(u_xlatb19){
					        u_xlat2 = texture(_MainTex, u_xlat0.xz);
					        u_xlat5 = texture(_RGBNormalMap, u_xlat0.xz);
					    } else {
					        u_xlatb18 = u_xlat13<0.600000024;
					        if(u_xlatb18){
					            u_xlat2 = texture(_MainTex2, u_xlat0.xz);
					            u_xlat5 = texture(_RGBNormalMap2, u_xlat0.xz);
					        } else {
					            u_xlat2 = texture(_MainTex3, u_xlat0.xz);
					            u_xlat5 = texture(_RGBNormalMap3, u_xlat0.xz);
					        }
					    }
					    u_xlat0.xz = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1.xy = u_xlat5.ww * u_xlat0.xz;
					    u_xlat0.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat0.x);
					    u_xlat2 = (-u_xlat3) + u_xlat2;
					    u_xlat3 = u_xlat6.xxxx * u_xlat2 + u_xlat3;
					    u_xlat0.x = u_xlat6.x + u_xlat2.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.xyz = (-u_xlat4.xyz) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + u_xlat4.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat18 = max(u_xlat18, 9.99999975e-06);
					    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat18);
					    u_xlat1.x = dot(unity_MatrixV[0].xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(unity_MatrixV[1].xyz, u_xlat0.xyz);
					    u_xlat1.z = dot(unity_MatrixV[2].xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = max(u_xlat0.x, 9.99999975e-06);
					    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xxx;
					    u_xlat0.w = u_xlat0.y + unity_MatrixVP[1].w;
					    u_xlat6.x = dot(u_xlat0.xzw, u_xlat0.xzw);
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat6.x = max(u_xlat6.x, 9.99999975e-06);
					    u_xlat0.xyz = u_xlat0.xwz / u_xlat6.xxx;
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * _WorldSpaceLightPos0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat4 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat5.x = dot(unity_SHBr, u_xlat4);
					    u_xlat5.y = dot(unity_SHBg, u_xlat4);
					    u_xlat5.z = dot(unity_SHBb, u_xlat4);
					    u_xlat6.x = u_xlat0.y * u_xlat0.y;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x + (-u_xlat6.x);
					    u_xlat0.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_GIScale, _GIScale, _GIScale));
					    u_xlat0.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * _RandomTint.xyz + (-u_xlat0.xyz);
					    SV_Target0.xyz = vs_TEXCOORD1.zzz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
					    u_xlat0.x = u_xlat3.w + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0.w = u_xlat3.w;
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
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
						vec4 _LightColor0;
						vec4 unused_0_2[2];
						vec4 _Color;
						vec4 _RandomTint;
						float _Cutoff;
						float _NumTiles;
						float _NumFrames;
						float _Speed;
						float _GIScale;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RGBNormalMap;
					uniform  sampler2D _MainTex2;
					uniform  sampler2D _RGBNormalMap2;
					uniform  sampler2D _MainTex3;
					uniform  sampler2D _RGBNormalMap3;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb8;
					bool u_xlatb12;
					float u_xlat13;
					bool u_xlatb13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w * 0.5 + 0.5;
					    u_xlat0.x = u_xlat0.x * _NumTiles;
					    u_xlat0.x = roundEven(u_xlat0.x);
					    u_xlat6.x = _Speed * _Time.y;
					    u_xlat6.x = vs_TEXCOORD1.y * _NumFrames + u_xlat6.x;
					    u_xlat6.x = u_xlat6.x / _NumFrames;
					    u_xlatb12 = u_xlat6.x>=(-u_xlat6.x);
					    u_xlat6.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (u_xlatb12) ? u_xlat6.x : (-u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * _NumFrames;
					    u_xlat0.z = floor(u_xlat6.x);
					    u_xlat0.w = ceil(u_xlat6.x);
					    u_xlat6.x = fract(u_xlat6.x);
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_NumTiles, _NumFrames);
					    u_xlat2.xyz = u_xlat0.xzw / vec3(_NumTiles, _NumFrames, _NumFrames);
					    u_xlat0.xz = u_xlat1.xy + u_xlat2.xy;
					    u_xlatb13 = vs_TEXCOORD1.x>=(-vs_TEXCOORD1.x);
					    u_xlat19 = fract(abs(vs_TEXCOORD1.x));
					    u_xlat13 = (u_xlatb13) ? u_xlat19 : (-u_xlat19);
					    u_xlatb19 = u_xlat13<0.300000012;
					    if(u_xlatb19){
					        u_xlat3 = texture(_MainTex, u_xlat0.xz);
					        u_xlat4 = texture(_RGBNormalMap, u_xlat0.xz);
					    } else {
					        u_xlatb8 = u_xlat13<0.600000024;
					        if(u_xlatb8){
					            u_xlat3 = texture(_MainTex2, u_xlat0.xz);
					            u_xlat4 = texture(_RGBNormalMap2, u_xlat0.xz);
					        } else {
					            u_xlat3 = texture(_MainTex3, u_xlat0.xz);
					            u_xlat4 = texture(_RGBNormalMap3, u_xlat0.xz);
					        }
					    }
					    u_xlat0.xz = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.ww * u_xlat0.xz;
					    u_xlat0.x = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat4.z = sqrt(u_xlat0.x);
					    u_xlat0.xz = u_xlat1.xy + u_xlat2.xz;
					    if(u_xlatb19){
					        u_xlat2 = texture(_MainTex, u_xlat0.xz);
					        u_xlat5 = texture(_RGBNormalMap, u_xlat0.xz);
					    } else {
					        u_xlatb18 = u_xlat13<0.600000024;
					        if(u_xlatb18){
					            u_xlat2 = texture(_MainTex2, u_xlat0.xz);
					            u_xlat5 = texture(_RGBNormalMap2, u_xlat0.xz);
					        } else {
					            u_xlat2 = texture(_MainTex3, u_xlat0.xz);
					            u_xlat5 = texture(_RGBNormalMap3, u_xlat0.xz);
					        }
					    }
					    u_xlat0.xz = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1.xy = u_xlat5.ww * u_xlat0.xz;
					    u_xlat0.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat0.x);
					    u_xlat2 = (-u_xlat3) + u_xlat2;
					    u_xlat3 = u_xlat6.xxxx * u_xlat2 + u_xlat3;
					    u_xlat0.x = u_xlat6.x + u_xlat2.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.xyz = (-u_xlat4.xyz) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz + u_xlat4.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = sqrt(u_xlat18);
					    u_xlat18 = max(u_xlat18, 9.99999975e-06);
					    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat18);
					    u_xlat1.x = dot(unity_MatrixV[0].xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(unity_MatrixV[1].xyz, u_xlat0.xyz);
					    u_xlat1.z = dot(unity_MatrixV[2].xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = max(u_xlat0.x, 9.99999975e-06);
					    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xxx;
					    u_xlat0.w = u_xlat0.y + unity_MatrixVP[1].w;
					    u_xlat6.x = dot(u_xlat0.xzw, u_xlat0.xzw);
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat6.x = max(u_xlat6.x, 9.99999975e-06);
					    u_xlat0.xyz = u_xlat0.xwz / u_xlat6.xxx;
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * _WorldSpaceLightPos0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat4 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat5.x = dot(unity_SHBr, u_xlat4);
					    u_xlat5.y = dot(unity_SHBg, u_xlat4);
					    u_xlat5.z = dot(unity_SHBb, u_xlat4);
					    u_xlat6.x = u_xlat0.y * u_xlat0.y;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x + (-u_xlat6.x);
					    u_xlat0.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_GIScale, _GIScale, _GIScale));
					    u_xlat0.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * _RandomTint.xyz + (-u_xlat0.xyz);
					    SV_Target0.xyz = vs_TEXCOORD1.zzz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
					    u_xlat0.x = u_xlat3.w + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0.w = u_xlat3.w;
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
					    return;
					}"
				}
			}
			Program "gp" {
				SubProgram "d3d11 hw_tier00 " {
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[8];
						float _Scale;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4;
						vec4 unity_OrthoParams;
					};
					layout(std140) uniform UnityPerCameraRare {
						vec4 unused_2_0[6];
						mat4x4 unity_CameraProjection;
						vec4 unused_2_2[12];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_NORMAL0 [1];
					in  vec4 vs_COLOR0 [1];
					in  vec4 vs_TEXCOORD1 [1];
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat5;
					bool u_xlatb5;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat9;
					bool u_xlatb9;
					bool u_xlatb11;
					float u_xlat13;
					bool u_xlatb13;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec4 gs_COLOR0;
					out vec4 gs_TEXCOORD1;
					layout(max_vertices = 4) out;
					void main()
					{
					    u_xlat0 = unity_ObjectToWorld[1] * gl_in[0].gl_Position.yyyy;
					    u_xlat0 = unity_ObjectToWorld[0] * gl_in[0].gl_Position.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * gl_in[0].gl_Position.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat1.x = u_xlat0.w * _ScreenParams.y;
					    u_xlat5.x = _ScreenParams.x * unity_OrthoParams.y;
					    u_xlat1.x = u_xlat1.x / u_xlat5.x;
					    u_xlat1.x = u_xlat1.x + (-unity_CameraProjection[0].x);
					    u_xlat1.x = unity_OrthoParams.w * u_xlat1.x + unity_CameraProjection[0].x;
					    u_xlat5.x = u_xlat1.x * _Scale;
					    u_xlat2 = (-u_xlat5.xxxx) * vec4(0.5, 0.0, 0.0, 0.0) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * vec4(0.5, 0.0, 0.0, 0.0) + u_xlat0;
					    gl_Position = u_xlat2;
					    gs_NORMAL0.xyz = vs_NORMAL0[0].xyz;
					    gs_TEXCOORD0.xy = vec2(0.0, 0.0);
					    gs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
					    gs_TEXCOORD1.xyz = vs_TEXCOORD1[0].xyz;
					    u_xlat5.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat5.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat5.xyz;
					    u_xlat5.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat5.xy = vec2(u_xlat9) * u_xlat5.xz;
					    u_xlat13 = max(abs(u_xlat5.y), abs(u_xlat5.x));
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat3.x = min(abs(u_xlat5.y), abs(u_xlat5.x));
					    u_xlat13 = u_xlat13 * u_xlat3.x;
					    u_xlat3.x = u_xlat13 * u_xlat13;
					    u_xlat7 = u_xlat3.x * 0.0208350997 + -0.0851330012;
					    u_xlat7 = u_xlat3.x * u_xlat7 + 0.180141002;
					    u_xlat7 = u_xlat3.x * u_xlat7 + -0.330299497;
					    u_xlat3.x = u_xlat3.x * u_xlat7 + 0.999866009;
					    u_xlat7 = u_xlat13 * u_xlat3.x;
					    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
					    u_xlatb11 = abs(u_xlat5.y)<abs(u_xlat5.x);
					    u_xlat7 = u_xlatb11 ? u_xlat7 : float(0.0);
					    u_xlat13 = u_xlat13 * u_xlat3.x + u_xlat7;
					    u_xlatb3 = u_xlat5.y<(-u_xlat5.y);
					    u_xlat3.x = u_xlatb3 ? -3.14159274 : float(0.0);
					    u_xlat13 = u_xlat13 + u_xlat3.x;
					    u_xlat3.x = min(u_xlat5.y, (-u_xlat5.x));
					    u_xlat5.x = max(u_xlat5.y, (-u_xlat5.x));
					    u_xlatb5 = u_xlat5.x>=(-u_xlat5.x);
					    u_xlatb9 = u_xlat3.x<(-u_xlat3.x);
					    u_xlatb5 = u_xlatb5 && u_xlatb9;
					    u_xlat5.x = (u_xlatb5) ? (-u_xlat13) : u_xlat13;
					    u_xlat9 = max(abs(vs_NORMAL0[0].z), abs(vs_NORMAL0[0].x));
					    u_xlat9 = float(1.0) / u_xlat9;
					    u_xlat13 = min(abs(vs_NORMAL0[0].z), abs(vs_NORMAL0[0].x));
					    u_xlat9 = u_xlat9 * u_xlat13;
					    u_xlat13 = u_xlat9 * u_xlat9;
					    u_xlat3.x = u_xlat13 * 0.0208350997 + -0.0851330012;
					    u_xlat3.x = u_xlat13 * u_xlat3.x + 0.180141002;
					    u_xlat3.x = u_xlat13 * u_xlat3.x + -0.330299497;
					    u_xlat13 = u_xlat13 * u_xlat3.x + 0.999866009;
					    u_xlat3.x = u_xlat13 * u_xlat9;
					    u_xlat3.x = u_xlat3.x * -2.0 + 1.57079637;
					    u_xlatb7 = abs(vs_NORMAL0[0].z)<abs(vs_NORMAL0[0].x);
					    u_xlat3.x = u_xlatb7 ? u_xlat3.x : float(0.0);
					    u_xlat9 = u_xlat9 * u_xlat13 + u_xlat3.x;
					    u_xlatb13 = vs_NORMAL0[0].z<(-vs_NORMAL0[0].z);
					    u_xlat13 = u_xlatb13 ? -3.14159274 : float(0.0);
					    u_xlat9 = u_xlat13 + u_xlat9;
					    u_xlat13 = min(vs_NORMAL0[0].z, (-vs_NORMAL0[0].x));
					    u_xlatb13 = u_xlat13<(-u_xlat13);
					    u_xlat3.x = max(vs_NORMAL0[0].z, (-vs_NORMAL0[0].x));
					    u_xlatb3 = u_xlat3.x>=(-u_xlat3.x);
					    u_xlatb13 = u_xlatb13 && u_xlatb3;
					    u_xlat9 = (u_xlatb13) ? (-u_xlat9) : u_xlat9;
					    u_xlat5.x = (-u_xlat5.x) + u_xlat9;
					    u_xlat5.x = u_xlat5.x * 0.318309903;
					    gs_TEXCOORD1.w = u_xlat5.x;
					    EmitVertex();
					    u_xlat9 = _ScreenParams.x / _ScreenParams.y;
					    u_xlat3 = vec4(u_xlat9) * vec4(0.0, -1.0, 0.0, 0.0);
					    u_xlat3 = u_xlat1.xxxx * u_xlat3;
					    u_xlat2 = u_xlat3 * vec4(_Scale) + u_xlat2;
					    u_xlat3 = u_xlat3 * vec4(_Scale) + u_xlat0;
					    gl_Position = u_xlat2;
					    gs_NORMAL0.xyz = vs_NORMAL0[0].xyz;
					    gs_TEXCOORD0.xy = vec2(0.0, 1.0);
					    gs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
					    gs_TEXCOORD1.xyz = vs_TEXCOORD1[0].xyz;
					    gs_TEXCOORD1.w = u_xlat5.x;
					    EmitVertex();
					    gl_Position = u_xlat0;
					    gs_NORMAL0.xyz = vs_NORMAL0[0].xyz;
					    gs_TEXCOORD0.xy = vec2(1.0, 0.0);
					    gs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
					    gs_TEXCOORD1.xyz = vs_TEXCOORD1[0].xyz;
					    gs_TEXCOORD1.w = u_xlat5.x;
					    EmitVertex();
					    gl_Position = u_xlat3;
					    gs_NORMAL0.xyz = vs_NORMAL0[0].xyz;
					    gs_TEXCOORD0.xy = vec2(1.0, 1.0);
					    gs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
					    gs_TEXCOORD1.xyz = vs_TEXCOORD1[0].xyz;
					    gs_TEXCOORD1.w = u_xlat5.x;
					    EmitVertex();
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[8];
						float _Scale;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4;
						vec4 unity_OrthoParams;
					};
					layout(std140) uniform UnityPerCameraRare {
						vec4 unused_2_0[6];
						mat4x4 unity_CameraProjection;
						vec4 unused_2_2[12];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_NORMAL0 [1];
					in  vec4 vs_COLOR0 [1];
					in  vec4 vs_TEXCOORD1 [1];
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat5;
					bool u_xlatb5;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat9;
					bool u_xlatb9;
					bool u_xlatb11;
					float u_xlat13;
					bool u_xlatb13;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec4 gs_COLOR0;
					out vec4 gs_TEXCOORD1;
					layout(max_vertices = 4) out;
					void main()
					{
					    u_xlat0 = unity_ObjectToWorld[1] * gl_in[0].gl_Position.yyyy;
					    u_xlat0 = unity_ObjectToWorld[0] * gl_in[0].gl_Position.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * gl_in[0].gl_Position.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat1.x = u_xlat0.w * _ScreenParams.y;
					    u_xlat5.x = _ScreenParams.x * unity_OrthoParams.y;
					    u_xlat1.x = u_xlat1.x / u_xlat5.x;
					    u_xlat1.x = u_xlat1.x + (-unity_CameraProjection[0].x);
					    u_xlat1.x = unity_OrthoParams.w * u_xlat1.x + unity_CameraProjection[0].x;
					    u_xlat5.x = u_xlat1.x * _Scale;
					    u_xlat2 = (-u_xlat5.xxxx) * vec4(0.5, 0.0, 0.0, 0.0) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * vec4(0.5, 0.0, 0.0, 0.0) + u_xlat0;
					    gl_Position = u_xlat2;
					    gs_NORMAL0.xyz = vs_NORMAL0[0].xyz;
					    gs_TEXCOORD0.xy = vec2(0.0, 0.0);
					    gs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
					    gs_TEXCOORD1.xyz = vs_TEXCOORD1[0].xyz;
					    u_xlat5.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat5.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat5.xyz;
					    u_xlat5.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat5.xy = vec2(u_xlat9) * u_xlat5.xz;
					    u_xlat13 = max(abs(u_xlat5.y), abs(u_xlat5.x));
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat3.x = min(abs(u_xlat5.y), abs(u_xlat5.x));
					    u_xlat13 = u_xlat13 * u_xlat3.x;
					    u_xlat3.x = u_xlat13 * u_xlat13;
					    u_xlat7 = u_xlat3.x * 0.0208350997 + -0.0851330012;
					    u_xlat7 = u_xlat3.x * u_xlat7 + 0.180141002;
					    u_xlat7 = u_xlat3.x * u_xlat7 + -0.330299497;
					    u_xlat3.x = u_xlat3.x * u_xlat7 + 0.999866009;
					    u_xlat7 = u_xlat13 * u_xlat3.x;
					    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
					    u_xlatb11 = abs(u_xlat5.y)<abs(u_xlat5.x);
					    u_xlat7 = u_xlatb11 ? u_xlat7 : float(0.0);
					    u_xlat13 = u_xlat13 * u_xlat3.x + u_xlat7;
					    u_xlatb3 = u_xlat5.y<(-u_xlat5.y);
					    u_xlat3.x = u_xlatb3 ? -3.14159274 : float(0.0);
					    u_xlat13 = u_xlat13 + u_xlat3.x;
					    u_xlat3.x = min(u_xlat5.y, (-u_xlat5.x));
					    u_xlat5.x = max(u_xlat5.y, (-u_xlat5.x));
					    u_xlatb5 = u_xlat5.x>=(-u_xlat5.x);
					    u_xlatb9 = u_xlat3.x<(-u_xlat3.x);
					    u_xlatb5 = u_xlatb5 && u_xlatb9;
					    u_xlat5.x = (u_xlatb5) ? (-u_xlat13) : u_xlat13;
					    u_xlat9 = max(abs(vs_NORMAL0[0].z), abs(vs_NORMAL0[0].x));
					    u_xlat9 = float(1.0) / u_xlat9;
					    u_xlat13 = min(abs(vs_NORMAL0[0].z), abs(vs_NORMAL0[0].x));
					    u_xlat9 = u_xlat9 * u_xlat13;
					    u_xlat13 = u_xlat9 * u_xlat9;
					    u_xlat3.x = u_xlat13 * 0.0208350997 + -0.0851330012;
					    u_xlat3.x = u_xlat13 * u_xlat3.x + 0.180141002;
					    u_xlat3.x = u_xlat13 * u_xlat3.x + -0.330299497;
					    u_xlat13 = u_xlat13 * u_xlat3.x + 0.999866009;
					    u_xlat3.x = u_xlat13 * u_xlat9;
					    u_xlat3.x = u_xlat3.x * -2.0 + 1.57079637;
					    u_xlatb7 = abs(vs_NORMAL0[0].z)<abs(vs_NORMAL0[0].x);
					    u_xlat3.x = u_xlatb7 ? u_xlat3.x : float(0.0);
					    u_xlat9 = u_xlat9 * u_xlat13 + u_xlat3.x;
					    u_xlatb13 = vs_NORMAL0[0].z<(-vs_NORMAL0[0].z);
					    u_xlat13 = u_xlatb13 ? -3.14159274 : float(0.0);
					    u_xlat9 = u_xlat13 + u_xlat9;
					    u_xlat13 = min(vs_NORMAL0[0].z, (-vs_NORMAL0[0].x));
					    u_xlatb13 = u_xlat13<(-u_xlat13);
					    u_xlat3.x = max(vs_NORMAL0[0].z, (-vs_NORMAL0[0].x));
					    u_xlatb3 = u_xlat3.x>=(-u_xlat3.x);
					    u_xlatb13 = u_xlatb13 && u_xlatb3;
					    u_xlat9 = (u_xlatb13) ? (-u_xlat9) : u_xlat9;
					    u_xlat5.x = (-u_xlat5.x) + u_xlat9;
					    u_xlat5.x = u_xlat5.x * 0.318309903;
					    gs_TEXCOORD1.w = u_xlat5.x;
					    EmitVertex();
					    u_xlat9 = _ScreenParams.x / _ScreenParams.y;
					    u_xlat3 = vec4(u_xlat9) * vec4(0.0, -1.0, 0.0, 0.0);
					    u_xlat3 = u_xlat1.xxxx * u_xlat3;
					    u_xlat2 = u_xlat3 * vec4(_Scale) + u_xlat2;
					    u_xlat3 = u_xlat3 * vec4(_Scale) + u_xlat0;
					    gl_Position = u_xlat2;
					    gs_NORMAL0.xyz = vs_NORMAL0[0].xyz;
					    gs_TEXCOORD0.xy = vec2(0.0, 1.0);
					    gs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
					    gs_TEXCOORD1.xyz = vs_TEXCOORD1[0].xyz;
					    gs_TEXCOORD1.w = u_xlat5.x;
					    EmitVertex();
					    gl_Position = u_xlat0;
					    gs_NORMAL0.xyz = vs_NORMAL0[0].xyz;
					    gs_TEXCOORD0.xy = vec2(1.0, 0.0);
					    gs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
					    gs_TEXCOORD1.xyz = vs_TEXCOORD1[0].xyz;
					    gs_TEXCOORD1.w = u_xlat5.x;
					    EmitVertex();
					    gl_Position = u_xlat3;
					    gs_NORMAL0.xyz = vs_NORMAL0[0].xyz;
					    gs_TEXCOORD0.xy = vec2(1.0, 1.0);
					    gs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
					    gs_TEXCOORD1.xyz = vs_TEXCOORD1[0].xyz;
					    gs_TEXCOORD1.w = u_xlat5.x;
					    EmitVertex();
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					"gs_4_0
					
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
					layout(std140) uniform GGlobals {
						vec4 unused_0_0[8];
						float _Scale;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4;
						vec4 unity_OrthoParams;
					};
					layout(std140) uniform UnityPerCameraRare {
						vec4 unused_2_0[6];
						mat4x4 unity_CameraProjection;
						vec4 unused_2_2[12];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec2 vs_TEXCOORD0 [1];
					in  vec3 vs_NORMAL0 [1];
					in  vec4 vs_COLOR0 [1];
					in  vec4 vs_TEXCOORD1 [1];
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat5;
					bool u_xlatb5;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat9;
					bool u_xlatb9;
					bool u_xlatb11;
					float u_xlat13;
					bool u_xlatb13;
					layout(points) in;
					layout(triangle_strip) out;
					out vec3 gs_NORMAL0;
					out vec2 gs_TEXCOORD0;
					out vec4 gs_COLOR0;
					out vec4 gs_TEXCOORD1;
					layout(max_vertices = 4) out;
					void main()
					{
					    u_xlat0 = unity_ObjectToWorld[1] * gl_in[0].gl_Position.yyyy;
					    u_xlat0 = unity_ObjectToWorld[0] * gl_in[0].gl_Position.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * gl_in[0].gl_Position.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat1.x = u_xlat0.w * _ScreenParams.y;
					    u_xlat5.x = _ScreenParams.x * unity_OrthoParams.y;
					    u_xlat1.x = u_xlat1.x / u_xlat5.x;
					    u_xlat1.x = u_xlat1.x + (-unity_CameraProjection[0].x);
					    u_xlat1.x = unity_OrthoParams.w * u_xlat1.x + unity_CameraProjection[0].x;
					    u_xlat5.x = u_xlat1.x * _Scale;
					    u_xlat2 = (-u_xlat5.xxxx) * vec4(0.5, 0.0, 0.0, 0.0) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * vec4(0.5, 0.0, 0.0, 0.0) + u_xlat0;
					    gl_Position = u_xlat2;
					    gs_NORMAL0.xyz = vs_NORMAL0[0].xyz;
					    gs_TEXCOORD0.xy = vec2(0.0, 0.0);
					    gs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
					    gs_TEXCOORD1.xyz = vs_TEXCOORD1[0].xyz;
					    u_xlat5.xyz = unity_ObjectToWorld[1].xyz * gl_in[0].gl_Position.yyy;
					    u_xlat5.xyz = unity_ObjectToWorld[0].xyz * gl_in[0].gl_Position.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_ObjectToWorld[2].xyz * gl_in[0].gl_Position.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = unity_ObjectToWorld[3].xyz * gl_in[0].gl_Position.www + u_xlat5.xyz;
					    u_xlat5.xyz = (-u_xlat5.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat5.xy = vec2(u_xlat9) * u_xlat5.xz;
					    u_xlat13 = max(abs(u_xlat5.y), abs(u_xlat5.x));
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlat3.x = min(abs(u_xlat5.y), abs(u_xlat5.x));
					    u_xlat13 = u_xlat13 * u_xlat3.x;
					    u_xlat3.x = u_xlat13 * u_xlat13;
					    u_xlat7 = u_xlat3.x * 0.0208350997 + -0.0851330012;
					    u_xlat7 = u_xlat3.x * u_xlat7 + 0.180141002;
					    u_xlat7 = u_xlat3.x * u_xlat7 + -0.330299497;
					    u_xlat3.x = u_xlat3.x * u_xlat7 + 0.999866009;
					    u_xlat7 = u_xlat13 * u_xlat3.x;
					    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
					    u_xlatb11 = abs(u_xlat5.y)<abs(u_xlat5.x);
					    u_xlat7 = u_xlatb11 ? u_xlat7 : float(0.0);
					    u_xlat13 = u_xlat13 * u_xlat3.x + u_xlat7;
					    u_xlatb3 = u_xlat5.y<(-u_xlat5.y);
					    u_xlat3.x = u_xlatb3 ? -3.14159274 : float(0.0);
					    u_xlat13 = u_xlat13 + u_xlat3.x;
					    u_xlat3.x = min(u_xlat5.y, (-u_xlat5.x));
					    u_xlat5.x = max(u_xlat5.y, (-u_xlat5.x));
					    u_xlatb5 = u_xlat5.x>=(-u_xlat5.x);
					    u_xlatb9 = u_xlat3.x<(-u_xlat3.x);
					    u_xlatb5 = u_xlatb5 && u_xlatb9;
					    u_xlat5.x = (u_xlatb5) ? (-u_xlat13) : u_xlat13;
					    u_xlat9 = max(abs(vs_NORMAL0[0].z), abs(vs_NORMAL0[0].x));
					    u_xlat9 = float(1.0) / u_xlat9;
					    u_xlat13 = min(abs(vs_NORMAL0[0].z), abs(vs_NORMAL0[0].x));
					    u_xlat9 = u_xlat9 * u_xlat13;
					    u_xlat13 = u_xlat9 * u_xlat9;
					    u_xlat3.x = u_xlat13 * 0.0208350997 + -0.0851330012;
					    u_xlat3.x = u_xlat13 * u_xlat3.x + 0.180141002;
					    u_xlat3.x = u_xlat13 * u_xlat3.x + -0.330299497;
					    u_xlat13 = u_xlat13 * u_xlat3.x + 0.999866009;
					    u_xlat3.x = u_xlat13 * u_xlat9;
					    u_xlat3.x = u_xlat3.x * -2.0 + 1.57079637;
					    u_xlatb7 = abs(vs_NORMAL0[0].z)<abs(vs_NORMAL0[0].x);
					    u_xlat3.x = u_xlatb7 ? u_xlat3.x : float(0.0);
					    u_xlat9 = u_xlat9 * u_xlat13 + u_xlat3.x;
					    u_xlatb13 = vs_NORMAL0[0].z<(-vs_NORMAL0[0].z);
					    u_xlat13 = u_xlatb13 ? -3.14159274 : float(0.0);
					    u_xlat9 = u_xlat13 + u_xlat9;
					    u_xlat13 = min(vs_NORMAL0[0].z, (-vs_NORMAL0[0].x));
					    u_xlatb13 = u_xlat13<(-u_xlat13);
					    u_xlat3.x = max(vs_NORMAL0[0].z, (-vs_NORMAL0[0].x));
					    u_xlatb3 = u_xlat3.x>=(-u_xlat3.x);
					    u_xlatb13 = u_xlatb13 && u_xlatb3;
					    u_xlat9 = (u_xlatb13) ? (-u_xlat9) : u_xlat9;
					    u_xlat5.x = (-u_xlat5.x) + u_xlat9;
					    u_xlat5.x = u_xlat5.x * 0.318309903;
					    gs_TEXCOORD1.w = u_xlat5.x;
					    EmitVertex();
					    u_xlat9 = _ScreenParams.x / _ScreenParams.y;
					    u_xlat3 = vec4(u_xlat9) * vec4(0.0, -1.0, 0.0, 0.0);
					    u_xlat3 = u_xlat1.xxxx * u_xlat3;
					    u_xlat2 = u_xlat3 * vec4(_Scale) + u_xlat2;
					    u_xlat3 = u_xlat3 * vec4(_Scale) + u_xlat0;
					    gl_Position = u_xlat2;
					    gs_NORMAL0.xyz = vs_NORMAL0[0].xyz;
					    gs_TEXCOORD0.xy = vec2(0.0, 1.0);
					    gs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
					    gs_TEXCOORD1.xyz = vs_TEXCOORD1[0].xyz;
					    gs_TEXCOORD1.w = u_xlat5.x;
					    EmitVertex();
					    gl_Position = u_xlat0;
					    gs_NORMAL0.xyz = vs_NORMAL0[0].xyz;
					    gs_TEXCOORD0.xy = vec2(1.0, 0.0);
					    gs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
					    gs_TEXCOORD1.xyz = vs_TEXCOORD1[0].xyz;
					    gs_TEXCOORD1.w = u_xlat5.x;
					    EmitVertex();
					    gl_Position = u_xlat3;
					    gs_NORMAL0.xyz = vs_NORMAL0[0].xyz;
					    gs_TEXCOORD0.xy = vec2(1.0, 1.0);
					    gs_COLOR0 = vec4(1.0, 1.0, 1.0, 1.0);
					    gs_TEXCOORD1.xyz = vs_TEXCOORD1[0].xyz;
					    gs_TEXCOORD1.w = u_xlat5.x;
					    EmitVertex();
					    return;
					}"
				}
			}
		}
	}
}