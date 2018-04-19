using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaterFlow : MonoBehaviour
{
    public Vector2 MainFlow;
    public Vector2 DetailFlow;
    public Material waterMaterial;


    void Awake()
    {
        if (waterMaterial != null)
        {
            // trun offset to defalt=0
            waterMaterial.SetTextureOffset("_MainTex", Vector2.zero);
            waterMaterial.SetTextureOffset("_DetailAlbedoMap", Vector2.zero);
        }
    }
    // Update is called once per frame
    void Update ()
    {
		if(waterMaterial != null)
        {
            waterMaterial.SetTextureOffset("_MainTex", MainFlow * Time.time);
            waterMaterial.SetTextureOffset("_DetailAlbedoMap", DetailFlow * Time.time);
        }
	}
}
