// Decompiled with JetBrains decompiler
// Type: UnityEngine.PostProcessing.DitheringModel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Runtime.InteropServices;

namespace UnityEngine.PostProcessing
{
  [Serializable]
  public class DitheringModel : PostProcessingModel
  {
    [SerializeField]
    private DitheringModel.Settings m_Settings = DitheringModel.Settings.defaultSettings;

    public DitheringModel.Settings settings
    {
      get => this.m_Settings;
      set => this.m_Settings = value;
    }

    public override void Reset() => this.m_Settings = DitheringModel.Settings.defaultSettings;

    [Serializable]
    [StructLayout(LayoutKind.Sequential, Size = 1)]
    public struct Settings
    {
      public static DitheringModel.Settings defaultSettings => new DitheringModel.Settings();
    }
  }
}
