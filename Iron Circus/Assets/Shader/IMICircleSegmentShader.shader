Shader "IMI/CircleSegmentShader" {
	Properties {
		[NoScaleOffset] _MainTex ("Mask (Red Channel)", 2D) = "white" {}
		[NoScaleOffset] _GradientTex ("Gradient", 2D) = "white" {}
		_Color ("Main Color", Vector) = (1,0,0,1)
		_Color2 ("Secondary Color", Vector) = (1,0,0,1)
		_MinAngle ("Min Angle", Range(0, 360)) = 0
		_MaxAngle ("Max Angle", Range(0, 360)) = 360
		_C2Angle ("Secondary Color Angle", Float) = 0
		_MinRadius ("Min Radius", Range(0, 1)) = 0
		_MaxRadius ("Max Radius", Range(0, 1)) = 1
		_C2Radius ("Secondary Color Radius", Float) = 0
		_RadiusAA ("Antialiasing Factor, Radius (~0.001)", Float) = 0.005
		_AngleAA ("Antialiasing Factor, Angle (~1)", Float) = 1
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 43798
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
						vec4 _Color;
						float _MinAngle;
						float _MaxAngle;
						float _MinRadius;
						float _MaxRadius;
						float _RadiusAA;
						float _AngleAA;
						vec4 _Color2;
						float _C2Angle;
						float _C2Radius;
					};
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
					    u_xlatb2 = u_xlatb2 && u_xlatb6;
					    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat2.x = u_xlat2.x * 57.2957802 + 180.0;
					    u_xlat2.x = u_xlat2.x * 0.00277777785;
					    u_xlat4.xy = (-vec2(_RadiusAA, _AngleAA)) * vec2(2.0, 2.0) + vec2(1.0, 360.0);
					    u_xlat6 = (-_C2Angle) * 2.0 + u_xlat4.y;
					    u_xlat0.x = u_xlat0.x * u_xlat4.x + _RadiusAA;
					    u_xlat2.x = u_xlat2.x * u_xlat6 + _AngleAA;
					    u_xlat0.y = u_xlat2.x + _C2Angle;
					    u_xlat4.xy = vec2(_MinRadius, _MinAngle) + vec2(_C2Radius, _C2Angle);
					    u_xlat4.xy = (-u_xlat4.xy) + u_xlat0.xy;
					    u_xlat4.xy = u_xlat4.xy / vec2(_RadiusAA, _AngleAA);
					    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					    u_xlat1.xy = vec2(_MaxRadius, _MaxAngle) + (-vec2(_C2Radius, _C2Angle));
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat1.x = u_xlat1.x / _RadiusAA;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.y / _AngleAA;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat6 = u_xlat4.y * u_xlat1.x;
					    u_xlat4.x = min(u_xlat6, u_xlat4.x);
					    u_xlat2.z = u_xlat0.y + (-_MinAngle);
					    u_xlat2.x = (-u_xlat0.y) + _MaxAngle;
					    u_xlat1.x = (-_MinAngle) + _MaxAngle;
					    u_xlat1.x = u_xlat2.z / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.yw = u_xlat2.xz / vec2(vec2(_AngleAA, _AngleAA));
					    u_xlat0.yw = clamp(u_xlat0.yw, 0.0, 1.0);
					    u_xlat1.y = 0.0;
					    u_xlat1 = texture(_GradientTex, u_xlat1.xy);
					    u_xlat1 = _Color * u_xlat1 + (-_Color2);
					    u_xlat1 = u_xlat4.xxxx * u_xlat1 + _Color2;
					    u_xlat0.z = u_xlat0.x + (-_MinRadius);
					    u_xlat0.x = (-u_xlat0.x) + _MaxRadius;
					    u_xlat0.xz = u_xlat0.xz / vec2(_RadiusAA);
					    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.zw;
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0.w = u_xlat0.x * u_xlat1.x;
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
						vec4 _Color;
						float _MinAngle;
						float _MaxAngle;
						float _MinRadius;
						float _MaxRadius;
						float _RadiusAA;
						float _AngleAA;
						vec4 _Color2;
						float _C2Angle;
						float _C2Radius;
					};
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
					    u_xlatb2 = u_xlatb2 && u_xlatb6;
					    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat2.x = u_xlat2.x * 57.2957802 + 180.0;
					    u_xlat2.x = u_xlat2.x * 0.00277777785;
					    u_xlat4.xy = (-vec2(_RadiusAA, _AngleAA)) * vec2(2.0, 2.0) + vec2(1.0, 360.0);
					    u_xlat6 = (-_C2Angle) * 2.0 + u_xlat4.y;
					    u_xlat0.x = u_xlat0.x * u_xlat4.x + _RadiusAA;
					    u_xlat2.x = u_xlat2.x * u_xlat6 + _AngleAA;
					    u_xlat0.y = u_xlat2.x + _C2Angle;
					    u_xlat4.xy = vec2(_MinRadius, _MinAngle) + vec2(_C2Radius, _C2Angle);
					    u_xlat4.xy = (-u_xlat4.xy) + u_xlat0.xy;
					    u_xlat4.xy = u_xlat4.xy / vec2(_RadiusAA, _AngleAA);
					    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					    u_xlat1.xy = vec2(_MaxRadius, _MaxAngle) + (-vec2(_C2Radius, _C2Angle));
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat1.x = u_xlat1.x / _RadiusAA;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.y / _AngleAA;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat6 = u_xlat4.y * u_xlat1.x;
					    u_xlat4.x = min(u_xlat6, u_xlat4.x);
					    u_xlat2.z = u_xlat0.y + (-_MinAngle);
					    u_xlat2.x = (-u_xlat0.y) + _MaxAngle;
					    u_xlat1.x = (-_MinAngle) + _MaxAngle;
					    u_xlat1.x = u_xlat2.z / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.yw = u_xlat2.xz / vec2(vec2(_AngleAA, _AngleAA));
					    u_xlat0.yw = clamp(u_xlat0.yw, 0.0, 1.0);
					    u_xlat1.y = 0.0;
					    u_xlat1 = texture(_GradientTex, u_xlat1.xy);
					    u_xlat1 = _Color * u_xlat1 + (-_Color2);
					    u_xlat1 = u_xlat4.xxxx * u_xlat1 + _Color2;
					    u_xlat0.z = u_xlat0.x + (-_MinRadius);
					    u_xlat0.x = (-u_xlat0.x) + _MaxRadius;
					    u_xlat0.xz = u_xlat0.xz / vec2(_RadiusAA);
					    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.zw;
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0.w = u_xlat0.x * u_xlat1.x;
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
						vec4 _Color;
						float _MinAngle;
						float _MaxAngle;
						float _MinRadius;
						float _MaxRadius;
						float _RadiusAA;
						float _AngleAA;
						vec4 _Color2;
						float _C2Angle;
						float _C2Radius;
					};
					uniform  sampler2D _GradientTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
					    u_xlatb2 = u_xlatb2 && u_xlatb6;
					    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat2.x = u_xlat2.x * 57.2957802 + 180.0;
					    u_xlat2.x = u_xlat2.x * 0.00277777785;
					    u_xlat4.xy = (-vec2(_RadiusAA, _AngleAA)) * vec2(2.0, 2.0) + vec2(1.0, 360.0);
					    u_xlat6 = (-_C2Angle) * 2.0 + u_xlat4.y;
					    u_xlat0.x = u_xlat0.x * u_xlat4.x + _RadiusAA;
					    u_xlat2.x = u_xlat2.x * u_xlat6 + _AngleAA;
					    u_xlat0.y = u_xlat2.x + _C2Angle;
					    u_xlat4.xy = vec2(_MinRadius, _MinAngle) + vec2(_C2Radius, _C2Angle);
					    u_xlat4.xy = (-u_xlat4.xy) + u_xlat0.xy;
					    u_xlat4.xy = u_xlat4.xy / vec2(_RadiusAA, _AngleAA);
					    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
					    u_xlat1.xy = vec2(_MaxRadius, _MaxAngle) + (-vec2(_C2Radius, _C2Angle));
					    u_xlat1.xy = (-u_xlat0.xy) + u_xlat1.xy;
					    u_xlat1.x = u_xlat1.x / _RadiusAA;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat4.x = u_xlat4.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.y / _AngleAA;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat6 = u_xlat4.y * u_xlat1.x;
					    u_xlat4.x = min(u_xlat6, u_xlat4.x);
					    u_xlat2.z = u_xlat0.y + (-_MinAngle);
					    u_xlat2.x = (-u_xlat0.y) + _MaxAngle;
					    u_xlat1.x = (-_MinAngle) + _MaxAngle;
					    u_xlat1.x = u_xlat2.z / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.yw = u_xlat2.xz / vec2(vec2(_AngleAA, _AngleAA));
					    u_xlat0.yw = clamp(u_xlat0.yw, 0.0, 1.0);
					    u_xlat1.y = 0.0;
					    u_xlat1 = texture(_GradientTex, u_xlat1.xy);
					    u_xlat1 = _Color * u_xlat1 + (-_Color2);
					    u_xlat1 = u_xlat4.xxxx * u_xlat1 + _Color2;
					    u_xlat0.z = u_xlat0.x + (-_MinRadius);
					    u_xlat0.x = (-u_xlat0.x) + _MaxRadius;
					    u_xlat0.xz = u_xlat0.xz / vec2(_RadiusAA);
					    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.zw;
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0.w = u_xlat0.x * u_xlat1.x;
					    return;
					}"
				}
			}
		}
	}
}