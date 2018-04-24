using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PointController : MonoBehaviour
{
    //private Vector3[] vectorList;

    //private Vector3 pos;

    [SerializeField]
    Material targetMat;

    //public GameObject obj;
    bool isClick = false;
    bool isPoint = false;
    private float range = 0;



    void Start()
    {
        //MeshFilter meshFilter = GetComponent<MeshFilter>();
        //meshFilter.mesh.SetIndices(meshFilter.mesh.GetIndices(0), MeshTopology.Points, 0);


        TurnMeshToTriangle();
        //TurnMeshToPoint();

    }

    public void TurnMeshToPoint()
    {

        if (GetComponent<SkinnedMeshRenderer>())
        {
            SkinnedMeshRenderer smr = GetComponent<SkinnedMeshRenderer>();
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
            SkinnedMeshRenderer smr = GetComponent<SkinnedMeshRenderer>();
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
        isClick = true;
        isPoint = true;

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
