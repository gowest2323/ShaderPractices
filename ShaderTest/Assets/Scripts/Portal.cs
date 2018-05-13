using DG.Tweening;
using UnityEngine;

public class Portal : MonoBehaviour
{
    [SerializeField]
    Material material;
    [SerializeField]
    Texture texture;
    [SerializeField]
    float radius = 0.15f;
    [SerializeField]
    GameObject target;

    readonly int subTexPropertyId = Shader.PropertyToID("_SubTex");
    void Start()
    {
        material.SetTexture(subTexPropertyId, texture);
    }

    void Update()
    {
        //var mousePosition = Input.mousePosition;
        var playerPosition = Camera.main.WorldToScreenPoint(target.transform.position + new Vector3(0, 1, 0));

        //var uv = new Vector3(
        //    mousePosition.x / Screen.width,
        //    mousePosition.y / Screen.height, 0);
        var uv = new Vector3(
            playerPosition.x / Screen.width,
            playerPosition.y / Screen.height, 0);



        material.SetVector("_Position", uv);

        var fluct = Mathf.Sin(Time.timeSinceLevelLoad * 3) * 0.1f + 0.9f;
        material.SetFloat(radiusPropertyId, radius * fluct);

        material.SetFloat("_Aspect", Screen.height / (float)Screen.width);

        //マウスクリックでポータル生成
        //if (Input.GetMouseButtonDown(0))
        //{
        //    OpenPortal();
        //}
        //else if (Input.GetMouseButtonUp(0))
        //{
        //    ClosePortal();
        //}
    }

    float currentPortalRadius = 0;
    void OpenPortal()
    {
        //SetPortalRadius(radius);
        DOTween.KillAll();
        DOTween.To(() => currentPortalRadius, SetPortalRadius, radius, 2f).SetEase(Ease.OutBack);
    }

    void ClosePortal()
    {
        //SetPortalRadius(0);
        DOTween.KillAll();
        DOTween.To(() => currentPortalRadius, SetPortalRadius, 0f, 0.6f).SetEase(Ease.InBack);
    }

    readonly int radiusPropertyId = Shader.PropertyToID("_Radius");
    void SetPortalRadius(float radius)
    {
        currentPortalRadius = radius;
        material.SetFloat(radiusPropertyId, radius);
    }

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Graphics.Blit(src, dest, material);
    }
}