// Decompiled with JetBrains decompiler
// Type: TFHC_ForceShield_Shader_Sample.ForceShieldImpactDetection
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace TFHC_ForceShield_Shader_Sample
{
  public class ForceShieldImpactDetection : MonoBehaviour
  {
    private float hitTime;
    private Material mat;

    private void Start() => this.mat = this.GetComponent<Renderer>().material;

    private void Update()
    {
      if ((double) this.hitTime <= 0.0)
        return;
      this.hitTime -= Time.deltaTime * 1000f;
      if ((double) this.hitTime < 0.0)
        this.hitTime = 0.0f;
      this.mat.SetFloat("_HitTime", this.hitTime);
    }

    private void OnCollisionEnter(Collision collision)
    {
      foreach (ContactPoint contact in collision.contacts)
      {
        this.mat.SetVector("_HitPosition", (Vector4) this.transform.InverseTransformPoint(contact.point));
        this.hitTime = 500f;
        this.mat.SetFloat("_HitTime", this.hitTime);
      }
    }
  }
}
