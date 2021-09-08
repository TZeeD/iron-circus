// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.CorrosiveSpitImpactFx
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class CorrosiveSpitImpactFx : MonoBehaviour
  {
    public float duration = 0.5f;
    public float radius = 4f;
    public GameObject floorAoECircle;
    public ParticleSystem particleSys;
    private float t;

    private void Start()
    {
      this.particleSys.main.startLifetime = (ParticleSystem.MinMaxCurve) this.duration;
      this.particleSys.transform.localScale = Vector3.one * this.radius * 2f;
      GameObject gameObject = MatchObjectsParent.Add(Object.Instantiate<GameObject>(this.floorAoECircle, this.transform));
      gameObject.transform.localScale = Vector3.one * this.radius;
      gameObject.transform.localPosition = new Vector3(0.0f, -this.transform.position.y, 0.0f);
    }

    private void Update()
    {
      this.t += Time.deltaTime;
      if ((double) this.t <= (double) this.duration)
        return;
      Object.Destroy((Object) this.gameObject);
    }
  }
}
