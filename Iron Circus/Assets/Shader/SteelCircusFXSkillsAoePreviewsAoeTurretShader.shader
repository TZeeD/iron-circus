Shader "SteelCircus/FX/Skills/AoePreviews/AoeTurretShader" {
	Properties {
		[NoScaleOffset] _MainTex ("Main Texture (R = background, G = overlay)", 2D) = "white" {}
		_ColorOutlineFG ("Outline FG", Vector) = (1,1,0,1)
		_ColorMiddle ("Middle Color", Vector) = (1,1,1,1)
		_ColorDark ("Dark Color", Vector) = (1,1,1,1)
		[NoScaleOffset] _CrosshairTex ("Crosshair (R = outlines, G = fill)", 2D) = "white" {}
		_CrosshairSize ("Crosshair size (%)", Range(0.01, 1)) = 0.5
		_CrosshairSpeed ("Crosshair blink speed", Float) = 0.5
		_RadiusInner ("Inner Radius (darker region)", Range(0.01, 1)) = 1
		_Radius ("Outer Radius (close to 1)", Range(0.01, 1)) = 1
		_OutlineWidth ("Outline Width (units div by scale)", Float) = 1
		_FireAnimation ("Fire animation time", Range(0, 1)) = 0
		_FireCrosshairScale ("Fire Crosshair Scale", Float) = 1.2
		_FireBlinkSpeed ("Fire Blink Frequency", Float) = 3
		_FragmentParams ("Fragment Params (xy = inner/outer radius ring 1, zw = ring 2)", Vector) = (0.4,0.5,0.8,1)
		[NoScaleOffset] _FragmentAnimationTex ("Fragment Animation Tex (R = ring 1, G = ring 2)", 2D) = "white" {}
		_FragmentAnimationSpeed ("Fragment Animation Speed", Float) = 0.5
		_ColorBuildupBG ("Buildup BG Color", Vector) = (1,0,0,1)
		_BuildupBGTime ("Buildup Time", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 12066
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
						vec4 unused_0_0[11];
						float _Radius;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xy = in_POSITION0.xy / vec2(_Radius);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[11];
						float _Radius;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xy = in_POSITION0.xy / vec2(_Radius);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[11];
						float _Radius;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xy = in_POSITION0.xy / vec2(_Radius);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
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
						vec4 _ColorDark;
						vec4 unused_0_4[2];
						vec4 _ColorBuildupBG;
						float _BuildupBGTime;
						vec4 _FragmentParams;
						float _Radius;
						float _OutlineWidth;
						float _CrosshairSize;
						float _CrosshairSpeed;
						float _RadiusInner;
						float _FireAnimation;
						float _FireCrosshairScale;
						float _FragmentAnimationSpeed;
						float _FireBlinkSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FragmentAnimationTex;
					uniform  sampler2D _CrosshairTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					bvec2 u_xlatb4;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat8;
					bool u_xlatb8;
					vec2 u_xlat10;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					vec2 u_xlat13;
					ivec2 u_xlati13;
					bvec2 u_xlatb13;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat10.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb6 = _Radius<u_xlat1.x;
					    u_xlatb11 = u_xlat2.y==0.0;
					    u_xlatb6 = u_xlatb11 && u_xlatb6;
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlat6.x = _BuildupBGTime * 0.649999976 + 0.349999994;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * u_xlat6.x;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6.xyz = u_xlat2.xxx * _ColorMiddle.xyz;
					    u_xlat2.x = u_xlat1.x / _Radius;
					    u_xlat12 = (-_OutlineWidth) + 1.0;
					    u_xlatb2 = u_xlat2.x>=u_xlat12;
					    u_xlat12 = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat7 = u_xlat12 + u_xlat2.y;
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat12 = (-_FireAnimation) + 1.0;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * 10.0;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = u_xlat12 * _RadiusInner;
					    u_xlatb12 = u_xlat12>=u_xlat1.x;
					    u_xlat3.x = 1.0;
					    u_xlat6.xyz = (bool(u_xlatb12)) ? _ColorDark.xyz : u_xlat6.xyz;
					    u_xlat12 = (u_xlatb12) ? 0.0 : u_xlat3.x;
					    u_xlat3.x = log2(_BuildupBGTime);
					    u_xlat3.xy = u_xlat3.xx * vec2(1.20000005, 0.25);
					    u_xlat3.xy = exp2(u_xlat3.xy);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlatb0.xy = greaterThanEqual(u_xlat3.xyxx, u_xlat0.xxxx).xy;
					    u_xlat0.x = (u_xlatb0.x) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlatb0.y) ? float(0.0) : float(1.0);
					    u_xlat3.xyz = (-u_xlat6.xyz) + _ColorBuildupBG.xyz;
					    u_xlat6.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat6.xyz;
					    u_xlat0.x = min(abs(u_xlat10.y), abs(u_xlat10.x));
					    u_xlat3.x = max(abs(u_xlat10.y), abs(u_xlat10.x));
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x;
					    u_xlat3.x = u_xlat0.x * u_xlat0.x;
					    u_xlat8 = u_xlat3.x * 0.0208350997 + -0.0851330012;
					    u_xlat8 = u_xlat3.x * u_xlat8 + 0.180141002;
					    u_xlat8 = u_xlat3.x * u_xlat8 + -0.330299497;
					    u_xlat3.x = u_xlat3.x * u_xlat8 + 0.999866009;
					    u_xlat8 = u_xlat0.x * u_xlat3.x;
					    u_xlatb13.x = abs(u_xlat10.y)<abs(u_xlat10.x);
					    u_xlat8 = u_xlat8 * -2.0 + 1.57079637;
					    u_xlat8 = u_xlatb13.x ? u_xlat8 : float(0.0);
					    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat8;
					    u_xlatb3 = u_xlat10.y<(-u_xlat10.y);
					    u_xlat3.x = u_xlatb3 ? -3.14159274 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat3.x;
					    u_xlat3.x = min(u_xlat10.y, u_xlat10.x);
					    u_xlat8 = max(u_xlat10.y, u_xlat10.x);
					    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
					    u_xlatb8 = u_xlat8>=(-u_xlat8);
					    u_xlatb3 = u_xlatb8 && u_xlatb3;
					    u_xlat0.x = (u_xlatb3) ? (-u_xlat0.x) : u_xlat0.x;
					    u_xlat3.x = u_xlat0.x * 0.159154937 + 0.5;
					    u_xlat3.y = _FragmentAnimationSpeed * (-_Time.y);
					    u_xlat3 = texture(_FragmentAnimationTex, u_xlat3.xy);
					    u_xlatb13.xy = greaterThanEqual(u_xlat1.xxxx, _FragmentParams.xzxz).xy;
					    u_xlatb4.xy = greaterThanEqual(_FragmentParams.ywyy, u_xlat1.xxxx).xy;
					    u_xlati13.xy = ivec2((uvec2(u_xlatb13.xy) * 0xffffffffu) & (uvec2(u_xlatb4.xy) * 0xffffffffu));
					    u_xlat13.xy = uintBitsToFloat(uvec2(u_xlati13.xy) & uvec2(1065353216u, 1065353216u));
					    u_xlat3.xy = u_xlat13.xy * u_xlat3.xy;
					    u_xlat4.xyz = (-u_xlat6.xyz) + _ColorMiddle.xyz;
					    u_xlat1.xyz = u_xlat3.xxx * u_xlat4.xyz + u_xlat6.xyz;
					    u_xlat3.xzw = (-u_xlat1.xyz) + _ColorMiddle.xyz;
					    u_xlat1.xyz = u_xlat3.yyy * u_xlat3.xzw + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + _ColorOutlineFG.xyz;
					    u_xlat1.xyz = vec3(u_xlat7) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat0.x = u_xlat12 * _FireAnimation;
					    u_xlat16 = _FireBlinkSpeed * _Time.y;
					    u_xlatb7 = u_xlat16>=(-u_xlat16);
					    u_xlat16 = fract(abs(u_xlat16));
					    u_xlat16 = (u_xlatb7) ? u_xlat16 : (-u_xlat16);
					    u_xlatb16 = u_xlat16>=0.5;
					    u_xlat16 = u_xlatb16 ? 1.0 : float(0.0);
					    u_xlat0.x = (u_xlatb2) ? 0.0 : u_xlat0.x;
					    u_xlat2.xyz = _ColorMiddle.xyz * vec3(u_xlat16) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.x = _CrosshairSpeed * _Time.y;
					    u_xlatb16 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlat0.x = fract(abs(u_xlat0.x));
					    u_xlat0.x = (u_xlatb16) ? u_xlat0.x : (-u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat16 = _FireAnimation * 10000.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x + u_xlat16;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat16 = u_xlat0.x + _FireAnimation;
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat2.x = _FireCrosshairScale + -1.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x + 1.0;
					    u_xlat16 = u_xlat16 * _CrosshairSize;
					    u_xlat10.xy = u_xlat10.xy / vec2(u_xlat16);
					    u_xlat10.xy = u_xlat10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat3 = texture(_CrosshairTex, u_xlat10.xy);
					    u_xlat0.x = u_xlat3.y * u_xlat0.x + u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xyz = _ColorOutlineFG.xyz + (-_ColorMiddle.xyz);
					    u_xlat2.xyz = vec3(vec3(_FireAnimation, _FireAnimation, _FireAnimation)) * u_xlat2.xyz + _ColorMiddle.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat3 = (-u_xlat1) + _ColorBuildupBG;
					    u_xlat1 = u_xlat0.yyyy * u_xlat3 + u_xlat1;
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
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
						vec4 _FragmentParams;
						float _Radius;
						float _OutlineWidth;
						float _CrosshairSize;
						float _CrosshairSpeed;
						float _RadiusInner;
						float _FireAnimation;
						float _FireCrosshairScale;
						float _FragmentAnimationSpeed;
						float _FireBlinkSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FragmentAnimationTex;
					uniform  sampler2D _CrosshairTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					bvec2 u_xlatb4;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat8;
					bool u_xlatb8;
					vec2 u_xlat10;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					vec2 u_xlat13;
					ivec2 u_xlati13;
					bvec2 u_xlatb13;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat10.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb6 = _Radius<u_xlat1.x;
					    u_xlatb11 = u_xlat2.y==0.0;
					    u_xlatb6 = u_xlatb11 && u_xlatb6;
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlat6.x = _BuildupBGTime * 0.649999976 + 0.349999994;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * u_xlat6.x;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6.xyz = u_xlat2.xxx * _ColorMiddle.xyz;
					    u_xlat2.x = u_xlat1.x / _Radius;
					    u_xlat12 = (-_OutlineWidth) + 1.0;
					    u_xlatb2 = u_xlat2.x>=u_xlat12;
					    u_xlat12 = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat7 = u_xlat12 + u_xlat2.y;
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat12 = (-_FireAnimation) + 1.0;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * 10.0;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = u_xlat12 * _RadiusInner;
					    u_xlatb12 = u_xlat12>=u_xlat1.x;
					    u_xlat3.x = 1.0;
					    u_xlat6.xyz = (bool(u_xlatb12)) ? _ColorDark.xyz : u_xlat6.xyz;
					    u_xlat12 = (u_xlatb12) ? 0.0 : u_xlat3.x;
					    u_xlat3.x = log2(_BuildupBGTime);
					    u_xlat3.xy = u_xlat3.xx * vec2(1.20000005, 0.25);
					    u_xlat3.xy = exp2(u_xlat3.xy);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlatb0.xy = greaterThanEqual(u_xlat3.xyxx, u_xlat0.xxxx).xy;
					    u_xlat0.x = (u_xlatb0.x) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlatb0.y) ? float(0.0) : float(1.0);
					    u_xlat3.xyz = (-u_xlat6.xyz) + _ColorBuildupBG.xyz;
					    u_xlat6.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat6.xyz;
					    u_xlat0.x = min(abs(u_xlat10.y), abs(u_xlat10.x));
					    u_xlat3.x = max(abs(u_xlat10.y), abs(u_xlat10.x));
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x;
					    u_xlat3.x = u_xlat0.x * u_xlat0.x;
					    u_xlat8 = u_xlat3.x * 0.0208350997 + -0.0851330012;
					    u_xlat8 = u_xlat3.x * u_xlat8 + 0.180141002;
					    u_xlat8 = u_xlat3.x * u_xlat8 + -0.330299497;
					    u_xlat3.x = u_xlat3.x * u_xlat8 + 0.999866009;
					    u_xlat8 = u_xlat0.x * u_xlat3.x;
					    u_xlatb13.x = abs(u_xlat10.y)<abs(u_xlat10.x);
					    u_xlat8 = u_xlat8 * -2.0 + 1.57079637;
					    u_xlat8 = u_xlatb13.x ? u_xlat8 : float(0.0);
					    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat8;
					    u_xlatb3 = u_xlat10.y<(-u_xlat10.y);
					    u_xlat3.x = u_xlatb3 ? -3.14159274 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat3.x;
					    u_xlat3.x = min(u_xlat10.y, u_xlat10.x);
					    u_xlat8 = max(u_xlat10.y, u_xlat10.x);
					    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
					    u_xlatb8 = u_xlat8>=(-u_xlat8);
					    u_xlatb3 = u_xlatb8 && u_xlatb3;
					    u_xlat0.x = (u_xlatb3) ? (-u_xlat0.x) : u_xlat0.x;
					    u_xlat3.x = u_xlat0.x * 0.159154937 + 0.5;
					    u_xlat3.y = _FragmentAnimationSpeed * (-_Time.y);
					    u_xlat3 = texture(_FragmentAnimationTex, u_xlat3.xy);
					    u_xlatb13.xy = greaterThanEqual(u_xlat1.xxxx, _FragmentParams.xzxz).xy;
					    u_xlatb4.xy = greaterThanEqual(_FragmentParams.ywyy, u_xlat1.xxxx).xy;
					    u_xlati13.xy = ivec2((uvec2(u_xlatb13.xy) * 0xffffffffu) & (uvec2(u_xlatb4.xy) * 0xffffffffu));
					    u_xlat13.xy = uintBitsToFloat(uvec2(u_xlati13.xy) & uvec2(1065353216u, 1065353216u));
					    u_xlat3.xy = u_xlat13.xy * u_xlat3.xy;
					    u_xlat4.xyz = (-u_xlat6.xyz) + _ColorMiddle.xyz;
					    u_xlat1.xyz = u_xlat3.xxx * u_xlat4.xyz + u_xlat6.xyz;
					    u_xlat3.xzw = (-u_xlat1.xyz) + _ColorMiddle.xyz;
					    u_xlat1.xyz = u_xlat3.yyy * u_xlat3.xzw + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + _ColorOutlineFG.xyz;
					    u_xlat1.xyz = vec3(u_xlat7) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat0.x = u_xlat12 * _FireAnimation;
					    u_xlat16 = _FireBlinkSpeed * _Time.y;
					    u_xlatb7 = u_xlat16>=(-u_xlat16);
					    u_xlat16 = fract(abs(u_xlat16));
					    u_xlat16 = (u_xlatb7) ? u_xlat16 : (-u_xlat16);
					    u_xlatb16 = u_xlat16>=0.5;
					    u_xlat16 = u_xlatb16 ? 1.0 : float(0.0);
					    u_xlat0.x = (u_xlatb2) ? 0.0 : u_xlat0.x;
					    u_xlat2.xyz = _ColorMiddle.xyz * vec3(u_xlat16) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.x = _CrosshairSpeed * _Time.y;
					    u_xlatb16 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlat0.x = fract(abs(u_xlat0.x));
					    u_xlat0.x = (u_xlatb16) ? u_xlat0.x : (-u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat16 = _FireAnimation * 10000.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x + u_xlat16;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat16 = u_xlat0.x + _FireAnimation;
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat2.x = _FireCrosshairScale + -1.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x + 1.0;
					    u_xlat16 = u_xlat16 * _CrosshairSize;
					    u_xlat10.xy = u_xlat10.xy / vec2(u_xlat16);
					    u_xlat10.xy = u_xlat10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat3 = texture(_CrosshairTex, u_xlat10.xy);
					    u_xlat0.x = u_xlat3.y * u_xlat0.x + u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xyz = _ColorOutlineFG.xyz + (-_ColorMiddle.xyz);
					    u_xlat2.xyz = vec3(vec3(_FireAnimation, _FireAnimation, _FireAnimation)) * u_xlat2.xyz + _ColorMiddle.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat3 = (-u_xlat1) + _ColorBuildupBG;
					    u_xlat1 = u_xlat0.yyyy * u_xlat3 + u_xlat1;
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
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
						vec4 _FragmentParams;
						float _Radius;
						float _OutlineWidth;
						float _CrosshairSize;
						float _CrosshairSpeed;
						float _RadiusInner;
						float _FireAnimation;
						float _FireCrosshairScale;
						float _FragmentAnimationSpeed;
						float _FireBlinkSpeed;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FragmentAnimationTex;
					uniform  sampler2D _CrosshairTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bvec2 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec3 u_xlat4;
					bvec2 u_xlatb4;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat8;
					bool u_xlatb8;
					vec2 u_xlat10;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					vec2 u_xlat13;
					ivec2 u_xlati13;
					bvec2 u_xlatb13;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat10.xy = u_xlat0.xy + u_xlat0.xy;
					    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb6 = _Radius<u_xlat1.x;
					    u_xlatb11 = u_xlat2.y==0.0;
					    u_xlatb6 = u_xlatb11 && u_xlatb6;
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlat6.x = _BuildupBGTime * 0.649999976 + 0.349999994;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * u_xlat6.x;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat6.xyz = u_xlat2.xxx * _ColorMiddle.xyz;
					    u_xlat2.x = u_xlat1.x / _Radius;
					    u_xlat12 = (-_OutlineWidth) + 1.0;
					    u_xlatb2 = u_xlat2.x>=u_xlat12;
					    u_xlat12 = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat7 = u_xlat12 + u_xlat2.y;
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat12 = (-_FireAnimation) + 1.0;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * 10.0;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = u_xlat12 * _RadiusInner;
					    u_xlatb12 = u_xlat12>=u_xlat1.x;
					    u_xlat3.x = 1.0;
					    u_xlat6.xyz = (bool(u_xlatb12)) ? _ColorDark.xyz : u_xlat6.xyz;
					    u_xlat12 = (u_xlatb12) ? 0.0 : u_xlat3.x;
					    u_xlat3.x = log2(_BuildupBGTime);
					    u_xlat3.xy = u_xlat3.xx * vec2(1.20000005, 0.25);
					    u_xlat3.xy = exp2(u_xlat3.xy);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlatb0.xy = greaterThanEqual(u_xlat3.xyxx, u_xlat0.xxxx).xy;
					    u_xlat0.x = (u_xlatb0.x) ? float(0.0) : float(1.0);
					    u_xlat0.y = (u_xlatb0.y) ? float(0.0) : float(1.0);
					    u_xlat3.xyz = (-u_xlat6.xyz) + _ColorBuildupBG.xyz;
					    u_xlat6.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat6.xyz;
					    u_xlat0.x = min(abs(u_xlat10.y), abs(u_xlat10.x));
					    u_xlat3.x = max(abs(u_xlat10.y), abs(u_xlat10.x));
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x;
					    u_xlat3.x = u_xlat0.x * u_xlat0.x;
					    u_xlat8 = u_xlat3.x * 0.0208350997 + -0.0851330012;
					    u_xlat8 = u_xlat3.x * u_xlat8 + 0.180141002;
					    u_xlat8 = u_xlat3.x * u_xlat8 + -0.330299497;
					    u_xlat3.x = u_xlat3.x * u_xlat8 + 0.999866009;
					    u_xlat8 = u_xlat0.x * u_xlat3.x;
					    u_xlatb13.x = abs(u_xlat10.y)<abs(u_xlat10.x);
					    u_xlat8 = u_xlat8 * -2.0 + 1.57079637;
					    u_xlat8 = u_xlatb13.x ? u_xlat8 : float(0.0);
					    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat8;
					    u_xlatb3 = u_xlat10.y<(-u_xlat10.y);
					    u_xlat3.x = u_xlatb3 ? -3.14159274 : float(0.0);
					    u_xlat0.x = u_xlat0.x + u_xlat3.x;
					    u_xlat3.x = min(u_xlat10.y, u_xlat10.x);
					    u_xlat8 = max(u_xlat10.y, u_xlat10.x);
					    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
					    u_xlatb8 = u_xlat8>=(-u_xlat8);
					    u_xlatb3 = u_xlatb8 && u_xlatb3;
					    u_xlat0.x = (u_xlatb3) ? (-u_xlat0.x) : u_xlat0.x;
					    u_xlat3.x = u_xlat0.x * 0.159154937 + 0.5;
					    u_xlat3.y = _FragmentAnimationSpeed * (-_Time.y);
					    u_xlat3 = texture(_FragmentAnimationTex, u_xlat3.xy);
					    u_xlatb13.xy = greaterThanEqual(u_xlat1.xxxx, _FragmentParams.xzxz).xy;
					    u_xlatb4.xy = greaterThanEqual(_FragmentParams.ywyy, u_xlat1.xxxx).xy;
					    u_xlati13.xy = ivec2((uvec2(u_xlatb13.xy) * 0xffffffffu) & (uvec2(u_xlatb4.xy) * 0xffffffffu));
					    u_xlat13.xy = uintBitsToFloat(uvec2(u_xlati13.xy) & uvec2(1065353216u, 1065353216u));
					    u_xlat3.xy = u_xlat13.xy * u_xlat3.xy;
					    u_xlat4.xyz = (-u_xlat6.xyz) + _ColorMiddle.xyz;
					    u_xlat1.xyz = u_xlat3.xxx * u_xlat4.xyz + u_xlat6.xyz;
					    u_xlat3.xzw = (-u_xlat1.xyz) + _ColorMiddle.xyz;
					    u_xlat1.xyz = u_xlat3.yyy * u_xlat3.xzw + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + _ColorOutlineFG.xyz;
					    u_xlat1.xyz = vec3(u_xlat7) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat0.x = u_xlat12 * _FireAnimation;
					    u_xlat16 = _FireBlinkSpeed * _Time.y;
					    u_xlatb7 = u_xlat16>=(-u_xlat16);
					    u_xlat16 = fract(abs(u_xlat16));
					    u_xlat16 = (u_xlatb7) ? u_xlat16 : (-u_xlat16);
					    u_xlatb16 = u_xlat16>=0.5;
					    u_xlat16 = u_xlatb16 ? 1.0 : float(0.0);
					    u_xlat0.x = (u_xlatb2) ? 0.0 : u_xlat0.x;
					    u_xlat2.xyz = _ColorMiddle.xyz * vec3(u_xlat16) + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.x = _CrosshairSpeed * _Time.y;
					    u_xlatb16 = u_xlat0.x>=(-u_xlat0.x);
					    u_xlat0.x = fract(abs(u_xlat0.x));
					    u_xlat0.x = (u_xlatb16) ? u_xlat0.x : (-u_xlat0.x);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat16 = _FireAnimation * 10000.0;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x + u_xlat16;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat16 = u_xlat0.x + _FireAnimation;
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat2.x = _FireCrosshairScale + -1.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x + 1.0;
					    u_xlat16 = u_xlat16 * _CrosshairSize;
					    u_xlat10.xy = u_xlat10.xy / vec2(u_xlat16);
					    u_xlat10.xy = u_xlat10.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat3 = texture(_CrosshairTex, u_xlat10.xy);
					    u_xlat0.x = u_xlat3.y * u_xlat0.x + u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xyz = _ColorOutlineFG.xyz + (-_ColorMiddle.xyz);
					    u_xlat2.xyz = vec3(vec3(_FireAnimation, _FireAnimation, _FireAnimation)) * u_xlat2.xyz + _ColorMiddle.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat3 = (-u_xlat1) + _ColorBuildupBG;
					    u_xlat1 = u_xlat0.yyyy * u_xlat3 + u_xlat1;
					    u_xlat0.x = u_xlat0.x + u_xlat2.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat0.x * u_xlat1.w;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}"
				}
			}
		}
	}
}