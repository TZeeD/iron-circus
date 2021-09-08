// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.GraphicsTierSetting
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core;

namespace SteelCircus.UI.OptionsUI
{
  public struct GraphicsTierSetting : ISetting
  {
    public QualityManager.RenderSettings renderSettings;
    public QualityManager.FrameRateSettings frameRateSettings;

    public GraphicsTierSetting(
      QualityManager.RenderSettings renderSettings,
      QualityManager.FrameRateSettings frameRateSettings)
    {
      this.renderSettings = renderSettings;
      this.frameRateSettings = frameRateSettings;
    }
  }
}
