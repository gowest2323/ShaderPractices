Shader "ShaderSketchs/MultiCircle"
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

            float rand(float2 st)
            {
                return frac(sin(dot(st, float2(12.9898, 78.233))) * 43758.5453);
            }

            float box(float2 st, float size) 
            {
                size = 0.5 + size * 0.5;
                st = step(st, size) * step(1.0 - st, size);
                return st.x * st.y;
            }

            float wave(float2 st, float n)
            {
                st = (floor(st * n) + 0.5) / n;
                float d = distance(0.5, st);
                return (1 + sin(d * 3 - _Time.y * 3)) * 0.5;
            }

            float box_wave(float2 uv, float n)
            {
                float2 st = frac(uv * n);
                float size = wave(uv, n);
                return box(st, size);
            }

            float box_size(float2 st, float n)
            {
                st = (floor(st * n) + 0.5) / n;
                float offs = rand(st) * 5;
                return (1 + sin(_Time.y * 3 + offs)) * 0.5;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //// ディスタンスフィールド
                //// distance(a, b) → a と b の距離を返す
                //float d = distance(float2(0.5, 0.5), i.uv);
                //d = d * 30;
                //d = abs(sin(d));
                //d = step(0.5, d);

                //return d;

                float n = 6;
                float2 st = frac(i.uv * n);
                float size = box_size(i.uv, n);
                return box(st, size);
                //return box(st, abs(sin(_Time.y)));

                /*float n = 2;
                float2 fst = frac(i.uv * n);

                float2 ist = floor(i.uv * n);

                return float4(fst.x, fst.y, 0, 1);*/


                //return box_wave(i.uv, 10);

                /*return float4(box_wave(i.uv, 9),
                            box_wave(i.uv, 18),
                            box_wave(i.uv, 36),
                            1);*/

                
			}
			ENDCG
		}
	}
}
