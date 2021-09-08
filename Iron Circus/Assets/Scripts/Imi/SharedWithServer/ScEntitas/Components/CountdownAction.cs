// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.CountdownAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  public class CountdownAction
  {
    public float currentT;
    public float duration;
    public readonly bool destroyEntityWhenDone;
    public readonly Func<bool> earlyExitCondition;
    public readonly bool executeFinishedActionOnEarlyExit;
    public readonly Func<bool> paused;
    public readonly Action onFinished;
    public readonly Action<float, float> onUpdate;

    public float RemainingT => this.duration - this.currentT;

    private CountdownAction(
      Action onFinished,
      float duration,
      Action<float, float> onUpdate,
      Func<bool> earlyExitCondition,
      bool destroyEntityWhenDone,
      bool executeFinishedActionOnEarlyExit,
      Func<bool> paused)
    {
      this.onFinished = onFinished;
      this.duration = duration;
      this.onUpdate = onUpdate;
      this.earlyExitCondition = earlyExitCondition;
      this.destroyEntityWhenDone = destroyEntityWhenDone;
      this.executeFinishedActionOnEarlyExit = executeFinishedActionOnEarlyExit;
      this.paused = paused;
    }

    public static CountdownAction.Builder WithDuration(float countdown) => new CountdownAction.Builder(countdown);

    public class Builder
    {
      private readonly float countdown;
      private bool destroyWhenDone;
      private Func<bool> earlyExitCondition;
      private bool executeFinishedActionOnEarlyExit;
      private Action onFinished;
      private Action<float, float> onUpdate;
      private Func<bool> paused;

      public Builder(float countdown) => this.countdown = countdown;

      public CountdownAction.Builder WithFinishedAction(Action onFinished)
      {
        this.onFinished = onFinished;
        return this;
      }

      public CountdownAction.Builder WithUpdateAction(Action<float, float> onUpdate)
      {
        this.onUpdate = onUpdate;
        return this;
      }

      public CountdownAction.Builder WithEarlyExitCondition(
        Func<bool> earlyExitCondition)
      {
        this.earlyExitCondition = earlyExitCondition;
        return this;
      }

      public CountdownAction.Builder DestoyEntityWhenDone()
      {
        this.destroyWhenDone = true;
        return this;
      }

      public CountdownAction.Builder ExecuteFinishedOnEarlyExit()
      {
        this.executeFinishedActionOnEarlyExit = true;
        return this;
      }

      public CountdownAction.Builder WithPauseCondition(Func<bool> paused)
      {
        this.paused = paused;
        return this;
      }

      public CountdownAction Create() => new CountdownAction(this.onFinished, this.countdown, this.onUpdate, this.earlyExitCondition, this.destroyWhenDone, this.executeFinishedActionOnEarlyExit, this.paused);
    }
  }
}
