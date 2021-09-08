// Decompiled with JetBrains decompiler
// Type: BumperFloorSegment
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class BumperFloorSegment : MonoBehaviour
{
  public float rotationFwdMin = 45f;
  public float rotationFwdMax = 90f;
  public float rotationBackMin = 25f;
  public float rotationBackMax = 50f;
  public float angleMin = 30f;
  public float angleMax = 80f;
  public float minDurationFwd = 0.25f;
  public float maxDurationFwd = 0.45f;
  public float minDurationBack = 0.1f;
  public float maxDurationBack = 0.2f;
  private Material material;
  private float animCounter;
  private float animDirection = 1f;
  private float currentRotationPerSec;
  private float currentTargetAngle;
  private float currentAngle;
  private float currentDuration;

  private void Awake()
  {
    this.material = this.GetComponent<MeshRenderer>().material;
    this.currentAngle = Random.Range(this.angleMin, this.angleMax);
    this.StartAnimation(1f);
    this.Update();
  }

  private void Update()
  {
    this.animCounter = Mathf.Min(this.animCounter + Time.deltaTime / this.currentDuration, 1f);
    this.transform.Rotate(new Vector3(0.0f, 0.0f, this.currentRotationPerSec * Time.deltaTime));
    this.currentAngle = Mathf.Lerp(this.currentAngle, this.currentTargetAngle, 1f - Mathf.Pow(0.01f, Time.deltaTime));
    this.material.SetFloat("_MinAngle", 360f - this.currentAngle);
    if ((double) this.animCounter != 1.0)
      return;
    this.StartAnimation(this.animDirection * -1f);
  }

  private void StartAnimation(float direction)
  {
    this.animCounter = 0.0f;
    this.animDirection = direction;
    this.currentTargetAngle = Random.Range(this.angleMin, this.angleMax);
    float num;
    if ((double) direction > 0.0)
    {
      this.currentDuration = Random.Range(this.minDurationFwd, this.maxDurationFwd);
      num = -Random.Range(this.rotationFwdMin, this.rotationFwdMax);
    }
    else
    {
      this.currentDuration = Random.Range(this.minDurationBack, this.maxDurationBack);
      num = Random.Range(this.rotationBackMin, this.rotationBackMax);
    }
    this.currentRotationPerSec = num / this.currentDuration;
  }
}
