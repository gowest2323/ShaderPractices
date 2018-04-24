Shader "Custom/Gradation"
{
	Properties
	{
        _MainTex("Texture", 2D) = "white" {}
		_Color("Color", Color) = (1, 1, 1, 1)
        _Displacement("Displacement", Range(0,10)) = 0
	}
	SubShader
	{
		Tags{ "RenderType" = "Transparent" }
		Cull Off 
		ZWrite On 
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct v2f
			{
				float4 pos : SV_POSITION;
                float3 uv : TEXCOORD0;
                //float4 col : COLOR;
			};

            sampler2D _MainTex;
            float4 _Color;
            float _Displacement;
			
			v2f vert (appdata_base v)
			{
                v2f o;
                float3 n = UnityObjectToWorldNormal(v.normal);
                o.pos = UnityObjectToClipPos(v.vertex) + float4(n * _Displacement, 0);
                o.uv = mul(unity_ObjectToWorld, v.vertex).xyz;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                return col * _Color;
			}
			ENDCG
		}
	}
    FallBack Off
}
