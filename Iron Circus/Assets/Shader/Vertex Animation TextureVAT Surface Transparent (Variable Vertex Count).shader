Shader "Vertex Animation Texture/VAT Surface Transparent (Variable Vertex Count)" {
	Properties {
		_Color ("Color", Vector) = (1,1,1,1)
		_Glossiness ("Smoothness", Range(0, 1)) = 0.5
		_Metallic ("Metallic", Range(0, 1)) = 0
		_VATTime ("VAT Current Frame", Range(0, 1)) = 0
		[NoScaleOffset] _VATPositions ("VAT Positions", 2D) = "white" {}
		[NoScaleOffset] _VATNormals ("VAT Normals", 2D) = "white" {}
		_VATNumFrames ("VAT Number of Frames", Float) = 20
		_VATBounds ("VAT Bounds", Vector) = (1,1,1,1)
	}
	SubShader {
		LOD 200
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			LOD 200
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 45619
			Program "vp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat0.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
					    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat15 = u_xlat0.y * u_xlat0.y;
					    u_xlat15 = u_xlat0.x * u_xlat0.x + (-u_xlat15);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat2);
					    u_xlat0.y = dot(unity_SHBg, u_xlat2);
					    u_xlat0.z = dot(unity_SHBb, u_xlat2);
					    u_xlat0.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat0.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
					    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat15 = u_xlat0.y * u_xlat0.y;
					    u_xlat15 = u_xlat0.x * u_xlat0.x + (-u_xlat15);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat2);
					    u_xlat0.y = dot(unity_SHBg, u_xlat2);
					    u_xlat0.z = dot(unity_SHBb, u_xlat2);
					    u_xlat0.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat0.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
					    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat15 = u_xlat0.y * u_xlat0.y;
					    u_xlat15 = u_xlat0.x * u_xlat0.x + (-u_xlat15);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat2);
					    u_xlat0.y = dot(unity_SHBg, u_xlat2);
					    u_xlat0.z = dot(unity_SHBb, u_xlat2);
					    u_xlat0.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat0.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
					    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat15 = u_xlat0.y * u_xlat0.y;
					    u_xlat15 = u_xlat0.x * u_xlat0.x + (-u_xlat15);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat2);
					    u_xlat0.y = dot(unity_SHBg, u_xlat2);
					    u_xlat0.z = dot(unity_SHBb, u_xlat2);
					    u_xlat0.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat0.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
					    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat15 = u_xlat0.y * u_xlat0.y;
					    u_xlat15 = u_xlat0.x * u_xlat0.x + (-u_xlat15);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat2);
					    u_xlat0.y = dot(unity_SHBg, u_xlat2);
					    u_xlat0.z = dot(unity_SHBb, u_xlat2);
					    u_xlat0.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat0.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat0.xxxx + u_xlat4;
					    u_xlat2 = u_xlat1 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat15 = u_xlat0.y * u_xlat0.y;
					    u_xlat15 = u_xlat0.x * u_xlat0.x + (-u_xlat15);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat2);
					    u_xlat0.y = dot(unity_SHBg, u_xlat2);
					    u_xlat0.z = dot(unity_SHBb, u_xlat2);
					    u_xlat0.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat11;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb30 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb30){
					        u_xlatb30 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb30)) ? u_xlat1.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat30 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat30, u_xlat11);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat30 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat1.xw = (-vec2(_Glossiness)) + vec2(1.0, 1.0);
					    u_xlat2.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat0.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * _LightColor0.xyz;
					    u_xlatb30 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb30){
					        u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat30 = inversesqrt(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat30) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat30 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat30 = min(u_xlat5.z, u_xlat30);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat30 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat30 = u_xlat30 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat30);
					    u_xlat1.x = u_xlat4.w + -1.0;
					    u_xlat1.x = unity_SpecCube0_HDR.w * u_xlat1.x + 1.0;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.y;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * u_xlat1.xxx;
					    u_xlatb32 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb32){
					        u_xlatb32 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb32){
					            u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat32 = inversesqrt(u_xlat32);
					            u_xlat6.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat32 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat32 = min(u_xlat7.z, u_xlat32);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat32) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat30);
					        u_xlat30 = u_xlat2.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat30 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat32 = u_xlat1.x + u_xlat1.x;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat32)) + u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat6.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat6.y = (-u_xlat1.x) + 1.0;
					    u_xlat6.zw = u_xlat6.xy * u_xlat6.xy;
					    u_xlat0.xy = u_xlat6.xy * u_xlat6.xw;
					    u_xlat1.yz = u_xlat6.zy * u_xlat0.xy;
					    u_xlat0.x = (-u_xlat30) + 1.0;
					    u_xlat0.x = u_xlat0.x + _Glossiness;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6 = texture(unity_NHxRoughness, u_xlat1.yw);
					    u_xlat10.x = u_xlat6.x * 16.0;
					    u_xlat1.xyw = u_xlat4.xyz * u_xlat10.xxx;
					    u_xlat10.xyz = _Color.xyz * vec3(u_xlat30) + u_xlat1.xyw;
					    u_xlat1.xyw = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat0.xxx;
					    u_xlat2.xyz = u_xlat1.zzz * u_xlat2.xyz + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat10.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = (-_Glossiness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat5.xy = (-u_xlat2.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat31 = u_xlat2.x * u_xlat5.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat31 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = u_xlat10 * u_xlat10;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21 = u_xlat2.x * u_xlat2.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat10 = (-u_xlat10) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat31) + _Glossiness;
					    u_xlat20 = u_xlat20 + 1.0;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat2.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat11.xyz = _Color.xyz * vec3(u_xlat31) + u_xlat2.xyz;
					    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xyz;
					    u_xlat2.xyz = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat0.x = (-u_xlat1.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat3.xyz = (-u_xlat4.xyz) + vec3(u_xlat20);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = (-_Glossiness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat31 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat31 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat31) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = dot(u_xlat10.xx, u_xlat2.xx);
					    u_xlat10.x = u_xlat10.x + -0.5;
					    u_xlat20 = (-u_xlat1.x) + 1.0;
					    u_xlat21 = u_xlat20 * u_xlat20;
					    u_xlat21 = u_xlat21 * u_xlat21;
					    u_xlat20 = u_xlat20 * u_xlat21;
					    u_xlat20 = u_xlat10.x * u_xlat20 + 1.0;
					    u_xlat21 = -abs(u_xlat30) + 1.0;
					    u_xlat12.x = u_xlat21 * u_xlat21;
					    u_xlat12.x = u_xlat12.x * u_xlat12.x;
					    u_xlat21 = u_xlat21 * u_xlat12.x;
					    u_xlat10.x = u_xlat10.x * u_xlat21 + 1.0;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat20 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = max(u_xlat20, 0.00200000009);
					    u_xlat2.x = (-u_xlat20) + 1.0;
					    u_xlat12.x = abs(u_xlat30) * u_xlat2.x + u_xlat20;
					    u_xlat2.x = u_xlat1.x * u_xlat2.x + u_xlat20;
					    u_xlat30 = abs(u_xlat30) * u_xlat2.x;
					    u_xlat30 = u_xlat1.x * u_xlat12.x + u_xlat30;
					    u_xlat30 = u_xlat30 + 9.99999975e-06;
					    u_xlat30 = 0.5 / u_xlat30;
					    u_xlat2.x = u_xlat20 * u_xlat20;
					    u_xlat12.x = u_xlat11 * u_xlat2.x + (-u_xlat11);
					    u_xlat11 = u_xlat12.x * u_xlat11 + 1.0;
					    u_xlat2.x = u_xlat2.x * 0.318309873;
					    u_xlat11 = u_xlat11 * u_xlat11 + 1.00000001e-07;
					    u_xlat11 = u_xlat2.x / u_xlat11;
					    u_xlat30 = u_xlat30 * u_xlat11;
					    u_xlat10.z = u_xlat30 * 3.14159274;
					    u_xlat10.xz = u_xlat1.xx * u_xlat10.xz;
					    u_xlat30 = max(u_xlat10.z, 0.0);
					    u_xlat20 = u_xlat20 * u_xlat20 + 1.0;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat31) + _Glossiness;
					    u_xlat1.x = u_xlat1.x + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = u_xlat10.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    u_xlat7.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat7.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat3.xyz;
					    u_xlat0.xyw = u_xlat6.xyz * u_xlat2.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat20);
					    u_xlat1.xyw = (-u_xlat4.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyw + u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat36;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat12.x, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat1.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2.xw = (-vec2(_Glossiness)) + vec2(1.0, 1.0);
					    u_xlat12.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat0.xyz);
					    u_xlat3.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb33)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25;
					        u_xlat1.x = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat36 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat33 = max(u_xlat33, u_xlat1.x);
					        u_xlat4.x = min(u_xlat36, u_xlat33);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD0.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD0.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4.xyz = u_xlat5.xyz + vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat12.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat12.xyz;
					    }
					    u_xlat33 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat33 = u_xlat33 * u_xlat2.x;
					    u_xlat33 = u_xlat33 * 6.0;
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat33);
					    u_xlat1.x = u_xlat5.w + -1.0;
					    u_xlat1.x = unity_SpecCube0_HDR.w * u_xlat1.x + 1.0;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.y;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * u_xlat1.xxx;
					    u_xlatb2 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb2){
					        u_xlatb2 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb2){
					            u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat2.x = inversesqrt(u_xlat2.x);
					            u_xlat7.xyz = u_xlat12.xyz * u_xlat2.xxx;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec4 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat2.x = min(u_xlat8.y, u_xlat8.x);
					            u_xlat2.x = min(u_xlat8.z, u_xlat2.x);
					            u_xlat8.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat7.xyz * u_xlat2.xxx + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat33);
					        u_xlat33 = u_xlat7.w + -1.0;
					        u_xlat33 = unity_SpecCube1_HDR.w * u_xlat33 + 1.0;
					        u_xlat33 = log2(u_xlat33);
					        u_xlat33 = u_xlat33 * unity_SpecCube1_HDR.y;
					        u_xlat33 = exp2(u_xlat33);
					        u_xlat33 = u_xlat33 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat7.xyz * vec3(u_xlat33);
					        u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz + (-u_xlat12.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat12.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat33 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat7.xyz = vec3(u_xlat33) * _Color.xyz;
					    u_xlat34 = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat2.x = u_xlat34 + u_xlat34;
					    u_xlat0.xyz = u_xlat1.xyz * (-u_xlat2.xxx) + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat34 = u_xlat34;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat8.y = (-u_xlat34) + 1.0;
					    u_xlat8.zw = u_xlat8.xy * u_xlat8.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat8.xw;
					    u_xlat2.yz = u_xlat8.zy * u_xlat0.xy;
					    u_xlat0.x = (-u_xlat33) + _Glossiness;
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8 = texture(unity_NHxRoughness, u_xlat2.yw);
					    u_xlat11.x = u_xlat8.x * 16.0;
					    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz + u_xlat7.xyz;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
					    u_xlat2.xyw = (-u_xlat5.xyz) + u_xlat0.xxx;
					    u_xlat2.xyz = u_xlat2.zzz * u_xlat2.xyw + u_xlat5.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat6.xyz;
					    u_xlat2.xyz = u_xlat4.xyz * u_xlat7.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat11.xyz * u_xlat1.xyz + u_xlat2.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat11;
					vec3 u_xlat12;
					vec3 u_xlat13;
					float u_xlat15;
					float u_xlat22;
					float u_xlat23;
					float u_xlat24;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlatb34 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb34){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat13.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat13.xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat13.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat13.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat13.x = (-_Glossiness) + 1.0;
					    u_xlat24 = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat24 = u_xlat24 + u_xlat24;
					    u_xlat3.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
					    u_xlat2.xzw = u_xlat2.xxx * _LightColor0.xyz;
					    if(u_xlatb34){
					        u_xlatb34 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb34)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat34 = u_xlat4.y * 0.25;
					        u_xlat36 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat34 = max(u_xlat34, u_xlat36);
					        u_xlat4.x = min(u_xlat15, u_xlat34);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD0.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD0.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4.xyz = u_xlat5.xyz + vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb34 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb34){
					        u_xlat34 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat34 = inversesqrt(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat34 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat34 = min(u_xlat6.z, u_xlat34);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat6.xy = (-u_xlat13.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat34 = u_xlat13.x * u_xlat6.x;
					    u_xlat34 = u_xlat34 * 6.0;
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat34);
					    u_xlat36 = u_xlat5.w + -1.0;
					    u_xlat36 = unity_SpecCube0_HDR.w * u_xlat36 + 1.0;
					    u_xlat36 = log2(u_xlat36);
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.y;
					    u_xlat36 = exp2(u_xlat36);
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.x;
					    u_xlat6.xzw = u_xlat5.xyz * vec3(u_xlat36);
					    u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb37){
					        u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb37){
					            u_xlat37 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat37 = inversesqrt(u_xlat37);
					            u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat37);
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat37 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat37 = min(u_xlat8.z, u_xlat37);
					            u_xlat8.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat37) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat3.xyz, u_xlat34);
					        u_xlat34 = u_xlat7.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat34 + 1.0;
					        u_xlat34 = log2(u_xlat34);
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.y;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat36) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xzw = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat34 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat3.xyz = vec3(u_xlat34) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat34 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat7.xyz = vec3(u_xlat34) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat36 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11 = u_xlat13.x * u_xlat13.x;
					    u_xlat22 = u_xlat11 * u_xlat11;
					    u_xlat12.x = u_xlat36 * u_xlat36;
					    u_xlat23 = u_xlat11 * u_xlat11 + -1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat23 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat23 = u_xlat13.x * u_xlat13.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat23;
					    u_xlat12.x = u_xlat12.x * u_xlat12.x;
					    u_xlat0.x = u_xlat0.x * u_xlat12.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat22 / u_xlat0.x;
					    u_xlat11 = u_xlat13.x * u_xlat11;
					    u_xlat11 = (-u_xlat11) * u_xlat6.y + 1.0;
					    u_xlat22 = (-u_xlat34) + _Glossiness;
					    u_xlat22 = u_xlat22 + 1.0;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat12.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat7.xyz;
					    u_xlat12.xyz = u_xlat2.xzw * u_xlat12.xyz;
					    u_xlat2.xyz = u_xlat4.xyz * u_xlat7.xyz;
					    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat33) + u_xlat2.xyz;
					    u_xlat0.xyw = u_xlat6.xzw * vec3(u_xlat11);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat2.xyz = (-u_xlat5.xyz) + vec3(u_xlat22);
					    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat0.xyw * u_xlat2.xyz + u_xlat12.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat12;
					vec3 u_xlat13;
					float u_xlat15;
					float u_xlat22;
					float u_xlat23;
					float u_xlat24;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlatb34 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb34){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat13.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat13.xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat13.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat13.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat13.x = (-_Glossiness) + 1.0;
					    u_xlat24 = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat24 = u_xlat24 + u_xlat24;
					    u_xlat3.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
					    u_xlat2.xzw = u_xlat2.xxx * _LightColor0.xyz;
					    if(u_xlatb34){
					        u_xlatb34 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb34)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat34 = u_xlat4.y * 0.25;
					        u_xlat36 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat34 = max(u_xlat34, u_xlat36);
					        u_xlat4.x = min(u_xlat15, u_xlat34);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD0.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD0.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4.xyz = u_xlat5.xyz + vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb34 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb34){
					        u_xlat34 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat34 = inversesqrt(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat34 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat34 = min(u_xlat6.z, u_xlat34);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat34 = (-u_xlat13.x) * 0.699999988 + 1.70000005;
					    u_xlat34 = u_xlat34 * u_xlat13.x;
					    u_xlat34 = u_xlat34 * 6.0;
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat34);
					    u_xlat36 = u_xlat5.w + -1.0;
					    u_xlat36 = unity_SpecCube0_HDR.w * u_xlat36 + 1.0;
					    u_xlat36 = log2(u_xlat36);
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.y;
					    u_xlat36 = exp2(u_xlat36);
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat36);
					    u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb37){
					        u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb37){
					            u_xlat37 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat37 = inversesqrt(u_xlat37);
					            u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat37);
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat37 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat37 = min(u_xlat8.z, u_xlat37);
					            u_xlat8.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat37) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat3.xyz, u_xlat34);
					        u_xlat34 = u_xlat7.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat34 + 1.0;
					        u_xlat34 = log2(u_xlat34);
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.y;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat36) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat34 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat3.xyz = vec3(u_xlat34) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat34 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat7.xyz = vec3(u_xlat34) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = dot(u_xlat11.xx, u_xlat13.xx);
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22 = (-u_xlat1.x) + 1.0;
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat22 = u_xlat11.x * u_xlat22 + 1.0;
					    u_xlat23 = -abs(u_xlat33) + 1.0;
					    u_xlat3.x = u_xlat23 * u_xlat23;
					    u_xlat3.x = u_xlat3.x * u_xlat3.x;
					    u_xlat23 = u_xlat23 * u_xlat3.x;
					    u_xlat11.x = u_xlat11.x * u_xlat23 + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat22;
					    u_xlat22 = u_xlat13.x * u_xlat13.x;
					    u_xlat22 = max(u_xlat22, 0.00200000009);
					    u_xlat13.x = (-u_xlat22) + 1.0;
					    u_xlat3.x = abs(u_xlat33) * u_xlat13.x + u_xlat22;
					    u_xlat13.x = u_xlat1.x * u_xlat13.x + u_xlat22;
					    u_xlat33 = abs(u_xlat33) * u_xlat13.x;
					    u_xlat33 = u_xlat1.x * u_xlat3.x + u_xlat33;
					    u_xlat33 = u_xlat33 + 9.99999975e-06;
					    u_xlat33 = 0.5 / u_xlat33;
					    u_xlat13.x = u_xlat22 * u_xlat22;
					    u_xlat3.x = u_xlat12 * u_xlat13.x + (-u_xlat12);
					    u_xlat12 = u_xlat3.x * u_xlat12 + 1.0;
					    u_xlat13.x = u_xlat13.x * 0.318309873;
					    u_xlat12 = u_xlat12 * u_xlat12 + 1.00000001e-07;
					    u_xlat12 = u_xlat13.x / u_xlat12;
					    u_xlat33 = u_xlat33 * u_xlat12;
					    u_xlat11.z = u_xlat33 * 3.14159274;
					    u_xlat11.xz = u_xlat1.xx * u_xlat11.xz;
					    u_xlat33 = max(u_xlat11.z, 0.0);
					    u_xlat22 = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat33 = u_xlat33 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat34) + _Glossiness;
					    u_xlat1.x = u_xlat1.x + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xzw * u_xlat11.xxx + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xzw * vec3(u_xlat33);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat4.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat4.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat2.xyz;
					    u_xlat0.xyw = u_xlat7.xyz * u_xlat3.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat22);
					    u_xlat1.xyw = (-u_xlat5.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat1.xyw + u_xlat5.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat1.xw = (-vec2(_Glossiness)) + vec2(1.0, 1.0);
					    u_xlat30 = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat30 = u_xlat30 + u_xlat30;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat30)) + (-u_xlat0.xyz);
					    u_xlat3 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat30 = log2(u_xlat3.w);
					    u_xlat30 = u_xlat30 * unity_Lightmap_HDR.y;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat30 * unity_Lightmap_HDR.x;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30);
					    u_xlatb30 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb30){
					        u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat30 = inversesqrt(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat30) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat30 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat30 = min(u_xlat5.z, u_xlat30);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat30 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat30 = u_xlat30 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat30);
					    u_xlat1.x = u_xlat4.w + -1.0;
					    u_xlat1.x = unity_SpecCube0_HDR.w * u_xlat1.x + 1.0;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.y;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * u_xlat1.xxx;
					    u_xlatb32 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb32){
					        u_xlatb32 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb32){
					            u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat32 = inversesqrt(u_xlat32);
					            u_xlat6.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec4 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat32 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat32 = min(u_xlat7.z, u_xlat32);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat32) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat30);
					        u_xlat30 = u_xlat2.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat30 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat30) * _Color.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat32 = u_xlat1.x + u_xlat1.x;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat32)) + u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat7.y = (-u_xlat1.x) + 1.0;
					    u_xlat7.zw = u_xlat7.xy * u_xlat7.xy;
					    u_xlat0.xy = u_xlat7.xy * u_xlat7.xw;
					    u_xlat1.yz = u_xlat7.zy * u_xlat0.xy;
					    u_xlat0.x = (-u_xlat30) + 1.0;
					    u_xlat0.x = u_xlat0.x + _Glossiness;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7 = texture(unity_NHxRoughness, u_xlat1.yw);
					    u_xlat10.x = u_xlat7.x * 16.0;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat6.xyz;
					    u_xlat1.xyw = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat0.xxx;
					    u_xlat2.xyz = u_xlat1.zzz * u_xlat2.xyz + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat6.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat10.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					float u_xlat20;
					vec2 u_xlat21;
					float u_xlat30;
					float u_xlat32;
					bool u_xlatb32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat21.y = (-_Glossiness) + 1.0;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlat3 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat32 = log2(u_xlat3.w);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.y;
					    u_xlat32 = exp2(u_xlat32);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.x;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat32);
					    u_xlatb32 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb32){
					        u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat32 = inversesqrt(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat32 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat32 = min(u_xlat5.z, u_xlat32);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat32) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat5.xy = (-u_xlat21.yy) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat32 = u_xlat21.y * u_xlat5.x;
					    u_xlat32 = u_xlat32 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat32);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat32);
					        u_xlat32 = u_xlat2.w + -1.0;
					        u_xlat32 = unity_SpecCube1_HDR.w * u_xlat32 + 1.0;
					        u_xlat32 = log2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.y;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat32 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat32) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.y = u_xlat21.y * u_xlat21.y;
					    u_xlat20 = u_xlat0.y * u_xlat0.y;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21.x = u_xlat0.y * u_xlat0.y + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21.x = u_xlat21.y * u_xlat21.y + 0.5;
					    u_xlat0.xy = u_xlat21.xy * u_xlat0.xy;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = (-u_xlat0.y) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat32) + _Glossiness;
					    u_xlat20 = u_xlat20 + 1.0;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat6.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * _LightColor0.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat6.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat2.xyz;
					    u_xlat0.xyw = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat2.xyz = (-u_xlat4.xyz) + vec3(u_xlat20);
					    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat0.xyw * u_xlat2.xyz + u_xlat11.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat11;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					float u_xlat32;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat35;
					bool u_xlatb35;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat31 = (-_Glossiness) + 1.0;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlat3 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat32 = log2(u_xlat3.w);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.y;
					    u_xlat32 = exp2(u_xlat32);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.x;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat4.xyz = u_xlat2.xyz * vec3(u_xlat33);
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat33 = min(u_xlat5.z, u_xlat33);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat33 = (-u_xlat31) * 0.699999988 + 1.70000005;
					    u_xlat33 = u_xlat31 * u_xlat33;
					    u_xlat33 = u_xlat33 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat33);
					    u_xlat34 = u_xlat4.w + -1.0;
					    u_xlat34 = unity_SpecCube0_HDR.w * u_xlat34 + 1.0;
					    u_xlat34 = log2(u_xlat34);
					    u_xlat34 = u_xlat34 * unity_SpecCube0_HDR.y;
					    u_xlat34 = exp2(u_xlat34);
					    u_xlat34 = u_xlat34 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat34);
					    u_xlatb35 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb35){
					        u_xlatb35 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb35){
					            u_xlat35 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat35 = inversesqrt(u_xlat35);
					            u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat35);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat35 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat35 = min(u_xlat7.z, u_xlat35);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat35) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat33);
					        u_xlat2.x = u_xlat6.w + -1.0;
					        u_xlat2.x = unity_SpecCube1_HDR.w * u_xlat2.x + 1.0;
					        u_xlat2.x = log2(u_xlat2.x);
					        u_xlat2.x = u_xlat2.x * unity_SpecCube1_HDR.y;
					        u_xlat2.x = exp2(u_xlat2.x);
					        u_xlat2.x = u_xlat2.x * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat6.xyz * u_xlat2.xxx;
					        u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat33 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat33) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = dot(u_xlat10.xx, vec2(u_xlat31));
					    u_xlat10.x = u_xlat10.x + -0.5;
					    u_xlat20 = (-u_xlat1.x) + 1.0;
					    u_xlat21 = u_xlat20 * u_xlat20;
					    u_xlat21 = u_xlat21 * u_xlat21;
					    u_xlat20 = u_xlat20 * u_xlat21;
					    u_xlat20 = u_xlat10.x * u_xlat20 + 1.0;
					    u_xlat21 = -abs(u_xlat30) + 1.0;
					    u_xlat2.x = u_xlat21 * u_xlat21;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat21 = u_xlat21 * u_xlat2.x;
					    u_xlat10.x = u_xlat10.x * u_xlat21 + 1.0;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat20 = u_xlat31 * u_xlat31;
					    u_xlat20 = max(u_xlat20, 0.00200000009);
					    u_xlat31 = (-u_xlat20) + 1.0;
					    u_xlat2.x = abs(u_xlat30) * u_xlat31 + u_xlat20;
					    u_xlat31 = u_xlat1.x * u_xlat31 + u_xlat20;
					    u_xlat30 = abs(u_xlat30) * u_xlat31;
					    u_xlat30 = u_xlat1.x * u_xlat2.x + u_xlat30;
					    u_xlat30 = u_xlat30 + 9.99999975e-06;
					    u_xlat30 = 0.5 / u_xlat30;
					    u_xlat31 = u_xlat20 * u_xlat20;
					    u_xlat2.x = u_xlat11 * u_xlat31 + (-u_xlat11);
					    u_xlat11 = u_xlat2.x * u_xlat11 + 1.0;
					    u_xlat31 = u_xlat31 * 0.318309873;
					    u_xlat11 = u_xlat11 * u_xlat11 + 1.00000001e-07;
					    u_xlat11 = u_xlat31 / u_xlat11;
					    u_xlat30 = u_xlat30 * u_xlat11;
					    u_xlat10.z = u_xlat30 * 3.14159274;
					    u_xlat10.xz = u_xlat1.xx * u_xlat10.xz;
					    u_xlat30 = max(u_xlat10.z, 0.0);
					    u_xlat20 = u_xlat20 * u_xlat20 + 1.0;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat33) + _Glossiness;
					    u_xlat1.x = u_xlat1.x + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2.xyz = u_xlat10.xxx * _LightColor0.xyz;
					    u_xlat2.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = vec3(u_xlat30) * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = u_xlat10.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    u_xlat7.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat7.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat3.xyz;
					    u_xlat0.xyw = u_xlat6.xyz * u_xlat2.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat20);
					    u_xlat1.xyw = (-u_xlat4.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyw + u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat13;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat1.xw = (-vec2(_Glossiness)) + vec2(1.0, 1.0);
					    u_xlat30 = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat30 = u_xlat30 + u_xlat30;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat30)) + (-u_xlat0.xyz);
					    u_xlatb30 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb30){
					        u_xlatb30 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb30)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat30 = u_xlat3.y * 0.25;
					        u_xlat32 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat13 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat30 = max(u_xlat30, u_xlat32);
					        u_xlat3.x = min(u_xlat13, u_xlat30);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					        u_xlat5.xyz = u_xlat3.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat3.xyz = u_xlat3.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat6.xyz = vs_TEXCOORD0.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat4.x = dot(u_xlat4, u_xlat6);
					        u_xlat4.y = dot(u_xlat5, u_xlat6);
					        u_xlat4.z = dot(u_xlat3, u_xlat6);
					    } else {
					        u_xlat3.xyz = vs_TEXCOORD0.xyz;
					        u_xlat3.w = 1.0;
					        u_xlat4.x = dot(unity_SHAr, u_xlat3);
					        u_xlat4.y = dot(unity_SHAg, u_xlat3);
					        u_xlat4.z = dot(unity_SHAb, u_xlat3);
					    }
					    u_xlat3 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
					    u_xlat5.x = dot(unity_SHBr, u_xlat3);
					    u_xlat5.y = dot(unity_SHBg, u_xlat3);
					    u_xlat5.z = dot(unity_SHBb, u_xlat3);
					    u_xlat30 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
					    u_xlat30 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat30);
					    u_xlat3.xyz = unity_SHC.xyz * vec3(u_xlat30) + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat30 = log2(u_xlat4.w);
					    u_xlat30 = u_xlat30 * unity_Lightmap_HDR.y;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat30 * unity_Lightmap_HDR.x;
					    u_xlat3.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat3.xyz;
					    u_xlatb30 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb30){
					        u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat30 = inversesqrt(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat30) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat30 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat30 = min(u_xlat5.z, u_xlat30);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat30 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat30 = u_xlat30 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat30);
					    u_xlat1.x = u_xlat4.w + -1.0;
					    u_xlat1.x = unity_SpecCube0_HDR.w * u_xlat1.x + 1.0;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.y;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * u_xlat1.xxx;
					    u_xlatb32 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb32){
					        u_xlatb32 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb32){
					            u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat32 = inversesqrt(u_xlat32);
					            u_xlat6.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec4 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat32 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat32 = min(u_xlat7.z, u_xlat32);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat32) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat30);
					        u_xlat30 = u_xlat2.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat30 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat30) * _Color.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat32 = u_xlat1.x + u_xlat1.x;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat32)) + u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat7.y = (-u_xlat1.x) + 1.0;
					    u_xlat7.zw = u_xlat7.xy * u_xlat7.xy;
					    u_xlat0.xy = u_xlat7.xy * u_xlat7.xw;
					    u_xlat1.yz = u_xlat7.zy * u_xlat0.xy;
					    u_xlat0.x = (-u_xlat30) + _Glossiness;
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7 = texture(unity_NHxRoughness, u_xlat1.yw);
					    u_xlat10.x = u_xlat7.x * 16.0;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat6.xyz;
					    u_xlat1.xyw = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat0.xxx;
					    u_xlat2.xyz = u_xlat1.zzz * u_xlat2.xyz + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat6.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat10.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					float u_xlat13;
					float u_xlat20;
					vec2 u_xlat21;
					float u_xlat30;
					float u_xlat32;
					bool u_xlatb32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat21.y = (-_Glossiness) + 1.0;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlatb32 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb32){
					        u_xlatb32 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb32)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat32 = u_xlat3.y * 0.25;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat4.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat32 = max(u_xlat32, u_xlat13);
					        u_xlat3.x = min(u_xlat4.x, u_xlat32);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					        u_xlat5.xyz = u_xlat3.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat3.xyz = u_xlat3.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat6.xyz = vs_TEXCOORD0.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat4.x = dot(u_xlat4, u_xlat6);
					        u_xlat4.y = dot(u_xlat5, u_xlat6);
					        u_xlat4.z = dot(u_xlat3, u_xlat6);
					    } else {
					        u_xlat3.xyz = vs_TEXCOORD0.xyz;
					        u_xlat3.w = 1.0;
					        u_xlat4.x = dot(unity_SHAr, u_xlat3);
					        u_xlat4.y = dot(unity_SHAg, u_xlat3);
					        u_xlat4.z = dot(unity_SHAb, u_xlat3);
					    }
					    u_xlat3 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
					    u_xlat5.x = dot(unity_SHBr, u_xlat3);
					    u_xlat5.y = dot(unity_SHBg, u_xlat3);
					    u_xlat5.z = dot(unity_SHBb, u_xlat3);
					    u_xlat32 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
					    u_xlat32 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat32);
					    u_xlat3.xyz = unity_SHC.xyz * vec3(u_xlat32) + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat32 = log2(u_xlat4.w);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.y;
					    u_xlat32 = exp2(u_xlat32);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.x;
					    u_xlat3.xyz = vec3(u_xlat32) * u_xlat4.xyz + u_xlat3.xyz;
					    u_xlatb32 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb32){
					        u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat32 = inversesqrt(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat32 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat32 = min(u_xlat5.z, u_xlat32);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat32) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat5.xy = (-u_xlat21.yy) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat32 = u_xlat21.y * u_xlat5.x;
					    u_xlat32 = u_xlat32 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat32);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat32);
					        u_xlat32 = u_xlat2.w + -1.0;
					        u_xlat32 = unity_SpecCube1_HDR.w * u_xlat32 + 1.0;
					        u_xlat32 = log2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.y;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat32 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat32) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.y = u_xlat21.y * u_xlat21.y;
					    u_xlat20 = u_xlat0.y * u_xlat0.y;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21.x = u_xlat0.y * u_xlat0.y + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21.x = u_xlat21.y * u_xlat21.y + 0.5;
					    u_xlat0.xy = u_xlat21.xy * u_xlat0.xy;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = (-u_xlat0.y) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat32) + _Glossiness;
					    u_xlat20 = u_xlat20 + 1.0;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat6.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * _LightColor0.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat6.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat2.xyz;
					    u_xlat0.xyw = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat2.xyz = (-u_xlat4.xyz) + vec3(u_xlat20);
					    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat0.xyw * u_xlat2.xyz + u_xlat11.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
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
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat11;
					float u_xlat13;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					float u_xlat32;
					bool u_xlatb32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat31 = (-_Glossiness) + 1.0;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlatb32 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb32){
					        u_xlatb32 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb32)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat32 = u_xlat3.y * 0.25;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat4.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat32 = max(u_xlat32, u_xlat13);
					        u_xlat3.x = min(u_xlat4.x, u_xlat32);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					        u_xlat5.xyz = u_xlat3.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat3.xyz = u_xlat3.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat6.xyz = vs_TEXCOORD0.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat4.x = dot(u_xlat4, u_xlat6);
					        u_xlat4.y = dot(u_xlat5, u_xlat6);
					        u_xlat4.z = dot(u_xlat3, u_xlat6);
					    } else {
					        u_xlat3.xyz = vs_TEXCOORD0.xyz;
					        u_xlat3.w = 1.0;
					        u_xlat4.x = dot(unity_SHAr, u_xlat3);
					        u_xlat4.y = dot(unity_SHAg, u_xlat3);
					        u_xlat4.z = dot(unity_SHAb, u_xlat3);
					    }
					    u_xlat3 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
					    u_xlat5.x = dot(unity_SHBr, u_xlat3);
					    u_xlat5.y = dot(unity_SHBg, u_xlat3);
					    u_xlat5.z = dot(unity_SHBb, u_xlat3);
					    u_xlat32 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
					    u_xlat32 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat32);
					    u_xlat3.xyz = unity_SHC.xyz * vec3(u_xlat32) + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat32 = log2(u_xlat4.w);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.y;
					    u_xlat32 = exp2(u_xlat32);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.x;
					    u_xlat3.xyz = vec3(u_xlat32) * u_xlat4.xyz + u_xlat3.xyz;
					    u_xlatb32 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb32){
					        u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat32 = inversesqrt(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat32 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat32 = min(u_xlat5.z, u_xlat32);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat32) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat32 = (-u_xlat31) * 0.699999988 + 1.70000005;
					    u_xlat32 = u_xlat31 * u_xlat32;
					    u_xlat32 = u_xlat32 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat32);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat32);
					        u_xlat32 = u_xlat2.w + -1.0;
					        u_xlat32 = unity_SpecCube1_HDR.w * u_xlat32 + 1.0;
					        u_xlat32 = log2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.y;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat32 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat32) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = dot(u_xlat10.xx, vec2(u_xlat31));
					    u_xlat10.x = u_xlat10.x + -0.5;
					    u_xlat20 = (-u_xlat1.x) + 1.0;
					    u_xlat21 = u_xlat20 * u_xlat20;
					    u_xlat21 = u_xlat21 * u_xlat21;
					    u_xlat20 = u_xlat20 * u_xlat21;
					    u_xlat20 = u_xlat10.x * u_xlat20 + 1.0;
					    u_xlat21 = -abs(u_xlat30) + 1.0;
					    u_xlat2.x = u_xlat21 * u_xlat21;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat21 = u_xlat21 * u_xlat2.x;
					    u_xlat10.x = u_xlat10.x * u_xlat21 + 1.0;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat20 = u_xlat31 * u_xlat31;
					    u_xlat20 = max(u_xlat20, 0.00200000009);
					    u_xlat31 = (-u_xlat20) + 1.0;
					    u_xlat2.x = abs(u_xlat30) * u_xlat31 + u_xlat20;
					    u_xlat31 = u_xlat1.x * u_xlat31 + u_xlat20;
					    u_xlat30 = abs(u_xlat30) * u_xlat31;
					    u_xlat30 = u_xlat1.x * u_xlat2.x + u_xlat30;
					    u_xlat30 = u_xlat30 + 9.99999975e-06;
					    u_xlat30 = 0.5 / u_xlat30;
					    u_xlat31 = u_xlat20 * u_xlat20;
					    u_xlat2.x = u_xlat11 * u_xlat31 + (-u_xlat11);
					    u_xlat11 = u_xlat2.x * u_xlat11 + 1.0;
					    u_xlat31 = u_xlat31 * 0.318309873;
					    u_xlat11 = u_xlat11 * u_xlat11 + 1.00000001e-07;
					    u_xlat11 = u_xlat31 / u_xlat11;
					    u_xlat30 = u_xlat30 * u_xlat11;
					    u_xlat10.z = u_xlat30 * 3.14159274;
					    u_xlat10.xz = u_xlat1.xx * u_xlat10.xz;
					    u_xlat30 = max(u_xlat10.z, 0.0);
					    u_xlat20 = u_xlat20 * u_xlat20 + 1.0;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat32) + _Glossiness;
					    u_xlat1.x = u_xlat1.x + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2.xyz = _LightColor0.xyz * u_xlat10.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat30) * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = u_xlat10.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    u_xlat7.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat7.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat3.xyz;
					    u_xlat0.xyw = u_xlat6.xyz * u_xlat2.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat20);
					    u_xlat1.xyw = (-u_xlat4.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyw + u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[5];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					bool u_xlatb29;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat1.xyz = vs_TEXCOORD0.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat28 = log2(u_xlat2.w);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat1.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat1.xyz;
					    }
					    u_xlat28 = (-u_xlat27) * 0.699999988 + 1.70000005;
					    u_xlat27 = u_xlat27 * u_xlat28;
					    u_xlat27 = u_xlat27 * 6.0;
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, u_xlat27);
					    u_xlat28 = u_xlat3.w + -1.0;
					    u_xlat28 = unity_SpecCube0_HDR.w * u_xlat28 + 1.0;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28);
					    u_xlatb29 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb29){
					        u_xlatb29 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb29){
					            u_xlat29 = dot(u_xlat1.xyz, u_xlat1.xyz);
					            u_xlat29 = inversesqrt(u_xlat29);
					            u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat29);
					            u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat29 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat29 = min(u_xlat6.z, u_xlat29);
					            u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat1.xyz, u_xlat27);
					        u_xlat27 = u_xlat5.w + -1.0;
					        u_xlat27 = unity_SpecCube1_HDR.w * u_xlat27 + 1.0;
					        u_xlat27 = log2(u_xlat27);
					        u_xlat27 = u_xlat27 * unity_SpecCube1_HDR.y;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat27 = u_xlat27 * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + (-u_xlat1.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat1.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat27 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat27) * _Color.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.x = (-u_xlat27) + 1.0;
					    u_xlat9.x = u_xlat9.x + _Glossiness;
					    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
					    u_xlat9.xyz = (-u_xlat3.xyz) + u_xlat9.xxx;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat5.xyz + u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[5];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat1.xyz = vs_TEXCOORD0.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat28 = log2(u_xlat2.w);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat1.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat1.xyz;
					    }
					    u_xlat4.xy = (-vec2(u_xlat27)) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat28 = u_xlat27 * u_xlat4.x;
					    u_xlat28 = u_xlat28 * 6.0;
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, u_xlat28);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = log2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.y;
					    u_xlat29 = exp2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xzw = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat1 = textureLod(unity_SpecCube1, u_xlat1.xyz, u_xlat28);
					        u_xlat28 = u_xlat1.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat1.xyz);
					        u_xlat4.xzw = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat1.xyz;
					    }
					    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat28 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat28) * _Color.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = u_xlat27 * u_xlat27;
					    u_xlat9.x = u_xlat27 * u_xlat9.x;
					    u_xlat9.x = (-u_xlat9.x) * u_xlat4.y + 1.0;
					    u_xlat18 = (-u_xlat28) + _Glossiness;
					    u_xlat18 = u_xlat18 + 1.0;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat4.xzw * u_xlat9.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.xyz = (-u_xlat3.xyz) + vec3(u_xlat18);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat5.xyz + u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[5];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat1.xyz = vs_TEXCOORD0.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat28 = log2(u_xlat2.w);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat1.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat1.xyz;
					    }
					    u_xlat28 = (-u_xlat27) * 0.699999988 + 1.70000005;
					    u_xlat28 = u_xlat27 * u_xlat28;
					    u_xlat28 = u_xlat28 * 6.0;
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, u_xlat28);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = log2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.y;
					    u_xlat29 = exp2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat1 = textureLod(unity_SpecCube1, u_xlat1.xyz, u_xlat28);
					        u_xlat28 = u_xlat1.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat1.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat1.xyz;
					    }
					    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat28 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat28) * _Color.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat9.x = u_xlat27 * u_xlat27;
					    u_xlat9.x = max(u_xlat9.x, 0.00200000009);
					    u_xlat9.x = u_xlat9.x * u_xlat9.x + 1.0;
					    u_xlat9.x = float(1.0) / u_xlat9.x;
					    u_xlat18 = (-u_xlat28) + _Glossiness;
					    u_xlat18 = u_xlat18 + 1.0;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat9.xxx;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.xyz = (-u_xlat3.xyz) + vec3(u_xlat18);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[5];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat11;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					bool u_xlatb29;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat1.xyz = vs_TEXCOORD0.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
					    u_xlatb28 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb28){
					        u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb28)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat28 = u_xlat2.y * 0.25;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat3.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat28 = max(u_xlat28, u_xlat11);
					        u_xlat2.x = min(u_xlat3.x, u_xlat28);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD0.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat3, u_xlat5);
					        u_xlat3.y = dot(u_xlat4, u_xlat5);
					        u_xlat3.z = dot(u_xlat2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD0.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    }
					    u_xlat2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat28 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
					    u_xlat28 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat28);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat28 = log2(u_xlat3.w);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat1.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat1.xyz;
					    }
					    u_xlat28 = (-u_xlat27) * 0.699999988 + 1.70000005;
					    u_xlat27 = u_xlat27 * u_xlat28;
					    u_xlat27 = u_xlat27 * 6.0;
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, u_xlat27);
					    u_xlat28 = u_xlat3.w + -1.0;
					    u_xlat28 = unity_SpecCube0_HDR.w * u_xlat28 + 1.0;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28);
					    u_xlatb29 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb29){
					        u_xlatb29 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb29){
					            u_xlat29 = dot(u_xlat1.xyz, u_xlat1.xyz);
					            u_xlat29 = inversesqrt(u_xlat29);
					            u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat29);
					            u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat29 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat29 = min(u_xlat6.z, u_xlat29);
					            u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat1.xyz, u_xlat27);
					        u_xlat27 = u_xlat5.w + -1.0;
					        u_xlat27 = unity_SpecCube1_HDR.w * u_xlat27 + 1.0;
					        u_xlat27 = log2(u_xlat27);
					        u_xlat27 = u_xlat27 * unity_SpecCube1_HDR.y;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat27 = u_xlat27 * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + (-u_xlat1.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat1.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat27 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat27) * _Color.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.x = (-u_xlat27) + _Glossiness;
					    u_xlat9.x = u_xlat9.x + 1.0;
					    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
					    u_xlat9.xyz = (-u_xlat3.xyz) + u_xlat9.xxx;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat5.xyz + u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[5];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat1.xyz = vs_TEXCOORD0.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
					    u_xlatb28 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb28){
					        u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb28)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat28 = u_xlat2.y * 0.25;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat3.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat28 = max(u_xlat28, u_xlat11);
					        u_xlat2.x = min(u_xlat3.x, u_xlat28);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD0.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat3, u_xlat5);
					        u_xlat3.y = dot(u_xlat4, u_xlat5);
					        u_xlat3.z = dot(u_xlat2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD0.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    }
					    u_xlat2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat28 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
					    u_xlat28 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat28);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat28 = log2(u_xlat3.w);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat1.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat1.xyz;
					    }
					    u_xlat4.xy = (-vec2(u_xlat27)) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat28 = u_xlat27 * u_xlat4.x;
					    u_xlat28 = u_xlat28 * 6.0;
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, u_xlat28);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = log2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.y;
					    u_xlat29 = exp2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xzw = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat1 = textureLod(unity_SpecCube1, u_xlat1.xyz, u_xlat28);
					        u_xlat28 = u_xlat1.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat1.xyz);
					        u_xlat4.xzw = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat1.xyz;
					    }
					    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat28 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat28) * _Color.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = u_xlat27 * u_xlat27;
					    u_xlat9.x = u_xlat27 * u_xlat9.x;
					    u_xlat9.x = (-u_xlat9.x) * u_xlat4.y + 1.0;
					    u_xlat18 = (-u_xlat28) + _Glossiness;
					    u_xlat18 = u_xlat18 + 1.0;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat4.xzw * u_xlat9.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.xyz = (-u_xlat3.xyz) + vec3(u_xlat18);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat5.xyz + u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[5];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat1.xyz = vs_TEXCOORD0.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
					    u_xlatb28 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb28){
					        u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb28)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat28 = u_xlat2.y * 0.25;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat3.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat28 = max(u_xlat28, u_xlat11);
					        u_xlat2.x = min(u_xlat3.x, u_xlat28);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD0.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat3, u_xlat5);
					        u_xlat3.y = dot(u_xlat4, u_xlat5);
					        u_xlat3.z = dot(u_xlat2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD0.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    }
					    u_xlat2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat28 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
					    u_xlat28 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat28);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat28 = log2(u_xlat3.w);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat1.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat1.xyz;
					    }
					    u_xlat28 = (-u_xlat27) * 0.699999988 + 1.70000005;
					    u_xlat28 = u_xlat27 * u_xlat28;
					    u_xlat28 = u_xlat28 * 6.0;
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, u_xlat28);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = log2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.y;
					    u_xlat29 = exp2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat1 = textureLod(unity_SpecCube1, u_xlat1.xyz, u_xlat28);
					        u_xlat28 = u_xlat1.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat1.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat1.xyz;
					    }
					    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat28 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat28) * _Color.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat9.x = u_xlat27 * u_xlat27;
					    u_xlat9.x = max(u_xlat9.x, 0.00200000009);
					    u_xlat9.x = u_xlat9.x * u_xlat9.x + 1.0;
					    u_xlat9.x = float(1.0) / u_xlat9.x;
					    u_xlat18 = (-u_xlat28) + _Glossiness;
					    u_xlat18 = u_xlat18 + 1.0;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat9.xxx;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.xyz = (-u_xlat3.xyz) + vec3(u_xlat18);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat11;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb30 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb30){
					        u_xlatb30 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb30)) ? u_xlat1.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat30 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat30, u_xlat11);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat30 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat1.xw = (-vec2(_Glossiness)) + vec2(1.0, 1.0);
					    u_xlat2.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat0.xyz);
					    u_xlat3.xyz = vec3(u_xlat30) * _LightColor0.xyz;
					    u_xlatb30 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb30){
					        u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat30 = inversesqrt(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat30) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat30 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat30 = min(u_xlat5.z, u_xlat30);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat30 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat30 = u_xlat30 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat30);
					    u_xlat1.x = u_xlat4.w + -1.0;
					    u_xlat1.x = unity_SpecCube0_HDR.w * u_xlat1.x + 1.0;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.y;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * u_xlat1.xxx;
					    u_xlatb32 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb32){
					        u_xlatb32 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb32){
					            u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat32 = inversesqrt(u_xlat32);
					            u_xlat6.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat32 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat32 = min(u_xlat7.z, u_xlat32);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat32) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat30);
					        u_xlat30 = u_xlat2.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat30 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat32 = u_xlat1.x + u_xlat1.x;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat32)) + u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat6.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat6.y = (-u_xlat1.x) + 1.0;
					    u_xlat6.zw = u_xlat6.xy * u_xlat6.xy;
					    u_xlat0.xy = u_xlat6.xy * u_xlat6.xw;
					    u_xlat1.yz = u_xlat6.zy * u_xlat0.xy;
					    u_xlat0.x = (-u_xlat30) + 1.0;
					    u_xlat0.x = u_xlat0.x + _Glossiness;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6 = texture(unity_NHxRoughness, u_xlat1.yw);
					    u_xlat10.x = u_xlat6.x * 16.0;
					    u_xlat1.xyw = u_xlat4.xyz * u_xlat10.xxx;
					    u_xlat10.xyz = _Color.xyz * vec3(u_xlat30) + u_xlat1.xyw;
					    u_xlat1.xyw = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat0.xxx;
					    u_xlat2.xyz = u_xlat1.zzz * u_xlat2.xyz + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat10.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat30 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = (-_Glossiness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat5.xy = (-u_xlat2.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat31 = u_xlat2.x * u_xlat5.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat31 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = u_xlat10 * u_xlat10;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21 = u_xlat2.x * u_xlat2.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat21;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = u_xlat2.x * u_xlat10;
					    u_xlat10 = (-u_xlat10) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat31) + 1.0;
					    u_xlat20 = u_xlat20 + _Glossiness;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat2.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat11.xyz = _Color.xyz * vec3(u_xlat31) + u_xlat2.xyz;
					    u_xlat11.xyz = u_xlat3.xyz * u_xlat11.xyz;
					    u_xlat2.xyz = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat0.x = (-u_xlat1.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat3.xyz = (-u_xlat4.xyz) + vec3(u_xlat20);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat0.xyz;
					    u_xlat30 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlatb31 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb31){
					        u_xlatb31 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb31)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat31 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat31, u_xlat12.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat31 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat2.x = (-_Glossiness) + 1.0;
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = vec3(u_xlat31) * _LightColor0.xyz;
					    u_xlatb31 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb31){
					        u_xlat31 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat31 = inversesqrt(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat31) * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat31 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat31 = min(u_xlat5.z, u_xlat31);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat31 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat31 = u_xlat31 * u_xlat2.x;
					    u_xlat31 = u_xlat31 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat31);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat31);
					        u_xlat31 = u_xlat6.w + -1.0;
					        u_xlat31 = unity_SpecCube1_HDR.w * u_xlat31 + 1.0;
					        u_xlat31 = log2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.y;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat31 = u_xlat31 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat31);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat31 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat12.xyz = vec3(u_xlat31) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat31 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat31) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat12.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11 = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = dot(u_xlat10.xx, u_xlat2.xx);
					    u_xlat10.x = u_xlat10.x + -0.5;
					    u_xlat20 = (-u_xlat1.x) + 1.0;
					    u_xlat21 = u_xlat20 * u_xlat20;
					    u_xlat21 = u_xlat21 * u_xlat21;
					    u_xlat20 = u_xlat20 * u_xlat21;
					    u_xlat20 = u_xlat10.x * u_xlat20 + 1.0;
					    u_xlat21 = -abs(u_xlat30) + 1.0;
					    u_xlat12.x = u_xlat21 * u_xlat21;
					    u_xlat12.x = u_xlat12.x * u_xlat12.x;
					    u_xlat21 = u_xlat21 * u_xlat12.x;
					    u_xlat10.x = u_xlat10.x * u_xlat21 + 1.0;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat20 = u_xlat2.x * u_xlat2.x;
					    u_xlat20 = max(u_xlat20, 0.00200000009);
					    u_xlat2.x = (-u_xlat20) + 1.0;
					    u_xlat12.x = abs(u_xlat30) * u_xlat2.x + u_xlat20;
					    u_xlat2.x = u_xlat1.x * u_xlat2.x + u_xlat20;
					    u_xlat30 = abs(u_xlat30) * u_xlat2.x;
					    u_xlat30 = u_xlat1.x * u_xlat12.x + u_xlat30;
					    u_xlat30 = u_xlat30 + 9.99999975e-06;
					    u_xlat30 = 0.5 / u_xlat30;
					    u_xlat2.x = u_xlat20 * u_xlat20;
					    u_xlat12.x = u_xlat11 * u_xlat2.x + (-u_xlat11);
					    u_xlat11 = u_xlat12.x * u_xlat11 + 1.0;
					    u_xlat2.x = u_xlat2.x * 0.318309873;
					    u_xlat11 = u_xlat11 * u_xlat11 + 1.00000001e-07;
					    u_xlat11 = u_xlat2.x / u_xlat11;
					    u_xlat30 = u_xlat30 * u_xlat11;
					    u_xlat10.z = u_xlat30 * 3.14159274;
					    u_xlat10.xz = u_xlat1.xx * u_xlat10.xz;
					    u_xlat30 = max(u_xlat10.z, 0.0);
					    u_xlat20 = u_xlat20 * u_xlat20 + 1.0;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat31) + 1.0;
					    u_xlat1.x = u_xlat1.x + _Glossiness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = u_xlat10.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    u_xlat7.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat7.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat3.xyz;
					    u_xlat0.xyw = u_xlat6.xyz * u_xlat2.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat20);
					    u_xlat1.xyw = (-u_xlat4.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyw + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    u_xlat30 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat36;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat12.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat12.x, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat1.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2.xw = (-vec2(_Glossiness)) + vec2(1.0, 1.0);
					    u_xlat12.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD0.xyz * (-u_xlat12.xxx) + (-u_xlat0.xyz);
					    u_xlat3.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb33)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25;
					        u_xlat1.x = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat36 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat33 = max(u_xlat33, u_xlat1.x);
					        u_xlat4.x = min(u_xlat36, u_xlat33);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD0.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD0.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4.xyz = u_xlat5.xyz + vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat12.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat12.xyz;
					    }
					    u_xlat33 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
					    u_xlat33 = u_xlat33 * u_xlat2.x;
					    u_xlat33 = u_xlat33 * 6.0;
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat33);
					    u_xlat1.x = u_xlat5.w + -1.0;
					    u_xlat1.x = unity_SpecCube0_HDR.w * u_xlat1.x + 1.0;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.y;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * u_xlat1.xxx;
					    u_xlatb2 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb2){
					        u_xlatb2 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb2){
					            u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat2.x = inversesqrt(u_xlat2.x);
					            u_xlat7.xyz = u_xlat12.xyz * u_xlat2.xxx;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec4 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat2.x = min(u_xlat8.y, u_xlat8.x);
					            u_xlat2.x = min(u_xlat8.z, u_xlat2.x);
					            u_xlat8.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat7.xyz * u_xlat2.xxx + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat12.xyz, u_xlat33);
					        u_xlat33 = u_xlat7.w + -1.0;
					        u_xlat33 = unity_SpecCube1_HDR.w * u_xlat33 + 1.0;
					        u_xlat33 = log2(u_xlat33);
					        u_xlat33 = u_xlat33 * unity_SpecCube1_HDR.y;
					        u_xlat33 = exp2(u_xlat33);
					        u_xlat33 = u_xlat33 * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat7.xyz * vec3(u_xlat33);
					        u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz + (-u_xlat12.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat12.xyz;
					    }
					    u_xlat33 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat33 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat7.xyz = vec3(u_xlat33) * _Color.xyz;
					    u_xlat34 = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat2.x = u_xlat34 + u_xlat34;
					    u_xlat0.xyz = u_xlat1.xyz * (-u_xlat2.xxx) + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat34 = u_xlat34;
					    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
					    u_xlat8.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat8.y = (-u_xlat34) + 1.0;
					    u_xlat8.zw = u_xlat8.xy * u_xlat8.xy;
					    u_xlat0.xy = u_xlat8.xy * u_xlat8.xw;
					    u_xlat2.yz = u_xlat8.zy * u_xlat0.xy;
					    u_xlat0.x = (-u_xlat33) + _Glossiness;
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8 = texture(unity_NHxRoughness, u_xlat2.yw);
					    u_xlat11.x = u_xlat8.x * 16.0;
					    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz + u_xlat7.xyz;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz;
					    u_xlat2.xyw = (-u_xlat5.xyz) + u_xlat0.xxx;
					    u_xlat2.xyz = u_xlat2.zzz * u_xlat2.xyw + u_xlat5.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat6.xyz;
					    u_xlat2.xyz = u_xlat4.xyz * u_xlat7.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat11.xyz * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat33 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					float u_xlat11;
					vec3 u_xlat12;
					vec3 u_xlat13;
					float u_xlat15;
					float u_xlat22;
					float u_xlat23;
					float u_xlat24;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlatb34 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb34){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat13.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat13.xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat13.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat13.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat13.x = (-_Glossiness) + 1.0;
					    u_xlat24 = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat24 = u_xlat24 + u_xlat24;
					    u_xlat3.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
					    u_xlat2.xzw = u_xlat2.xxx * _LightColor0.xyz;
					    if(u_xlatb34){
					        u_xlatb34 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb34)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat34 = u_xlat4.y * 0.25;
					        u_xlat36 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat34 = max(u_xlat34, u_xlat36);
					        u_xlat4.x = min(u_xlat15, u_xlat34);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD0.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD0.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4.xyz = u_xlat5.xyz + vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb34 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb34){
					        u_xlat34 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat34 = inversesqrt(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat34 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat34 = min(u_xlat6.z, u_xlat34);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat6.xy = (-u_xlat13.xx) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat34 = u_xlat13.x * u_xlat6.x;
					    u_xlat34 = u_xlat34 * 6.0;
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat34);
					    u_xlat36 = u_xlat5.w + -1.0;
					    u_xlat36 = unity_SpecCube0_HDR.w * u_xlat36 + 1.0;
					    u_xlat36 = log2(u_xlat36);
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.y;
					    u_xlat36 = exp2(u_xlat36);
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.x;
					    u_xlat6.xzw = u_xlat5.xyz * vec3(u_xlat36);
					    u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb37){
					        u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb37){
					            u_xlat37 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat37 = inversesqrt(u_xlat37);
					            u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat37);
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat37 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat37 = min(u_xlat8.z, u_xlat37);
					            u_xlat8.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat37) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat3.xyz, u_xlat34);
					        u_xlat34 = u_xlat7.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat34 + 1.0;
					        u_xlat34 = log2(u_xlat34);
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.y;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat36) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xzw = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat34 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat3.xyz = vec3(u_xlat34) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat34 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat7.xyz = vec3(u_xlat34) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat36 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11 = u_xlat13.x * u_xlat13.x;
					    u_xlat22 = u_xlat11 * u_xlat11;
					    u_xlat12.x = u_xlat36 * u_xlat36;
					    u_xlat23 = u_xlat11 * u_xlat11 + -1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat23 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat23 = u_xlat13.x * u_xlat13.x + 0.5;
					    u_xlat0.x = u_xlat0.x * u_xlat23;
					    u_xlat12.x = u_xlat12.x * u_xlat12.x;
					    u_xlat0.x = u_xlat0.x * u_xlat12.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat22 / u_xlat0.x;
					    u_xlat11 = u_xlat13.x * u_xlat11;
					    u_xlat11 = (-u_xlat11) * u_xlat6.y + 1.0;
					    u_xlat22 = (-u_xlat34) + _Glossiness;
					    u_xlat22 = u_xlat22 + 1.0;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat12.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat7.xyz;
					    u_xlat12.xyz = u_xlat2.xzw * u_xlat12.xyz;
					    u_xlat2.xyz = u_xlat4.xyz * u_xlat7.xyz;
					    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat33) + u_xlat2.xyz;
					    u_xlat0.xyw = u_xlat6.xzw * vec3(u_xlat11);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat2.xyz = (-u_xlat5.xyz) + vec3(u_xlat22);
					    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz + u_xlat12.xyz;
					    u_xlat33 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat12;
					vec3 u_xlat13;
					float u_xlat15;
					float u_xlat22;
					float u_xlat23;
					float u_xlat24;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat36;
					float u_xlat37;
					bool u_xlatb37;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlatb34 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb34){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat13.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat13.xyz;
					        u_xlat13.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat13.xyz;
					        u_xlat13.xyz = u_xlat13.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat13.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat13.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat13.x = (-_Glossiness) + 1.0;
					    u_xlat24 = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat24 = u_xlat24 + u_xlat24;
					    u_xlat3.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
					    u_xlat2.xzw = u_xlat2.xxx * _LightColor0.xyz;
					    if(u_xlatb34){
					        u_xlatb34 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb34)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat34 = u_xlat4.y * 0.25;
					        u_xlat36 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat15 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat34 = max(u_xlat34, u_xlat36);
					        u_xlat4.x = min(u_xlat15, u_xlat34);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD0.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat5, u_xlat7);
					        u_xlat5.y = dot(u_xlat6, u_xlat7);
					        u_xlat5.z = dot(u_xlat4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD0.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    }
					    u_xlat4.xyz = u_xlat5.xyz + vs_TEXCOORD2.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb34 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb34){
					        u_xlat34 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat34 = inversesqrt(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat34) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat34 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat34 = min(u_xlat6.z, u_xlat34);
					        u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat34) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    }
					    u_xlat34 = (-u_xlat13.x) * 0.699999988 + 1.70000005;
					    u_xlat34 = u_xlat34 * u_xlat13.x;
					    u_xlat34 = u_xlat34 * 6.0;
					    u_xlat5 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat34);
					    u_xlat36 = u_xlat5.w + -1.0;
					    u_xlat36 = unity_SpecCube0_HDR.w * u_xlat36 + 1.0;
					    u_xlat36 = log2(u_xlat36);
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.y;
					    u_xlat36 = exp2(u_xlat36);
					    u_xlat36 = u_xlat36 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat5.xyz * vec3(u_xlat36);
					    u_xlatb37 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb37){
					        u_xlatb37 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb37){
					            u_xlat37 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat37 = inversesqrt(u_xlat37);
					            u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat37);
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat37 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat37 = min(u_xlat8.z, u_xlat37);
					            u_xlat8.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat37) + u_xlat8.xyz;
					        }
					        u_xlat7 = textureLod(unity_SpecCube1, u_xlat3.xyz, u_xlat34);
					        u_xlat34 = u_xlat7.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat34 + 1.0;
					        u_xlat34 = log2(u_xlat34);
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.y;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat36) * u_xlat5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    }
					    u_xlat34 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat34 = inversesqrt(u_xlat34);
					    u_xlat3.xyz = vec3(u_xlat34) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat34 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat7.xyz = vec3(u_xlat34) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + _WorldSpaceLightPos0.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = max(u_xlat33, 0.00100000005);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat33 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = dot(u_xlat11.xx, u_xlat13.xx);
					    u_xlat11.x = u_xlat11.x + -0.5;
					    u_xlat22 = (-u_xlat1.x) + 1.0;
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * u_xlat23;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat22 = u_xlat11.x * u_xlat22 + 1.0;
					    u_xlat23 = -abs(u_xlat33) + 1.0;
					    u_xlat3.x = u_xlat23 * u_xlat23;
					    u_xlat3.x = u_xlat3.x * u_xlat3.x;
					    u_xlat23 = u_xlat23 * u_xlat3.x;
					    u_xlat11.x = u_xlat11.x * u_xlat23 + 1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat22;
					    u_xlat22 = u_xlat13.x * u_xlat13.x;
					    u_xlat22 = max(u_xlat22, 0.00200000009);
					    u_xlat13.x = (-u_xlat22) + 1.0;
					    u_xlat3.x = abs(u_xlat33) * u_xlat13.x + u_xlat22;
					    u_xlat13.x = u_xlat1.x * u_xlat13.x + u_xlat22;
					    u_xlat33 = abs(u_xlat33) * u_xlat13.x;
					    u_xlat33 = u_xlat1.x * u_xlat3.x + u_xlat33;
					    u_xlat33 = u_xlat33 + 9.99999975e-06;
					    u_xlat33 = 0.5 / u_xlat33;
					    u_xlat13.x = u_xlat22 * u_xlat22;
					    u_xlat3.x = u_xlat12 * u_xlat13.x + (-u_xlat12);
					    u_xlat12 = u_xlat3.x * u_xlat12 + 1.0;
					    u_xlat13.x = u_xlat13.x * 0.318309873;
					    u_xlat12 = u_xlat12 * u_xlat12 + 1.00000001e-07;
					    u_xlat12 = u_xlat13.x / u_xlat12;
					    u_xlat33 = u_xlat33 * u_xlat12;
					    u_xlat11.z = u_xlat33 * 3.14159274;
					    u_xlat11.xz = u_xlat1.xx * u_xlat11.xz;
					    u_xlat33 = max(u_xlat11.z, 0.0);
					    u_xlat22 = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat33 = u_xlat33 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat34) + _Glossiness;
					    u_xlat1.x = u_xlat1.x + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.xyz = u_xlat2.xzw * u_xlat11.xxx + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xzw * vec3(u_xlat33);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat11.x = u_xlat0.x * u_xlat0.x;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat4.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat4.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat2.xyz;
					    u_xlat0.xyw = u_xlat7.xyz * u_xlat3.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat22);
					    u_xlat1.xyw = (-u_xlat5.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat1.xyw + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    u_xlat33 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat1.xw = (-vec2(_Glossiness)) + vec2(1.0, 1.0);
					    u_xlat30 = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat30 = u_xlat30 + u_xlat30;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat30)) + (-u_xlat0.xyz);
					    u_xlat3 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat30 = log2(u_xlat3.w);
					    u_xlat30 = u_xlat30 * unity_Lightmap_HDR.y;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat30 * unity_Lightmap_HDR.x;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30);
					    u_xlatb30 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb30){
					        u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat30 = inversesqrt(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat30) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat30 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat30 = min(u_xlat5.z, u_xlat30);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat30 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat30 = u_xlat30 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat30);
					    u_xlat1.x = u_xlat4.w + -1.0;
					    u_xlat1.x = unity_SpecCube0_HDR.w * u_xlat1.x + 1.0;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.y;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * u_xlat1.xxx;
					    u_xlatb32 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb32){
					        u_xlatb32 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb32){
					            u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat32 = inversesqrt(u_xlat32);
					            u_xlat6.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec4 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat32 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat32 = min(u_xlat7.z, u_xlat32);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat32) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat30);
					        u_xlat30 = u_xlat2.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat30 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat30) * _Color.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat32 = u_xlat1.x + u_xlat1.x;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat32)) + u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat7.y = (-u_xlat1.x) + 1.0;
					    u_xlat7.zw = u_xlat7.xy * u_xlat7.xy;
					    u_xlat0.xy = u_xlat7.xy * u_xlat7.xw;
					    u_xlat1.yz = u_xlat7.zy * u_xlat0.xy;
					    u_xlat0.x = (-u_xlat30) + 1.0;
					    u_xlat0.x = u_xlat0.x + _Glossiness;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7 = texture(unity_NHxRoughness, u_xlat1.yw);
					    u_xlat10.x = u_xlat7.x * 16.0;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat6.xyz;
					    u_xlat1.xyw = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat0.xxx;
					    u_xlat2.xyz = u_xlat1.zzz * u_xlat2.xyz + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat6.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat10.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat30 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					float u_xlat20;
					vec2 u_xlat21;
					float u_xlat30;
					float u_xlat32;
					bool u_xlatb32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat21.y = (-_Glossiness) + 1.0;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlat3 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat32 = log2(u_xlat3.w);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.y;
					    u_xlat32 = exp2(u_xlat32);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.x;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat32);
					    u_xlatb32 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb32){
					        u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat32 = inversesqrt(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat32 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat32 = min(u_xlat5.z, u_xlat32);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat32) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat5.xy = (-u_xlat21.yy) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat32 = u_xlat21.y * u_xlat5.x;
					    u_xlat32 = u_xlat32 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat32);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat32);
					        u_xlat32 = u_xlat2.w + -1.0;
					        u_xlat32 = unity_SpecCube1_HDR.w * u_xlat32 + 1.0;
					        u_xlat32 = log2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.y;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat32 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat32) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.y = u_xlat21.y * u_xlat21.y;
					    u_xlat20 = u_xlat0.y * u_xlat0.y;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21.x = u_xlat0.y * u_xlat0.y + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21.x = u_xlat21.y * u_xlat21.y + 0.5;
					    u_xlat0.xy = u_xlat21.xy * u_xlat0.xy;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = (-u_xlat0.y) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat32) + 1.0;
					    u_xlat20 = u_xlat20 + _Glossiness;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat6.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * _LightColor0.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat6.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat2.xyz;
					    u_xlat0.xyw = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat2.xyz = (-u_xlat4.xyz) + vec3(u_xlat20);
					    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat30 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat11;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					float u_xlat32;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat35;
					bool u_xlatb35;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat31 = (-_Glossiness) + 1.0;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlat3 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat32 = log2(u_xlat3.w);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.y;
					    u_xlat32 = exp2(u_xlat32);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.x;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat4.xyz = u_xlat2.xyz * vec3(u_xlat33);
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat33 = min(u_xlat5.z, u_xlat33);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat33 = (-u_xlat31) * 0.699999988 + 1.70000005;
					    u_xlat33 = u_xlat31 * u_xlat33;
					    u_xlat33 = u_xlat33 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat33);
					    u_xlat34 = u_xlat4.w + -1.0;
					    u_xlat34 = unity_SpecCube0_HDR.w * u_xlat34 + 1.0;
					    u_xlat34 = log2(u_xlat34);
					    u_xlat34 = u_xlat34 * unity_SpecCube0_HDR.y;
					    u_xlat34 = exp2(u_xlat34);
					    u_xlat34 = u_xlat34 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat34);
					    u_xlatb35 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb35){
					        u_xlatb35 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb35){
					            u_xlat35 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat35 = inversesqrt(u_xlat35);
					            u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat35);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat35 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat35 = min(u_xlat7.z, u_xlat35);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat35) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat33);
					        u_xlat2.x = u_xlat6.w + -1.0;
					        u_xlat2.x = unity_SpecCube1_HDR.w * u_xlat2.x + 1.0;
					        u_xlat2.x = log2(u_xlat2.x);
					        u_xlat2.x = u_xlat2.x * unity_SpecCube1_HDR.y;
					        u_xlat2.x = exp2(u_xlat2.x);
					        u_xlat2.x = u_xlat2.x * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat6.xyz * u_xlat2.xxx;
					        u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat33 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat33) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = dot(u_xlat10.xx, vec2(u_xlat31));
					    u_xlat10.x = u_xlat10.x + -0.5;
					    u_xlat20 = (-u_xlat1.x) + 1.0;
					    u_xlat21 = u_xlat20 * u_xlat20;
					    u_xlat21 = u_xlat21 * u_xlat21;
					    u_xlat20 = u_xlat20 * u_xlat21;
					    u_xlat20 = u_xlat10.x * u_xlat20 + 1.0;
					    u_xlat21 = -abs(u_xlat30) + 1.0;
					    u_xlat2.x = u_xlat21 * u_xlat21;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat21 = u_xlat21 * u_xlat2.x;
					    u_xlat10.x = u_xlat10.x * u_xlat21 + 1.0;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat20 = u_xlat31 * u_xlat31;
					    u_xlat20 = max(u_xlat20, 0.00200000009);
					    u_xlat31 = (-u_xlat20) + 1.0;
					    u_xlat2.x = abs(u_xlat30) * u_xlat31 + u_xlat20;
					    u_xlat31 = u_xlat1.x * u_xlat31 + u_xlat20;
					    u_xlat30 = abs(u_xlat30) * u_xlat31;
					    u_xlat30 = u_xlat1.x * u_xlat2.x + u_xlat30;
					    u_xlat30 = u_xlat30 + 9.99999975e-06;
					    u_xlat30 = 0.5 / u_xlat30;
					    u_xlat31 = u_xlat20 * u_xlat20;
					    u_xlat2.x = u_xlat11 * u_xlat31 + (-u_xlat11);
					    u_xlat11 = u_xlat2.x * u_xlat11 + 1.0;
					    u_xlat31 = u_xlat31 * 0.318309873;
					    u_xlat11 = u_xlat11 * u_xlat11 + 1.00000001e-07;
					    u_xlat11 = u_xlat31 / u_xlat11;
					    u_xlat30 = u_xlat30 * u_xlat11;
					    u_xlat10.z = u_xlat30 * 3.14159274;
					    u_xlat10.xz = u_xlat1.xx * u_xlat10.xz;
					    u_xlat30 = max(u_xlat10.z, 0.0);
					    u_xlat20 = u_xlat20 * u_xlat20 + 1.0;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat33) + 1.0;
					    u_xlat1.x = u_xlat1.x + _Glossiness;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2.xyz = u_xlat10.xxx * _LightColor0.xyz;
					    u_xlat2.xyz = vec3(u_xlat32) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = vec3(u_xlat30) * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = u_xlat10.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    u_xlat7.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat7.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat3.xyz;
					    u_xlat0.xyw = u_xlat6.xyz * u_xlat2.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat20);
					    u_xlat1.xyw = (-u_xlat4.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyw + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    u_xlat30 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat13;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat1.xw = (-vec2(_Glossiness)) + vec2(1.0, 1.0);
					    u_xlat30 = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat30 = u_xlat30 + u_xlat30;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat30)) + (-u_xlat0.xyz);
					    u_xlatb30 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb30){
					        u_xlatb30 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb30)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat30 = u_xlat3.y * 0.25;
					        u_xlat32 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat13 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat30 = max(u_xlat30, u_xlat32);
					        u_xlat3.x = min(u_xlat13, u_xlat30);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					        u_xlat5.xyz = u_xlat3.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat3.xyz = u_xlat3.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat6.xyz = vs_TEXCOORD0.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat4.x = dot(u_xlat4, u_xlat6);
					        u_xlat4.y = dot(u_xlat5, u_xlat6);
					        u_xlat4.z = dot(u_xlat3, u_xlat6);
					    } else {
					        u_xlat3.xyz = vs_TEXCOORD0.xyz;
					        u_xlat3.w = 1.0;
					        u_xlat4.x = dot(unity_SHAr, u_xlat3);
					        u_xlat4.y = dot(unity_SHAg, u_xlat3);
					        u_xlat4.z = dot(unity_SHAb, u_xlat3);
					    }
					    u_xlat3 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
					    u_xlat5.x = dot(unity_SHBr, u_xlat3);
					    u_xlat5.y = dot(unity_SHBg, u_xlat3);
					    u_xlat5.z = dot(unity_SHBb, u_xlat3);
					    u_xlat30 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
					    u_xlat30 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat30);
					    u_xlat3.xyz = unity_SHC.xyz * vec3(u_xlat30) + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat30 = log2(u_xlat4.w);
					    u_xlat30 = u_xlat30 * unity_Lightmap_HDR.y;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat30 * unity_Lightmap_HDR.x;
					    u_xlat3.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat3.xyz;
					    u_xlatb30 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb30){
					        u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat30 = inversesqrt(u_xlat30);
					        u_xlat4.xyz = vec3(u_xlat30) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat30 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat30 = min(u_xlat5.z, u_xlat30);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat30 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat30 = u_xlat30 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat30);
					    u_xlat1.x = u_xlat4.w + -1.0;
					    u_xlat1.x = unity_SpecCube0_HDR.w * u_xlat1.x + 1.0;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.y;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * u_xlat1.xxx;
					    u_xlatb32 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb32){
					        u_xlatb32 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb32){
					            u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat32 = inversesqrt(u_xlat32);
					            u_xlat6.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec4 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat32 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat32 = min(u_xlat7.z, u_xlat32);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat32) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat30);
					        u_xlat30 = u_xlat2.w + -1.0;
					        u_xlat30 = unity_SpecCube1_HDR.w * u_xlat30 + 1.0;
					        u_xlat30 = log2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.y;
					        u_xlat30 = exp2(u_xlat30);
					        u_xlat30 = u_xlat30 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30);
					        u_xlat4.xyz = u_xlat1.xxx * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat30 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat30) * _Color.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat32 = u_xlat1.x + u_xlat1.x;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat32)) + u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat7.y = (-u_xlat1.x) + 1.0;
					    u_xlat7.zw = u_xlat7.xy * u_xlat7.xy;
					    u_xlat0.xy = u_xlat7.xy * u_xlat7.xw;
					    u_xlat1.yz = u_xlat7.zy * u_xlat0.xy;
					    u_xlat0.x = (-u_xlat30) + _Glossiness;
					    u_xlat0.x = u_xlat0.x + 1.0;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7 = texture(unity_NHxRoughness, u_xlat1.yw);
					    u_xlat10.x = u_xlat7.x * 16.0;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + u_xlat6.xyz;
					    u_xlat1.xyw = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat0.xxx;
					    u_xlat2.xyz = u_xlat1.zzz * u_xlat2.xyz + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat6.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat10.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat30 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					float u_xlat10;
					vec3 u_xlat11;
					float u_xlat13;
					float u_xlat20;
					vec2 u_xlat21;
					float u_xlat30;
					float u_xlat32;
					bool u_xlatb32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat21.y = (-_Glossiness) + 1.0;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlatb32 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb32){
					        u_xlatb32 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb32)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat32 = u_xlat3.y * 0.25;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat4.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat32 = max(u_xlat32, u_xlat13);
					        u_xlat3.x = min(u_xlat4.x, u_xlat32);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					        u_xlat5.xyz = u_xlat3.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat3.xyz = u_xlat3.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat6.xyz = vs_TEXCOORD0.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat4.x = dot(u_xlat4, u_xlat6);
					        u_xlat4.y = dot(u_xlat5, u_xlat6);
					        u_xlat4.z = dot(u_xlat3, u_xlat6);
					    } else {
					        u_xlat3.xyz = vs_TEXCOORD0.xyz;
					        u_xlat3.w = 1.0;
					        u_xlat4.x = dot(unity_SHAr, u_xlat3);
					        u_xlat4.y = dot(unity_SHAg, u_xlat3);
					        u_xlat4.z = dot(unity_SHAb, u_xlat3);
					    }
					    u_xlat3 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
					    u_xlat5.x = dot(unity_SHBr, u_xlat3);
					    u_xlat5.y = dot(unity_SHBg, u_xlat3);
					    u_xlat5.z = dot(unity_SHBb, u_xlat3);
					    u_xlat32 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
					    u_xlat32 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat32);
					    u_xlat3.xyz = unity_SHC.xyz * vec3(u_xlat32) + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat32 = log2(u_xlat4.w);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.y;
					    u_xlat32 = exp2(u_xlat32);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.x;
					    u_xlat3.xyz = vec3(u_xlat32) * u_xlat4.xyz + u_xlat3.xyz;
					    u_xlatb32 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb32){
					        u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat32 = inversesqrt(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat32 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat32 = min(u_xlat5.z, u_xlat32);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat32) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat5.xy = (-u_xlat21.yy) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat32 = u_xlat21.y * u_xlat5.x;
					    u_xlat32 = u_xlat32 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat32);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xzw = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat32);
					        u_xlat32 = u_xlat2.w + -1.0;
					        u_xlat32 = unity_SpecCube1_HDR.w * u_xlat32 + 1.0;
					        u_xlat32 = log2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.y;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xzw = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat32 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat32) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat33 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.y = u_xlat21.y * u_xlat21.y;
					    u_xlat20 = u_xlat0.y * u_xlat0.y;
					    u_xlat11.x = u_xlat33 * u_xlat33;
					    u_xlat21.x = u_xlat0.y * u_xlat0.y + -1.0;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat21.x = u_xlat21.y * u_xlat21.y + 0.5;
					    u_xlat0.xy = u_xlat21.xy * u_xlat0.xy;
					    u_xlat11.x = u_xlat11.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * u_xlat11.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat20 / u_xlat0.x;
					    u_xlat10 = (-u_xlat0.y) * u_xlat5.y + 1.0;
					    u_xlat20 = (-u_xlat32) + _Glossiness;
					    u_xlat20 = u_xlat20 + 1.0;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat11.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat6.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * _LightColor0.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat6.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat30) + u_xlat2.xyz;
					    u_xlat0.xyw = u_xlat5.xzw * vec3(u_xlat10);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat2.xyz = (-u_xlat4.xyz) + vec3(u_xlat20);
					    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyw * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat30 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					float u_xlat11;
					float u_xlat13;
					float u_xlat20;
					float u_xlat21;
					float u_xlat30;
					float u_xlat31;
					float u_xlat32;
					bool u_xlatb32;
					float u_xlat33;
					float u_xlat34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat31 = (-_Glossiness) + 1.0;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD0.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlatb32 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb32){
					        u_xlatb32 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb32)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat32 = u_xlat3.y * 0.25;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat4.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat32 = max(u_xlat32, u_xlat13);
					        u_xlat3.x = min(u_xlat4.x, u_xlat32);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					        u_xlat5.xyz = u_xlat3.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat3.xyz = u_xlat3.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat6.xyz = vs_TEXCOORD0.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat4.x = dot(u_xlat4, u_xlat6);
					        u_xlat4.y = dot(u_xlat5, u_xlat6);
					        u_xlat4.z = dot(u_xlat3, u_xlat6);
					    } else {
					        u_xlat3.xyz = vs_TEXCOORD0.xyz;
					        u_xlat3.w = 1.0;
					        u_xlat4.x = dot(unity_SHAr, u_xlat3);
					        u_xlat4.y = dot(unity_SHAg, u_xlat3);
					        u_xlat4.z = dot(unity_SHAb, u_xlat3);
					    }
					    u_xlat3 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
					    u_xlat5.x = dot(unity_SHBr, u_xlat3);
					    u_xlat5.y = dot(unity_SHBg, u_xlat3);
					    u_xlat5.z = dot(unity_SHBb, u_xlat3);
					    u_xlat32 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
					    u_xlat32 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat32);
					    u_xlat3.xyz = unity_SHC.xyz * vec3(u_xlat32) + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat4.xyz;
					    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat32 = log2(u_xlat4.w);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.y;
					    u_xlat32 = exp2(u_xlat32);
					    u_xlat32 = u_xlat32 * unity_Lightmap_HDR.x;
					    u_xlat3.xyz = vec3(u_xlat32) * u_xlat4.xyz + u_xlat3.xyz;
					    u_xlatb32 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb32){
					        u_xlat32 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat32 = inversesqrt(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat32) * u_xlat2.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat32 = min(u_xlat5.y, u_xlat5.x);
					        u_xlat32 = min(u_xlat5.z, u_xlat32);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat32) + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat2.xyz;
					    }
					    u_xlat32 = (-u_xlat31) * 0.699999988 + 1.70000005;
					    u_xlat32 = u_xlat31 * u_xlat32;
					    u_xlat32 = u_xlat32 * 6.0;
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, u_xlat32);
					    u_xlat33 = u_xlat4.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat33 + 1.0;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.y;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat34);
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat34 = min(u_xlat7.z, u_xlat34);
					            u_xlat7.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat6.xyz * vec3(u_xlat34) + u_xlat7.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, u_xlat32);
					        u_xlat32 = u_xlat2.w + -1.0;
					        u_xlat32 = unity_SpecCube1_HDR.w * u_xlat32 + 1.0;
					        u_xlat32 = log2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.y;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat32);
					        u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + (-u_xlat2.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat32 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat32) * _Color.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat11 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = dot(u_xlat10.xx, vec2(u_xlat31));
					    u_xlat10.x = u_xlat10.x + -0.5;
					    u_xlat20 = (-u_xlat1.x) + 1.0;
					    u_xlat21 = u_xlat20 * u_xlat20;
					    u_xlat21 = u_xlat21 * u_xlat21;
					    u_xlat20 = u_xlat20 * u_xlat21;
					    u_xlat20 = u_xlat10.x * u_xlat20 + 1.0;
					    u_xlat21 = -abs(u_xlat30) + 1.0;
					    u_xlat2.x = u_xlat21 * u_xlat21;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat21 = u_xlat21 * u_xlat2.x;
					    u_xlat10.x = u_xlat10.x * u_xlat21 + 1.0;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat20 = u_xlat31 * u_xlat31;
					    u_xlat20 = max(u_xlat20, 0.00200000009);
					    u_xlat31 = (-u_xlat20) + 1.0;
					    u_xlat2.x = abs(u_xlat30) * u_xlat31 + u_xlat20;
					    u_xlat31 = u_xlat1.x * u_xlat31 + u_xlat20;
					    u_xlat30 = abs(u_xlat30) * u_xlat31;
					    u_xlat30 = u_xlat1.x * u_xlat2.x + u_xlat30;
					    u_xlat30 = u_xlat30 + 9.99999975e-06;
					    u_xlat30 = 0.5 / u_xlat30;
					    u_xlat31 = u_xlat20 * u_xlat20;
					    u_xlat2.x = u_xlat11 * u_xlat31 + (-u_xlat11);
					    u_xlat11 = u_xlat2.x * u_xlat11 + 1.0;
					    u_xlat31 = u_xlat31 * 0.318309873;
					    u_xlat11 = u_xlat11 * u_xlat11 + 1.00000001e-07;
					    u_xlat11 = u_xlat31 / u_xlat11;
					    u_xlat30 = u_xlat30 * u_xlat11;
					    u_xlat10.z = u_xlat30 * 3.14159274;
					    u_xlat10.xz = u_xlat1.xx * u_xlat10.xz;
					    u_xlat30 = max(u_xlat10.z, 0.0);
					    u_xlat20 = u_xlat20 * u_xlat20 + 1.0;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlatb1 = u_xlat1.x!=0.0;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat1.x = (-u_xlat32) + _Glossiness;
					    u_xlat1.x = u_xlat1.x + 1.0;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat2.xyz = _LightColor0.xyz * u_xlat10.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat30) * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = u_xlat10.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    u_xlat7.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat0.xyw = u_xlat7.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat0.xyw = u_xlat0.xyw * u_xlat3.xyz;
					    u_xlat0.xyw = u_xlat6.xyz * u_xlat2.xyz + u_xlat0.xyw;
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat20);
					    u_xlat1.xyw = (-u_xlat4.xyz) + u_xlat1.xxx;
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyw + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xyw;
					    u_xlat30 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[5];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					bool u_xlatb29;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat1.xyz = vs_TEXCOORD0.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat28 = log2(u_xlat2.w);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat1.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat1.xyz;
					    }
					    u_xlat28 = (-u_xlat27) * 0.699999988 + 1.70000005;
					    u_xlat27 = u_xlat27 * u_xlat28;
					    u_xlat27 = u_xlat27 * 6.0;
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, u_xlat27);
					    u_xlat28 = u_xlat3.w + -1.0;
					    u_xlat28 = unity_SpecCube0_HDR.w * u_xlat28 + 1.0;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28);
					    u_xlatb29 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb29){
					        u_xlatb29 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb29){
					            u_xlat29 = dot(u_xlat1.xyz, u_xlat1.xyz);
					            u_xlat29 = inversesqrt(u_xlat29);
					            u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat29);
					            u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat29 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat29 = min(u_xlat6.z, u_xlat29);
					            u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat1.xyz, u_xlat27);
					        u_xlat27 = u_xlat5.w + -1.0;
					        u_xlat27 = unity_SpecCube1_HDR.w * u_xlat27 + 1.0;
					        u_xlat27 = log2(u_xlat27);
					        u_xlat27 = u_xlat27 * unity_SpecCube1_HDR.y;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat27 = u_xlat27 * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + (-u_xlat1.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat1.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat27 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat27) * _Color.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.x = (-u_xlat27) + 1.0;
					    u_xlat9.x = u_xlat9.x + _Glossiness;
					    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
					    u_xlat9.xyz = (-u_xlat3.xyz) + u_xlat9.xxx;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat5.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[5];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat1.xyz = vs_TEXCOORD0.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat28 = log2(u_xlat2.w);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat1.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat1.xyz;
					    }
					    u_xlat4.xy = (-vec2(u_xlat27)) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat28 = u_xlat27 * u_xlat4.x;
					    u_xlat28 = u_xlat28 * 6.0;
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, u_xlat28);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = log2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.y;
					    u_xlat29 = exp2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xzw = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat1 = textureLod(unity_SpecCube1, u_xlat1.xyz, u_xlat28);
					        u_xlat28 = u_xlat1.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat1.xyz);
					        u_xlat4.xzw = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat1.xyz;
					    }
					    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat28 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat28) * _Color.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = u_xlat27 * u_xlat27;
					    u_xlat9.x = u_xlat27 * u_xlat9.x;
					    u_xlat9.x = (-u_xlat9.x) * u_xlat4.y + 1.0;
					    u_xlat18 = (-u_xlat28) + 1.0;
					    u_xlat18 = u_xlat18 + _Glossiness;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat4.xzw * u_xlat9.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.xyz = (-u_xlat3.xyz) + vec3(u_xlat18);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat5.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[5];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat1.xyz = vs_TEXCOORD0.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat28 = log2(u_xlat2.w);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat1.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat1.xyz;
					    }
					    u_xlat28 = (-u_xlat27) * 0.699999988 + 1.70000005;
					    u_xlat28 = u_xlat27 * u_xlat28;
					    u_xlat28 = u_xlat28 * 6.0;
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, u_xlat28);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = log2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.y;
					    u_xlat29 = exp2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat1 = textureLod(unity_SpecCube1, u_xlat1.xyz, u_xlat28);
					        u_xlat28 = u_xlat1.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat1.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat1.xyz;
					    }
					    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat28 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat28) * _Color.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat9.x = u_xlat27 * u_xlat27;
					    u_xlat9.x = max(u_xlat9.x, 0.00200000009);
					    u_xlat9.x = u_xlat9.x * u_xlat9.x + 1.0;
					    u_xlat9.x = float(1.0) / u_xlat9.x;
					    u_xlat18 = (-u_xlat28) + 1.0;
					    u_xlat18 = u_xlat18 + _Glossiness;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat9.xxx;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.xyz = (-u_xlat3.xyz) + vec3(u_xlat18);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[5];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat11;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					bool u_xlatb29;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat1.xyz = vs_TEXCOORD0.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
					    u_xlatb28 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb28){
					        u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb28)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat28 = u_xlat2.y * 0.25;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat3.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat28 = max(u_xlat28, u_xlat11);
					        u_xlat2.x = min(u_xlat3.x, u_xlat28);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD0.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat3, u_xlat5);
					        u_xlat3.y = dot(u_xlat4, u_xlat5);
					        u_xlat3.z = dot(u_xlat2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD0.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    }
					    u_xlat2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat28 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
					    u_xlat28 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat28);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat28 = log2(u_xlat3.w);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat1.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat1.xyz;
					    }
					    u_xlat28 = (-u_xlat27) * 0.699999988 + 1.70000005;
					    u_xlat27 = u_xlat27 * u_xlat28;
					    u_xlat27 = u_xlat27 * 6.0;
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, u_xlat27);
					    u_xlat28 = u_xlat3.w + -1.0;
					    u_xlat28 = unity_SpecCube0_HDR.w * u_xlat28 + 1.0;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28);
					    u_xlatb29 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb29){
					        u_xlatb29 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb29){
					            u_xlat29 = dot(u_xlat1.xyz, u_xlat1.xyz);
					            u_xlat29 = inversesqrt(u_xlat29);
					            u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat29);
					            u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat29 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat29 = min(u_xlat6.z, u_xlat29);
					            u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat1.xyz, u_xlat27);
					        u_xlat27 = u_xlat5.w + -1.0;
					        u_xlat27 = unity_SpecCube1_HDR.w * u_xlat27 + 1.0;
					        u_xlat27 = log2(u_xlat27);
					        u_xlat27 = u_xlat27 * unity_SpecCube1_HDR.y;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat27 = u_xlat27 * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + (-u_xlat1.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat1.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat27 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat27) * _Color.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.x = (-u_xlat27) + _Glossiness;
					    u_xlat9.x = u_xlat9.x + 1.0;
					    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
					    u_xlat9.xyz = (-u_xlat3.xyz) + u_xlat9.xxx;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat5.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[5];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat1.xyz = vs_TEXCOORD0.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
					    u_xlatb28 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb28){
					        u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb28)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat28 = u_xlat2.y * 0.25;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat3.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat28 = max(u_xlat28, u_xlat11);
					        u_xlat2.x = min(u_xlat3.x, u_xlat28);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD0.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat3, u_xlat5);
					        u_xlat3.y = dot(u_xlat4, u_xlat5);
					        u_xlat3.z = dot(u_xlat2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD0.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    }
					    u_xlat2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat28 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
					    u_xlat28 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat28);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat28 = log2(u_xlat3.w);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat1.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat1.xyz;
					    }
					    u_xlat4.xy = (-vec2(u_xlat27)) * vec2(0.699999988, 0.0799999982) + vec2(1.70000005, 0.600000024);
					    u_xlat28 = u_xlat27 * u_xlat4.x;
					    u_xlat28 = u_xlat28 * 6.0;
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, u_xlat28);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = log2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.y;
					    u_xlat29 = exp2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xzw = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat1 = textureLod(unity_SpecCube1, u_xlat1.xyz, u_xlat28);
					        u_xlat28 = u_xlat1.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat1.xyz);
					        u_xlat4.xzw = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat1.xyz;
					    }
					    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat28 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat28) * _Color.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = u_xlat27 * u_xlat27;
					    u_xlat9.x = u_xlat27 * u_xlat9.x;
					    u_xlat9.x = (-u_xlat9.x) * u_xlat4.y + 1.0;
					    u_xlat18 = (-u_xlat28) + _Glossiness;
					    u_xlat18 = u_xlat18 + 1.0;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat4.xzw * u_xlat9.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.xyz = (-u_xlat3.xyz) + vec3(u_xlat18);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat5.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[5];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_Lightmap;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
					    u_xlat1.x = u_xlat1.x + u_xlat1.x;
					    u_xlat1.xyz = vs_TEXCOORD0.xyz * (-u_xlat1.xxx) + (-u_xlat0.xyz);
					    u_xlatb28 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb28){
					        u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb28)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat28 = u_xlat2.y * 0.25;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat3.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat28 = max(u_xlat28, u_xlat11);
					        u_xlat2.x = min(u_xlat3.x, u_xlat28);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD0.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat3, u_xlat5);
					        u_xlat3.y = dot(u_xlat4, u_xlat5);
					        u_xlat3.z = dot(u_xlat2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD0.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    }
					    u_xlat2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat28 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
					    u_xlat28 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat28);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = texture(unity_Lightmap, vs_TEXCOORD2.xy);
					    u_xlat28 = log2(u_xlat3.w);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.y;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlatb28 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb28){
					        u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
					        u_xlat28 = inversesqrt(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat28) * u_xlat1.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec4 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat28 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat28 = min(u_xlat4.z, u_xlat28);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat1.xyz;
					    }
					    u_xlat28 = (-u_xlat27) * 0.699999988 + 1.70000005;
					    u_xlat28 = u_xlat27 * u_xlat28;
					    u_xlat28 = u_xlat28 * 6.0;
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, u_xlat28);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = log2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.y;
					    u_xlat29 = exp2(u_xlat29);
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat1.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat1.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat1 = textureLod(unity_SpecCube1, u_xlat1.xyz, u_xlat28);
					        u_xlat28 = u_xlat1.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = log2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.y;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat1.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat1.xyz;
					    }
					    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat28 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat28) * _Color.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat9.x = u_xlat27 * u_xlat27;
					    u_xlat9.x = max(u_xlat9.x, 0.00200000009);
					    u_xlat9.x = u_xlat9.x * u_xlat9.x + 1.0;
					    u_xlat9.x = float(1.0) / u_xlat9.x;
					    u_xlat18 = (-u_xlat28) + _Glossiness;
					    u_xlat18 = u_xlat18 + 1.0;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat9.xxx;
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.xyz = (-u_xlat3.xyz) + vec3(u_xlat18);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			LOD 200
			Tags { "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 106228
			Program "vp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_4[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD3 = u_xlat1.z;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _VATTime;
						float _VATNumFrames;
						vec4 _VATBounds;
						vec4 unused_0_5[2];
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
					uniform  sampler2D _VATPositions;
					uniform  sampler2D _VATNormals;
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = _VATNumFrames * _VATTime;
					    u_xlat0.x = u_xlat0.x * 0.999998987;
					    u_xlat0.x = floor(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x / _VATNumFrames;
					    u_xlat0.y = u_xlat0.x + in_TEXCOORD0.y;
					    u_xlat0.x = in_TEXCOORD0.x;
					    u_xlat1 = textureLod(_VATPositions, u_xlat0.xy, 0.0);
					    u_xlat0 = textureLod(_VATNormals, u_xlat0.xy, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _VATBounds.www;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD3 = u_xlat2.z;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD2.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb15)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat15, u_xlat16);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTexture0, vec2(u_xlat16));
					    u_xlat15 = u_xlat15 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat15 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat16 = u_xlat16 + u_xlat16;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat16)) + u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = (-_Glossiness) + 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat3.x * 16.0;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat5;
					float u_xlat6;
					float u_xlat10;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb16)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat17);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat16 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5 = (-_Glossiness) + 1.0;
					    u_xlat10 = u_xlat5 * u_xlat5;
					    u_xlat1.x = u_xlat10 * u_xlat10;
					    u_xlat6 = u_xlat17 * u_xlat17;
					    u_xlat10 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat10 = u_xlat6 * u_xlat10 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat5 = u_xlat5 * u_xlat5 + 0.5;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    u_xlat5 = u_xlat10 * u_xlat10;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat1.x / u_xlat0.x;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat16) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat22, u_xlat23);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTexture0, vec2(u_xlat23));
					    u_xlat22 = u_xlat22 * u_xlat3.x;
					    u_xlat3.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat22 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat22) * _Color.xyz;
					    u_xlat22 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat7.y = u_xlat14 * 3.14159274;
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat14 = max(u_xlat7.y, 0.0);
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat14;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
					    u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat6.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat5;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat5 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat12, u_xlat5);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat12 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat13 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat13 = u_xlat13 + u_xlat13;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat13)) + u_xlat0.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = (-_Glossiness) + 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 16.0;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb1){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat5.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat5.x, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat1.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat13 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4 = (-_Glossiness) + 1.0;
					    u_xlat8 = u_xlat4 * u_xlat4;
					    u_xlat6 = u_xlat8 * u_xlat8;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat8 = u_xlat8 * u_xlat8 + -1.0;
					    u_xlat8 = u_xlat2.x * u_xlat8 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat4 = u_xlat4 * u_xlat4 + 0.5;
					    u_xlat0.x = u_xlat4 * u_xlat0.x;
					    u_xlat4 = u_xlat8 * u_xlat8;
					    u_xlat0.x = u_xlat4 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat6 / u_xlat0.x;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat13) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb19)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat8 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat19, u_xlat8);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat2.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat19 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat19) * _Color.xyz;
					    u_xlat19 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat20 = u_xlat13 * u_xlat13;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat13 = u_xlat13 * u_xlat20;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat6.y = u_xlat12 * 3.14159274;
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat12 = max(u_xlat6.y, 0.0);
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat12;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat2.xyz;
					    u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat2.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat2 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat2 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat2;
					    u_xlat2 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_WorldToLight[3];
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb15)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat15, u_xlat16);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlatb16 = 0.0<u_xlat2.z;
					    u_xlat16 = u_xlatb16 ? 1.0 : float(0.0);
					    u_xlat3.xy = u_xlat2.xy / u_xlat2.ww;
					    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat16 = u_xlat16 * u_xlat3.w;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat15 = u_xlat15 * u_xlat16;
					    u_xlat2.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat15 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat16 = u_xlat16 + u_xlat16;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat16)) + u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = (-_Glossiness) + 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat3.x * 16.0;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat6;
					vec2 u_xlat8;
					float u_xlat10;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat2 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat2;
					    u_xlat2 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_WorldToLight[3];
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb16)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat8.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat8.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlatb3 = 0.0<u_xlat2.z;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat8.xy = u_xlat2.xy / u_xlat2.ww;
					    u_xlat8.xy = u_xlat8.xy + vec2(0.5, 0.5);
					    u_xlat4 = texture(_LightTexture0, u_xlat8.xy);
					    u_xlat17 = u_xlat3.x * u_xlat4.w;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat2.x = u_xlat17 * u_xlat3.x;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat16 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5 = (-_Glossiness) + 1.0;
					    u_xlat10 = u_xlat5 * u_xlat5;
					    u_xlat1.x = u_xlat10 * u_xlat10;
					    u_xlat6 = u_xlat17 * u_xlat17;
					    u_xlat10 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat10 = u_xlat6 * u_xlat10 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat5 = u_xlat5 * u_xlat5 + 0.5;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    u_xlat5 = u_xlat10 * u_xlat10;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat1.x / u_xlat0.x;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat16) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					bool u_xlatb23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat3 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat3;
					    u_xlat3 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat3;
					    u_xlat3 = u_xlat3 + unity_WorldToLight[3];
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat22, u_xlat23);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb23 = 0.0<u_xlat3.z;
					    u_xlat23 = u_xlatb23 ? 1.0 : float(0.0);
					    u_xlat4.xy = u_xlat3.xy / u_xlat3.ww;
					    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xy);
					    u_xlat23 = u_xlat23 * u_xlat4.w;
					    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat3.xx);
					    u_xlat23 = u_xlat23 * u_xlat3.x;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat3.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat22 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat22) * _Color.xyz;
					    u_xlat22 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat7.y = u_xlat14 * 3.14159274;
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat14 = max(u_xlat7.y, 0.0);
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat14;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
					    u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat6.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb15)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat15, u_xlat16);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat16));
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xyz);
					    u_xlat16 = u_xlat2.w * u_xlat3.x;
					    u_xlat15 = u_xlat15 * u_xlat16;
					    u_xlat2.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat15 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat16 = u_xlat16 + u_xlat16;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat16)) + u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = (-_Glossiness) + 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat3.x * 16.0;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat5;
					float u_xlat6;
					float u_xlat10;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb16)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat17);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat17));
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xyz);
					    u_xlat2.x = u_xlat2.w * u_xlat3.x;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat16 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5 = (-_Glossiness) + 1.0;
					    u_xlat10 = u_xlat5 * u_xlat5;
					    u_xlat1.x = u_xlat10 * u_xlat10;
					    u_xlat6 = u_xlat17 * u_xlat17;
					    u_xlat10 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat10 = u_xlat6 * u_xlat10 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat5 = u_xlat5 * u_xlat5 + 0.5;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    u_xlat5 = u_xlat10 * u_xlat10;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat1.x / u_xlat0.x;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat16) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat22, u_xlat23);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat23));
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xyz);
					    u_xlat23 = u_xlat3.w * u_xlat4.x;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat3.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat22 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat22) * _Color.xyz;
					    u_xlat22 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat7.y = u_xlat14 * 3.14159274;
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat14 = max(u_xlat7.y, 0.0);
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat14;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
					    u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat6.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_WorldToLight[3].xy;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb12)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12, u_xlat9);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlat12 = u_xlat12 * u_xlat1.w;
					    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat12 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat13 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat13 = u_xlat13 + u_xlat13;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat13)) + u_xlat0.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = (-_Glossiness) + 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 16.0;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat6;
					float u_xlat8;
					float u_xlat9;
					bool u_xlatb9;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_WorldToLight[3].xy;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13, u_xlat9);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat9 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlat1.x = u_xlat9 * u_xlat2.w;
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat13 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4 = (-_Glossiness) + 1.0;
					    u_xlat8 = u_xlat4 * u_xlat4;
					    u_xlat6 = u_xlat8 * u_xlat8;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat8 = u_xlat8 * u_xlat8 + -1.0;
					    u_xlat8 = u_xlat2.x * u_xlat8 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat4 = u_xlat4 * u_xlat4 + 0.5;
					    u_xlat0.x = u_xlat4 * u_xlat0.x;
					    u_xlat4 = u_xlat8 * u_xlat8;
					    u_xlat0.x = u_xlat4 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat6 / u_xlat0.x;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat13) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat12;
					float u_xlat13;
					float u_xlat14;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat2.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_WorldToLight[3].xy;
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb19)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat19, u_xlat14);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xy);
					    u_xlat19 = u_xlat19 * u_xlat2.w;
					    u_xlat2.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat19 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat19) * _Color.xyz;
					    u_xlat19 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat20 = u_xlat13 * u_xlat13;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat13 = u_xlat13 * u_xlat20;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat6.y = u_xlat12 * 3.14159274;
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat12 = max(u_xlat6.y, 0.0);
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat12;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat2.xyz;
					    u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat2.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" "FOG_LINEAR" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb15)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat15, u_xlat16);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTexture0, vec2(u_xlat16));
					    u_xlat15 = u_xlat15 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat15 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat16 = u_xlat16 + u_xlat16;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat16)) + u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = (-_Glossiness) + 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat3.x * 16.0;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat15 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" "FOG_LINEAR" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat5;
					float u_xlat6;
					float u_xlat10;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb16)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat17);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat16 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5 = (-_Glossiness) + 1.0;
					    u_xlat10 = u_xlat5 * u_xlat5;
					    u_xlat1.x = u_xlat10 * u_xlat10;
					    u_xlat6 = u_xlat17 * u_xlat17;
					    u_xlat10 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat10 = u_xlat6 * u_xlat10 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat5 = u_xlat5 * u_xlat5 + 0.5;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    u_xlat5 = u_xlat10 * u_xlat10;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat1.x / u_xlat0.x;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat16) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" "FOG_LINEAR" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat22, u_xlat23);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTexture0, vec2(u_xlat23));
					    u_xlat22 = u_xlat22 * u_xlat3.x;
					    u_xlat3.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat22 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat22) * _Color.xyz;
					    u_xlat22 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat7.y = u_xlat14 * 3.14159274;
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat14 = max(u_xlat7.y, 0.0);
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat14;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
					    u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat5;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat5 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat12, u_xlat5);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat12 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat13 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat13 = u_xlat13 + u_xlat13;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat13)) + u_xlat0.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = (-_Glossiness) + 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 16.0;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb1){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat5.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat5.x, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat1.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat13 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4 = (-_Glossiness) + 1.0;
					    u_xlat8 = u_xlat4 * u_xlat4;
					    u_xlat6 = u_xlat8 * u_xlat8;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat8 = u_xlat8 * u_xlat8 + -1.0;
					    u_xlat8 = u_xlat2.x * u_xlat8 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat4 = u_xlat4 * u_xlat4 + 0.5;
					    u_xlat0.x = u_xlat4 * u_xlat0.x;
					    u_xlat4 = u_xlat8 * u_xlat8;
					    u_xlat0.x = u_xlat4 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat6 / u_xlat0.x;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat13) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
						vec4 unused_0_2[3];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat8;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb19)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat8 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat19, u_xlat8);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat2.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat19 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat19) * _Color.xyz;
					    u_xlat19 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat20 = u_xlat13 * u_xlat13;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat13 = u_xlat13 * u_xlat20;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat6.y = u_xlat12 * 3.14159274;
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat12 = max(u_xlat6.y, 0.0);
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat12;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat2.xyz;
					    u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat2.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" "FOG_LINEAR" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat2 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat2 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat2;
					    u_xlat2 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_WorldToLight[3];
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb15)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat15, u_xlat16);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlatb16 = 0.0<u_xlat2.z;
					    u_xlat16 = u_xlatb16 ? 1.0 : float(0.0);
					    u_xlat3.xy = u_xlat2.xy / u_xlat2.ww;
					    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat16 = u_xlat16 * u_xlat3.w;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat15 = u_xlat15 * u_xlat16;
					    u_xlat2.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat15 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat16 = u_xlat16 + u_xlat16;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat16)) + u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = (-_Glossiness) + 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat3.x * 16.0;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat15 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" "FOG_LINEAR" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					float u_xlat5;
					float u_xlat6;
					vec2 u_xlat8;
					float u_xlat10;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat2 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat2;
					    u_xlat2 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_WorldToLight[3];
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb16)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat8.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat8.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlatb3 = 0.0<u_xlat2.z;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat8.xy = u_xlat2.xy / u_xlat2.ww;
					    u_xlat8.xy = u_xlat8.xy + vec2(0.5, 0.5);
					    u_xlat4 = texture(_LightTexture0, u_xlat8.xy);
					    u_xlat17 = u_xlat3.x * u_xlat4.w;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat2.x = u_xlat17 * u_xlat3.x;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat16 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5 = (-_Glossiness) + 1.0;
					    u_xlat10 = u_xlat5 * u_xlat5;
					    u_xlat1.x = u_xlat10 * u_xlat10;
					    u_xlat6 = u_xlat17 * u_xlat17;
					    u_xlat10 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat10 = u_xlat6 * u_xlat10 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat5 = u_xlat5 * u_xlat5 + 0.5;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    u_xlat5 = u_xlat10 * u_xlat10;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat1.x / u_xlat0.x;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat16) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" "FOG_LINEAR" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					bool u_xlatb23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat3 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat3;
					    u_xlat3 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat3;
					    u_xlat3 = u_xlat3 + unity_WorldToLight[3];
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat22, u_xlat23);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlatb23 = 0.0<u_xlat3.z;
					    u_xlat23 = u_xlatb23 ? 1.0 : float(0.0);
					    u_xlat4.xy = u_xlat3.xy / u_xlat3.ww;
					    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xy);
					    u_xlat23 = u_xlat23 * u_xlat4.w;
					    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat3.xx);
					    u_xlat23 = u_xlat23 * u_xlat3.x;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat3.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat22 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat22) * _Color.xyz;
					    u_xlat22 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat7.y = u_xlat14 * 3.14159274;
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat14 = max(u_xlat7.y, 0.0);
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat14;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
					    u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb15)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat15, u_xlat16);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat16));
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xyz);
					    u_xlat16 = u_xlat2.w * u_xlat3.x;
					    u_xlat15 = u_xlat15 * u_xlat16;
					    u_xlat2.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat15 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat16 = u_xlat16 + u_xlat16;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat16)) + u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = (-_Glossiness) + 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat3.x * 16.0;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat15 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat5;
					float u_xlat6;
					float u_xlat10;
					float u_xlat15;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb16)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat17 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat16, u_xlat17);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat16 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat17));
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xyz);
					    u_xlat2.x = u_xlat2.w * u_xlat3.x;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat16) * _LightColor0.xyz;
					    u_xlat16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat16 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.00100000005);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5 = (-_Glossiness) + 1.0;
					    u_xlat10 = u_xlat5 * u_xlat5;
					    u_xlat1.x = u_xlat10 * u_xlat10;
					    u_xlat6 = u_xlat17 * u_xlat17;
					    u_xlat10 = u_xlat10 * u_xlat10 + -1.0;
					    u_xlat10 = u_xlat6 * u_xlat10 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat5 = u_xlat5 * u_xlat5 + 0.5;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    u_xlat5 = u_xlat10 * u_xlat10;
					    u_xlat0.x = u_xlat5 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat1.x / u_xlat0.x;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat16) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat3.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : vs_TEXCOORD1.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat22, u_xlat23);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    }
					    u_xlat22 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat23));
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xyz);
					    u_xlat23 = u_xlat3.w * u_xlat4.x;
					    u_xlat22 = u_xlat22 * u_xlat23;
					    u_xlat3.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat22 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat4.xyz = vec3(u_xlat22) * vs_TEXCOORD0.xyz;
					    u_xlat5.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat22 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat6.xyz = vec3(u_xlat22) * _Color.xyz;
					    u_xlat22 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat7.y = u_xlat14 * 3.14159274;
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat14 = max(u_xlat7.y, 0.0);
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat14;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
					    u_xlat7.xyz = u_xlat3.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_WorldToLight[3].xy;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb12)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12, u_xlat9);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlat12 = u_xlat12 * u_xlat1.w;
					    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat12 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat13 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat13 = u_xlat13 + u_xlat13;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat13)) + u_xlat0.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = (-_Glossiness) + 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 16.0;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat6;
					float u_xlat8;
					float u_xlat9;
					bool u_xlatb9;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_WorldToLight[3].xy;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13, u_xlat9);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat9 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlat1.x = u_xlat9 * u_xlat2.w;
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat13 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat13 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = max(u_xlat12, 0.00100000005);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat4 = (-_Glossiness) + 1.0;
					    u_xlat8 = u_xlat4 * u_xlat4;
					    u_xlat6 = u_xlat8 * u_xlat8;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat8 = u_xlat8 * u_xlat8 + -1.0;
					    u_xlat8 = u_xlat2.x * u_xlat8 + 1.00001001;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = max(u_xlat0.x, 0.100000001);
					    u_xlat4 = u_xlat4 * u_xlat4 + 0.5;
					    u_xlat0.x = u_xlat4 * u_xlat0.x;
					    u_xlat4 = u_xlat8 * u_xlat8;
					    u_xlat0.x = u_xlat4 * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    u_xlat0.x = u_xlat6 / u_xlat0.x;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = _Color.xyz * vec3(u_xlat13) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[2];
						float _Glossiness;
						float _Metallic;
						vec4 _Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat12;
					float u_xlat13;
					float u_xlat14;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat2.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_WorldToLight[3].xy;
					    u_xlatb19 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb19){
					        u_xlatb19 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb19)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat19, u_xlat14);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat19 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xy);
					    u_xlat19 = u_xlat19 * u_xlat2.w;
					    u_xlat2.xyz = vec3(u_xlat19) * _LightColor0.xyz;
					    u_xlat19 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD0.xyz;
					    u_xlat4.xyz = _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
					    u_xlat4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
					    u_xlat19 = (-_Metallic) * 0.959999979 + 0.959999979;
					    u_xlat5.xyz = vec3(u_xlat19) * _Color.xyz;
					    u_xlat19 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat20 = u_xlat13 * u_xlat13;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat13 = u_xlat13 * u_xlat20;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat6.y = u_xlat12 * 3.14159274;
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat12 = max(u_xlat6.y, 0.0);
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat12;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat2.xyz;
					    u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat2.xyz = (-u_xlat4.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = _Color.w;
					    return;
					}"
				}
			}
		}
	}
}