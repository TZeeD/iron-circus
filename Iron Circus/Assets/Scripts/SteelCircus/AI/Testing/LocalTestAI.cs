// Decompiled with JetBrains decompiler
// Type: SteelCircus.AI.Testing.LocalTestAI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.AI;
using Imi.SharedWithServer.ScEntitas.Components;
using System.Collections.Generic;
using System.Diagnostics;

namespace SteelCircus.AI.Testing
{
  public class LocalTestAI : AIPlayer
  {
    private LocalTestAIMonoBehaviour visualizer;
    private List<string> lastTickTimes = new List<string>();
    private Stopwatch tickStopWatch = new Stopwatch();

    public LocalTestAI(
      GameEntity playerEntity,
      AIDifficulty difficulty,
      AIRole role,
      AICache cache)
      : base(playerEntity, difficulty, role, cache)
    {
    }

    public new void ShutDown()
    {
    }

    public void SetVisualizer(LocalTestAIMonoBehaviour visualizer) => this.visualizer = visualizer;

    public override void Tick(ref Input input)
    {
      this.visualizer.Clear();
      this.tickStopWatch.Stop();
      this.tickStopWatch.Reset();
      this.tickStopWatch.Start();
      base.Tick(ref input);
      this.tickStopWatch.Stop();
      this.debugStringBuilder.Append(string.Format("Tick time: {0}\n", (object) (float) ((double) this.tickStopWatch.ElapsedTicks / 10000.0)));
      int num1 = 20;
      this.debugStringBuilder.Append("prev tick times:\n");
      float num2 = (float) this.tickStopWatch.ElapsedTicks / 10000f;
      if ((double) num2 > 3.0)
        this.lastTickTimes.Add(string.Format("<color=red>{0} ms - {1}</color>", (object) num2, (object) this.currentState.GetType().Name));
      else if ((double) num2 > 1.0)
        this.lastTickTimes.Add(string.Format("<color=yellow>{0} ms - {1}</color>", (object) num2, (object) this.currentState.GetType().Name));
      else
        this.lastTickTimes.Add(string.Format("{0} ms - {1}", (object) num2, (object) this.currentState.GetType().Name));
      while (this.lastTickTimes.Count > num1)
        this.lastTickTimes.RemoveAt(0);
      for (int index = this.lastTickTimes.Count - 1; index >= 0; --index)
        this.debugStringBuilder.Append(this.lastTickTimes[index] + "\n");
    }
  }
}
