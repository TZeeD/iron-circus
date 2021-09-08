// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.Floor.AimableAoePreviewBase
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using UnityEngine;

namespace SteelCircus.FX.Skills.Floor
{
  public abstract class AimableAoePreviewBase : CustomAoePreviewBase
  {
    protected const string AimDirectionName = "AimDir";
    protected AreaOfEffect aoe;
    protected GameEntity owner;
    protected SkillVar<JVector> aimDirection;

    protected abstract float GetAimOffset();

    protected virtual void Start() => this.UpdateTransform();

    public override void SetAoe(AreaOfEffect aoe) => this.aoe = aoe;

    public override void SetOwner(GameEntity entity)
    {
      base.SetOwner(entity);
      this.owner = entity;
    }

    public override void SetSkillGraph(SkillGraph graph)
    {
      base.SetSkillGraph(graph);
      this.aimDirection = graph.GetVar<JVector>("AimDir");
    }

    protected override void Update()
    {
      base.Update();
      this.UpdateTransform();
    }

    protected virtual void UpdateTransform()
    {
      if (this.owner == null || !this.owner.hasUnityView)
        return;
      Vector3 vector3 = ((JVector) this.aimDirection).ToVector3();
      vector3.Normalize();
      this.transform.position = this.owner.unityView.gameObject.transform.position + vector3 * this.GetAimOffset();
      this.transform.rotation = Quaternion.LookRotation(vector3);
    }
  }
}
