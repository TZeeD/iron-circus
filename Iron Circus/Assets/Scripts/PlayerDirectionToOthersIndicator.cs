// Decompiled with JetBrains decompiler
// Type: PlayerDirectionToOthersIndicator
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class PlayerDirectionToOthersIndicator : MonoBehaviour
{
  private Material material;
  [SerializeField]
  private SpriteRenderer sprite;

  private void Awake() => this.material = this.sprite.material;

  public void SetColor(Color c) => this.sprite.color = c;

  public void SetLength(float units)
  {
    Vector2 size = this.sprite.size;
    float num = this.sprite.transform.localPosition.z * this.transform.lossyScale.x;
    float x = this.sprite.transform.lossyScale.x;
    size.y = (units - num) / x;
    this.sprite.size = size;
  }

  public void SetThickness(float t) => this.material.SetFloat("_Threshold", Mathf.Clamp01(1f - t));
}
