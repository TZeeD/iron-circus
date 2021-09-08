// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Debugging.DebugNetworkUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas.Components;
using SharedWithServer.ScEvents;
using System;
using System.Collections;
using Tayx.Graphy;
using UnityEngine;
using UnityEngine.UI;

namespace Imi.SteelCircus.Debugging
{
  public class DebugNetworkUi : MonoBehaviour
  {
    [Header("Update Rate for Network Stats")]
    [SerializeField]
    private uint updateRateInHertz = 10;
    [SerializeField]
    private bool updateEveryFrame;
    [Header("Network stats references")]
    [SerializeField]
    private GameObject uiRoot;
    [SerializeField]
    private GameObject simpleUiRoot;
    [SerializeField]
    private GameObject graphUiRoot;
    [Header("Simple View references")]
    [SerializeField]
    private Text rttField;
    [SerializeField]
    private Text rtttField;
    [SerializeField]
    private Text lossField;
    [SerializeField]
    private Text receivedField;
    [SerializeField]
    private Text sendField;
    [SerializeField]
    private Text ackField;
    [SerializeField]
    private Text serverTickField;
    [SerializeField]
    private Text clientTickField;
    [SerializeField]
    private Text tickDField;
    [SerializeField]
    private Text tickRateField;
    [SerializeField]
    private Text fpsField;
    [SerializeField]
    private Text memoryField;
    [SerializeField]
    private Text gcField;
    [Header("Graph View references")]
    [SerializeField]
    private NetworkQuantityGraph rttGraph;
    [SerializeField]
    private Text rtttFieldGraph;
    [SerializeField]
    private NetworkQuantityGraph lossGraph;
    [SerializeField]
    private NetworkQuantityGraph receivedGraph;
    [SerializeField]
    private NetworkQuantityGraph sendGraph;
    [SerializeField]
    private NetworkQuantityGraph ackGraph;
    [SerializeField]
    private NetworkQuantityGraph fpsGraph;
    [SerializeField]
    private Text serverTickFieldGraph;
    [SerializeField]
    private Text clientTickFieldGraph;
    [SerializeField]
    private Text tickDFieldGraph;
    [SerializeField]
    private Text tickRateFieldGraph;
    [SerializeField]
    private Text fpsFieldGraph;
    private ShaderGraph rttShaderGraph;
    private float lastRtt;
    private float lastLatency;
    private double lastUpdate;
    private bool keepGoing = true;
    private bool showNetworkUi;
    private bool showGraphView;
    private float time;
    private GameEntity infoEntity;

    private void Start()
    {
      Events.Global.OnEventDebug += new Events.EventDebug(this.OnDebugEvent);
      Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnMatchStateChangedEvent);
      Events.Global.OnEventMemoryOverLimit += new Events.EventMemoryOverLimit(this.OnMemoryOverLimitEvent);
    }

    private void OnMemoryOverLimitEvent(long usedMemory, long limit)
    {
      this.gcField.text = "no";
      this.gcField.color = Color.red;
    }

    private void OnMatchStateChangedEvent(
      Imi.SharedWithServer.Game.MatchState matchState,
      float cutsceneDuration,
      float remainingMatchTime)
    {
      this.gcField.text = "yes";
      this.gcField.color = new Color(0.83f, 0.83f, 0.83f, 1f);
    }

    private void OnDebugEvent(ulong playerId, DebugEventType type)
    {
      switch (type)
      {
        case DebugEventType.ToggleGraphView:
          if (!this.showNetworkUi)
            break;
          this.showGraphView = !this.showGraphView;
          break;
        case DebugEventType.ToggleNetworkUI:
          this.showNetworkUi = !this.showNetworkUi;
          break;
        case DebugEventType.ToggleNetworkUIUpdateRate:
          this.updateEveryFrame = !this.updateEveryFrame;
          break;
      }
    }

    private void Update()
    {
      this.uiRoot.SetActive(this.showNetworkUi);
      if (!this.showNetworkUi)
        return;
      this.time += Time.deltaTime;
      float num = 1f / (float) this.updateRateInHertz;
      if (this.updateEveryFrame)
      {
        this.UpdateUi();
      }
      else
      {
        if ((double) this.time < (double) num)
          return;
        this.time %= num;
        this.UpdateUi();
      }
    }

