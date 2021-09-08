// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.RampageParticleFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class RampageParticleFX : MonoBehaviour, IVfxWithDeferredStop, IVfx
  {
    [SerializeField]
    private ParticleSystem particleSystem;
    [SerializeField]
    private float breakDownDuration = 0.5f;
    private float breakDownCounter;

    public void SetOwner(GameEntity entity)
    {
      this.particleSystem.shape.skinnedMeshRenderer = entity.unityView.gameObject.transform.GetComponentInChildren<SkinnedMeshRenderer>();
      ColorsConfig instance = SingletonScriptableObject<ColorsConfig>.Instance;
      this.particleSystem.GetComponent<Renderer>().material.color = instance.LightColor(entity.playerTeam.value);
    }

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }

    public void OnStopRequested()
    {
      this.breakDownCounter = this.breakDownDuration;
      this.particleSystem.emission.enabled = false;
      this.particleSystem.Stop(false, ParticleSystemStopBehavior.StopEmitting);
    }

    private void Update()
    {
      if ((double) this.breakDownCounter == 0.0)
        return;
      this.breakDownCounter -= Time.deltaTime;
      if ((double) this.breakDownCounter > 0.0)
        return;
      VfxManager.ReturnToPool(this.gameObject);
    }
  }
}
