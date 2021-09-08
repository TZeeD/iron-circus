// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.RumbleControllerAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public class RumbleControllerAction : SkillAction
  {
    public SkillVar<UniqueId> entities;
    [SyncValue]
    public SyncableValue<ulong> playerId;
    [SyncValue]
    public SyncableValue<float> strength;
    [SyncValue]
    public SyncableValue<float> duration;

    public override bool IsNetworked => true;

    public RumbleControllerAction(SkillGraph skillGraph, string name)
      : base(skillGraph, name)
    {
    }

    public RumbleControllerAction()
    {
    }

    protected override void PerformActionInternal()
    {
    }

    public override void SyncedDo()
    {
      if (this.skillGraph.IsSyncing() || this.skillGraph.IsRepredicting())
        return;
      if (this.entities != null)
      {
        for (int i = 0; i < this.entities.Length; ++i)
        {
          GameEntity entity = this.skillGraph.GetEntity(this.entities[i]);
          if (entity != null && entity.isPlayer)
            ControllerRumble.RumbleController(entity.playerId.value, this.strength.Get(), this.duration.Get());
        }
      }
      else
        ControllerRumble.RumbleController(this.playerId.Get(), this.strength.Get(), this.duration.Get());
    }

    public override void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex)
    {
      this.playerId.Parse(serializationInfo, ref valueIndex, this.Name + ".playerId");
      this.strength.Parse(serializationInfo, ref valueIndex, this.Name + ".strength");
      this.duration.Parse(serializationInfo, ref valueIndex, this.Name + ".duration");
    }

    public override void Serialize(byte[] target, ref int valueIndex)
    {
      this.playerId.Serialize(target, ref valueIndex);
      this.strength.Serialize(target, ref valueIndex);
      this.duration.Serialize(target, ref valueIndex);
    }

    public override void Deserialize(byte[] target, ref int valueIndex)
    {
      this.playerId.Deserialize(target, ref valueIndex);
      this.strength.Deserialize(target, ref valueIndex);
      this.duration.Deserialize(target, ref valueIndex);
    }
  }
}
