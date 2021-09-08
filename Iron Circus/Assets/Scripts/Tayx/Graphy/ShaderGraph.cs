// Decompiled with JetBrains decompiler
// Type: Tayx.Graphy.ShaderGraph
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace Tayx.Graphy
{
  public class ShaderGraph
  {
    public const int ArrayMaxSizeFull = 512;
    public const int ArrayMaxSizeLight = 128;
    public int ArrayMaxSize = 128;
    public Image Image;
    private string Name = "GraphValues";
    private string Name_Length = "GraphValues_Length";
    public float[] Array;
    public float Average;
    private int averagePropertyId;
    public float midThreshold;
    public float highThreshold;
    private int midThresholdPropertyId;
    private int highThresholdPropertyId;
    public Color lowColor;
    public Color midColor;
    public Color highColor;
    private int lowColorPropertyId;
    private int midColorPropertyId;
    private int highColorPropertyId;

    public void InitializeShader()
    {
      this.Image.material.SetFloatArray(this.Name, new float[this.ArrayMaxSize]);
      this.averagePropertyId = Shader.PropertyToID("Average");
      this.midThresholdPropertyId = Shader.PropertyToID("_MidThreshold");
      this.highThresholdPropertyId = Shader.PropertyToID("_HighThreshold");
      this.lowColorPropertyId = Shader.PropertyToID("_LowColor");
      this.midColorPropertyId = Shader.PropertyToID("_MidColor");
      this.highColorPropertyId = Shader.PropertyToID("_HighColor");
    }

    public void UpdateArray() => this.Image.material.SetInt(this.Name_Length, this.Array.Length);

    public void UpdateAverage() => this.Image.material.SetFloat(this.averagePropertyId, this.Average);

    public void UpdateThresholds()
    {
      this.Image.material.SetFloat(this.midThresholdPropertyId, this.midThreshold);
      this.Image.material.SetFloat(this.highThresholdPropertyId, this.highThreshold);
    }

    public void UpdateColors()
    {
      this.Image.material.SetColor(this.lowColorPropertyId, this.lowColor);
      this.Image.material.SetColor(this.midColorPropertyId, this.midColor);
      this.Image.material.SetColor(this.highColorPropertyId, this.highColor);
    }

    public void UpdatePoints() => this.Image.material.SetFloatArray(this.Name, this.Array);
  }
}
