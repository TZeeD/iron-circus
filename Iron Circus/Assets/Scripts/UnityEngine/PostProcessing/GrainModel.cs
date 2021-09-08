// Decompiled with JetBrains decompiler
// Type: UnityEngine.PostProcessing.GrainModel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace UnityEngine.PostProcessing
{
  [Serializable]
  public class GrainModel : PostProcessingModel
  {
    [SerializeField]
    private GrainModel.Settings m_Settings = GrainModel.Settings.defaultSettings;

    public GrainModel.Settings settings
    {
      get => this.m_Settings;
      set => this.m_Settings = value;
    }

    public override void Reset() => this.m_Settings = GrainModel.Settings.defaultSettings;

    [Serializable]
    public struct Settings
    {
      [Tooltip("Enable the use of colored grain.")]
      public bool colored;
      [Range(0.0f, 1f)]
      [Tooltip("Grain strength. Higher means more visible grain.")]
      public float intensity;
      [Range(0.3f, 3f)]
      [Tooltip("Grain particle size.")]
      public float size;
      [Range(0.0f, 1f)]
      [Tooltip("Controls the noisiness response curve based on scene luminance. Lower values mean less noise in dark areas.")]
      public float luminanceContribution;

      public static GrainModel.Settings defaultSettings => new GrainModel.Settings()
      {
        colored = true,
        intensity = 0.5f,
        size = 1f,
        luminanceContribution = 0.8f
      };
    }
  }
}
