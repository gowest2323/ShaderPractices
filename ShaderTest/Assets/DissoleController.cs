using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class DissoleController : MonoBehaviour
{
    [SerializeField]
    private Material dissolveMat;

    public Transform deadPoint;

    [SerializeField]
    private float dissolveRange = 0;
    [SerializeField]
    private bool isEnter = false;

	// Use this for initialization
	void Awake ()
    {
        dissolveRange = 0;
    }
	
	// Update is called once per frame
	void Update ()
    {
        if (isEnter)
        {
            dissolveRange += 0.5f * Time.deltaTime;
        }

        Dissolve();
	}

    private void Dissolve()
    {
        dissolveMat.SetFloat("_Threshold", dissolveRange);

        if (dissolveMat.GetFloat("_Threshold") == 1.0f)
        {
            Object.Destroy(this);
        }
    }


    private void OnCollisionEnter(Collision collision)
    {
        if(collision.transform.tag == "Enemy")
        {
            isEnter = true;
        }
    }

    public void Reset()
    {
        isEnter = false;
        dissolveRange = 0;
    }


}
