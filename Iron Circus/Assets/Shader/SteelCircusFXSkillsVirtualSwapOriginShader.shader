Shader "SteelCircus/FX/Skills/VirtualSwapOriginShader" {
	Properties {
		_ColorOutlineFG ("Outline FG", Vector) = (1,1,0,1)
		_ColorMiddle ("Middle Color", Vector) = (1,1,1,1)
		_ColorDark ("Dark Color", Vector) = (1,1,1,1)
		_OutlineWidth ("Outline Width", Float) = 0.1
		[NoScaleOffset] _CharTex ("Charset", 2D) = "white" {}
		_CharDim ("Charset Dimensions (x=columns, y=rows, z=ws width, w=ws height)", Vector) = (16,16,0.5,0.75)
		_GridDim ("Output Grid Dimensions (x=columns, y=rows)", Vector) = (16,8,0,0)
		[NoScaleOffset] _CharAnimTex ("Charset animation", 2D) = "white" {}
		_CharAnimSpeed ("Charset animation speed", Float) = 1
		_ColorBuildupBG ("Buildup BG Color", Vector) = (1,0,0,1)
		_BuildupBGTime ("Buildup Time", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 52902
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
						vec4 unused_0_0[4];
						vec4 _ColorMiddle;
						vec4 _ColorDark;
						vec4 unused_0_3[2];
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 _CharDim;
						vec4 _GridDim;
						float _CharAnimSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _CharAnimTex;
					uniform  sampler2D _CharTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bvec2 u_xlatb2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat9;
					bool u_xlatb9;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat8.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat8.x = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlatb8 = 1.0<u_xlat8.x;
					    if(((int(u_xlatb8) * int(0xffffffffu)))!=0){discard;}
					    u_xlat8.xy = vs_TEXCOORD2.zx * vec2(1.0, -1.0);
					    u_xlat1.x = _CharDim.y * _CharDim.x;
					    u_xlat8.xy = u_xlat8.xy / _CharDim.zw;
					    u_xlat8.xy = u_xlat8.xy + vec2(1000.0, 1000.0);
					    u_xlat5.xy = floor(u_xlat8.xy);
					    u_xlat8.xy = u_xlat8.xy + (-u_xlat5.xy);
					    u_xlat5.xz = u_xlat5.xy / _GridDim.xy;
					    u_xlatb2.xy = greaterThanEqual(u_xlat5.xzxx, (-u_xlat5.xzxx)).xy;
					    u_xlat5.xz = fract(abs(u_xlat5.xz));
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb2.x) ? u_xlat5.x : (-u_xlat5.x);
					        hlslcc_movcTemp.z = (u_xlatb2.y) ? u_xlat5.z : (-u_xlat5.z);
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat5.xz = u_xlat5.xz * _GridDim.xy;
					    u_xlat5.x = u_xlat5.z * _GridDim.x + u_xlat5.x;
					    u_xlat9 = u_xlat5.y * 0.100000001;
					    u_xlat2.y = _Time.y * _CharAnimSpeed + u_xlat9;
					    u_xlat9 = _GridDim.y * _GridDim.x;
					    u_xlat2.x = u_xlat5.x / u_xlat9;
					    u_xlat2 = texture(_CharAnimTex, u_xlat2.xy);
					    u_xlat5.x = u_xlat2.x / u_xlat1.x;
					    u_xlat9 = _CharDim.x * _CharDim.y + -1.0;
					    u_xlat5.x = u_xlat9 * u_xlat5.x;
					    u_xlat1.x = u_xlat1.x * u_xlat5.x;
					    u_xlat1.x = floor(u_xlat1.x);
					    u_xlat5.x = u_xlat1.x / _CharDim.x;
					    u_xlatb9 = u_xlat5.x>=(-u_xlat5.x);
					    u_xlat13 = fract(abs(u_xlat5.x));
					    u_xlat9 = (u_xlatb9) ? u_xlat13 : (-u_xlat13);
					    u_xlat2.x = u_xlat9 * _CharDim.x;
					    u_xlat2.y = floor(u_xlat5.x);
					    u_xlat5.xy = u_xlat2.xy / _CharDim.xy;
					    u_xlat8.xy = u_xlat8.xy / _CharDim.xy;
					    u_xlat8.xy = u_xlat5.xy + u_xlat8.xy;
					    u_xlat2 = texture(_CharTex, u_xlat8.xy);
					    u_xlat3 = _ColorMiddle + (-_ColorDark);
					    u_xlat5.xyz = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat8.x = u_xlat2.x * u_xlat3.w + _ColorDark.w;
					    u_xlatb12 = 0.0>=u_xlat1.x;
					    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
					    u_xlat8.x = u_xlat12 * u_xlat8.x;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat5.xyz + _ColorDark.xyz;
					    u_xlat8.x = inversesqrt(_BuildupBGTime);
					    u_xlat8.x = float(1.0) / u_xlat8.x;
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlatb0 = u_xlat8.x>=u_xlat0.x;
					    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
					    u_xlat1.w = _ColorDark.w;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ColorBuildupBG.xyz;
					    u_xlat2.w = _ColorBuildupBG.w * _ColorDark.w + (-u_xlat1.w);
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
						vec4 unused_0_0[4];
						vec4 _ColorMiddle;
						vec4 _ColorDark;
						vec4 unused_0_3[2];
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 _CharDim;
						vec4 _GridDim;
						float _CharAnimSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _CharAnimTex;
					uniform  sampler2D _CharTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bvec2 u_xlatb2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat9;
					bool u_xlatb9;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat8.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat8.x = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlatb8 = 1.0<u_xlat8.x;
					    if(((int(u_xlatb8) * int(0xffffffffu)))!=0){discard;}
					    u_xlat8.xy = vs_TEXCOORD2.zx * vec2(1.0, -1.0);
					    u_xlat1.x = _CharDim.y * _CharDim.x;
					    u_xlat8.xy = u_xlat8.xy / _CharDim.zw;
					    u_xlat8.xy = u_xlat8.xy + vec2(1000.0, 1000.0);
					    u_xlat5.xy = floor(u_xlat8.xy);
					    u_xlat8.xy = u_xlat8.xy + (-u_xlat5.xy);
					    u_xlat5.xz = u_xlat5.xy / _GridDim.xy;
					    u_xlatb2.xy = greaterThanEqual(u_xlat5.xzxx, (-u_xlat5.xzxx)).xy;
					    u_xlat5.xz = fract(abs(u_xlat5.xz));
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb2.x) ? u_xlat5.x : (-u_xlat5.x);
					        hlslcc_movcTemp.z = (u_xlatb2.y) ? u_xlat5.z : (-u_xlat5.z);
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat5.xz = u_xlat5.xz * _GridDim.xy;
					    u_xlat5.x = u_xlat5.z * _GridDim.x + u_xlat5.x;
					    u_xlat9 = u_xlat5.y * 0.100000001;
					    u_xlat2.y = _Time.y * _CharAnimSpeed + u_xlat9;
					    u_xlat9 = _GridDim.y * _GridDim.x;
					    u_xlat2.x = u_xlat5.x / u_xlat9;
					    u_xlat2 = texture(_CharAnimTex, u_xlat2.xy);
					    u_xlat5.x = u_xlat2.x / u_xlat1.x;
					    u_xlat9 = _CharDim.x * _CharDim.y + -1.0;
					    u_xlat5.x = u_xlat9 * u_xlat5.x;
					    u_xlat1.x = u_xlat1.x * u_xlat5.x;
					    u_xlat1.x = floor(u_xlat1.x);
					    u_xlat5.x = u_xlat1.x / _CharDim.x;
					    u_xlatb9 = u_xlat5.x>=(-u_xlat5.x);
					    u_xlat13 = fract(abs(u_xlat5.x));
					    u_xlat9 = (u_xlatb9) ? u_xlat13 : (-u_xlat13);
					    u_xlat2.x = u_xlat9 * _CharDim.x;
					    u_xlat2.y = floor(u_xlat5.x);
					    u_xlat5.xy = u_xlat2.xy / _CharDim.xy;
					    u_xlat8.xy = u_xlat8.xy / _CharDim.xy;
					    u_xlat8.xy = u_xlat5.xy + u_xlat8.xy;
					    u_xlat2 = texture(_CharTex, u_xlat8.xy);
					    u_xlat3 = _ColorMiddle + (-_ColorDark);
					    u_xlat5.xyz = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat8.x = u_xlat2.x * u_xlat3.w + _ColorDark.w;
					    u_xlatb12 = 0.0>=u_xlat1.x;
					    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
					    u_xlat8.x = u_xlat12 * u_xlat8.x;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat5.xyz + _ColorDark.xyz;
					    u_xlat8.x = inversesqrt(_BuildupBGTime);
					    u_xlat8.x = float(1.0) / u_xlat8.x;
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlatb0 = u_xlat8.x>=u_xlat0.x;
					    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
					    u_xlat1.w = _ColorDark.w;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ColorBuildupBG.xyz;
					    u_xlat2.w = _ColorBuildupBG.w * _ColorDark.w + (-u_xlat1.w);
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
						vec4 unused_0_0[4];
						vec4 _ColorMiddle;
						vec4 _ColorDark;
						vec4 unused_0_3[2];
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 _CharDim;
						vec4 _GridDim;
						float _CharAnimSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _CharAnimTex;
					uniform  sampler2D _CharTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bvec2 u_xlatb2;
					vec4 u_xlat3;
					vec3 u_xlat5;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat9;
					bool u_xlatb9;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat8.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat8.x = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlatb8 = 1.0<u_xlat8.x;
					    if(((int(u_xlatb8) * int(0xffffffffu)))!=0){discard;}
					    u_xlat8.xy = vs_TEXCOORD2.zx * vec2(1.0, -1.0);
					    u_xlat1.x = _CharDim.y * _CharDim.x;
					    u_xlat8.xy = u_xlat8.xy / _CharDim.zw;
					    u_xlat8.xy = u_xlat8.xy + vec2(1000.0, 1000.0);
					    u_xlat5.xy = floor(u_xlat8.xy);
					    u_xlat8.xy = u_xlat8.xy + (-u_xlat5.xy);
					    u_xlat5.xz = u_xlat5.xy / _GridDim.xy;
					    u_xlatb2.xy = greaterThanEqual(u_xlat5.xzxx, (-u_xlat5.xzxx)).xy;
					    u_xlat5.xz = fract(abs(u_xlat5.xz));
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb2.x) ? u_xlat5.x : (-u_xlat5.x);
					        hlslcc_movcTemp.z = (u_xlatb2.y) ? u_xlat5.z : (-u_xlat5.z);
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat5.xz = u_xlat5.xz * _GridDim.xy;
					    u_xlat5.x = u_xlat5.z * _GridDim.x + u_xlat5.x;
					    u_xlat9 = u_xlat5.y * 0.100000001;
					    u_xlat2.y = _Time.y * _CharAnimSpeed + u_xlat9;
					    u_xlat9 = _GridDim.y * _GridDim.x;
					    u_xlat2.x = u_xlat5.x / u_xlat9;
					    u_xlat2 = texture(_CharAnimTex, u_xlat2.xy);
					    u_xlat5.x = u_xlat2.x / u_xlat1.x;
					    u_xlat9 = _CharDim.x * _CharDim.y + -1.0;
					    u_xlat5.x = u_xlat9 * u_xlat5.x;
					    u_xlat1.x = u_xlat1.x * u_xlat5.x;
					    u_xlat1.x = floor(u_xlat1.x);
					    u_xlat5.x = u_xlat1.x / _CharDim.x;
					    u_xlatb9 = u_xlat5.x>=(-u_xlat5.x);
					    u_xlat13 = fract(abs(u_xlat5.x));
					    u_xlat9 = (u_xlatb9) ? u_xlat13 : (-u_xlat13);
					    u_xlat2.x = u_xlat9 * _CharDim.x;
					    u_xlat2.y = floor(u_xlat5.x);
					    u_xlat5.xy = u_xlat2.xy / _CharDim.xy;
					    u_xlat8.xy = u_xlat8.xy / _CharDim.xy;
					    u_xlat8.xy = u_xlat5.xy + u_xlat8.xy;
					    u_xlat2 = texture(_CharTex, u_xlat8.xy);
					    u_xlat3 = _ColorMiddle + (-_ColorDark);
					    u_xlat5.xyz = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat8.x = u_xlat2.x * u_xlat3.w + _ColorDark.w;
					    u_xlatb12 = 0.0>=u_xlat1.x;
					    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
					    u_xlat8.x = u_xlat12 * u_xlat8.x;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat5.xyz + _ColorDark.xyz;
					    u_xlat8.x = inversesqrt(_BuildupBGTime);
					    u_xlat8.x = float(1.0) / u_xlat8.x;
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlatb0 = u_xlat8.x>=u_xlat0.x;
					    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
					    u_xlat1.w = _ColorDark.w;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ColorBuildupBG.xyz;
					    u_xlat2.w = _ColorBuildupBG.w * _ColorDark.w + (-u_xlat1.w);
					    SV_Target0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
					    return;
					}"
				}
			}
		}
	}
}