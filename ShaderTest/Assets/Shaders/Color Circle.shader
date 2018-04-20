Shader "Custom/ColorCircle" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Texture", 2D) = "white"{}
        _CenterPosition ("Center Position", Vector) = (0, 0, 0, 0)
        _GroundColor ("GroundColor", Color) = (1,1,1,1)
		_Cutoff ("Cutoff", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "Queue"="AlphaTest"
				"RenderType" = "Transparent"}
		LOD 200

		//両面を描画したい
		Cull Off

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows alphatest:_Cutoff

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		struct Input 
        {
            float3 worldPos;
            float2 uv_MainTex;
		};

        fixed3 _CenterPosition;
        // 透過用のテクスチャ
        sampler2D _MainTex;
		fixed4 _Color;
        fixed4 _GroundColor;
		

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o)
        {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);// *_Color;

            float dist = distance(_CenterPosition, IN.worldPos);
            float val = abs(sin(dist * 3.0 - _Time * 100)); // +は内側に、-は外側に
            if (val > 0.98)
            {
                //線の色
                o.Albedo = _Color.rgb;
            }
            else
            {
                o.Albedo = _GroundColor.rgb;
            }
			o.Alpha = c.a;
		}
		ENDCG
	}
	Fallback "Transparent/Cutout/Diffuse"
}
