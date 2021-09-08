// Decompiled with JetBrains decompiler
// Type: DebugToggleActiveOnEvent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SharedWithServer.ScEvents;
using System.Collections.Generic;
using UnityEngine;

public class DebugToggleActiveOnEvent : MonoBehaviour
{
  public List<GameObject> gameObjects = new List<GameObject>();
  public DebugEventType debugEventType;

  private void Start() => Events.Global.OnEventDebug += new Events.EventDebug(this.OnDebugEvent);

  private void OnDebugEvent(ulong playerId, DebugEventType type)
  {
    if (this.debugEventType == DebugEventType.Invalid || this.debugEventType != type)
      return;
    foreach (GameObject gameObject in this.gameObjects)
      gameObject.SetActive(!gameObject.activeSelf);
  }

  private void OnDestroy() => Events.Global.OnEventDebug -= new Events.EventDebug(this.OnDebugEvent);
}
