// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.DisplaySetting
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SteelCircus.UI.OptionsUI
{
  public struct DisplaySetting : ISetting
  {
    public Resolution resolution;
    public FullScreenMode fullScreenMode;

    public DisplaySetting(Resolution resolution, FullScreenMode fullScreenMode)
    {
      this.resolution = resolution;
      this.fullScreenMode = fullScreenMode;
    }
  }
}
