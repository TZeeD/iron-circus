// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.ParticleEmissionControlObject
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SteelCircus.FX
{
  public class ParticleEmissionControlObject : MonoBehaviour
  {
    public ParticleSystem[] particleSystems;

    private void Start() => this.SetEmission(true);

    private void OnEnable() => this.SetEmission(true);

    private void OnDisable() => this.SetEmission(false);

    private void SetEmission(bool enabled)
    {
      foreach (ParticleSystem particleSystem in this.particleSystems)
        particleSystem.emission.enabled = enabled;
    }
  }
}
