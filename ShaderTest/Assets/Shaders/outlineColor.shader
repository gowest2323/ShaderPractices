Shader "Unlit/outlineColor"
{
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
            Cull Front
            
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
						
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};
	
			v2f vert (appdata v)
			{
				v2f o;
                v.vertex += float4(v.normal * 0.01f, 0); //アウトラインの厚さ
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// アウトラインの色
                fixed4 col = fixed4(0.1, 0.1, 0.1, 1);
				return col;
			}
			ENDCG
		}

        Pass
        {
            Cull Back

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //色を制限
                half nl = max(0, dot(i.normal, _WorldSpaceLightPos0.xyz));
                if (nl <= 0.01f) nl = 0.1f;
                else if (nl <= 0.2f) nl = 0.4f; 
				else if (nl <= 0.5f) nl = 0.5f;
                else nl = 1.0f;
                fixed4 col = fixed4(nl, nl, nl, 1);
                return col;
            }
            ENDCG
        }
	}
}