    private IEnumerator UpdateCustomRate()
    {
      float t = 0.0f;
      while (this.keepGoing)
      {
        t += Time.deltaTime;
        float num = 1f / (float) this.updateRateInHertz;
        if ((double) t > (double) num)
        {
          t -= num;
          this.UpdateUi();
        }
        yield return (object) null;
      }
    }

    public void OnDestroy()
    {
      Events.Global.OnEventDebug -= new Events.EventDebug(this.OnDebugEvent);
      Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnMatchStateChangedEvent);
      Events.Global.OnEventMemoryOverLimit -= new Events.EventMemoryOverLimit(this.OnMemoryOverLimitEvent);
      this.keepGoing = false;
    }

    private void UpdateUi()
    {
      if (this.infoEntity == null)
        this.infoEntity = Contexts.sharedInstance.game.GetGroup(GameMatcher.ConnectionInfo).GetEntities()?[0];
      if (this.infoEntity == null)
        return;
      ConnectionInfoComponent connectionInfo = this.infoEntity.connectionInfo;
      int currentTick = Contexts.sharedInstance.game.globalTime.currentTick;
      float fixedSimTimeStep = Contexts.sharedInstance.game.globalTime.fixedSimTimeStep;
      this.simpleUiRoot.SetActive(!this.showGraphView);
      this.graphUiRoot.SetActive(this.showGraphView);
      if (this.showGraphView)
      {
        this.rttGraph.UpdateGraph(connectionInfo.rttMillis, "{0:###.##}");
        this.rtttFieldGraph.text = string.Format("{0}", (object) Mathf.CeilToInt(connectionInfo.rttMillis / (fixedSimTimeStep * 1000f)));
        this.lossGraph.UpdateGraph(connectionInfo.loss * 100f, "{0:##0.##}");
        this.receivedGraph.UpdateGraph(connectionInfo.recvBandwidthKbps, "{0:####.###}");
        this.sendGraph.UpdateGraph(connectionInfo.sentBandwidthKbps, "{0:####.###}");
        this.ackGraph.UpdateGraph(connectionInfo.ackBandwidthKbps, "{0:####.###}");
        this.fpsGraph.UpdateGraph(Mathf.Round(1f / Time.smoothDeltaTime), "{0:###}");
        this.serverTickFieldGraph.text = string.Format("{0}", (object) connectionInfo.lastReceivedRemoteTick);
        this.clientTickFieldGraph.text = string.Format("{0}", (object) currentTick);
        this.tickDFieldGraph.text = string.Format("{0}", (object) (currentTick - connectionInfo.lastReceivedRemoteTick));
        this.tickRateFieldGraph.text = string.Format("{0:##.##}", (object) connectionInfo.currentTickRateMillis);
        this.fpsFieldGraph.text = string.Format("{0}/{1}", (object) Mathf.Round(1f / Time.smoothDeltaTime), (object) Mathf.Round(1f / Time.deltaTime));
      }
      else
      {
        this.rttField.text = string.Format("{0:###.##}", (object) connectionInfo.rttMillis);
        this.rtttField.text = string.Format("{0}", (object) Mathf.CeilToInt(connectionInfo.rttMillis / (fixedSimTimeStep * 1000f)));
        this.lossField.text = string.Format("{0}", (object) (float) ((double) connectionInfo.loss * 100.0));
        this.receivedField.text = string.Format("{0:####.###}", (object) connectionInfo.recvBandwidthKbps);
        this.sendField.text = string.Format("{0:####.###}", (object) connectionInfo.sentBandwidthKbps);
        this.ackField.text = string.Format("{0:####.###}", (object) connectionInfo.ackBandwidthKbps);
        this.serverTickField.text = string.Format("{0}", (object) connectionInfo.lastReceivedRemoteTick);
        this.clientTickField.text = string.Format("{0}", (object) currentTick);
        this.tickDField.text = string.Format("{0}", (object) (currentTick - connectionInfo.lastReceivedRemoteTick));
        this.tickRateField.text = string.Format("{0:##.##}", (object) connectionInfo.currentTickRateMillis);
        this.fpsField.text = string.Format("{0}/{1}", (object) Mathf.Round(1f / Time.smoothDeltaTime), (object) Mathf.Round(1f / Time.deltaTime));
        this.memoryField.text = string.Format("{0:####.##}", (object) (float) ((double) GC.GetTotalMemory(false) / 1048576.0));
      }
    }
  }
}
