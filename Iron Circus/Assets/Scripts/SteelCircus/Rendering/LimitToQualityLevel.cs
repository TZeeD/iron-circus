// Decompiled with JetBrains decompiler
// Type: SteelCircus.Rendering.LimitToQualityLevel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SharedWithServer.ScEvents;
using SteelCircus.Core;
using SteelCircus.Core.Services;
using UnityEngine;

namespace SteelCircus.Rendering
{
  public class LimitToQualityLevel : MonoBehaviour
  {
    public LimitToQualityLevel.Mode mode;
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
        Events.Global.OnEventQualitySettingsChanged -= new Events.EventQualitySettingsChanged(this.OnQualityLevelChanged);
      else if (this.mode == LimitToQualityLevel.Mode.DisableBelowMinQualityLevel)
        this.gameObject.SetActive(ImiServices.Instance.QualityManager.CurrentRenderSettings.vfx >= this.minQualityLevel);
      else
        this.gameObject.SetActive(ImiServices.Instance.QualityManager.CurrentRenderSettings.vfx <= this.minQualityLevel);
    }

    public enum Mode
    {
      DisableBelowMinQualityLevel,
      DisableAboveMinQualityLevel,
    }
  }
}
