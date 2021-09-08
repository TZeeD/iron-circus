// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.LightningTrailParticleFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.Utils.Extensions;
using SteelCircus.Core;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class LightningTrailParticleFX : FollowTransform, IVfx
  {
    [SerializeField]
    private string parentBoneName;
    [SerializeField]
    private Transform particleParent;

    public void SetOwner(GameEntity entity) => this.Target = entity.unityView.gameObject.transform.FindDeepChild(this.parentBoneName);

    protected override void Start()
    {
      base.Start();
      this.particleParent.transform.parent = (Transform) null;
      MatchObjectsParent.Add(this.particleParent.transform);
    }

    private void OnDestroy()
    {
      foreach (ParticleSystem componentsInChild in this.particleParent.GetComponentsInChildren<ParticleSystem>())
        componentsInChild.emission.enabled = false;
    }

    protected override void Update()
    {
      base.Update();
      if ((Object) this.particleParent == (Object) null)
        return;
      this.particleParent.transform.position = this.transform.position;
    }

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }
  }
}
