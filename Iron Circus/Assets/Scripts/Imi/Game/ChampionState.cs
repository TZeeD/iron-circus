// Decompiled with JetBrains decompiler
// Type: Imi.Game.ChampionState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.Networking.Messages.SerDes;
using Imi.SharedWithServer.ScEntitas.Components;
using System;

namespace Imi.Game
{
  public struct ChampionState : ISerDesAble, IEquatable<ChampionState>
  {
    public SerializedSkillGraphs serializedSkillGraph;
    public SerializedStatusEffects serializedStatusEffects;
    public AnimationStates animationStates;

    public ChampionState(
      SerializedSkillGraphs serializedSkillGraph,
      SerializedStatusEffects serializedStatusEffects,
      AnimationStates animationStates)
    {
      this.serializedSkillGraph = serializedSkillGraph;
      this.serializedStatusEffects = serializedStatusEffects;
      this.animationStates = animationStates;
    }

    public void SerializeOrDeserialize(IMessageSerDes messageSerDes)
    {
      this.serializedSkillGraph.SerializeOrDeserialize(messageSerDes);
      this.serializedStatusEffects.SerializeOrDeserialize(messageSerDes);
      this.animationStates.SerializeOrDeserialize(messageSerDes);
    }

    public bool Equals(ChampionState other) => this.serializedStatusEffects.Equals(other.serializedStatusEffects) && this.serializedSkillGraph.Equals((object) other.serializedSkillGraph) && this.animationStates.Equals(other.animationStates);

    public override string ToString()
    {
      string str = "";
      if (this.serializedSkillGraph != null)
        str = "SM: " + this.serializedSkillGraph.ToString();
      if (this.serializedStatusEffects != null)
        str = str + "\n    SE: " + this.serializedStatusEffects.ToString();
      if (this.animationStates != null)
        str = str + "\n    ANI: " + this.animationStates.ToString();
      return str;
    }
  }
}
