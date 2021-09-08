// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScriptableObjects.FloorLitMaterialConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using UnityEngine;

namespace Imi.SteelCircus.ScriptableObjects
{
  [CreateAssetMenu(fileName = "FloorLitMaterialConfig", menuName = "SteelCircus/Configs/FloorLitMaterialConfig")]
  public class FloorLitMaterialConfig : ScriptableObject
  {
    [Header("Noise")]
    [Tooltip("A texture containing noise")]
    public Texture2D _FloorLightNoise;
    [Tooltip("Noise Finetuning Params (change if patterns emerge). First two in the 100s, second two in the 10s.")]
    public Vector4 _FloorLightNoiseParams;
    [Header("Floor Emission Params")]
    [Tooltip("Intensity of floor light.")]
    public float _FloorLightEmissionScale;
    [Tooltip("Range of floor light in meters.")]
    public float _FloorLightEmissionRange;
    [Tooltip("A visual hack: decrease regular light where floor light is active. 0 means no effect, 1 means mesh is completely dark near floor")]
    public float _FloorLightDarkensRegularLight;
    [Tooltip("Integer number of samples per pixel. More = better visuals but more GPU heavy")]
    public float _FloorLightRaymarchSamples;
    [Tooltip("Max angle at which the light from floor is sent out, in radians.")]
    public float _FloorLightScatterAngle;
    private static readonly int _FloorLightNoiseID = Shader.PropertyToID(nameof (_FloorLightNoise));
    private static readonly int _FloorLightNoiseParamsID = Shader.PropertyToID(nameof (_FloorLightNoiseParams));
    private static readonly int _FloorLightEmissionScaleID = Shader.PropertyToID(nameof (_FloorLightEmissionScale));
    private static readonly int _FloorLightEmissionRangeID = Shader.PropertyToID(nameof (_FloorLightEmissionRange));
    private static readonly int _FloorLightDarkensRegularLightID = Shader.PropertyToID(nameof (_FloorLightDarkensRegularLight));
    private static readonly int _FloorLightRaymarchSamplesID = Shader.PropertyToID(nameof (_FloorLightRaymarchSamples));
    private static readonly int _FloorLightScatterAngleID = Shader.PropertyToID(nameof (_FloorLightScatterAngle));

    public void SetGlobalShaderProps()
    {
      Log.Debug("Applying Floor Lighting Properties");
      Shader.SetGlobalTexture(FloorLitMaterialConfig._FloorLightNoiseID, (Texture) this._FloorLightNoise);
      Shader.SetGlobalVector(FloorLitMaterialConfig._FloorLightNoiseParamsID, this._FloorLightNoiseParams);
      Shader.SetGlobalFloat(FloorLitMaterialConfig._FloorLightEmissionScaleID, this._FloorLightEmissionScale);
      Shader.SetGlobalFloat(FloorLitMaterialConfig._FloorLightEmissionRangeID, this._FloorLightEmissionRange);
      Shader.SetGlobalFloat(FloorLitMaterialConfig._FloorLightDarkensRegularLightID, this._FloorLightDarkensRegularLight);
      Shader.SetGlobalFloat(FloorLitMaterialConfig._FloorLightRaymarchSamplesID, this._FloorLightRaymarchSamples);
      Shader.SetGlobalFloat(FloorLitMaterialConfig._FloorLightScatterAngleID, this._FloorLightScatterAngle);
    }

    public static void DisableFloorLighting()
    {
      Log.Debug("Disabling Floor Lighting");
      Shader.SetGlobalVector("_FloorDim", new Vector4(1f, 1f, 1f, 1f));
      Vector4 vector4 = new Vector4(1f, 1f, 0.0f, 0.0f);
      Shader.SetGlobalVector(FloorLitMaterialConfig._FloorLightNoiseParamsID, new Vector4(1f, 1f, 1f, 1f));
      Shader.SetGlobalVector("_FloorTex_ST", vector4);
      Shader.SetGlobalFloat(FloorLitMaterialConfig._FloorLightRaymarchSamplesID, 2f);
      Shader.SetGlobalFloat(FloorLitMaterialConfig._FloorLightDarkensRegularLightID, 0.0f);
      Shader.SetGlobalFloat(FloorLitMaterialConfig._FloorLightEmissionRangeID, 1E-05f);
      Shader.SetGlobalFloat(FloorLitMaterialConfig._FloorLightEmissionScaleID, 0.0f);
    }
  }
}
