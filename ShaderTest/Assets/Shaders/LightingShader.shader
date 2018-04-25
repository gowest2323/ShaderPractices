// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/LightingShader"
{
	Properties
	{
		_BaseColor("BaseColor", Color) = (0.5, 0, 0, 1)
		_ShadowColor("ShadowColor", Color) = (0.5, 0, 0, 1)
	}
	SubShader
	{
		Tags{ "RenderType" = "Opaque" "LightMode" = "ForwardBase" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase

			#include "UnityCG.cginc"
			#include "AutoLight.cginc"

			uniform fixed4 _LightColor0;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos      : SV_POSITION;
				float3 lightDir : TEXCOORD0;
				float3 normal   : TEXCOORD1;
				LIGHTING_COORDS(3, 4)
			};

			sampler2D _MainTex;
			float4 _ShadowColor;
			float4 _BaseColor;
			
			v2f vert (appdata_base v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.lightDir = normalize(ObjSpaceLightDir(v.vertex));
				o.normal = normalize(v.normal).xyz;

				TRANSFER_VERTEX_TO_FRAGMENT(o);
				TRANSFER_SHADOW(o);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				half LdotN = dot(i.lightDir, i.normal);
				fixed atten = LIGHT_ATTENUATION(i);
				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT;


				//fixed4 lightColor = _LightColor0 * saturate(dot(i.lightDir, i.normal));
				half4 c;
				//c.rgb = i.Albedo * _LightColor0.rgb * (LdotN * 2);
				//c.rgb *= NdotL * min((atten + _ShadowColor.rgb), 1); //atten が影の色
				c.rgb = _BaseColor * _LightColor0.rgb * (LdotN * min((atten + _ShadowColor), 1) * 2); //ReceiveShadow無し

				//fixed4 c = _BaseColor;
				//c.rgb = (c * lightColor * atten) + ambient;
				return c;
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
}
