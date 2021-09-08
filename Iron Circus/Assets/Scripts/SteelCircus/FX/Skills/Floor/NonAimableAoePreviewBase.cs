// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.Floor.NonAimableAoePreviewBase
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SteelCircus.JitterUnity;
using UnityEngine;

namespace SteelCircus.FX.Skills.Floor
{
  public abstract class NonAimableAoePreviewBase : CustomAoePreviewBase
  {
    protected AreaOfEffect aoe;
    protected GameEntity owner;

    protected abstract float GetOffset();

    protected virtual void Start() => this.UpdateTransform();

    public override void SetAoe(AreaOfEffect aoe) => this.aoe = aoe;

    public override void SetOwner(GameEntity entity)
    {
      base.SetOwner(entity);
      this.owner = entity;
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
      Vector3 vector3 = this.owner.transform.Forward.ToVector3();
      vector3.Normalize();
      this.transform.position = this.owner.unityView.gameObject.transform.position + vector3 * this.GetOffset();
      this.transform.rotation = Quaternion.LookRotation(vector3);
    }
  }
}
