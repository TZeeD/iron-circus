// Decompiled with JetBrains decompiler
// Type: TFHC_ForceShield_Shader_Sample.ForceShieldShootBall
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace TFHC_ForceShield_Shader_Sample
{
  public class ForceShieldShootBall : MonoBehaviour
  {
    public Rigidbody bullet;
    public Transform origshoot;
    public float speed = 1000f;
    private float distance = 10f;

    private void Update()
    {
      if (!Input.GetButtonDown("Fire1"))
        return;
      Vector3 worldPoint = Camera.main.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y, this.distance));
      Rigidbody rigidbody = Object.Instantiate<Rigidbody>(this.bullet, this.transform.position, Quaternion.identity);
      rigidbody.transform.LookAt(worldPoint);
      rigidbody.AddForce(rigidbody.transform.forward * this.speed);
    }
  }
}
