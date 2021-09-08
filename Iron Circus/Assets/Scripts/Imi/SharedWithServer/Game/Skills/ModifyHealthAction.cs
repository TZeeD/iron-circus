// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ModifyHealthAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ModifyHealthAction : SkillAction
  {
    public SkillVar<UniqueId> targetEntities;
    [SyncValue]
    public SyncableValue<int> value;

    protected override void PerformActionInternal()
    {
      this.skillGraph.GetOwner();
      GameContext context = this.skillGraph.GetContext();
      for (int i = 0; i < this.targetEntities.Length; ++i)
      {
        GameEntity entityWithUniqueId = context.GetFirstEntityWithUniqueId(this.targetEntities[i]);
        if (entityWithUniqueId != null)
        {
          int num = entityWithUniqueId.hasPlayerHealth ? 1 : 0;
        }
      }
    }

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.value.Parse(serializationInfo, ref valueIndex, this.Name + ".value");

    public override void Serialize(byte[] target, ref int valueIndex) => this.value.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.value.Deserialize(target, ref valueIndex);
  }
}
