// Decompiled with JetBrains decompiler
// Type: LatencyIndicator
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas.Components;
using SharedWithServer.ScEvents;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class LatencyIndicator : MonoBehaviour
{
  [SerializeField]
  private Image packetLossImage;
  [SerializeField]
  private Image latencyImage;
  [SerializeField]
  private TextMeshProUGUI latencyTxt;
  [SerializeField]
  private float latencyMin;
  [SerializeField]
  private float latencyMax;
  [SerializeField]
  private float packetLossMin;
  [SerializeField]
  private float packetLossMax;
  [SerializeField]
  private float updateInterval = 0.2f;
  [SerializeField]
  private float minimumDuration = 5f;
  private float nextTime;
  private GameEntity infoEntity;
  private bool update;
  private float lastLatencyEnabledTime;
  private float lastPacketLossTime;
  [Header("Data")]
  public float Loss;
  public float Latency;

  private void Start() => Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);

  private void OnGameStateChangedEvent(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    if (this.infoEntity == null)
      this.infoEntity = Contexts.sharedInstance.game.GetGroup(GameMatcher.ConnectionInfo).GetEntities()[0];
    if (matchState == Imi.SharedWithServer.Game.MatchState.GetReady)
    {
      this.update = true;
    }
    else
    {
      if (matchState != Imi.SharedWithServer.Game.MatchState.MatchOver)
        return;
      this.update = false;
    }
  }

  private void Update()
  {
    if (!this.update || (double) Time.time < (double) this.nextTime)
      return;
    if (this.infoEntity == null)
      this.infoEntity = Contexts.sharedInstance.game.GetGroup(GameMatcher.ConnectionInfo).GetEntities()[0];
    if (this.infoEntity == null)
      return;
    ConnectionInfoComponent connectionInfo = this.infoEntity.connectionInfo;
    this.Loss = connectionInfo.loss * 100f;
    this.Latency = connectionInfo.rttMillis;
    this.UpdatePacketLoss();
    this.UpdateLatency();
    this.nextTime += this.updateInterval;
  }

  private void UpdateLatency()
  {
    if ((double) this.Latency > (double) this.latencyMin)
    {
      this.lastLatencyEnabledTime = Time.time;
      this.latencyImage.enabled = true;
      this.latencyTxt.enabled = true;
      this.latencyImage.color = Color.yellow;
      this.latencyTxt.color = Color.yellow;
      if ((double) this.Latency > (double) this.latencyMax)
      {
        this.latencyImage.color = Color.red;
        this.latencyTxt.color = Color.red;
      }
      this.latencyTxt.text = "Latency\n" + (object) (int) this.Latency + " ms";
    }
    else
    {
      if ((double) this.lastLatencyEnabledTime + (double) this.minimumDuration >= (double) Time.time)
        return;
      this.latencyImage.enabled = false;
      this.latencyTxt.enabled = false;
    }
  }

  private void UpdatePacketLoss()
  {
    if ((double) this.Loss > (double) this.packetLossMin)
    {
      this.lastPacketLossTime = Time.time;
      this.packetLossImage.enabled = true;
      this.packetLossImage.color = Color.yellow;
      if ((double) this.Loss <= (double) this.packetLossMax)
        return;
      this.packetLossImage.color = Color.red;
    }
    else
    {
      if ((double) this.lastLatencyEnabledTime + (double) this.minimumDuration >= (double) Time.time)
        return;
      this.packetLossImage.enabled = false;
    }
  }

  private void OnDestroy() => Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
}
