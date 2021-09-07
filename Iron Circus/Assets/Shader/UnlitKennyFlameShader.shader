Shader "Unlit/KennyFlameShader" {
	Properties {
		_Intensity ("Intensity", Range(0, 4)) = 1
		_BrightnessMin ("Brightness Scale Min", Float) = 1
		_BrightnessMax ("Brightness Scale Max", Float) = 1
		_RampTex ("Color Ramp", 2D) = "white" {}
		_MainTex ("Texture (R=Alpha, G=Displacement)", 2D) = "white" {}
		_RingTex ("Ring Tex", 2D) = "white" {}
		_SpeedMain ("Scroll Speed, Main", Float) = 1
		_SpeedDisplacement ("Scroll Speed Scale, Displacement", Float) = 0.7
		_Displacement ("Displacement Intensity", Float) = 0.1
		_Displacement_Ring ("Ring Displacement Intensity", Float) = 0.1
		_SpeedRing ("Scroll Speed, Ring", Float) = 1
		_SpeedScale ("Global Speed Scale", Float) = 1
		_AfterBurnerDisplacement ("AfterBurner Displacement (Intensity>3)", Float) = 0.2
		_AfterBurnerTiling ("AfterBurner Noise Tiling (x,y)", Vector) = (1,1,0,0)
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 52788
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
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _RingTex_ST;
						float _SpeedMain;
						float _SpeedRing;
						float _SpeedDisplacement;
						float _SpeedScale;
						float _AfterBurnerDisplacement;
						vec4 _AfterBurnerTiling;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform Props {
						float _Intensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					out vec2 vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec2 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat9;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xy = vec2(_SpeedMain, _SpeedRing) * _Time.yy;
					    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_SpeedScale, _SpeedScale));
					    u_xlat0.z = 0.0;
					    u_xlat1.xy = in_TEXCOORD0.xy * _AfterBurnerTiling.xy + u_xlat0.zx;
					    u_xlat9.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.xy = u_xlat0.zx + u_xlat9.xy;
					    u_xlat9.xy = u_xlat0.zx * vec2(vec2(_SpeedDisplacement, _SpeedDisplacement)) + u_xlat9.xy;
					    u_xlat1.xy = u_xlat1.xy + (-u_xlat2.xy);
					    u_xlat12 = _Intensity + -3.0;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xy = vec2(u_xlat12) * u_xlat1.xy + u_xlat2.xy;
					    u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					    vs_TEXCOORD1.xy = u_xlat1.xy;
					    u_xlat1.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat2.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * in_TEXCOORD0.yyy;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_AfterBurnerDisplacement);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat12) + in_POSITION0.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_ObjectToWorld[1];
					    u_xlat3 = unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat2 = unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
					    vs_TEXCOORD0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
					    u_xlat2 = u_xlat2 + unity_ObjectToWorld[3];
					    u_xlat1.xy = u_xlat0.zx * vec2(vec2(_SpeedDisplacement, _SpeedDisplacement));
					    u_xlat1.xy = in_TEXCOORD0.xy * _AfterBurnerTiling.xy + u_xlat1.xy;
					    u_xlat1.xy = (-u_xlat9.xy) + u_xlat1.xy;
					    vs_TEXCOORD2.xy = vec2(u_xlat12) * u_xlat1.xy + u_xlat9.xy;
					    u_xlat0.xw = in_TEXCOORD0.xy * _RingTex_ST.xy + _RingTex_ST.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zy + u_xlat0.xw;
					    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_NORMAL0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _RingTex_ST;
						float _SpeedMain;
						float _SpeedRing;
						float _SpeedDisplacement;
						float _SpeedScale;
						float _AfterBurnerDisplacement;
						vec4 _AfterBurnerTiling;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform Props {
						float _Intensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					out vec2 vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec2 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat9;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xy = vec2(_SpeedMain, _SpeedRing) * _Time.yy;
					    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_SpeedScale, _SpeedScale));
					    u_xlat0.z = 0.0;
					    u_xlat1.xy = in_TEXCOORD0.xy * _AfterBurnerTiling.xy + u_xlat0.zx;
					    u_xlat9.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.xy = u_xlat0.zx + u_xlat9.xy;
					    u_xlat9.xy = u_xlat0.zx * vec2(vec2(_SpeedDisplacement, _SpeedDisplacement)) + u_xlat9.xy;
					    u_xlat1.xy = u_xlat1.xy + (-u_xlat2.xy);
					    u_xlat12 = _Intensity + -3.0;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xy = vec2(u_xlat12) * u_xlat1.xy + u_xlat2.xy;
					    u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					    vs_TEXCOORD1.xy = u_xlat1.xy;
					    u_xlat1.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat2.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * in_TEXCOORD0.yyy;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_AfterBurnerDisplacement);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat12) + in_POSITION0.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_ObjectToWorld[1];
					    u_xlat3 = unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat2 = unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
					    vs_TEXCOORD0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
					    u_xlat2 = u_xlat2 + unity_ObjectToWorld[3];
					    u_xlat1.xy = u_xlat0.zx * vec2(vec2(_SpeedDisplacement, _SpeedDisplacement));
					    u_xlat1.xy = in_TEXCOORD0.xy * _AfterBurnerTiling.xy + u_xlat1.xy;
					    u_xlat1.xy = (-u_xlat9.xy) + u_xlat1.xy;
					    vs_TEXCOORD2.xy = vec2(u_xlat12) * u_xlat1.xy + u_xlat9.xy;
					    u_xlat0.xw = in_TEXCOORD0.xy * _RingTex_ST.xy + _RingTex_ST.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zy + u_xlat0.xw;
					    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_NORMAL0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _RingTex_ST;
						float _SpeedMain;
						float _SpeedRing;
						float _SpeedDisplacement;
						float _SpeedScale;
						float _AfterBurnerDisplacement;
						vec4 _AfterBurnerTiling;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform Props {
						float _Intensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					out vec2 vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					out vec3 vs_NORMAL0;
					vec4 u_xlat0;
					vec2 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat9;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xy = vec2(_SpeedMain, _SpeedRing) * _Time.yy;
					    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_SpeedScale, _SpeedScale));
					    u_xlat0.z = 0.0;
					    u_xlat1.xy = in_TEXCOORD0.xy * _AfterBurnerTiling.xy + u_xlat0.zx;
					    u_xlat9.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.xy = u_xlat0.zx + u_xlat9.xy;
					    u_xlat9.xy = u_xlat0.zx * vec2(vec2(_SpeedDisplacement, _SpeedDisplacement)) + u_xlat9.xy;
					    u_xlat1.xy = u_xlat1.xy + (-u_xlat2.xy);
					    u_xlat12 = _Intensity + -3.0;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xy = vec2(u_xlat12) * u_xlat1.xy + u_xlat2.xy;
					    u_xlat2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					    vs_TEXCOORD1.xy = u_xlat1.xy;
					    u_xlat1.x = u_xlat2.x * 2.0 + -1.0;
					    u_xlat2.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * in_TEXCOORD0.yyy;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_AfterBurnerDisplacement);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat12) + in_POSITION0.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_ObjectToWorld[1];
					    u_xlat3 = unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat2 = unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat3;
					    vs_TEXCOORD0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
					    u_xlat2 = u_xlat2 + unity_ObjectToWorld[3];
					    u_xlat1.xy = u_xlat0.zx * vec2(vec2(_SpeedDisplacement, _SpeedDisplacement));
					    u_xlat1.xy = in_TEXCOORD0.xy * _AfterBurnerTiling.xy + u_xlat1.xy;
					    u_xlat1.xy = (-u_xlat9.xy) + u_xlat1.xy;
					    vs_TEXCOORD2.xy = vec2(u_xlat12) * u_xlat1.xy + u_xlat9.xy;
					    u_xlat0.xw = in_TEXCOORD0.xy * _RingTex_ST.xy + _RingTex_ST.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zy + u_xlat0.xw;
					    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_NORMAL0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "INSTANCING_ON" }
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
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _RingTex_ST;
						float _SpeedMain;
						float _SpeedRing;
						float _SpeedDisplacement;
						float _SpeedScale;
						float _AfterBurnerDisplacement;
						vec4 _AfterBurnerTiling;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					struct PropsArray_Type {
						float PropsArray._Intensity;
					};
					layout(std140) uniform UnityInstancing_Props {
						PropsArray_Type PropsArray;
						vec4 unused_5_1[2];
					};
					uniform  sampler2D _MainTex;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					out vec2 vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					out vec3 vs_NORMAL0;
					flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat9;
					float u_xlat10;
					float u_xlat12;
					int u_xlati12;
					void main()
					{
					    u_xlat0.xy = vec2(_SpeedMain, _SpeedRing) * _Time.yy;
					    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_SpeedScale, _SpeedScale));
					    u_xlat0.z = 0.0;
					    u_xlat1.xy = in_TEXCOORD0.xy * _AfterBurnerTiling.xy + u_xlat0.zx;
					    u_xlat9.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.xy = u_xlat0.zx + u_xlat9.xy;
					    u_xlat9.xy = u_xlat0.zx * vec2(vec2(_SpeedDisplacement, _SpeedDisplacement)) + u_xlat9.xy;
					    u_xlat1.xy = u_xlat1.xy + (-u_xlat2.xy);
					    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlat10 = -3.0 + PropsArray.PropsArray._Intensity;
					    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
					    u_xlati12 = u_xlati12 << 3;
					    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy + u_xlat2.xy;
					    u_xlat3 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					    vs_TEXCOORD1.xy = u_xlat1.xy;
					    u_xlat1.x = u_xlat3.x * 2.0 + -1.0;
					    u_xlat2.xyw = u_xlat1.xxx * in_NORMAL0.xyz;
					    u_xlat2.xyw = u_xlat2.xyw * in_TEXCOORD0.yyy;
					    u_xlat2.xyw = u_xlat2.xyw * vec3(_AfterBurnerDisplacement);
					    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat10) + in_POSITION0.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati12 + 1)];
					    u_xlat3 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati12] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati12 + 2)] * u_xlat2.wwww + u_xlat3;
					    vs_TEXCOORD0.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati12 + 3)].xyz * in_POSITION0.www + u_xlat3.xyz;
					    u_xlat3 = u_xlat3 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati12 + 3)];
					    u_xlat1.xy = u_xlat0.zx * vec2(vec2(_SpeedDisplacement, _SpeedDisplacement));
					    u_xlat1.xy = in_TEXCOORD0.xy * _AfterBurnerTiling.xy + u_xlat1.xy;
					    u_xlat1.xy = (-u_xlat9.xy) + u_xlat1.xy;
					    vs_TEXCOORD2.xy = vec2(u_xlat10) * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = in_TEXCOORD0.xy * _RingTex_ST.xy + _RingTex_ST.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zy + u_xlat1.xy;
					    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
					    u_xlat1 = u_xlat3.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat3.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati12].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati12 + 1)].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati12 + 2)].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_NORMAL0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "INSTANCING_ON" }
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
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _RingTex_ST;
						float _SpeedMain;
						float _SpeedRing;
						float _SpeedDisplacement;
						float _SpeedScale;
						float _AfterBurnerDisplacement;
						vec4 _AfterBurnerTiling;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					struct PropsArray_Type {
						float PropsArray._Intensity;
					};
					layout(std140) uniform UnityInstancing_Props {
						PropsArray_Type PropsArray;
						vec4 unused_5_1[2];
					};
					uniform  sampler2D _MainTex;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					out vec2 vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					out vec3 vs_NORMAL0;
					flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat9;
					float u_xlat10;
					float u_xlat12;
					int u_xlati12;
					void main()
					{
					    u_xlat0.xy = vec2(_SpeedMain, _SpeedRing) * _Time.yy;
					    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_SpeedScale, _SpeedScale));
					    u_xlat0.z = 0.0;
					    u_xlat1.xy = in_TEXCOORD0.xy * _AfterBurnerTiling.xy + u_xlat0.zx;
					    u_xlat9.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.xy = u_xlat0.zx + u_xlat9.xy;
					    u_xlat9.xy = u_xlat0.zx * vec2(vec2(_SpeedDisplacement, _SpeedDisplacement)) + u_xlat9.xy;
					    u_xlat1.xy = u_xlat1.xy + (-u_xlat2.xy);
					    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlat10 = -3.0 + PropsArray.PropsArray._Intensity;
					    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
					    u_xlati12 = u_xlati12 << 3;
					    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy + u_xlat2.xy;
					    u_xlat3 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					    vs_TEXCOORD1.xy = u_xlat1.xy;
					    u_xlat1.x = u_xlat3.x * 2.0 + -1.0;
					    u_xlat2.xyw = u_xlat1.xxx * in_NORMAL0.xyz;
					    u_xlat2.xyw = u_xlat2.xyw * in_TEXCOORD0.yyy;
					    u_xlat2.xyw = u_xlat2.xyw * vec3(_AfterBurnerDisplacement);
					    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat10) + in_POSITION0.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati12 + 1)];
					    u_xlat3 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati12] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati12 + 2)] * u_xlat2.wwww + u_xlat3;
					    vs_TEXCOORD0.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati12 + 3)].xyz * in_POSITION0.www + u_xlat3.xyz;
					    u_xlat3 = u_xlat3 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati12 + 3)];
					    u_xlat1.xy = u_xlat0.zx * vec2(vec2(_SpeedDisplacement, _SpeedDisplacement));
					    u_xlat1.xy = in_TEXCOORD0.xy * _AfterBurnerTiling.xy + u_xlat1.xy;
					    u_xlat1.xy = (-u_xlat9.xy) + u_xlat1.xy;
					    vs_TEXCOORD2.xy = vec2(u_xlat10) * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = in_TEXCOORD0.xy * _RingTex_ST.xy + _RingTex_ST.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zy + u_xlat1.xy;
					    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
					    u_xlat1 = u_xlat3.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat3.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati12].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati12 + 1)].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati12 + 2)].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_NORMAL0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "INSTANCING_ON" }
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
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _RingTex_ST;
						float _SpeedMain;
						float _SpeedRing;
						float _SpeedDisplacement;
						float _SpeedScale;
						float _AfterBurnerDisplacement;
						vec4 _AfterBurnerTiling;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					struct PropsArray_Type {
						float PropsArray._Intensity;
					};
					layout(std140) uniform UnityInstancing_Props {
						PropsArray_Type PropsArray;
						vec4 unused_5_1[2];
					};
					uniform  sampler2D _MainTex;
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					out vec2 vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					out vec3 vs_NORMAL0;
					flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat9;
					float u_xlat10;
					float u_xlat12;
					int u_xlati12;
					void main()
					{
					    u_xlat0.xy = vec2(_SpeedMain, _SpeedRing) * _Time.yy;
					    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_SpeedScale, _SpeedScale));
					    u_xlat0.z = 0.0;
					    u_xlat1.xy = in_TEXCOORD0.xy * _AfterBurnerTiling.xy + u_xlat0.zx;
					    u_xlat9.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.xy = u_xlat0.zx + u_xlat9.xy;
					    u_xlat9.xy = u_xlat0.zx * vec2(vec2(_SpeedDisplacement, _SpeedDisplacement)) + u_xlat9.xy;
					    u_xlat1.xy = u_xlat1.xy + (-u_xlat2.xy);
					    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlat10 = -3.0 + PropsArray.PropsArray._Intensity;
					    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
					    u_xlati12 = u_xlati12 << 3;
					    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy + u_xlat2.xy;
					    u_xlat3 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					    vs_TEXCOORD1.xy = u_xlat1.xy;
					    u_xlat1.x = u_xlat3.x * 2.0 + -1.0;
					    u_xlat2.xyw = u_xlat1.xxx * in_NORMAL0.xyz;
					    u_xlat2.xyw = u_xlat2.xyw * in_TEXCOORD0.yyy;
					    u_xlat2.xyw = u_xlat2.xyw * vec3(_AfterBurnerDisplacement);
					    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat10) + in_POSITION0.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati12 + 1)];
					    u_xlat3 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati12] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati12 + 2)] * u_xlat2.wwww + u_xlat3;
					    vs_TEXCOORD0.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati12 + 3)].xyz * in_POSITION0.www + u_xlat3.xyz;
					    u_xlat3 = u_xlat3 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati12 + 3)];
					    u_xlat1.xy = u_xlat0.zx * vec2(vec2(_SpeedDisplacement, _SpeedDisplacement));
					    u_xlat1.xy = in_TEXCOORD0.xy * _AfterBurnerTiling.xy + u_xlat1.xy;
					    u_xlat1.xy = (-u_xlat9.xy) + u_xlat1.xy;
					    vs_TEXCOORD2.xy = vec2(u_xlat10) * u_xlat1.xy + u_xlat9.xy;
					    u_xlat1.xy = in_TEXCOORD0.xy * _RingTex_ST.xy + _RingTex_ST.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zy + u_xlat1.xy;
					    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
					    u_xlat1 = u_xlat3.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat3.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati12].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati12 + 1)].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati12 + 2)].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_NORMAL0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
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
						vec4 unused_0_0[4];
						float _Displacement;
						float _Displacement_Ring;
						float _BrightnessMin;
						float _BrightnessMax;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform Props {
						float _Intensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RingTex;
					uniform  sampler2D _RampTex;
					in  vec3 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					in  vec2 vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = abs(u_xlat0.x) * 3.1415;
					    u_xlat0.x = cos(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.5;
					    u_xlat5.x = inversesqrt(vs_TEXCOORD4.y);
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat2.y = u_xlat1.y * _Displacement;
					    u_xlat12.y = u_xlat1.y * _Displacement_Ring;
					    u_xlat2.x = float(0.0);
					    u_xlat12.x = float(0.0);
					    u_xlat5.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
					    u_xlat1.xy = u_xlat12.xy + vs_TEXCOORD3.xy;
					    u_xlat1 = texture(_RingTex, u_xlat1.xy);
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat5.x = u_xlat2.x * vs_COLOR0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat5.x;
					    u_xlat5.x = vs_TEXCOORD4.y * vs_TEXCOORD4.y + (-u_xlat0.x);
					    u_xlat2.x = u_xlat5.x + 1.0;
					    u_xlat2.yz = vec2(_Intensity) + vec2(-1.0, -3.0);
					    u_xlat2.yz = clamp(u_xlat2.yz, 0.0, 1.0);
					    u_xlat3 = texture(_RampTex, u_xlat2.xy);
					    u_xlat2.w = 0.0;
					    u_xlat4 = texture(_RampTex, u_xlat2.wy);
					    u_xlat5.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
					    u_xlat6 = (-vs_TEXCOORD4.y) + 1.0;
					    u_xlat1.x = u_xlat6 * u_xlat1.x;
					    u_xlat1.x = u_xlat2.y * u_xlat1.x;
					    u_xlat6 = (-u_xlat2.z) + 1.0;
					    u_xlat1.x = u_xlat6 * u_xlat1.x;
					    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat3.xyz;
					    u_xlat6 = (-_BrightnessMin) + _BrightnessMax;
					    u_xlat6 = u_xlat2.y * u_xlat6 + _BrightnessMin;
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat6);
					    u_xlat5.x = (-vs_TEXCOORD4.y) * vs_TEXCOORD4.y + 1.0;
					    u_xlat10 = u_xlat5.x * u_xlat0.x;
					    u_xlat0.x = (-u_xlat0.x) * u_xlat5.x + u_xlat5.x;
					    u_xlat2.w = u_xlat1.x * u_xlat0.x + u_xlat10;
					    u_xlat0.x = _Intensity;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0 = u_xlat0.xxxx * u_xlat2;
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
						vec4 unused_0_0[4];
						float _Displacement;
						float _Displacement_Ring;
						float _BrightnessMin;
						float _BrightnessMax;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform Props {
						float _Intensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RingTex;
					uniform  sampler2D _RampTex;
					in  vec3 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					in  vec2 vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = abs(u_xlat0.x) * 3.1415;
					    u_xlat0.x = cos(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.5;
					    u_xlat5.x = inversesqrt(vs_TEXCOORD4.y);
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat2.y = u_xlat1.y * _Displacement;
					    u_xlat12.y = u_xlat1.y * _Displacement_Ring;
					    u_xlat2.x = float(0.0);
					    u_xlat12.x = float(0.0);
					    u_xlat5.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
					    u_xlat1.xy = u_xlat12.xy + vs_TEXCOORD3.xy;
					    u_xlat1 = texture(_RingTex, u_xlat1.xy);
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat5.x = u_xlat2.x * vs_COLOR0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat5.x;
					    u_xlat5.x = vs_TEXCOORD4.y * vs_TEXCOORD4.y + (-u_xlat0.x);
					    u_xlat2.x = u_xlat5.x + 1.0;
					    u_xlat2.yz = vec2(_Intensity) + vec2(-1.0, -3.0);
					    u_xlat2.yz = clamp(u_xlat2.yz, 0.0, 1.0);
					    u_xlat3 = texture(_RampTex, u_xlat2.xy);
					    u_xlat2.w = 0.0;
					    u_xlat4 = texture(_RampTex, u_xlat2.wy);
					    u_xlat5.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
					    u_xlat6 = (-vs_TEXCOORD4.y) + 1.0;
					    u_xlat1.x = u_xlat6 * u_xlat1.x;
					    u_xlat1.x = u_xlat2.y * u_xlat1.x;
					    u_xlat6 = (-u_xlat2.z) + 1.0;
					    u_xlat1.x = u_xlat6 * u_xlat1.x;
					    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat3.xyz;
					    u_xlat6 = (-_BrightnessMin) + _BrightnessMax;
					    u_xlat6 = u_xlat2.y * u_xlat6 + _BrightnessMin;
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat6);
					    u_xlat5.x = (-vs_TEXCOORD4.y) * vs_TEXCOORD4.y + 1.0;
					    u_xlat10 = u_xlat5.x * u_xlat0.x;
					    u_xlat0.x = (-u_xlat0.x) * u_xlat5.x + u_xlat5.x;
					    u_xlat2.w = u_xlat1.x * u_xlat0.x + u_xlat10;
					    u_xlat0.x = _Intensity;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0 = u_xlat0.xxxx * u_xlat2;
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
						vec4 unused_0_0[4];
						float _Displacement;
						float _Displacement_Ring;
						float _BrightnessMin;
						float _BrightnessMax;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform Props {
						float _Intensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RingTex;
					uniform  sampler2D _RampTex;
					in  vec3 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					in  vec2 vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					in  vec3 vs_NORMAL0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = abs(u_xlat0.x) * 3.1415;
					    u_xlat0.x = cos(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.5;
					    u_xlat5.x = inversesqrt(vs_TEXCOORD4.y);
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat2.y = u_xlat1.y * _Displacement;
					    u_xlat12.y = u_xlat1.y * _Displacement_Ring;
					    u_xlat2.x = float(0.0);
					    u_xlat12.x = float(0.0);
					    u_xlat5.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
					    u_xlat1.xy = u_xlat12.xy + vs_TEXCOORD3.xy;
					    u_xlat1 = texture(_RingTex, u_xlat1.xy);
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat5.x = u_xlat2.x * vs_COLOR0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat5.x;
					    u_xlat5.x = vs_TEXCOORD4.y * vs_TEXCOORD4.y + (-u_xlat0.x);
					    u_xlat2.x = u_xlat5.x + 1.0;
					    u_xlat2.yz = vec2(_Intensity) + vec2(-1.0, -3.0);
					    u_xlat2.yz = clamp(u_xlat2.yz, 0.0, 1.0);
					    u_xlat3 = texture(_RampTex, u_xlat2.xy);
					    u_xlat2.w = 0.0;
					    u_xlat4 = texture(_RampTex, u_xlat2.wy);
					    u_xlat5.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
					    u_xlat6 = (-vs_TEXCOORD4.y) + 1.0;
					    u_xlat1.x = u_xlat6 * u_xlat1.x;
					    u_xlat1.x = u_xlat2.y * u_xlat1.x;
					    u_xlat6 = (-u_xlat2.z) + 1.0;
					    u_xlat1.x = u_xlat6 * u_xlat1.x;
					    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat3.xyz;
					    u_xlat6 = (-_BrightnessMin) + _BrightnessMax;
					    u_xlat6 = u_xlat2.y * u_xlat6 + _BrightnessMin;
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat6);
					    u_xlat5.x = (-vs_TEXCOORD4.y) * vs_TEXCOORD4.y + 1.0;
					    u_xlat10 = u_xlat5.x * u_xlat0.x;
					    u_xlat0.x = (-u_xlat0.x) * u_xlat5.x + u_xlat5.x;
					    u_xlat2.w = u_xlat1.x * u_xlat0.x + u_xlat10;
					    u_xlat0.x = _Intensity;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0 = u_xlat0.xxxx * u_xlat2;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "INSTANCING_ON" }
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
						vec4 unused_0_0[4];
						float _Displacement;
						float _Displacement_Ring;
						float _BrightnessMin;
						float _BrightnessMax;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct PropsArray_Type {
						float PropsArray._Intensity;
					};
					layout(std140) uniform UnityInstancing_Props {
						PropsArray_Type PropsArray;
						vec4 unused_3_1[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RingTex;
					uniform  sampler2D _RampTex;
					in  vec3 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					in  vec2 vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					in  vec3 vs_NORMAL0;
					flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					int u_xlati5;
					vec3 u_xlat6;
					float u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = abs(u_xlat0.x) * 3.1415;
					    u_xlat0.x = cos(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.5;
					    u_xlat5.x = inversesqrt(vs_TEXCOORD4.y);
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat2.y = u_xlat1.y * _Displacement;
					    u_xlat12.y = u_xlat1.y * _Displacement_Ring;
					    u_xlat2.x = float(0.0);
					    u_xlat12.x = float(0.0);
					    u_xlat5.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
					    u_xlat1.xy = u_xlat12.xy + vs_TEXCOORD3.xy;
					    u_xlat1 = texture(_RingTex, u_xlat1.xy);
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat5.x = u_xlat2.x * vs_COLOR0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat5.x;
					    u_xlat5.x = vs_TEXCOORD4.y * vs_TEXCOORD4.y + (-u_xlat0.x);
					    u_xlat2.x = u_xlat5.x + 1.0;
					    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					    u_xlat2.yz = vec2(-1.0, -3.0) + vec2(PropsArray.PropsArray._Intensity);
					    u_xlat2.yz = clamp(u_xlat2.yz, 0.0, 1.0);
					    u_xlat5.x = PropsArray.PropsArray._Intensity;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat3 = texture(_RampTex, u_xlat2.xy);
					    u_xlat2.w = 0.0;
					    u_xlat4 = texture(_RampTex, u_xlat2.wy);
					    u_xlat6.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
					    u_xlat10 = (-vs_TEXCOORD4.y) + 1.0;
					    u_xlat10 = u_xlat10 * u_xlat1.x;
					    u_xlat10 = u_xlat2.y * u_xlat10;
					    u_xlat15 = (-u_xlat2.z) + 1.0;
					    u_xlat10 = u_xlat15 * u_xlat10;
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat6.xyz + u_xlat3.xyz;
					    u_xlat15 = (-_BrightnessMin) + _BrightnessMax;
					    u_xlat15 = u_xlat2.y * u_xlat15 + _BrightnessMin;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat15 = (-vs_TEXCOORD4.y) * vs_TEXCOORD4.y + 1.0;
					    u_xlat2.x = u_xlat15 * u_xlat0.x;
					    u_xlat0.x = (-u_xlat0.x) * u_xlat15 + u_xlat15;
					    u_xlat1.w = u_xlat10 * u_xlat0.x + u_xlat2.x;
					    SV_Target0 = u_xlat5.xxxx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "INSTANCING_ON" }
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
						vec4 unused_0_0[4];
						float _Displacement;
						float _Displacement_Ring;
						float _BrightnessMin;
						float _BrightnessMax;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct PropsArray_Type {
						float PropsArray._Intensity;
					};
					layout(std140) uniform UnityInstancing_Props {
						PropsArray_Type PropsArray;
						vec4 unused_3_1[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RingTex;
					uniform  sampler2D _RampTex;
					in  vec3 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					in  vec2 vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					in  vec3 vs_NORMAL0;
					flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					int u_xlati5;
					vec3 u_xlat6;
					float u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = abs(u_xlat0.x) * 3.1415;
					    u_xlat0.x = cos(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.5;
					    u_xlat5.x = inversesqrt(vs_TEXCOORD4.y);
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat2.y = u_xlat1.y * _Displacement;
					    u_xlat12.y = u_xlat1.y * _Displacement_Ring;
					    u_xlat2.x = float(0.0);
					    u_xlat12.x = float(0.0);
					    u_xlat5.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
					    u_xlat1.xy = u_xlat12.xy + vs_TEXCOORD3.xy;
					    u_xlat1 = texture(_RingTex, u_xlat1.xy);
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat5.x = u_xlat2.x * vs_COLOR0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat5.x;
					    u_xlat5.x = vs_TEXCOORD4.y * vs_TEXCOORD4.y + (-u_xlat0.x);
					    u_xlat2.x = u_xlat5.x + 1.0;
					    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					    u_xlat2.yz = vec2(-1.0, -3.0) + vec2(PropsArray.PropsArray._Intensity);
					    u_xlat2.yz = clamp(u_xlat2.yz, 0.0, 1.0);
					    u_xlat5.x = PropsArray.PropsArray._Intensity;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat3 = texture(_RampTex, u_xlat2.xy);
					    u_xlat2.w = 0.0;
					    u_xlat4 = texture(_RampTex, u_xlat2.wy);
					    u_xlat6.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
					    u_xlat10 = (-vs_TEXCOORD4.y) + 1.0;
					    u_xlat10 = u_xlat10 * u_xlat1.x;
					    u_xlat10 = u_xlat2.y * u_xlat10;
					    u_xlat15 = (-u_xlat2.z) + 1.0;
					    u_xlat10 = u_xlat15 * u_xlat10;
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat6.xyz + u_xlat3.xyz;
					    u_xlat15 = (-_BrightnessMin) + _BrightnessMax;
					    u_xlat15 = u_xlat2.y * u_xlat15 + _BrightnessMin;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat15 = (-vs_TEXCOORD4.y) * vs_TEXCOORD4.y + 1.0;
					    u_xlat2.x = u_xlat15 * u_xlat0.x;
					    u_xlat0.x = (-u_xlat0.x) * u_xlat15 + u_xlat15;
					    u_xlat1.w = u_xlat10 * u_xlat0.x + u_xlat2.x;
					    SV_Target0 = u_xlat5.xxxx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "INSTANCING_ON" }
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
						vec4 unused_0_0[4];
						float _Displacement;
						float _Displacement_Ring;
						float _BrightnessMin;
						float _BrightnessMax;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct PropsArray_Type {
						float PropsArray._Intensity;
					};
					layout(std140) uniform UnityInstancing_Props {
						PropsArray_Type PropsArray;
						vec4 unused_3_1[2];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _RingTex;
					uniform  sampler2D _RampTex;
					in  vec3 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					in  vec2 vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					in  vec3 vs_NORMAL0;
					flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					int u_xlati5;
					vec3 u_xlat6;
					float u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, vs_NORMAL0.xyz);
					    u_xlat0.x = abs(u_xlat0.x) * 3.1415;
					    u_xlat0.x = cos(u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) * 0.5 + 1.5;
					    u_xlat5.x = inversesqrt(vs_TEXCOORD4.y);
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD2.xy);
					    u_xlat2.y = u_xlat1.y * _Displacement;
					    u_xlat12.y = u_xlat1.y * _Displacement_Ring;
					    u_xlat2.x = float(0.0);
					    u_xlat12.x = float(0.0);
					    u_xlat5.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
					    u_xlat1.xy = u_xlat12.xy + vs_TEXCOORD3.xy;
					    u_xlat1 = texture(_RingTex, u_xlat1.xy);
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat5.x = u_xlat2.x * vs_COLOR0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat5.x;
					    u_xlat5.x = vs_TEXCOORD4.y * vs_TEXCOORD4.y + (-u_xlat0.x);
					    u_xlat2.x = u_xlat5.x + 1.0;
					    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					    u_xlat2.yz = vec2(-1.0, -3.0) + vec2(PropsArray.PropsArray._Intensity);
					    u_xlat2.yz = clamp(u_xlat2.yz, 0.0, 1.0);
					    u_xlat5.x = PropsArray.PropsArray._Intensity;
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat3 = texture(_RampTex, u_xlat2.xy);
					    u_xlat2.w = 0.0;
					    u_xlat4 = texture(_RampTex, u_xlat2.wy);
					    u_xlat6.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
					    u_xlat10 = (-vs_TEXCOORD4.y) + 1.0;
					    u_xlat10 = u_xlat10 * u_xlat1.x;
					    u_xlat10 = u_xlat2.y * u_xlat10;
					    u_xlat15 = (-u_xlat2.z) + 1.0;
					    u_xlat10 = u_xlat15 * u_xlat10;
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat6.xyz + u_xlat3.xyz;
					    u_xlat15 = (-_BrightnessMin) + _BrightnessMax;
					    u_xlat15 = u_xlat2.y * u_xlat15 + _BrightnessMin;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat15 = (-vs_TEXCOORD4.y) * vs_TEXCOORD4.y + 1.0;
					    u_xlat2.x = u_xlat15 * u_xlat0.x;
					    u_xlat0.x = (-u_xlat0.x) * u_xlat15 + u_xlat15;
					    u_xlat1.w = u_xlat10 * u_xlat0.x + u_xlat2.x;
					    SV_Target0 = u_xlat5.xxxx * u_xlat1;
					    return;
					}"
				}
			}
		}
	}
}