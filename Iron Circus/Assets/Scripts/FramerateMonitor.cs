// Decompiled with JetBrains decompiler
// Type: FramerateMonitor
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class FramerateMonitor : UserReportingMonitor
{
  private float duration;
  public float MaximumDurationInSeconds;
  public float MinimumFramerate;

  public FramerateMonitor()
  {
    this.MaximumDurationInSeconds = 10f;
    this.MinimumFramerate = 15f;
  }

  private void Update()
  {
    float deltaTime = Time.deltaTime;
    if (1.0 / (double) deltaTime < (double) this.MinimumFramerate)
      this.duration += deltaTime;
    else
      this.duration = 0.0f;
    if ((double) this.duration <= (double) this.MaximumDurationInSeconds)
      return;
    this.duration = 0.0f;
    this.Trigger();
  }
}
