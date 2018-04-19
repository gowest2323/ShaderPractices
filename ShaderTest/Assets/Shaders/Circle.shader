Shader "ShaderSketchs/Circle"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
                // 座標をそのまま色として出力してます
                //return float4(i.uv.x, i.uv.y, 0, 1);

                // ディスタンスフィールド
                //distance(a, b) → a と b の距離を返す
                float d = distance(float2(0.5, 0.5), i.uv);
                //step(a, x) → x が a 以上なら 1 / a より小さければ 0
                float a = abs(sin(_Time.y))*  0.4; // 閾値
                return step(a, d);               
			}
			ENDCG
		}
	}
}
