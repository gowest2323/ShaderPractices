using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.ImageEffects;

public class StartCRT : MonoBehaviour {

    [SerializeField]
    private Camera mainCamera;

    private float cnt = 0;
    private bool isCnt = false;
    public float effectSeconds = 1;

	// Use this for initialization
	void Start () {
        mainCamera.GetComponent<ScreenOverlay>().intensity = 0;


    }

    // Update is called once per frame
    void Update ()
    {
        if (isCnt)
        {
            cnt += 1 * Time.deltaTime;

            if (mainCamera.GetComponent<ScreenOverlay>().intensity <= 1)
            {
                mainCamera.GetComponent<ScreenOverlay>().intensity += 1 / effectSeconds;
            }

        }

        if (cnt >= effectSeconds)
        {
           // mainCamera.GetComponent<CRT>().enabled = false;
            mainCamera.GetComponent<ScreenOverlay>().enabled = false;
            mainCamera.GetComponent<ScreenOverlay>().intensity = 0;


            cnt = 0;
            isCnt = false;
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if(collision.transform.tag == "Enemy")
        {
           // mainCamera.GetComponent<CRT>().enabled = true;
            mainCamera.GetComponent<ScreenOverlay>().enabled = true;





            isCnt = true;
        }
    }
}
