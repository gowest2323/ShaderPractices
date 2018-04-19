Shader "Custom/CircleDraw" 
{
    Properties
    {
        _CenterPosition ("Center Position", Vector) = (0, 0, 0, 0)
    }
        SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard 

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        fixed3 _CenterPosition;


		struct Input 
        {
			float3 worldPos;
		};

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float dist = distance(_CenterPosition, IN.worldPos);
            float val = abs(sin(dist * 3.0 - _Time * 100)); // +は内側に、-は外側に
            //float radius = 2;
            if (val > 0.98) 
            {
                o.Albedo = fixed4(1, 1, 1, 1);
            }
            else
            {
                o.Albedo = fixed4(110 / 255.0, 87 / 255.0, 139 / 255.0, 1);
            }
		}
		ENDCG
	}
	FallBack "Diffuse"
}
