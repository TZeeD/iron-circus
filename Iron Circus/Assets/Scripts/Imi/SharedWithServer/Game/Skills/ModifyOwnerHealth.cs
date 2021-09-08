// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ModifyOwnerHealth
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class ModifyOwnerHealth : SkillAction
  {
    [SyncValue]
    public SyncableValue<int> value;

    protected override void PerformActionInternal()
    {
      this.skillGraph.GetOwner();
      this.value.Get();
    }

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex) => this.value.Parse(serializationInfo, ref valueIndex, this.Name + ".value");

    public override void Serialize(byte[] target, ref int valueIndex) => this.value.Serialize(target, ref valueIndex);

    public override void Deserialize(byte[] target, ref int valueIndex) => this.value.Deserialize(target, ref valueIndex);
  }
}
