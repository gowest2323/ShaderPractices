using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Click : MonoBehaviour
{
    [SerializeField]
    private Vector3 m_position;

    [SerializeField]
    Material mat;


    //Update is called once per frame
    void Update()
    {
        //クリック
        if (Input.GetMouseButtonDown(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit, Mathf.Infinity, LayerMask.GetMask("Field")))
            {
                m_position = hit.point;
            }

            if (Input.GetKey(KeyCode.LeftArrow))
            {
                m_position.x -= 0.1f;
            }
            else if (Input.GetKey(KeyCode.RightArrow))
            {
                m_position.x += 0.1f;
            }
            else if (Input.GetKey(KeyCode.UpArrow))
            {
                m_position.z += 0.1f;
            }
            else if (Input.GetKey(KeyCode.DownArrow))
            {
                m_position.z -= 0.1f;
            }
        }

        //キー
        if (Input.GetKey(KeyCode.LeftArrow))
        {
            m_position.x -= 0.1f;
        }
        else if (Input.GetKey(KeyCode.RightArrow))
        {
            m_position.x += 0.1f;
        }

        mat.SetVector("_CenterPosition", m_position);
    }

}
