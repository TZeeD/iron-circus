// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OptionsUI.CustomLobbySettings
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;

namespace SteelCircus.UI.OptionsUI
{
  public class CustomLobbySettings : Observer
  {
    private List<ObservedSetting> settings;

    private void OnEnable()
    {
      this.settings = new List<ObservedSetting>();
      foreach (ObservedSetting componentsInChild in this.GetComponentsInChildren<ObservedSetting>(true))
      {
        componentsInChild.RegisterObserver((Observer) this);
        this.settings.Add(componentsInChild);
      }
    }

    public void ApplySettings()
    {
      foreach (ObservedSetting setting in this.settings)
        setting.ApplySetting(setting.GetCurrentSetting());
    }

    public override void OnNotify(ISetting setting, Settings.SettingType type)
    {
    }
  }
}
