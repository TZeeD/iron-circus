// Decompiled with JetBrains decompiler
// Type: SteelCircus.Tracking.AverageMatchFPSReporter
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Networking.Messages;
using SharedWithServer.Networking.Messages;
using SharedWithServer.ScEvents;
using UnityEngine;

namespace SteelCircus.Tracking
{
  public class AverageMatchFPSReporter : MonoBehaviour
  {
    private float totalSeconds;
    private int totalFrames;

    private void Start() => Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnMatchStateChanged);

    private void OnDestroy() => Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnMatchStateChanged);

    private void OnMatchStateChanged(
      Imi.SharedWithServer.Game.MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime)
    {
      if (matchState == Imi.SharedWithServer.Game.MatchState.Intro)
      {
        this.Reset();
      }
      else
      {
        if (matchState != Imi.SharedWithServer.Game.MatchState.MatchOver)
          return;
        this.ReportStats();
      }
    }

    private void Reset()
    {
      this.totalSeconds = 0.0f;
      this.totalFrames = 0;
    }

    private void ReportStats()
    {
      float averageFps = 1f / (this.totalSeconds / (float) this.totalFrames);
      string deviceName = SystemInfo.deviceName;
      int hashCode = deviceName.GetHashCode();
      Log.Debug(string.Format("Sending FPS stats - average FPS: {0}, deviceNameHash: {1}, device name: {2}", (object) averageFps, (object) hashCode, (object) deviceName));
      Contexts.sharedInstance.meta.metaNetwork.value.SendReliable((Message) new AverageFpsMessage(averageFps, deviceName));
    }

    private void Update()
    {
      GameContext game = Contexts.sharedInstance.game;
      if (game == null)
        return;
      GameEntity matchStateEntity = game.matchStateEntity;
      if (matchStateEntity == null || matchStateEntity.matchState.value != Imi.SharedWithServer.Game.MatchState.PointInProgress)
        return;
      ++this.totalFrames;
      this.totalSeconds += Time.deltaTime;
    }
  }
}
