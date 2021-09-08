// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Systems.AddRemainingMatchTimeSystem
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using System;

namespace Imi.SharedWithServer.ScEntitas.Systems
{
  public class AddRemainingMatchTimeSystem : IInitializeSystem, ISystem
  {
    private readonly Contexts contexts;
    private readonly float matchTime = 300f;

    public AddRemainingMatchTimeSystem(Contexts contexts) => this.contexts = contexts;

    public void Initialize()
    {
      this.contexts.game.isRemainingMatchTime = true;
      this.contexts.game.remainingMatchTimeEntity.ReplaceCountdownAction(CountdownAction.WithDuration(this.matchTime).WithFinishedAction((Action) (() => this.contexts.game.ReplaceMatchStateTransitionEvent(TransitionEvent.MatchTimeOut))).Create());
    }
  }
}
