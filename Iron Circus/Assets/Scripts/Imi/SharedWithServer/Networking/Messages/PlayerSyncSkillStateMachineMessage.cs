// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.PlayerSyncSkillStateMachineMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Networking.Messages.SerDes;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Networking.Messages
{
  public class PlayerSyncSkillStateMachineMessage : Message
  {
    public int instanceIdx;
    public ulong ownerId;
    public List<int> activeStates = new List<int>();
    public byte[] stateData = new byte[0];

    public PlayerSyncSkillStateMachineMessage()
      : base(RumpfieldMessageType.SyncSkillStateMachine)
    {
    }

    public PlayerSyncSkillStateMachineMessage(
      int instanceIdx,
      ulong ownerId,
      List<int> activeStates,
      byte[] stateData)
      : base(RumpfieldMessageType.SyncSkillStateMachine)
    {
      this.instanceIdx = instanceIdx;
      this.ownerId = ownerId;
      this.activeStates = activeStates;
      this.stateData = stateData;
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      messageSerDes.ULong(ref this.ownerId);
      messageSerDes.Int(ref this.instanceIdx);
      if (messageSerDes.IsSerializer())
        this.SerializeSkillScriptInstance(messageSerDes);
      else
        this.DeserializeSkillScriptInstance(messageSerDes);
    }

    private void SerializeSkillScriptInstance(IMessageSerDes messageSerDes)
    {
      byte count = (byte) this.activeStates.Count;
      messageSerDes.Byte(ref count);
      for (int index = 0; index < this.activeStates.Count; ++index)
      {
        int activeState = this.activeStates[index];
        messageSerDes.Int(ref activeState);
      }
      byte length = (byte) this.stateData.Length;
      messageSerDes.Byte(ref length);
      foreach (byte num in this.stateData)
        messageSerDes.Byte(ref num);
    }

    private void DeserializeSkillScriptInstance(IMessageSerDes messageSerDes)
    {
      byte num1 = 0;
      messageSerDes.Byte(ref num1);
      this.activeStates = new List<int>();
      for (int index = 0; index < (int) num1; ++index)
      {
        int num2 = 0;
        messageSerDes.Int(ref num2);
        this.activeStates.Add(num2);
      }
      byte num3 = 0;
      messageSerDes.Byte(ref num3);
      this.stateData = new byte[(int) num3];
      for (int index = 0; index < (int) num3; ++index)
      {
        byte num4 = 0;
        messageSerDes.Byte(ref num4);
        this.stateData[index] = num4;
      }
    }
  }
}
