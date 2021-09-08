// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.FullPlayerState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.Networking.Messages
{
  public struct FullPlayerState
  {
    public TransformStateDelta tState;
    public Input input;
    public SerializedSkillGraphs smStatesDelta;
    public SerializedStatusEffects seStatesDelta;
    public AnimationStates aniStatesDelta;

    public void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      this.tState.SerializeOrDeserialize(messageSerDes);
      if (!messageSerDes.IsSerializer())
      {
        this.smStatesDelta = new SerializedSkillGraphs(isDiff: true);
        this.seStatesDelta = new SerializedStatusEffects();
        this.aniStatesDelta = new AnimationStates();
        this.input = new Input();
      }
      this.smStatesDelta.SerializeOrDeserialize(messageSerDes);
      this.seStatesDelta.SerializeOrDeserialize(messageSerDes);
      this.aniStatesDelta.SerializeOrDeserialize(messageSerDes);
      this.input.SerializeOrDeserialize(messageSerDes);
    }
  }
}
