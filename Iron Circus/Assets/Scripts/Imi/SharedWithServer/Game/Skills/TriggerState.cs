// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.TriggerState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class TriggerState : SkillState
  {
    [SyncValue]
    private SyncableValue<int> lastTriggerTick;
    private int lastProcessedTriggerTick;
    public Action onTrigger;
    public Action<int> onTriggerWithTick;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.lastTriggerTick.Parse(serializationInfo, ref valueIndex, this.Name + ".lastTriggerTick");

    public override void Serialize(byte[] target, ref int valueIndex) => this.lastTriggerTick.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.lastTriggerTick.Deserialize(target, ref valueIndex);

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    public override SkillStateSyncFlag SkillStateSyncFlag => SkillStateSyncFlag.AlwaysSync;

    public void Trigger()
    {
      this.lastTriggerTick.Set(this.skillGraph.GetTick());
      this.lastProcessedTriggerTick = -1;
    }

    protected override void EnterDerived() => this.TickLogic();

    protected override void TickDerived() => this.TickLogic();

    private void TickLogic()
    {
      int num = this.lastTriggerTick.Get();
      if (num <= this.lastProcessedTriggerTick)
        return;
      this.lastProcessedTriggerTick = num;
      Action onTrigger = this.onTrigger;
      if (onTrigger != null)
        onTrigger();
      Action<int> onTriggerWithTick = this.onTriggerWithTick;
      if (onTriggerWithTick == null)
        return;
      onTriggerWithTick(num);
    }
  }
}
