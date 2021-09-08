// Decompiled with JetBrains decompiler
// Type: UIWiggle
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class UIWiggle : MonoBehaviour
{
  [Header("Rotation")]
  [Range(0.0f, 10f)]
  [SerializeField]
  private float wiggleAmountRotation;
  [Range(0.1f, 30f)]
  [SerializeField]
  private float wiggleFrequencyRotation = 1f;
  [Header("Scale")]
  [Range(0.0f, 4f)]
  [SerializeField]
  private float wiggleAmountScale;
  [SerializeField]
  private float scaleMultiplier = 1f;
  [Range(0.1f, 30f)]
  [SerializeField]
  private float wiggleFrequencyScale = 1f;
  [Header("Position")]
  [Range(0.0f, 10f)]
  [SerializeField]
  private float wiggleAmountPositionX;
  [Range(0.1f, 30f)]
  [SerializeField]
  private float wiggleFrequencyPositionX = 1f;
  [Range(0.0f, 10f)]
  [SerializeField]
  private float wiggleAmountPositionY;
  [Range(0.1f, 30f)]
  [SerializeField]
  private float wiggleFrequencyPositionY = 1f;
  private float startRotationZ;
  private float startScale;
  private float startPositionX;
  private float startPositionY;
  private float currentWiggleRotation;
  private float currentWiggleScale;
  private float currentWigglePositionX;
  private float currentWigglePositionY;
  private float wiggleStartTime;

  private void Start()
  {
    this.wiggleStartTime = Time.time;
    this.startRotationZ = this.transform.rotation.z;
    this.startPositionX = this.transform.localPosition.x;
    this.startPositionY = this.transform.localPosition.y;
    this.startScale = (float) (((double) this.transform.localScale.x + (double) this.transform.localScale.y) / 2.0);
  }

  private void Update()
  {
    if (!this.gameObject.activeInHierarchy)
      return;
    if ((double) this.wiggleAmountRotation > 0.05)
    {
      this.currentWiggleRotation = Mathf.Sin((float) (((double) Time.time - (double) this.wiggleStartTime) * ((double) this.wiggleFrequencyRotation * 4.0))) * this.wiggleAmountRotation;
      this.transform.rotation = Quaternion.Euler(new Vector3(this.transform.rotation.x, this.transform.rotation.y, this.startRotationZ + this.currentWiggleRotation));
    }
    else
      this.transform.rotation = Quaternion.Euler(new Vector3(this.transform.rotation.x, this.transform.rotation.y, this.startRotationZ));
    if ((double) this.wiggleAmountScale > 0.05)
    {
      this.currentWiggleScale = (float) ((double) Mathf.Sin((float) (((double) Time.time - (double) this.wiggleStartTime) * ((double) this.wiggleFrequencyScale * 4.0))) * (double) this.wiggleAmountScale / 10.0);
      this.transform.localScale = new Vector3(this.startScale * this.scaleMultiplier + this.currentWiggleScale, this.startScale * this.scaleMultiplier + this.currentWiggleScale, this.startScale + this.currentWiggleScale);
    }
    else
      this.transform.localScale = new Vector3(this.startScale * this.scaleMultiplier, this.startScale * this.scaleMultiplier, this.startScale);
    this.currentWigglePositionX = (double) this.wiggleAmountPositionX <= 0.05 ? this.startPositionX : this.startPositionX + (float) ((double) Mathf.Sin((float) (((double) Time.time - (double) this.wiggleStartTime) * ((double) this.wiggleFrequencyPositionX * 4.0))) * (double) this.wiggleAmountPositionX * 2.0);
    this.currentWigglePositionY = (double) this.wiggleAmountPositionY <= 0.05 ? this.startPositionY : this.startPositionY + (float) ((double) Mathf.Sin((float) (((double) Time.time - (double) this.wiggleStartTime) * ((double) this.wiggleFrequencyPositionY * 4.0))) * (double) this.wiggleAmountPositionY * 2.0);
    this.transform.localPosition = new Vector3(this.currentWigglePositionX, this.currentWigglePositionY, this.transform.localPosition.z);
  }
}
