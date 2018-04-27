using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StartCRT : MonoBehaviour {

    [SerializeField]
    private Camera mainCamera;

    private float cnt = 0;
    private bool isCnt = false;
    public float effectSeconds = 1;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update ()
    {
        if (isCnt)
        {
            cnt += 1 * Time.deltaTime;
        }

        if (cnt >= effectSeconds)
        {
            mainCamera.GetComponent<CRT>().enabled = false;

            cnt = 0;
            isCnt = false;
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if(collision.transform.tag == "Enemy")
        {
            mainCamera.GetComponent<CRT>().enabled = true;

            isCnt = true;
        }
    }
}
