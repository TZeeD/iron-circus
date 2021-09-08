// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SpawnAoeVfxAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;

namespace Imi.SharedWithServer.Game.Skills
{
  public class SpawnAoeVfxAction : SpawnVfxAction
  {
    public ConfigValue<AreaOfEffect> aoe;

    public override bool IsNetworked => true;

    protected override void PerformActionInternal() => VfxManager.PlayAoeVfxOneShot(this.skillGraph, this.vfxPrefab, this.aoe.Get(), this.position.Get(), this.lookDir.Get(), (object) this.args);
  }
}
