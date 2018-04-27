using UnityEngine;
using System.Collections;

public class PostEffect : MonoBehaviour
{
    [SerializeField]
    private Material effectMat;

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Graphics.Blit(src, dest, effectMat);
    }
}