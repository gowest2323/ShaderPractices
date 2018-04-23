Shader "Unlit/outlineOnly"
{
	Properties
	{
		_OutlineColor("Outline Color", Color) = (0, 0, 0, 0)
		_OutlineWidth("Outline Width", float) = 0.1
	}

		SubShader
	{
		Tags { "RenderType" = "Geometry" }
		LOD 100

		Pass
		{
			Cull Front

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			float4 _OutlineColor;
			float _OutlineWidth;
			

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
				//カメラからの距離に依存せずに一定の幅が保たれるように、
				//カメラからの距離に応じたスケールをかける
				float distance = UnityObjectToViewPos(v.vertex).z;
				v.vertex.xyz += v.normal * -distance * _OutlineWidth;

				v2f o;
                //v.vertex += float4(v.normal * 0.05f, 0); //アウトラインの厚さ
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// アウトラインの色
                //fixed4 col = fixed4(0.1, 0.1, 0.1, 1);
				return _OutlineColor;
			}
			ENDCG
		}

    //    Pass
    //    {
    //        Cull Back

    //        CGPROGRAM
    //        #pragma vertex vert
    //        #pragma fragment frag

    //        #include "UnityCG.cginc"

    //        struct appdata
    //        {
    //            float4 vertex : POSITION;
    //            float3 normal : NORMAL;
    //        };

    //        struct v2f
    //        {
    //            float4 vertex : SV_POSITION;
    //            float3 normal : NORMAL;
    //        };

    //        v2f vert(appdata v)
    //        {
    //            v2f o;
    //            o.vertex = UnityObjectToClipPos(v.vertex);
    //            o.normal = UnityObjectToWorldNormal(v.normal);
    //            return o;
    //        }

    //        fixed4 frag(v2f i) : SV_Target
    //        {
    //            //色を制限
    //            half nl = max(0, dot(i.normal, _WorldSpaceLightPos0.xyz));
    //            if (nl <= 0.01f) nl = 0.1f;
    //            else if (nl <= 0.3f) nl = 0.3f; 
				//else if (nl <= 0.5f) nl = 0.5f;
    //            else nl = 1.0f;
    //            fixed4 col = fixed4(nl, nl, nl, 1);
    //            return col;
    //        }
    //        ENDCG
    //  }
	}
}
