using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PointController : MonoBehaviour
{
    //private Vector3[] vectorList;

    //private Vector3 pos;

    [SerializeField]
    Material targetMat;
    [SerializeField]
    Material defaltMat;

    //public GameObject obj;
    bool isClick = false;
    private float range = 0;
    private SkinnedMeshRenderer smr;



    void Start()
    {
        smr = GetComponent<SkinnedMeshRenderer>();
        smr.material = defaltMat;

        TurnMeshToTriangle();
        //TurnMeshToPoint();

    }

    public void TurnMeshToPoint()
    {

        if (GetComponent<SkinnedMeshRenderer>())
        {
            //smr = GetComponent<SkinnedMeshRenderer>();
            smr.sharedMesh.SetIndices(smr.sharedMesh.GetIndices(0), MeshTopology.Points, 0);
        }
        else if(GetComponent<MeshFilter>())
        {
            MeshFilter meshFilter = GetComponent<MeshFilter>();
            meshFilter.mesh.SetIndices(meshFilter.mesh.GetIndices(0), MeshTopology.Points, 0);
        }
    }

    public void TurnMeshToTriangle()
    {
        if(GetComponent<SkinnedMeshRenderer>())
        {
            //SkinnedMeshRenderer smr = GetComponent<SkinnedMeshRenderer>();
            smr.sharedMesh.SetIndices(smr.sharedMesh.GetIndices(0), MeshTopology.Triangles, 0);
        }
        else if (GetComponent<MeshFilter>())
        {
            MeshFilter meshFilter = GetComponent<MeshFilter>();
            meshFilter.mesh.SetIndices(meshFilter.mesh.GetIndices(0), MeshTopology.Triangles, 0);
        }
    }


    public void LetsBlow()
    {
        TurnMeshToPoint();
        smr.material = targetMat;

        isClick = true;

    }

    private void Update()
    {
        if (isClick)
        {
            range += 0.05f;
        }

        targetMat.SetFloat("_Displacement", range);
    }

}
