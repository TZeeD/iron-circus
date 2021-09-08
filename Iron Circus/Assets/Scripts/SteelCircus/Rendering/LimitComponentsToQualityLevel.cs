// Decompiled with JetBrains decompiler
// Type: SteelCircus.Rendering.LimitComponentsToQualityLevel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SharedWithServer.ScEvents;
using SteelCircus.Core;
using SteelCircus.Core.Services;
using System.Collections.Generic;
using UnityEngine;

namespace SteelCircus.Rendering
{
  public class LimitComponentsToQualityLevel : MonoBehaviour
  {
    [SerializeField]
    private List<MonoBehaviour> components = new List<MonoBehaviour>();
    public LimitComponentsToQualityLevel.Mode mode;
    [SerializeField]
    private LimitComponentsToQualityLevel.SettingType settingType;
    public QualityManager.Level minQualityLevel = QualityManager.Level.Low;

    private void Start()
    {
      Events.Global.OnEventQualitySettingsChanged += new Events.EventQualitySettingsChanged(this.OnQualityLevelChanged);
      this.HandleQualityChange();
    }

    private void OnDestroy() => Events.Global.OnEventQualitySettingsChanged -= new Events.EventQualitySettingsChanged(this.OnQualityLevelChanged);

    private void OnQualityLevelChanged(QualityManager.RenderSettings newRenderSettings) => this.HandleQualityChange();

    private void HandleQualityChange()
    {
      if ((Object) this.gameObject == (Object) null)
      {
        Events.Global.OnEventQualitySettingsChanged -= new Events.EventQualitySettingsChanged(this.OnQualityLevelChanged);
      }
      else
      {
        QualityManager.RenderSettings currentRenderSettings = ImiServices.Instance.QualityManager.CurrentRenderSettings;
        QualityManager.Level level;
        switch (this.settingType)
        {
          case LimitComponentsToQualityLevel.SettingType.Vfx:
            level = currentRenderSettings.vfx;
            break;
          case LimitComponentsToQualityLevel.SettingType.ShaderQuality:
            level = currentRenderSettings.shaderQuality;
            break;
          case LimitComponentsToQualityLevel.SettingType.PostProcessing:
            level = currentRenderSettings.postProcessing;
            break;
          default:
            level = currentRenderSettings.miscSettings;
            break;
        }
        if (this.mode == LimitComponentsToQualityLevel.Mode.DisableBelowMinQualityLevel)
        {
          foreach (MonoBehaviour component in this.components)
          {
            if ((Object) component != (Object) null)
              component.enabled = level >= this.minQualityLevel;
          }
        }
        else
        {
          foreach (MonoBehaviour component in this.components)
          {
            if ((Object) component != (Object) null)
              component.enabled = level <= this.minQualityLevel;
          }
        }
      }
    }

    public enum SettingType
    {
      Vfx,
      ShaderQuality,
      PostProcessing,
      Misc,
    }

    public enum Mode
    {
      DisableBelowMinQualityLevel,
      DisableAboveMinQualityLevel,
    }
  }
}
