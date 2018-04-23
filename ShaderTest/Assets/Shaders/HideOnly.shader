// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/HideOnly"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Col ("Color", Color) = (0.5, 0, 0, 1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque"
				"Queue"="Transparent"
				"HideDisp"="Yes" }
		LOD 100

		Pass
		{
			Stencil
			{
				Ref 2
				Comp notequal
			}

			ZTest Greater
			ZWrite off
			Lighting off
			SeparateSpecular off
			Blend SrcAlpha OneMinusSrcAlpha


			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _Col;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float4 col : COLOR;
			};

			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.col = _Col;
				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				return col * i.col;
			}
			ENDCG
		}



	}
			Fallback "VertexLit"
}
