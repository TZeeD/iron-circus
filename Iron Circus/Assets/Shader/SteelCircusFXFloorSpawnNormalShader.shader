Shader "SteelCircus/FX/FloorSpawnNormalShader" {
	Properties {
		_HoleSize ("Hole radius (local space)", Float) = 0.25
		_MainRippleSize ("Main ripple radius (local space)", Float) = 0.2
		_MainRippleInitRadius ("Main ripple initial offset (local space)", Float) = 0.5
		_MainRippleHoleCutoff ("Main ripple final cutoff (curve %)", Float) = 0.5
		_SecondaryRippleStrength ("Strength of secondary ripples", Float) = 0.002
		_SecondaryRippleSpeed ("Secondary ripple speed", Float) = 0.2
		_SecondaryRippleFrequency ("Secondary ripple frequency", Float) = 2
		_AnimationProgress ("Animation progress", Range(0, 1)) = 1
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 13826
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
						float _HoleSize;
						float _AnimationProgress;
						float _MainRippleSize;
						float _MainRippleInitRadius;
						float _MainRippleHoleCutoff;
						float _SecondaryRippleStrength;
						float _SecondaryRippleSpeed;
						float _SecondaryRippleFrequency;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					int u_xlati0;
					bool u_xlatb0;
					float u_xlat1;
					int u_xlati1;
					vec3 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					vec2 u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlatb0 = _AnimationProgress<0.5;
					    u_xlat3 = (-_AnimationProgress) + 0.5;
					    u_xlat3 = u_xlat3 + u_xlat3;
					    u_xlat6.x = _MainRippleSize * _MainRippleHoleCutoff;
					    u_xlat9 = _MainRippleHoleCutoff * _MainRippleSize + _MainRippleInitRadius;
					    u_xlat3 = u_xlat3 * u_xlat9 + (-u_xlat6.x);
					    u_xlat6.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1 = dot(u_xlat6.xy, u_xlat6.xy);
					    u_xlat4 = sqrt(u_xlat1);
					    u_xlat1 = inversesqrt(u_xlat1);
					    u_xlat6.xy = u_xlat6.xy * vec2(u_xlat1);
					    u_xlat3 = (-u_xlat3) + u_xlat4;
					    u_xlat3 = u_xlat3 / _MainRippleSize;
					    u_xlat1 = _AnimationProgress + -0.5;
					    u_xlat1 = dot(vec2(u_xlat1), vec2(_HoleSize));
					    u_xlat1 = (-u_xlat1) + u_xlat4;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 / _MainRippleSize;
					    u_xlat1 = u_xlat1 + _MainRippleHoleCutoff;
					    u_xlat0.x = (u_xlatb0) ? u_xlat3 : u_xlat1;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 6.28318405;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat3 = _SecondaryRippleSpeed * _Time.y;
					    u_xlat3 = _SecondaryRippleFrequency * u_xlat4 + u_xlat3;
					    u_xlat1 = min(u_xlat4, 1.0);
					    u_xlat1 = u_xlat1 * 6.28318405;
					    u_xlat1 = cos(u_xlat1);
					    u_xlat1 = (-u_xlat1) * 0.5 + 0.5;
					    u_xlat3 = sin(u_xlat3);
					    u_xlat4 = _SecondaryRippleFrequency * (-_SecondaryRippleStrength);
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = u_xlat1 * u_xlat3;
					    u_xlat1 = inversesqrt(_AnimationProgress);
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat3 = u_xlat3 * u_xlat1;
					    u_xlat1 = _AnimationProgress + _AnimationProgress;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat0.x = u_xlat0.x * u_xlat1 + u_xlat3;
					    u_xlati3 = int((0.0<u_xlat0.x) ? 0xFFFFFFFFu : uint(0));
					    u_xlati1 = int((u_xlat0.x<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlat2.z = -abs(u_xlat0.x) + 1.0;
					    u_xlati0 = u_xlati3 + (-u_xlati1);
					    u_xlat0.x = float(u_xlati0);
					    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy;
					    u_xlat6.x = (-u_xlat2.z) * u_xlat2.z + 1.0;
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat2.xy = u_xlat6.xx * u_xlat0.xy;
					    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.x = log2(abs(u_xlat2.z));
					    u_xlat0.x = u_xlat0.x * 100.0;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.w = (-u_xlat0.x) + 1.0;
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
						float _HoleSize;
						float _AnimationProgress;
						float _MainRippleSize;
						float _MainRippleInitRadius;
						float _MainRippleHoleCutoff;
						float _SecondaryRippleStrength;
						float _SecondaryRippleSpeed;
						float _SecondaryRippleFrequency;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					int u_xlati0;
					bool u_xlatb0;
					float u_xlat1;
					int u_xlati1;
					vec3 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					vec2 u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlatb0 = _AnimationProgress<0.5;
					    u_xlat3 = (-_AnimationProgress) + 0.5;
					    u_xlat3 = u_xlat3 + u_xlat3;
					    u_xlat6.x = _MainRippleSize * _MainRippleHoleCutoff;
					    u_xlat9 = _MainRippleHoleCutoff * _MainRippleSize + _MainRippleInitRadius;
					    u_xlat3 = u_xlat3 * u_xlat9 + (-u_xlat6.x);
					    u_xlat6.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1 = dot(u_xlat6.xy, u_xlat6.xy);
					    u_xlat4 = sqrt(u_xlat1);
					    u_xlat1 = inversesqrt(u_xlat1);
					    u_xlat6.xy = u_xlat6.xy * vec2(u_xlat1);
					    u_xlat3 = (-u_xlat3) + u_xlat4;
					    u_xlat3 = u_xlat3 / _MainRippleSize;
					    u_xlat1 = _AnimationProgress + -0.5;
					    u_xlat1 = dot(vec2(u_xlat1), vec2(_HoleSize));
					    u_xlat1 = (-u_xlat1) + u_xlat4;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 / _MainRippleSize;
					    u_xlat1 = u_xlat1 + _MainRippleHoleCutoff;
					    u_xlat0.x = (u_xlatb0) ? u_xlat3 : u_xlat1;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 6.28318405;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat3 = _SecondaryRippleSpeed * _Time.y;
					    u_xlat3 = _SecondaryRippleFrequency * u_xlat4 + u_xlat3;
					    u_xlat1 = min(u_xlat4, 1.0);
					    u_xlat1 = u_xlat1 * 6.28318405;
					    u_xlat1 = cos(u_xlat1);
					    u_xlat1 = (-u_xlat1) * 0.5 + 0.5;
					    u_xlat3 = sin(u_xlat3);
					    u_xlat4 = _SecondaryRippleFrequency * (-_SecondaryRippleStrength);
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = u_xlat1 * u_xlat3;
					    u_xlat1 = inversesqrt(_AnimationProgress);
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat3 = u_xlat3 * u_xlat1;
					    u_xlat1 = _AnimationProgress + _AnimationProgress;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat0.x = u_xlat0.x * u_xlat1 + u_xlat3;
					    u_xlati3 = int((0.0<u_xlat0.x) ? 0xFFFFFFFFu : uint(0));
					    u_xlati1 = int((u_xlat0.x<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlat2.z = -abs(u_xlat0.x) + 1.0;
					    u_xlati0 = u_xlati3 + (-u_xlati1);
					    u_xlat0.x = float(u_xlati0);
					    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy;
					    u_xlat6.x = (-u_xlat2.z) * u_xlat2.z + 1.0;
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat2.xy = u_xlat6.xx * u_xlat0.xy;
					    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.x = log2(abs(u_xlat2.z));
					    u_xlat0.x = u_xlat0.x * 100.0;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.w = (-u_xlat0.x) + 1.0;
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
						float _HoleSize;
						float _AnimationProgress;
						float _MainRippleSize;
						float _MainRippleInitRadius;
						float _MainRippleHoleCutoff;
						float _SecondaryRippleStrength;
						float _SecondaryRippleSpeed;
						float _SecondaryRippleFrequency;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					int u_xlati0;
					bool u_xlatb0;
					float u_xlat1;
					int u_xlati1;
					vec3 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					vec2 u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlatb0 = _AnimationProgress<0.5;
					    u_xlat3 = (-_AnimationProgress) + 0.5;
					    u_xlat3 = u_xlat3 + u_xlat3;
					    u_xlat6.x = _MainRippleSize * _MainRippleHoleCutoff;
					    u_xlat9 = _MainRippleHoleCutoff * _MainRippleSize + _MainRippleInitRadius;
					    u_xlat3 = u_xlat3 * u_xlat9 + (-u_xlat6.x);
					    u_xlat6.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1 = dot(u_xlat6.xy, u_xlat6.xy);
					    u_xlat4 = sqrt(u_xlat1);
					    u_xlat1 = inversesqrt(u_xlat1);
					    u_xlat6.xy = u_xlat6.xy * vec2(u_xlat1);
					    u_xlat3 = (-u_xlat3) + u_xlat4;
					    u_xlat3 = u_xlat3 / _MainRippleSize;
					    u_xlat1 = _AnimationProgress + -0.5;
					    u_xlat1 = dot(vec2(u_xlat1), vec2(_HoleSize));
					    u_xlat1 = (-u_xlat1) + u_xlat4;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 / _MainRippleSize;
					    u_xlat1 = u_xlat1 + _MainRippleHoleCutoff;
					    u_xlat0.x = (u_xlatb0) ? u_xlat3 : u_xlat1;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * 6.28318405;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat3 = _SecondaryRippleSpeed * _Time.y;
					    u_xlat3 = _SecondaryRippleFrequency * u_xlat4 + u_xlat3;
					    u_xlat1 = min(u_xlat4, 1.0);
					    u_xlat1 = u_xlat1 * 6.28318405;
					    u_xlat1 = cos(u_xlat1);
					    u_xlat1 = (-u_xlat1) * 0.5 + 0.5;
					    u_xlat3 = sin(u_xlat3);
					    u_xlat4 = _SecondaryRippleFrequency * (-_SecondaryRippleStrength);
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = u_xlat1 * u_xlat3;
					    u_xlat1 = inversesqrt(_AnimationProgress);
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat3 = u_xlat3 * u_xlat1;
					    u_xlat1 = _AnimationProgress + _AnimationProgress;
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat0.x = u_xlat0.x * u_xlat1 + u_xlat3;
					    u_xlati3 = int((0.0<u_xlat0.x) ? 0xFFFFFFFFu : uint(0));
					    u_xlati1 = int((u_xlat0.x<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlat2.z = -abs(u_xlat0.x) + 1.0;
					    u_xlati0 = u_xlati3 + (-u_xlati1);
					    u_xlat0.x = float(u_xlati0);
					    u_xlat0.xy = u_xlat0.xx * u_xlat6.xy;
					    u_xlat6.x = (-u_xlat2.z) * u_xlat2.z + 1.0;
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat2.xy = u_xlat6.xx * u_xlat0.xy;
					    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat0.x = log2(abs(u_xlat2.z));
					    u_xlat0.x = u_xlat0.x * 100.0;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.w = (-u_xlat0.x) + 1.0;
					    return;
					}"
				}
			}
		}
	}
}