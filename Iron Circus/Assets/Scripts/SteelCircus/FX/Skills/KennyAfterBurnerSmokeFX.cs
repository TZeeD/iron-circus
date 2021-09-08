// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.KennyAfterBurnerSmokeFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class KennyAfterBurnerSmokeFX : MonoBehaviour, IVfxWithDeferredStop, IVfx
  {
    [SerializeField]
    private ParticleSystem smokeParticles;

    public void SetOwner(GameEntity entity)
    {
    }

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }

    public void OnStopRequested()
    {
      this.smokeParticles.emission.enabled = false;
      this.smokeParticles.Stop(false, ParticleSystemStopBehavior.StopEmitting);
    }

    private void Update()
    {
      if (!((Object) this.smokeParticles == (Object) null))
        return;
      Object.Destroy((Object) this.gameObject);
    }
  }
}
