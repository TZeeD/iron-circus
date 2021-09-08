// Decompiled with JetBrains decompiler
// Type: UnityEngine.PostProcessing.FogModel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace UnityEngine.PostProcessing
{
  [Serializable]
  public class FogModel : PostProcessingModel
  {
    [SerializeField]
    private FogModel.Settings m_Settings = FogModel.Settings.defaultSettings;

    public FogModel.Settings settings
    {
      get => this.m_Settings;
      set => this.m_Settings = value;
    }

    public override void Reset() => this.m_Settings = FogModel.Settings.defaultSettings;

    [Serializable]
    public struct Settings
    {
      [Tooltip("Should the fog affect the skybox?")]
      public bool excludeSkybox;

      public static FogModel.Settings defaultSettings => new FogModel.Settings()
      {
        excludeSkybox = true
      };
    }
  }
}
