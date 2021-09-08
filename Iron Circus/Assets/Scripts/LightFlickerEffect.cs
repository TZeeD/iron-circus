// Decompiled with JetBrains decompiler
// Type: LightFlickerEffect
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using UnityEngine;

public class LightFlickerEffect : MonoBehaviour
{
  [Tooltip("External light to flicker; you can leave this null if you attach script to a light")]
  public Light light;
  [Tooltip("Minimum random light intensity")]
  public float minIntensity;
  [Tooltip("Maximum random light intensity")]
  public float maxIntensity = 1f;
  public float minStepTime;
  public float maxStepTime;
  private float currentStepTime;
  private float timeSinceLastTick;
  private float targetVal;
  private float sourceVal;
  private Queue<float> smoothQueue;

  private void Start()
  {
    if ((Object) this.light == (Object) null)
      this.light = this.GetComponent<Light>();
    this.sourceVal = this.light.intensity;
  }

  private void Update()
  {
    if ((Object) this.light == (Object) null || !this.light.isActiveAndEnabled)
      return;
    this.timeSinceLastTick += Time.deltaTime;
    if ((double) this.timeSinceLastTick >= (double) this.currentStepTime)
    {
      this.timeSinceLastTick -= this.currentStepTime;
      this.sourceVal = this.targetVal;
      this.targetVal = Random.Range(this.minIntensity, this.maxIntensity);
      this.currentStepTime = Random.Range(this.minStepTime, this.maxStepTime);
    }
    double targetVal = (double) this.targetVal;
    double intensity = (double) this.light.intensity;
    this.light.intensity = Mathf.SmoothStep(this.sourceVal, this.targetVal, this.timeSinceLastTick / this.currentStepTime);
  }
}
