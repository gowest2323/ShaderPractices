Shader "Custom/Portal"
{
    Properties
    {
        _MainTex("MainTex", 2D) = "black"{}
    }

    CGINCLUDE
    #include "UnityCG.cginc"

    sampler2D _MainTex;
    sampler2D _SubTex;
    float _Aspect;
    float _Radius;
    float2 _Position;

    // Transform UV for Portal Effect
    // .xy = uv for portal effect
    // .z  = 1: inside, 0: outside
    float3 transform_uv(float2 uv)
    {
        float width = 0.03;

        // 自身のピクセルからポータル中心までの距離
        float distance = length((_Position - uv) * float2(1, _Aspect));

        // 自身のピクセル位置での歪み具合
        float distortion = 1 - smoothstep(_Radius - width, _Radius, distance);

        // 自身のピクセル位置での歪み具合分だけ
        // ポータル中心の方へずらした uv を計算します
        uv += (_Position - uv) * distortion;

        return float3(uv, step(1, distortion));
    }

    float4 frag(v2f_img i) : SV_Target
    {
        float3 portal = transform_uv(i.uv);
        // 計算した uv で _MainTex のカラーを出力します
        // ポータル内に違う絵を出すために、
        // lerp + step で出力テクスチャを切り替えています
        return lerp(tex2D(_MainTex, portal.xy),
            tex2D(_MainTex, i.uv),
            portal.z);
    }
    ENDCG

    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            ENDCG
        }
    }
}