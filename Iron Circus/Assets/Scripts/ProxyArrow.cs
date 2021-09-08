// Decompiled with JetBrains decompiler
// Type: ProxyArrow
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class ProxyArrow : MonoBehaviour
{
  public float lifeTime = 5f;
  public float counter;
  public Color startColor = Color.red;
  public Color endColor = Color.yellow;
  public float startSize = 1f;
  public float endSize = 0.5f;

  public void Init()
  {
    this.counter = 0.0f;
    this.UpdateVisuals();
  }

  public void UpdateVisuals() => this.transform.localScale = Vector3.one * Mathf.Lerp(this.startSize, this.endSize, Mathf.Clamp01(this.counter / this.lifeTime));
}
