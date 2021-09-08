// Decompiled with JetBrains decompiler
// Type: Imi.Game.History.PlayerHistoryObject
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.Utils.Extensions;

namespace Imi.Game.History
{
  public class PlayerHistoryObject : IHistoryObject
  {
    private byte[] cachedByteArray = new byte[2048];
    public bool isWritten;

    public TransformState TransformState { get; private set; }

    public ChampionState ChampionState { get; private set; }

    public PlayerHistoryObject()
    {
      this.TransformState = new TransformState();
      this.ChampionState = new ChampionState();
    }

    public PlayerHistoryObject(TransformState transformState, ChampionState championState)
    {
      this.TransformState = transformState;
      this.ChampionState = championState;
    }

    public void CopyFrom(GameEntity entity, IHistoryObject copyFromReference)
    {
      this.TransformState = entity.ToTransformState();
      this.InPlaceSetChampionState(entity, copyFromReference);
      this.isWritten = true;
    }

    private void InPlaceSetChampionState(GameEntity entity, IHistoryObject copyFromReference)
    {
      if (copyFromReference == null)
      {
        ChampionState championState = this.ChampionState;
        championState.serializedSkillGraph = SerializedSkillGraphs.CreateFrom(entity, this.cachedByteArray);
        championState.serializedStatusEffects = SerializedStatusEffects.CreateFrom(entity.statusEffect.effects);
        championState.animationStates = AnimationStates.CreateFrom(entity.animationState);
        this.ChampionState = championState;
      }
      else
        this.ChampionState = (copyFromReference as PlayerHistoryObject).ChampionState;
    }

    public override string ToString() => "T: " + this.TransformState.ToStringRounded() + "\n C: " + this.ChampionState.ToString();
  }
}
