// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SetCollisionLayerAndMaskAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class SetCollisionLayerAndMaskAction : SkillAction
  {
    [SyncValue]
    public SyncableValue<UniqueId> targetEntityId;
    [SyncValue]
    public SyncableValue<int> setToLayer;
    [SyncValue]
    public SyncableValue<int> setToMask;

    public override bool IsNetworked => true;

    protected override void PerformActionInternal()
    {
    }

    public override void SyncedDo()
    {
      GameEntity entity = this.skillGraph.GetEntity(this.targetEntityId.Get());
      if (entity == null || !entity.hasRigidbody)
        return;
      entity.rigidbody.value.CollisionLayer = this.setToLayer.Get();
      entity.rigidbody.value.CollisionMask = this.setToMask.Get();
    }

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.targetEntityId.Parse(serializationInfo, ref valueIndex, this.Name + ".targetEntityId");
      this.setToLayer.Parse(serializationInfo, ref valueIndex, this.Name + ".setToLayer");
      this.setToMask.Parse(serializationInfo, ref valueIndex, this.Name + ".setToMask");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.targetEntityId.Serialize(target, ref valueIndex);
      this.setToLayer.Serialize(target, ref valueIndex);
      this.setToMask.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.targetEntityId.Deserialize(target, ref valueIndex);
      this.setToLayer.Deserialize(target, ref valueIndex);
      this.setToMask.Deserialize(target, ref valueIndex);
    }
  }
}
