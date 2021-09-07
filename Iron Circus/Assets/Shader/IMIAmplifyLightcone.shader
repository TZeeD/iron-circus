Shader "IMI/Amplify/Lightcone" {
	Properties {
		_Color ("Color", Vector) = (0.2028302,1,0.8343505,0)
		_Fesnel_intensity ("Fesnel_intensity", Range(0, 10)) = 0
		_Inner_cone ("Inner_cone", Float) = 1
		_Transparency ("Transparency", Range(0, 1)) = 0.5
		_Fog_speed ("Fog_speed", Vector) = (1,0,0,0)
		_FogTexture ("FogTexture", 2D) = "white" {}
		_Fog_tiling ("Fog_tiling", Float) = 0
	}
	SubShader {
		LOD 100
		Tags { "RenderType" = "Transparent" }
		Pass {
			Name "SubShader 0 Pass 0"
			LOD 100
			Tags { "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ZWrite Off
			GpuProgramID 28286
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat7;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD0.w = 0.0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat7;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD0.w = 0.0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat7;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD0.w = 0.0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
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
						vec4 unused_3_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					flat out uint vs_SV_InstanceID0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].xyz * in_POSITION0.zzz + u_xlat3.xyz;
					    vs_TEXCOORD0.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat3.xyz;
					    vs_TEXCOORD0.w = 0.0;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
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
						vec4 unused_3_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					flat out uint vs_SV_InstanceID0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].xyz * in_POSITION0.zzz + u_xlat3.xyz;
					    vs_TEXCOORD0.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat3.xyz;
					    vs_TEXCOORD0.w = 0.0;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
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
						vec4 unused_3_1[16];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					flat out uint vs_SV_InstanceID0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_SV_InstanceID0 =  uint(gl_InstanceID);
					    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].xyz * in_POSITION0.zzz + u_xlat3.xyz;
					    vs_TEXCOORD0.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat3.xyz;
					    vs_TEXCOORD0.w = 0.0;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.w = 0.0;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat1.zw;
					    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
						float _Inner_cone;
						float _Fesnel_intensity;
						float _Transparency;
						vec2 _Fog_speed;
						float _Fog_tiling;
						vec4 unused_0_7;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _FogTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _Inner_cone;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fesnel_intensity;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat0.x = u_xlat0.x * _Transparency;
					    u_xlat0.xyz = u_xlat0.xxx * _Color.xyz;
					    u_xlat1.xy = vs_TEXCOORD2.xy * vec2(vec2(_Fog_tiling, _Fog_tiling));
					    u_xlat6 = _Time.y * 0.200000003;
					    u_xlat1.xy = vec2(u_xlat6) * _Fog_speed.xy + u_xlat1.xy;
					    u_xlat1 = texture(_FogTexture, u_xlat1.xy);
					    u_xlat6 = u_xlat1.x * 0.699999988 + 0.300000012;
					    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.yz);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat2 = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat2 = float(1.0) / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + u_xlat2;
					    u_xlat0.x = u_xlat0.x * 0.00999999978;
					    SV_Target0.w = min(abs(u_xlat0.x), 1.0);
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
						float _Inner_cone;
						float _Fesnel_intensity;
						float _Transparency;
						vec2 _Fog_speed;
						float _Fog_tiling;
						vec4 unused_0_7;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _FogTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _Inner_cone;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fesnel_intensity;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat0.x = u_xlat0.x * _Transparency;
					    u_xlat0.xyz = u_xlat0.xxx * _Color.xyz;
					    u_xlat1.xy = vs_TEXCOORD2.xy * vec2(vec2(_Fog_tiling, _Fog_tiling));
					    u_xlat6 = _Time.y * 0.200000003;
					    u_xlat1.xy = vec2(u_xlat6) * _Fog_speed.xy + u_xlat1.xy;
					    u_xlat1 = texture(_FogTexture, u_xlat1.xy);
					    u_xlat6 = u_xlat1.x * 0.699999988 + 0.300000012;
					    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.yz);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat2 = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat2 = float(1.0) / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + u_xlat2;
					    u_xlat0.x = u_xlat0.x * 0.00999999978;
					    SV_Target0.w = min(abs(u_xlat0.x), 1.0);
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
						float _Inner_cone;
						float _Fesnel_intensity;
						float _Transparency;
						vec2 _Fog_speed;
						float _Fog_tiling;
						vec4 unused_0_7;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _FogTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _Inner_cone;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fesnel_intensity;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat0.x = u_xlat0.x * _Transparency;
					    u_xlat0.xyz = u_xlat0.xxx * _Color.xyz;
					    u_xlat1.xy = vs_TEXCOORD2.xy * vec2(vec2(_Fog_tiling, _Fog_tiling));
					    u_xlat6 = _Time.y * 0.200000003;
					    u_xlat1.xy = vec2(u_xlat6) * _Fog_speed.xy + u_xlat1.xy;
					    u_xlat1 = texture(_FogTexture, u_xlat1.xy);
					    u_xlat6 = u_xlat1.x * 0.699999988 + 0.300000012;
					    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.yz);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat2 = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat2 = float(1.0) / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + u_xlat2;
					    u_xlat0.x = u_xlat0.x * 0.00999999978;
					    SV_Target0.w = min(abs(u_xlat0.x), 1.0);
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
						vec4 unused_0_0[2];
						vec4 _Color;
						float _Inner_cone;
						float _Fesnel_intensity;
						float _Transparency;
						vec2 _Fog_speed;
						float _Fog_tiling;
						vec4 unused_0_7;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _FogTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _Inner_cone;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fesnel_intensity;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat0.x = u_xlat0.x * _Transparency;
					    u_xlat0.xyz = u_xlat0.xxx * _Color.xyz;
					    u_xlat1.xy = vs_TEXCOORD2.xy * vec2(vec2(_Fog_tiling, _Fog_tiling));
					    u_xlat6 = _Time.y * 0.200000003;
					    u_xlat1.xy = vec2(u_xlat6) * _Fog_speed.xy + u_xlat1.xy;
					    u_xlat1 = texture(_FogTexture, u_xlat1.xy);
					    u_xlat6 = u_xlat1.x * 0.699999988 + 0.300000012;
					    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.yz);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat2 = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat2 = float(1.0) / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + u_xlat2;
					    u_xlat0.x = u_xlat0.x * 0.00999999978;
					    SV_Target0.w = min(abs(u_xlat0.x), 1.0);
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
						vec4 unused_0_0[2];
						vec4 _Color;
						float _Inner_cone;
						float _Fesnel_intensity;
						float _Transparency;
						vec2 _Fog_speed;
						float _Fog_tiling;
						vec4 unused_0_7;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _FogTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _Inner_cone;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fesnel_intensity;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat0.x = u_xlat0.x * _Transparency;
					    u_xlat0.xyz = u_xlat0.xxx * _Color.xyz;
					    u_xlat1.xy = vs_TEXCOORD2.xy * vec2(vec2(_Fog_tiling, _Fog_tiling));
					    u_xlat6 = _Time.y * 0.200000003;
					    u_xlat1.xy = vec2(u_xlat6) * _Fog_speed.xy + u_xlat1.xy;
					    u_xlat1 = texture(_FogTexture, u_xlat1.xy);
					    u_xlat6 = u_xlat1.x * 0.699999988 + 0.300000012;
					    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.yz);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat2 = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat2 = float(1.0) / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + u_xlat2;
					    u_xlat0.x = u_xlat0.x * 0.00999999978;
					    SV_Target0.w = min(abs(u_xlat0.x), 1.0);
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
						vec4 unused_0_0[2];
						vec4 _Color;
						float _Inner_cone;
						float _Fesnel_intensity;
						float _Transparency;
						vec2 _Fog_speed;
						float _Fog_tiling;
						vec4 unused_0_7;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _FogTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _Inner_cone;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fesnel_intensity;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat0.x = u_xlat0.x * _Transparency;
					    u_xlat0.xyz = u_xlat0.xxx * _Color.xyz;
					    u_xlat1.xy = vs_TEXCOORD2.xy * vec2(vec2(_Fog_tiling, _Fog_tiling));
					    u_xlat6 = _Time.y * 0.200000003;
					    u_xlat1.xy = vec2(u_xlat6) * _Fog_speed.xy + u_xlat1.xy;
					    u_xlat1 = texture(_FogTexture, u_xlat1.xy);
					    u_xlat6 = u_xlat1.x * 0.699999988 + 0.300000012;
					    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.zxy / vs_TEXCOORD3.www;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.yz);
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat2 = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat2 = float(1.0) / u_xlat2;
					    u_xlat0.x = (-u_xlat0.x) + u_xlat2;
					    u_xlat0.x = u_xlat0.x * 0.00999999978;
					    SV_Target0.w = min(abs(u_xlat0.x), 1.0);
					    return;
					}"
				}
			}
		}
	}
	CustomEditor "ASEMaterialInspector"
}