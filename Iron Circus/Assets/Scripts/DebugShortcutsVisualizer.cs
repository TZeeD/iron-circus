// Decompiled with JetBrains decompiler
// Type: DebugShortcutsVisualizer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SharedWithServer.ScEvents;
using UnityEngine;
using UnityEngine.UI;

public class DebugShortcutsVisualizer : MonoBehaviour
{
  public Text textField;
  public float duration = 2f;
  private float counter = 1f;

  private void Start() => Events.Global.OnEventDebug += new Events.EventDebug(this.OnDebugEvent);

  private void OnDebugEvent(ulong playerId, DebugEventType type)
  {
    this.textField.text = type.ToString();
    this.counter = 0.0f;
  }

  private void Update()
  {
    if ((double) this.counter >= 1.0)
      return;
    this.counter = Mathf.Clamp01(this.counter + Time.deltaTime / this.duration);
    Color color = this.textField.color;
    color.a = 1f - Mathf.Pow(this.counter, 6f);
    this.textField.color = color;
  }

  private void OnDestroy() => Events.Global.OnEventDebug -= new Events.EventDebug(this.OnDebugEvent);
}
