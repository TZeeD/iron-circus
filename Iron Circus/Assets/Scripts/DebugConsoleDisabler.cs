// Decompiled with JetBrains decompiler
// Type: DebugConsoleDisabler
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SharedWithServer.ScEvents;
using UnityEngine;

public class DebugConsoleDisabler : MonoBehaviour
{
  public static bool isConsoleEnabled;

  private void Start() => Events.Global.OnEventDebug += new Events.EventDebug(this.OnDebugEvent);

  private void Update() => Debug.developerConsoleVisible = DebugConsoleDisabler.isConsoleEnabled;

  private void LateUpdate() => Debug.developerConsoleVisible = DebugConsoleDisabler.isConsoleEnabled;

  private void OnDestroy() => Events.Global.OnEventDebug -= new Events.EventDebug(this.OnDebugEvent);

  private void OnDebugEvent(ulong playerId, DebugEventType type)
  {
    if (type != DebugEventType.ToggleDevelopementConsole)
      return;
    DebugConsoleDisabler.isConsoleEnabled = !DebugConsoleDisabler.isConsoleEnabled;
  }
}
