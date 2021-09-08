// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.GameElements.BallStateMachine
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using System;
using System.Collections.Generic;

namespace Imi.SteelCircus.GameElements
{
  public class BallStateMachine
  {
    public BallViewState state;
    private Dictionary<BallViewState, BallViewStateConfig> stateEvents = new Dictionary<BallViewState, BallViewStateConfig>();

    public void AddState(BallViewState viewState, BallViewStateConfig ballViewStateConfig) => this.stateEvents[viewState] = ballViewStateConfig;

    public void EnterState(BallViewState newState)
    {
      if (newState == this.state)
      {
        Log.Warning(string.Format("BallStateMachine trying to enter already active state '{0}'. Aborting state change!", (object) newState));
      }
      else
      {
        this.LeaveState(this.state);
        this.state = newState;
        if (this.stateEvents.ContainsKey(newState))
        {
          Action onEnter = this.stateEvents[newState].onEnter;
          if (onEnter == null)
            return;
          onEnter();
        }
        else
          Log.Warning(string.Format("State '{0}' was not configured in BallStateMachine!", (object) newState));
      }
    }

    public void LeaveState(BallViewState viewState)
    {
      if (this.stateEvents.ContainsKey(viewState))
      {
        Action onExit = this.stateEvents[viewState].onExit;
        if (onExit == null)
          return;
        onExit();
      }
      else
        Log.Warning(string.Format("State '{0}' was not configured in BallStateMachine!", (object) viewState));
    }
  }
}
