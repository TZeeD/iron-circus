// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SpawnVfxAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;
using System;

namespace Imi.SharedWithServer.Game.Skills
{
  public class SpawnVfxAction : SkillAction
  {
    public VfxPrefab vfxPrefab;
    public ConfigValue<JVector> position;
    public ConfigValue<JVector> lookDir;
    public Func<object> args;
    public bool parentToOwner;

    public override bool IsNetworked => true;

    public SpawnVfxAction()
    {
    }

    public SpawnVfxAction(SkillGraph skillGraph, string name = "unnamed")
      : base(skillGraph, name)
    {
    }

    protected override void PerformActionInternal()
    {
    }

    public override void SyncedDo()
    {
      if (!((UnityEngine.Object) this.vfxPrefab.value != (UnityEngine.Object) null))
        return;
      VfxManager.PlayVfxOneShot(this.skillGraph, this.vfxPrefab, this.position.Get(), this.lookDir.Get(), this.parentToOwner, this.args != null ? this.args() : (object) null);
    }
  }
}
