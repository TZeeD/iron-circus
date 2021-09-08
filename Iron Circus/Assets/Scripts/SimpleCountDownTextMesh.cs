// Decompiled with JetBrains decompiler
// Type: SimpleCountDownTextMesh
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using TMPro;
using UnityEngine;

public class SimpleCountDownTextMesh : MonoBehaviour
{
  public string preText = "";
  public string postText = "";
  private float timeLeft = 300f;
  private bool hasStarted;
  public TextMeshProUGUI text;

  private void Update()
  {
    if (!this.hasStarted)
      return;
    this.timeLeft -= Time.deltaTime;
    this.text.text = this.preText + Mathf.Round(this.timeLeft).ToString() + this.postText;
    if ((double) this.timeLeft >= 0.0)
      return;
    this.hasStarted = false;
  }

  public void StartCountdown(float coundownTime)
  {
    this.timeLeft = coundownTime;
    this.hasStarted = true;
  }

  public void StopCountDown()
  {
    this.hasStarted = false;
    this.timeLeft = 300f;
  }
}
