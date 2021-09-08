// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.AIStateMachine
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Game.AI.States;
using Imi.SharedWithServer.ScEntitas.Components;
using System;
using System.Collections.Generic;
using System.Text;

namespace Imi.SharedWithServer.Game.AI
{
  public class AIStateMachine : BaseAI
  {
    protected Dictionary<Type, AIStateBase> states = new Dictionary<Type, AIStateBase>(10);
    protected AIStateBase currentState;
    protected StringBuilder debugStringBuilder = new StringBuilder();

    public AIStateMachine(
      GameEntity playerEntity,
      AIDifficulty difficulty,
      AIRole role,
      AICache cache)
      : base(playerEntity, difficulty, role, cache)
    {
      Log.Debug(string.Format("AI player: team: {0} role: {1} difficulty: {2}", (object) playerEntity.playerTeam.value, (object) role, (object) difficulty));
    }

    public void AddState(AIStateBase state) => this.states[state.GetType()] = state;

    protected void SetState(Type stateType)
    {
      Input input = new Input();
      this.SetState(stateType, ref input);
    }

    public void SetState(Type stateType, ref Input input)
    {
      AIStateBase state = this.GetState(stateType);
      AIStateBase currentState = this.currentState;
      if (state == currentState)
        return;
      if (this.currentState != null)
        this.currentState.Exit(state, ref input);
      this.currentState = state;
      state?.Enter(currentState, ref input);
    }

    public AIStateBase GetState(Type stateType)
    {
      foreach (Type key in this.states.Keys)
      {
        if (stateType == key || stateType.IsSubclassOf(key) || key.IsSubclassOf(stateType))
          return this.states[key];
      }
      return (AIStateBase) null;
    }

    public override void Tick(ref Input input)
    {
      this.debugStringBuilder.Clear();
      if (this.ownerEntity.IsDead())
        return;
      base.Tick(ref input);
      this.debugStringBuilder.Append(this.currentState.GetType().Name + "\n");
      this.currentState.Tick(ref input);
      this.debugStringBuilder.Append(this.currentState.GetDebugOutput());
    }

    public string GetDebugOutput() => this.debugStringBuilder.ToString();
  }
}
