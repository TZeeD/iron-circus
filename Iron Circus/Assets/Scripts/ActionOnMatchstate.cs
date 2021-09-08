// Decompiled with JetBrains decompiler
// Type: ActionOnMatchstate
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SharedWithServer.ScEvents;
using UnityEngine;

public class ActionOnMatchstate : MonoBehaviour
{
  [SerializeField]
  private Imi.SharedWithServer.Game.MatchState state;

  private void Start() => Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);

  private void OnGameStateChangedEvent(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    if (matchState != this.state)
      return;
    this.GetComponent<Animator>().enabled = true;
  }

  private void OnDestroy() => Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
}
