// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.AI.States.AIStateBase
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;
using System;
using System.Diagnostics;
using System.Text;

namespace Imi.SharedWithServer.Game.AI.States
{
  public abstract class AIStateBase
  {
    protected AIStateMachine owner;
    protected AICache cache;
    protected GameContext context;
    protected int startTick = -1;
    protected StringBuilder debugStringBuilder = new StringBuilder();

    public AIStateBase(AIStateMachine owner, AICache cache)
    {
      this.owner = owner;
      this.cache = cache;
      this.context = cache.Context;
      this.Init();
    }

    protected virtual void Init()
    {
      this.SetupDifficulty();
      this.SetupRole();
    }

    protected virtual void SetupDifficulty()
    {
    }

    protected virtual void SetupRole()
    {
    }

    public virtual void Enter(AIStateBase prevState, ref Input input)
    {
      this.startTick = this.context.globalTime.currentTick;
      this.Reset();
    }

    public virtual void Exit(AIStateBase nextState, ref Input input)
    {
    }

    public abstract void Reset();

    public abstract void Tick(ref Input input);

    public string GetDebugOutput() => this.debugStringBuilder.ToString();

    [Conditional("AI_DEBUG")]
    protected void Print(string msg) => this.debugStringBuilder.Append(msg + "\n");

    protected string PosToString(JVector pos) => string.Format("X: {0} Z: {1}", (object) Math.Round((double) pos.X, 1), (object) Math.Round((double) pos.Z, 1));
  }
}
