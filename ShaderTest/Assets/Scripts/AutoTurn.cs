using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AutoTurn : MonoBehaviour
{


	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update ()
    {
        transform.Rotate(new Vector3(1, 1, 1));

	}
}
