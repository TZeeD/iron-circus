// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.AudioState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SharedWithServer.Game;

namespace Imi.SharedWithServer.Game.Skills
{
  public class AudioState : SkillState
  {
    public ConfigValue<string> audioResourceName;

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    protected override void OnBecameActiveThisTick() => AudioTriggerManager.PlayAudio(this.skillGraph, this.audioResourceName.Get());

    protected override void OnBecameInactiveThisTick() => AudioTriggerManager.StopAudio(this.skillGraph, this.audioResourceName.Get());
  }
}
