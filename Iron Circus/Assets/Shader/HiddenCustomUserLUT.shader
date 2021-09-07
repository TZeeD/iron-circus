Shader "Hidden/Custom/UserLUT" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 18589
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[2];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[2];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[2];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "USE_BG_LUT" }
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[4];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "USE_BG_LUT" }
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[4];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "USE_BG_LUT" }
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
						vec4 unused_0_0[26];
						float _RenderViewportScaleFactor;
						vec4 unused_0_2[4];
					};
					in  vec3 in_POSITION0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					vec2 u_xlat0;
					void main()
					{
					    gl_Position.xy = in_POSITION0.xy;
					    gl_Position.zw = vec2(0.0, 1.0);
					    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.5, -0.5) + vec2(0.0, 1.0);
					    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
					    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5);
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
						vec4 unused_0_0[28];
						vec4 _UserLut_Params;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _UserLut;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bvec3 u_xlatb4;
					vec3 u_xlat7;
					float u_xlat10;
					void main()
					{
					    u_xlat0.x = _UserLut_Params.y;
					    u_xlat0.y = 0.0;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz;
					    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
					    SV_Target0.w = u_xlat1.w;
					    u_xlat2.xyz = max(u_xlat1.zxy, vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat3.xyz = u_xlat1.zxy * vec3(12.9200001, 12.9200001, 12.9200001);
					    u_xlatb4.xyz = greaterThanEqual(vec4(0.00313080009, 0.00313080009, 0.00313080009, 0.0), u_xlat1.zxyz).xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat2;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat3.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat3.z : u_xlat2.z;
					        u_xlat2 = hlslcc_movcTemp;
					    }
					    u_xlat7.xyz = u_xlat2.xyz * _UserLut_Params.zzz;
					    u_xlat10 = floor(u_xlat7.x);
					    u_xlat3.xy = _UserLut_Params.xy * vec2(0.5, 0.5);
					    u_xlat3.yz = u_xlat7.yz * _UserLut_Params.xy + u_xlat3.xy;
					    u_xlat3.x = u_xlat10 * _UserLut_Params.y + u_xlat3.y;
					    u_xlat10 = u_xlat2.x * _UserLut_Params.z + (-u_xlat10);
					    u_xlat0.xy = u_xlat0.xy + u_xlat3.xz;
					    u_xlat2 = texture(_UserLut, u_xlat3.xz);
					    u_xlat3 = texture(_UserLut, u_xlat0.xy);
					    u_xlat0.xyw = (-u_xlat2.xyz) + u_xlat3.xyz;
					    u_xlat0.xyz = vec3(u_xlat10) * u_xlat0.xyw + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat2.xyz = max(abs(u_xlat2.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb0.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0.xyzx).xyz;
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat3.x : u_xlat2.x;
					    u_xlat0.y = (u_xlatb0.y) ? u_xlat3.y : u_xlat2.y;
					    u_xlat0.z = (u_xlatb0.z) ? u_xlat3.z : u_xlat2.z;
					    u_xlat0.xyz = (-u_xlat1.xyz) + u_xlat0.xyz;
					    SV_Target0.xyz = _UserLut_Params.www * u_xlat0.xyz + u_xlat1.xyz;
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
						vec4 unused_0_0[28];
						vec4 _UserLut_Params;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _UserLut;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bvec3 u_xlatb4;
					vec3 u_xlat7;
					float u_xlat10;
					void main()
					{
					    u_xlat0.x = _UserLut_Params.y;
					    u_xlat0.y = 0.0;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz;
					    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
					    SV_Target0.w = u_xlat1.w;
					    u_xlat2.xyz = max(u_xlat1.zxy, vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat3.xyz = u_xlat1.zxy * vec3(12.9200001, 12.9200001, 12.9200001);
					    u_xlatb4.xyz = greaterThanEqual(vec4(0.00313080009, 0.00313080009, 0.00313080009, 0.0), u_xlat1.zxyz).xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat2;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat3.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat3.z : u_xlat2.z;
					        u_xlat2 = hlslcc_movcTemp;
					    }
					    u_xlat7.xyz = u_xlat2.xyz * _UserLut_Params.zzz;
					    u_xlat10 = floor(u_xlat7.x);
					    u_xlat3.xy = _UserLut_Params.xy * vec2(0.5, 0.5);
					    u_xlat3.yz = u_xlat7.yz * _UserLut_Params.xy + u_xlat3.xy;
					    u_xlat3.x = u_xlat10 * _UserLut_Params.y + u_xlat3.y;
					    u_xlat10 = u_xlat2.x * _UserLut_Params.z + (-u_xlat10);
					    u_xlat0.xy = u_xlat0.xy + u_xlat3.xz;
					    u_xlat2 = texture(_UserLut, u_xlat3.xz);
					    u_xlat3 = texture(_UserLut, u_xlat0.xy);
					    u_xlat0.xyw = (-u_xlat2.xyz) + u_xlat3.xyz;
					    u_xlat0.xyz = vec3(u_xlat10) * u_xlat0.xyw + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat2.xyz = max(abs(u_xlat2.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb0.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0.xyzx).xyz;
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat3.x : u_xlat2.x;
					    u_xlat0.y = (u_xlatb0.y) ? u_xlat3.y : u_xlat2.y;
					    u_xlat0.z = (u_xlatb0.z) ? u_xlat3.z : u_xlat2.z;
					    u_xlat0.xyz = (-u_xlat1.xyz) + u_xlat0.xyz;
					    SV_Target0.xyz = _UserLut_Params.www * u_xlat0.xyz + u_xlat1.xyz;
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
						vec4 unused_0_0[28];
						vec4 _UserLut_Params;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _UserLut;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bvec3 u_xlatb4;
					vec3 u_xlat7;
					float u_xlat10;
					void main()
					{
					    u_xlat0.x = _UserLut_Params.y;
					    u_xlat0.y = 0.0;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz;
					    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
					    SV_Target0.w = u_xlat1.w;
					    u_xlat2.xyz = max(u_xlat1.zxy, vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat3.xyz = u_xlat1.zxy * vec3(12.9200001, 12.9200001, 12.9200001);
					    u_xlatb4.xyz = greaterThanEqual(vec4(0.00313080009, 0.00313080009, 0.00313080009, 0.0), u_xlat1.zxyz).xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat2;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat3.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat3.z : u_xlat2.z;
					        u_xlat2 = hlslcc_movcTemp;
					    }
					    u_xlat7.xyz = u_xlat2.xyz * _UserLut_Params.zzz;
					    u_xlat10 = floor(u_xlat7.x);
					    u_xlat3.xy = _UserLut_Params.xy * vec2(0.5, 0.5);
					    u_xlat3.yz = u_xlat7.yz * _UserLut_Params.xy + u_xlat3.xy;
					    u_xlat3.x = u_xlat10 * _UserLut_Params.y + u_xlat3.y;
					    u_xlat10 = u_xlat2.x * _UserLut_Params.z + (-u_xlat10);
					    u_xlat0.xy = u_xlat0.xy + u_xlat3.xz;
					    u_xlat2 = texture(_UserLut, u_xlat3.xz);
					    u_xlat3 = texture(_UserLut, u_xlat0.xy);
					    u_xlat0.xyw = (-u_xlat2.xyz) + u_xlat3.xyz;
					    u_xlat0.xyz = vec3(u_xlat10) * u_xlat0.xyw + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat2.xyz = max(abs(u_xlat2.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb0.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0.xyzx).xyz;
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat3.x : u_xlat2.x;
					    u_xlat0.y = (u_xlatb0.y) ? u_xlat3.y : u_xlat2.y;
					    u_xlat0.z = (u_xlatb0.z) ? u_xlat3.z : u_xlat2.z;
					    u_xlat0.xyz = (-u_xlat1.xyz) + u_xlat0.xyz;
					    SV_Target0.xyz = _UserLut_Params.www * u_xlat0.xyz + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "USE_BG_LUT" }
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
						vec4 unused_0_0[21];
						vec4 _ZBufferParams;
						vec4 unused_0_2[6];
						vec4 _UserLut_Params;
						vec4 _BGLut_Params;
						vec2 _BGLut_Blend;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _UserLut;
					uniform  sampler2D _BGLut;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					bvec3 u_xlatb4;
					vec3 u_xlat7;
					vec2 u_xlat10;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat10.x = _BGLut_Params.y;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz;
					    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
					    SV_Target0.w = u_xlat1.w;
					    u_xlat2.xyz = max(u_xlat1.zxy, vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat3.xyz = u_xlat1.zxy * vec3(12.9200001, 12.9200001, 12.9200001);
					    u_xlatb4.xyz = greaterThanEqual(vec4(0.00313080009, 0.00313080009, 0.00313080009, 0.0), u_xlat1.zxyz).xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat2;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat3.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat3.z : u_xlat2.z;
					        u_xlat2 = hlslcc_movcTemp;
					    }
					    u_xlat3.xyz = u_xlat2.xyz * _BGLut_Params.zzz;
					    u_xlat16 = floor(u_xlat3.x);
					    u_xlat3.xw = _BGLut_Params.xy * vec2(0.5, 0.5);
					    u_xlat3.yz = u_xlat3.yz * _BGLut_Params.xy + u_xlat3.xw;
					    u_xlat3.x = u_xlat16 * _BGLut_Params.y + u_xlat3.y;
					    u_xlat16 = u_xlat2.x * _BGLut_Params.z + (-u_xlat16);
					    u_xlat0.y = float(0.0);
					    u_xlat10.y = float(0.0);
					    u_xlat10.xy = u_xlat10.xy + u_xlat3.xz;
					    u_xlat3 = texture(_BGLut, u_xlat3.xz);
					    u_xlat4 = texture(_BGLut, u_xlat10.xy);
					    u_xlat4.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + u_xlat3.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * _UserLut_Params.zzz;
					    u_xlat10.xy = _UserLut_Params.xy * vec2(0.5, 0.5);
					    u_xlat4.yz = u_xlat7.yz * _UserLut_Params.xy + u_xlat10.xy;
					    u_xlat10.x = floor(u_xlat7.x);
					    u_xlat4.x = u_xlat10.x * _UserLut_Params.y + u_xlat4.y;
					    u_xlat10.x = u_xlat2.x * _UserLut_Params.z + (-u_xlat10.x);
					    u_xlat0.x = _UserLut_Params.y;
					    u_xlat0.xy = u_xlat0.xy + u_xlat4.xz;
					    u_xlat2 = texture(_UserLut, u_xlat4.xz);
					    u_xlat4 = texture(_UserLut, u_xlat0.xy);
					    u_xlat0.xyw = (-u_xlat2.xyz) + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat10.xxx * u_xlat0.xyw + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
					    u_xlat3 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat15 = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat15 = float(1.0) / u_xlat15;
					    u_xlat15 = u_xlat15 + (-_BGLut_Blend.x);
					    u_xlat15 = u_xlat15 / _BGLut_Blend.y;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat2.xyz = max(abs(u_xlat2.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb0.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0.xyzx).xyz;
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat3.x : u_xlat2.x;
					    u_xlat0.y = (u_xlatb0.y) ? u_xlat3.y : u_xlat2.y;
					    u_xlat0.z = (u_xlatb0.z) ? u_xlat3.z : u_xlat2.z;
					    u_xlat0.xyz = (-u_xlat1.xyz) + u_xlat0.xyz;
					    SV_Target0.xyz = _UserLut_Params.www * u_xlat0.xyz + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "USE_BG_LUT" }
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
						vec4 unused_0_0[21];
						vec4 _ZBufferParams;
						vec4 unused_0_2[6];
						vec4 _UserLut_Params;
						vec4 _BGLut_Params;
						vec2 _BGLut_Blend;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _UserLut;
					uniform  sampler2D _BGLut;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					bvec3 u_xlatb4;
					vec3 u_xlat7;
					vec2 u_xlat10;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat10.x = _BGLut_Params.y;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz;
					    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
					    SV_Target0.w = u_xlat1.w;
					    u_xlat2.xyz = max(u_xlat1.zxy, vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat3.xyz = u_xlat1.zxy * vec3(12.9200001, 12.9200001, 12.9200001);
					    u_xlatb4.xyz = greaterThanEqual(vec4(0.00313080009, 0.00313080009, 0.00313080009, 0.0), u_xlat1.zxyz).xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat2;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat3.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat3.z : u_xlat2.z;
					        u_xlat2 = hlslcc_movcTemp;
					    }
					    u_xlat3.xyz = u_xlat2.xyz * _BGLut_Params.zzz;
					    u_xlat16 = floor(u_xlat3.x);
					    u_xlat3.xw = _BGLut_Params.xy * vec2(0.5, 0.5);
					    u_xlat3.yz = u_xlat3.yz * _BGLut_Params.xy + u_xlat3.xw;
					    u_xlat3.x = u_xlat16 * _BGLut_Params.y + u_xlat3.y;
					    u_xlat16 = u_xlat2.x * _BGLut_Params.z + (-u_xlat16);
					    u_xlat0.y = float(0.0);
					    u_xlat10.y = float(0.0);
					    u_xlat10.xy = u_xlat10.xy + u_xlat3.xz;
					    u_xlat3 = texture(_BGLut, u_xlat3.xz);
					    u_xlat4 = texture(_BGLut, u_xlat10.xy);
					    u_xlat4.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + u_xlat3.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * _UserLut_Params.zzz;
					    u_xlat10.xy = _UserLut_Params.xy * vec2(0.5, 0.5);
					    u_xlat4.yz = u_xlat7.yz * _UserLut_Params.xy + u_xlat10.xy;
					    u_xlat10.x = floor(u_xlat7.x);
					    u_xlat4.x = u_xlat10.x * _UserLut_Params.y + u_xlat4.y;
					    u_xlat10.x = u_xlat2.x * _UserLut_Params.z + (-u_xlat10.x);
					    u_xlat0.x = _UserLut_Params.y;
					    u_xlat0.xy = u_xlat0.xy + u_xlat4.xz;
					    u_xlat2 = texture(_UserLut, u_xlat4.xz);
					    u_xlat4 = texture(_UserLut, u_xlat0.xy);
					    u_xlat0.xyw = (-u_xlat2.xyz) + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat10.xxx * u_xlat0.xyw + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
					    u_xlat3 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat15 = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat15 = float(1.0) / u_xlat15;
					    u_xlat15 = u_xlat15 + (-_BGLut_Blend.x);
					    u_xlat15 = u_xlat15 / _BGLut_Blend.y;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat2.xyz = max(abs(u_xlat2.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb0.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0.xyzx).xyz;
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat3.x : u_xlat2.x;
					    u_xlat0.y = (u_xlatb0.y) ? u_xlat3.y : u_xlat2.y;
					    u_xlat0.z = (u_xlatb0.z) ? u_xlat3.z : u_xlat2.z;
					    u_xlat0.xyz = (-u_xlat1.xyz) + u_xlat0.xyz;
					    SV_Target0.xyz = _UserLut_Params.www * u_xlat0.xyz + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "USE_BG_LUT" }
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
						vec4 unused_0_0[21];
						vec4 _ZBufferParams;
						vec4 unused_0_2[6];
						vec4 _UserLut_Params;
						vec4 _BGLut_Params;
						vec2 _BGLut_Blend;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _UserLut;
					uniform  sampler2D _BGLut;
					uniform  sampler2D _CameraDepthTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec3 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					bvec3 u_xlatb4;
					vec3 u_xlat7;
					vec2 u_xlat10;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat10.x = _BGLut_Params.y;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz;
					    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
					    SV_Target0.w = u_xlat1.w;
					    u_xlat2.xyz = max(u_xlat1.zxy, vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat3.xyz = u_xlat1.zxy * vec3(12.9200001, 12.9200001, 12.9200001);
					    u_xlatb4.xyz = greaterThanEqual(vec4(0.00313080009, 0.00313080009, 0.00313080009, 0.0), u_xlat1.zxyz).xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat2;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat3.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat3.z : u_xlat2.z;
					        u_xlat2 = hlslcc_movcTemp;
					    }
					    u_xlat3.xyz = u_xlat2.xyz * _BGLut_Params.zzz;
					    u_xlat16 = floor(u_xlat3.x);
					    u_xlat3.xw = _BGLut_Params.xy * vec2(0.5, 0.5);
					    u_xlat3.yz = u_xlat3.yz * _BGLut_Params.xy + u_xlat3.xw;
					    u_xlat3.x = u_xlat16 * _BGLut_Params.y + u_xlat3.y;
					    u_xlat16 = u_xlat2.x * _BGLut_Params.z + (-u_xlat16);
					    u_xlat0.y = float(0.0);
					    u_xlat10.y = float(0.0);
					    u_xlat10.xy = u_xlat10.xy + u_xlat3.xz;
					    u_xlat3 = texture(_BGLut, u_xlat3.xz);
					    u_xlat4 = texture(_BGLut, u_xlat10.xy);
					    u_xlat4.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat4.xyz + u_xlat3.xyz;
					    u_xlat7.xyz = u_xlat2.xyz * _UserLut_Params.zzz;
					    u_xlat10.xy = _UserLut_Params.xy * vec2(0.5, 0.5);
					    u_xlat4.yz = u_xlat7.yz * _UserLut_Params.xy + u_xlat10.xy;
					    u_xlat10.x = floor(u_xlat7.x);
					    u_xlat4.x = u_xlat10.x * _UserLut_Params.y + u_xlat4.y;
					    u_xlat10.x = u_xlat2.x * _UserLut_Params.z + (-u_xlat10.x);
					    u_xlat0.x = _UserLut_Params.y;
					    u_xlat0.xy = u_xlat0.xy + u_xlat4.xz;
					    u_xlat2 = texture(_UserLut, u_xlat4.xz);
					    u_xlat4 = texture(_UserLut, u_xlat0.xy);
					    u_xlat0.xyw = (-u_xlat2.xyz) + u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat10.xxx * u_xlat0.xyw + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
					    u_xlat3 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy);
					    u_xlat15 = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat15 = float(1.0) / u_xlat15;
					    u_xlat15 = u_xlat15 + (-_BGLut_Blend.x);
					    u_xlat15 = u_xlat15 / _BGLut_Blend.y;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + vec3(0.0549999997, 0.0549999997, 0.0549999997);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.947867334, 0.947867334, 0.947867334);
					    u_xlat2.xyz = max(abs(u_xlat2.xyz), vec3(1.1920929e-07, 1.1920929e-07, 1.1920929e-07));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(2.4000001, 2.4000001, 2.4000001);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.0773993805, 0.0773993805, 0.0773993805);
					    u_xlatb0.xyz = greaterThanEqual(vec4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0.xyzx).xyz;
					    u_xlat0.x = (u_xlatb0.x) ? u_xlat3.x : u_xlat2.x;
					    u_xlat0.y = (u_xlatb0.y) ? u_xlat3.y : u_xlat2.y;
					    u_xlat0.z = (u_xlatb0.z) ? u_xlat3.z : u_xlat2.z;
					    u_xlat0.xyz = (-u_xlat1.xyz) + u_xlat0.xyz;
					    SV_Target0.xyz = _UserLut_Params.www * u_xlat0.xyz + u_xlat1.xyz;
					    return;
					}"
				}
			}
		}
	}
}