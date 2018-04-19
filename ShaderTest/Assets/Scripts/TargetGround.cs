using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TargetGround : MonoBehaviour
{
    [SerializeField]
    Material groundMat;
    [SerializeField]
    Material targetMat;

    private void Awake()
    {
        //床の色と同期
        targetMat.SetColor("_GroundColor", groundMat.GetColor("_Color"));
    }


}
