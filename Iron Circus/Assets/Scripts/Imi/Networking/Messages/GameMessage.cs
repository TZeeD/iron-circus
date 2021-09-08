// Decompiled with JetBrains decompiler
// Type: Imi.Networking.Messages.GameMessage
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Jitter.LinearMath;
using System.Collections.Generic;

namespace Imi.Networking.Messages
{
  public class GameMessage : Message
  {
    public ServerStatusHeader status;
    public UniqueId ballOwner;
    public bool ballHoldDisabled;
    public JVector ballvelocity;
    public float ballTraveledDistance;
    public float ballFlighDuration;
    public TransformStateDelta ballTransformStateDelta;
    public Dictionary<UniqueId, FullPlayerState> playerStates;
    public Dictionary<UniqueId, TransformStateDelta> tmpEntities;

    public GameMessage(ServerStatusHeader status)
      : base(RumpfieldMessageType.GameMessage)
    {
      this.status = status;
      this.ballOwner = UniqueId.Zero;
      this.ballTransformStateDelta = TransformStateDelta.GetDelta(TransformState.Invalid, TransformState.Default);
      this.playerStates = new Dictionary<UniqueId, FullPlayerState>();
      this.tmpEntities = new Dictionary<UniqueId, TransformStateDelta>();
    }

    public void Clear()
    {
      this.status = new ServerStatusHeader();
      this.ballOwner = new UniqueId();
      this.ballHoldDisabled = false;
      this.ballvelocity = new JVector();
      this.ballTraveledDistance = 0.0f;
      this.ballFlighDuration = 0.0f;
      this.ballTransformStateDelta = new TransformStateDelta();
      if (this.playerStates != null)
        this.playerStates.Clear();
      if (this.tmpEntities == null)
        return;
      this.tmpEntities.Clear();
    }

    public GameMessage(
      ServerStatusHeader status,
      UniqueId ballOwner,
      bool ballHoldDisabled,
      TransformStateDelta ballTransformStateDelta,
      JVector ballvelocity,
      float ballTraveledDistance,
      float ballFlighDuration,
      Dictionary<UniqueId, FullPlayerState> playerStates,
      Dictionary<UniqueId, TransformStateDelta> tmpEntities)
      : base(RumpfieldMessageType.GameMessage)
    {
      this.status = status;
      this.ballOwner = ballOwner;
      this.ballHoldDisabled = ballHoldDisabled;
      this.ballTransformStateDelta = ballTransformStateDelta;
      this.ballvelocity = ballvelocity;
      this.ballTraveledDistance = ballTraveledDistance;
      this.ballFlighDuration = ballFlighDuration;
      this.playerStates = playerStates;
      this.tmpEntities = tmpEntities;
    }

    public GameMessage()
      : base(RumpfieldMessageType.GameMessage)
    {
      this.playerStates = new Dictionary<UniqueId, FullPlayerState>(6);
      this.tmpEntities = new Dictionary<UniqueId, TransformStateDelta>(6);
    }

    protected override void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      this.status.SerializeOrDeserialize(messageSerDes);
      messageSerDes.UniqueId(ref this.ballOwner);
      messageSerDes.JVector(ref this.ballvelocity);
      messageSerDes.Float(ref this.ballTraveledDistance);
      messageSerDes.Float(ref this.ballFlighDuration);
      messageSerDes.Bool(ref this.ballHoldDisabled);
      this.ballTransformStateDelta.SerializeOrDeserialize(messageSerDes, true);
      this.SerializeOrDeserializePlayerStates(messageSerDes);
      this.SerDesTmpEntities(messageSerDes);
    }

    public override string ToString()
    {
      string str = "";
      foreach (KeyValuePair<UniqueId, FullPlayerState> playerState in this.playerStates)
      {
        UniqueId key = playerState.Key;
        str = str + string.Format("\tPlayer [{0}] {{\n", (object) key) + string.Format("\t\tInput {{ {0} }}\n", (object) playerState.Value.input) + string.Format("\t\tAnimStates {{ {0} }}\n", (object) playerState.Value.aniStatesDelta) + string.Format("\t\tStatusEffects {{ {0} }}\n", (object) playerState.Value.seStatesDelta) + "\t\tSkillGraphsDiff {\n " + string.Format("\t{0} \n", (object) playerState.Value.smStatesDelta) + "\t\t}\n\t}\n";
      }
      return "GameStateMessage {\n\tStatus {\n" + string.Format("\t\tServerTick [{0}]\n", (object) this.status.serverTick) + string.Format("\t\tServerBaseline [{0}]\n", (object) this.status.serverBaseline) + string.Format("\t\tC/S-Offset [{0}]\n", (object) this.status.clientToServerOffset) + string.Format("\t\tLastInputLate [{0}]", (object) this.status.wasLastInputLate) + "\t}\n\tBall {\n" + string.Format("\t\tOwner [{0}]\n", (object) this.ballOwner) + string.Format("\t\tVelocity [{0}]\n", (object) this.ballvelocity) + string.Format("\t\tTraveledDistance [{0}]\n", (object) this.ballTraveledDistance) + string.Format("\t\tFlightDuration [{0}]\n", (object) this.ballFlighDuration) + string.Format("\t\tHoldDisabled [{0}]\n", (object) this.ballHoldDisabled) + "\t\tTransformStateDelta {\n" + string.Format("\t\t\t{0}\n", (object) this.ballHoldDisabled) + "\t\t}\n\t}\n\tPlayerStates {\n" + str + "\t}\n}";
    }

    private void SerDesTmpEntities(IMessageSerDes messageSerDes)
    {
      byte count = (byte) this.tmpEntities.Count;
      messageSerDes.Byte(ref count, (byte) 0, (byte) 128);
      if (messageSerDes.IsSerializer())
      {
        foreach (KeyValuePair<UniqueId, TransformStateDelta> tmpEntity in this.tmpEntities)
        {
          UniqueId key = tmpEntity.Key;
          messageSerDes.UniqueId(ref key);
          tmpEntity.Value.SerializeOrDeserialize(messageSerDes, true);
        }
      }
      else
      {
        for (int index = 0; index < (int) count; ++index)
        {
          UniqueId zero = UniqueId.Zero;
          TransformStateDelta transformStateDelta = new TransformStateDelta();
          messageSerDes.UniqueId(ref zero);
          transformStateDelta.SerializeOrDeserialize(messageSerDes, true);
          this.tmpEntities[zero] = transformStateDelta;
        }
      }
    }

    private void SerializeOrDeserializePlayerStates(IMessageSerDes messageSerDes)
    {
      byte count = (byte) this.playerStates.Count;
      messageSerDes.Byte(ref count, (byte) 0, (byte) 10);
      if (messageSerDes.IsSerializer())
      {
        foreach (KeyValuePair<UniqueId, FullPlayerState> playerState in this.playerStates)
        {
          UniqueId key = playerState.Key;
          messageSerDes.UniqueId(ref key);
          playerState.Value.SerializeOrDeserialize(messageSerDes);
        }
      }
      else
      {
        for (int index = 0; index < (int) count; ++index)
        {
          UniqueId zero = UniqueId.Zero;
          FullPlayerState fullPlayerState = new FullPlayerState();
          messageSerDes.UniqueId(ref zero);
          fullPlayerState.SerializeOrDeserialize(messageSerDes);
          this.playerStates[zero] = fullPlayerState;
        }
      }
    }
  }
}
