// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SkillVar
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Game.Skills
{
  public abstract class SkillVar
  {
    public const int ArraySize = 16;
    protected string name;

    public string Name => this.name;

    public UniqueId OwnerId { get; private set; }

    public byte StateMachineIndex { get; private set; }

    public byte VarIndex { get; private set; }

    public void SetAddress(UniqueId ownerId, byte skillGraphIdx, byte varIdx)
    {
      this.OwnerId = ownerId;
      this.StateMachineIndex = skillGraphIdx;
      this.VarIndex = varIdx;
    }

    public abstract void Parse(List<SerializedSyncValueInfo> serializationInfo, ref int valueIndex);

    public abstract void Serialize(byte[] target, ref int valueIdx);

    public abstract void Deserialize(byte[] source, ref int valueIdx);
  }
}
