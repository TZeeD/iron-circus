// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ModVarOverTimeState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ModVarOverTimeState : SkillState
  {
    public ConfigValue<float> amountPerSecond;
    [SyncValue]
    public SyncableValue<float> targetValue;
    public SkillVar<float> var;

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.targetValue.Parse(serializationInfo, ref valueIndex, this.Name + ".targetValue");

    public override void Serialize(byte[] target, ref int valueIndex) => this.targetValue.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.targetValue.Deserialize(target, ref valueIndex);

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickOnlyLocalEntity;

    protected override void TickDerived()
    {
      float num1 = this.targetValue.Get();
      float num2 = this.amountPerSecond.Get() * this.skillGraph.GetFixedTimeStep();
      float num3 = (float) this.var + num2;
      if (((double) num2 <= 0.0 || (double) num3 < (double) num1 ? ((double) num2 >= 0.0 ? 0 : ((double) num3 <= (double) num1 ? 1 : 0)) : 1) == 0)
      {
        this.var.Set(num3);
      }
      else
      {
        this.var.Set(this.targetValue.Get());
        this.Exit_();
      }
    }
  }
}
