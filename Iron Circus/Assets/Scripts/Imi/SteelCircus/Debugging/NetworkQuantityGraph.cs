// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Debugging.NetworkQuantityGraph
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Tayx.Graphy;
using UnityEngine;
using UnityEngine.UI;

namespace Imi.SteelCircus.Debugging
{
  public class NetworkQuantityGraph : MonoBehaviour
  {
    public Image graphImage;
    public Text quantityValueText;
    public int graphResolution = 150;
    public float lowThreshold = 50f;
    public float highThreshold = 150f;
    public bool fitHeight = true;
    public float maxValue;
    private ShaderGraph graphImageProperies;
    private float lastValue;
    private float[] data;

    public void OnEnable()
    {
      this.graphImageProperies = new ShaderGraph();
      this.graphImageProperies.Image = this.graphImage;
      this.graphImageProperies.Image.material = new Material(this.graphImage.material);
      this.UpdateGraphParameters();
    }

    public void UpdateGraphParameters()
    {
      this.data = new float[this.graphResolution];
      this.graphImageProperies.ArrayMaxSize = 512;
      this.graphImageProperies.InitializeShader();
      this.graphImageProperies.Array = new float[this.graphResolution];
      this.data = new float[this.graphResolution];
      for (int index = 0; index < this.graphResolution; ++index)
        this.graphImageProperies.Array[index] = 0.0f;
      this.graphImageProperies.UpdateArray();
    }

    public void UpdateGraph(float newValue, string formatString)
    {
      this.quantityValueText.text = string.Format(formatString, (object) newValue);
      this.lastValue = newValue;
      float num = 0.0f;
      for (int index = 0; index <= this.graphResolution - 1; ++index)
      {
        this.data[index] = index != this.graphResolution - 1 ? this.data[index + 1] : this.lastValue;
        if ((double) num < (double) this.data[index])
          num = this.data[index];
      }
      if (this.fitHeight)
        this.maxValue = num;
      for (int index = 0; index < this.graphResolution; ++index)
        this.graphImageProperies.Array[index] = this.data[index] / this.maxValue;
      this.graphImageProperies.UpdatePoints();
      this.graphImageProperies.Average = this.lastValue / this.maxValue;
      this.graphImageProperies.UpdateAverage();
      this.graphImageProperies.midThreshold = this.lowThreshold / this.maxValue;
      this.graphImageProperies.highThreshold = this.highThreshold / this.maxValue;
      this.graphImageProperies.UpdateThresholds();
    }
  }
}
