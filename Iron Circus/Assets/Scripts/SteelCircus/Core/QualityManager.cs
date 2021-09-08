// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.QualityManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using System;
using UnityEngine;
using UnityEngine.Rendering;

namespace SteelCircus.Core
{
  public class QualityManager
  {
    private QualityManager.State state;
    private QualityManager.RenderSettings currentRenderSettings;
    private QualityManager.FrameRateSettings currentFrameRateSettings;

    public QualityManager.RenderSettings CurrentRenderSettings => this.currentRenderSettings;

    public QualityManager.FrameRateSettings CurrentFrameRateSettings => this.currentFrameRateSettings;

    public QualityManager(ImiServicesHelper helper)
    {
      Events.Global.OnEventMetaStateChanged += new Events.EventMetaStateChanged(this.OnMetaStateChanged);
      this.state = QualityManager.State.Menu;
      this.LoadSettingsFromPlayerPrefs();
      this.SetupMenu();
    }

    public void SetRenderSettings(QualityManager.RenderSettings settings)
    {
      this.currentRenderSettings = settings;
      this.ApplyCurrentRenderSettings();
      Log.Debug("Setting Render Settings: " + settings.ToString());
    }

    public void SetFrameRateSettings(QualityManager.FrameRateSettings settings)
    {
      this.currentFrameRateSettings = settings;
      this.ApplyCurrentFpsSettings();
      Log.Debug("Setting FrameRate Settings: " + settings.ToString());
    }

    public QualityManager.RenderSettings GetPreset(QualityManager.Level level)
    {
      QualityManager.RenderSettings renderSettings = new QualityManager.RenderSettings();
      renderSettings.baseQuality = level;
      renderSettings.miscSettings = level;
      renderSettings.vfx = level;
      switch (level)
      {
        case QualityManager.Level.Lowest:
          renderSettings.antialiasing = QualityManager.Level.Lowest;
          renderSettings.shaderQuality = QualityManager.Level.Lowest;
          renderSettings.postProcessing = QualityManager.Level.Lowest;
          break;
        case QualityManager.Level.Low:
          renderSettings.antialiasing = QualityManager.Level.Lowest;
          renderSettings.shaderQuality = QualityManager.Level.Low;
          renderSettings.postProcessing = QualityManager.Level.Lowest;
          break;
        case QualityManager.Level.Medium:
          renderSettings.antialiasing = QualityManager.Level.Low;
          renderSettings.shaderQuality = QualityManager.Level.Low;
          renderSettings.postProcessing = QualityManager.Level.Low;
          break;
        case QualityManager.Level.High:
          renderSettings.antialiasing = QualityManager.Level.Medium;
          renderSettings.shaderQuality = QualityManager.Level.Low;
          renderSettings.postProcessing = QualityManager.Level.Low;
          break;
      }
      return renderSettings;
    }

    public void StoreSettingsInPlayerPrefs()
    {
      PlayerPrefs.SetInt("quality_vsync", this.currentFrameRateSettings.vsync ? 1 : 0);
      PlayerPrefs.SetInt("quality_fpsCap", this.currentFrameRateSettings.fpsCap ? 1 : 0);
      PlayerPrefs.SetInt("quality_fpsCapLimit", this.currentFrameRateSettings.fpsCapLimit);
      PlayerPrefs.SetInt("quality_baseQuality", (int) this.currentRenderSettings.baseQuality);
      PlayerPrefs.SetInt("quality_vfx", (int) this.currentRenderSettings.vfx);
      PlayerPrefs.SetInt("quality_shaderQuality", (int) this.currentRenderSettings.shaderQuality);
      PlayerPrefs.SetInt("quality_postProcessing", (int) this.currentRenderSettings.postProcessing);
      PlayerPrefs.SetInt("quality_antialiasing", (int) this.currentRenderSettings.antialiasing);
      PlayerPrefs.SetInt("quality_miscSettings", (int) this.currentRenderSettings.miscSettings);
      PlayerPrefs.Save();
    }

    public void LoadSettingsFromPlayerPrefs()
    {
      if (!PlayerPrefs.HasKey("quality_baseQuality"))
      {
        this.FirstTimeSetup();
      }
      else
      {
        try
        {
          QualityManager.FrameRateSettings settings1;
          settings1.vsync = PlayerPrefs.GetInt("quality_vsync") == 1;
          settings1.fpsCap = PlayerPrefs.GetInt("quality_fpsCap") == 1;
          settings1.fpsCapLimit = PlayerPrefs.GetInt("quality_fpsCapLimit");
          QualityManager.RenderSettings settings2;
          settings2.baseQuality = (QualityManager.Level) PlayerPrefs.GetInt("quality_baseQuality");
          settings2.vfx = (QualityManager.Level) PlayerPrefs.GetInt("quality_vfx");
          settings2.shaderQuality = (QualityManager.Level) PlayerPrefs.GetInt("quality_shaderQuality");
          settings2.postProcessing = (QualityManager.Level) PlayerPrefs.GetInt("quality_postProcessing");
          settings2.antialiasing = (QualityManager.Level) PlayerPrefs.GetInt("quality_antialiasing");
          settings2.miscSettings = (QualityManager.Level) PlayerPrefs.GetInt("quality_miscSettings");
          this.SetFrameRateSettings(settings1);
          this.SetRenderSettings(settings2);
        }
        catch (Exception ex)
        {
          Log.Error("Exception loading Quality Settings from Player Prefs. Initializing new settings. Error: " + ex.ToString());
          this.FirstTimeSetup();
        }
      }
    }

    private void FirstTimeSetup()
    {
      QualityManager.FrameRateSettings settings = new QualityManager.FrameRateSettings();
      settings.vsync = false;
      settings.fpsCap = true;
      settings.fpsCapLimit = 90;
      QualityManager.RenderSettings preset = this.GetPreset(this.GetDefaultQualityLevelForSystem());
      this.SetFrameRateSettings(settings);
      this.SetRenderSettings(preset);
      this.StoreSettingsInPlayerPrefs();
    }

    private QualityManager.Level GetDefaultQualityLevelForSystem()
    {
      string upper = SystemInfo.graphicsDeviceName.ToUpper();
      float num1 = (float) SystemInfo.graphicsMemorySize / 1024f;
      if (upper.Contains("NVIDIA"))
      {
        if (upper.Contains("RTX"))
          return QualityManager.Level.High;
        if (upper.Contains("GTX"))
        {
          int startIndex = upper.IndexOf("GTX") + 4;
          int num2 = upper.IndexOf(" ", startIndex);
          if (num2 == -1)
            num2 = upper.Length;
          int result;
          if (int.TryParse(upper.Substring(startIndex, num2 - startIndex), out result) && (result >= 1060 || result >= 970))
            return QualityManager.Level.Medium;
        }
      }
      else if ((upper.Contains("AMD") || upper.Contains("RADEON")) && upper.Contains("RX"))
        return QualityManager.Level.Medium;
      return (double) num1 > 2.5 ? QualityManager.Level.Low : QualityManager.Level.Lowest;
    }

    private void OnMetaStateChanged(in MetaState metaState)
    {
      if (metaState == MetaState.Game)
        this.SetupGame();
      else
        this.SetupMenu();
    }

    private void ApplyCurrentRenderSettings()
    {
      QualityManager.Level miscSettings = this.currentRenderSettings.miscSettings;
      this.SetGraphicsTier();
      QualitySettings.SetQualityLevel((int) (3 - miscSettings), true);
      this.SetShadowCascades(miscSettings);
      this.SetShaderQuality();
      this.SetAntialiasing(this.currentRenderSettings.antialiasing);
      this.ApplyCurrentFpsSettings();
      Events.Global.FireEventQualitySettingsChanged(this.currentRenderSettings);
    }

    private void SetGraphicsTier()
    {
      if (this.state == QualityManager.State.Menu)
      {
        Graphics.activeTier = GraphicsTier.Tier3;
      }
      else
      {
        switch (this.currentRenderSettings.miscSettings)
        {
          case QualityManager.Level.Lowest:
            Graphics.activeTier = GraphicsTier.Tier1;
            break;
          case QualityManager.Level.Low:
            Graphics.activeTier = GraphicsTier.Tier2;
            break;
          case QualityManager.Level.Medium:
            Graphics.activeTier = GraphicsTier.Tier3;
            break;
          case QualityManager.Level.High:
            Graphics.activeTier = GraphicsTier.Tier3;
            break;
        }
      }
    }

    private void ApplyCurrentFpsSettings()
    {
      this.SetVSync(this.currentFrameRateSettings.vsync);
      this.SetFpsCap();
    }

    private void SetShadowCascades(QualityManager.Level currLevel)
    {
      if (this.state == QualityManager.State.Menu)
      {
        if (currLevel <= QualityManager.Level.Low)
          QualitySettings.shadowCascades = 2;
        else
          QualitySettings.shadowCascades = 4;
      }
      else
        QualitySettings.shadowCascades = 1;
    }

    private void SetVSync(bool on) => QualitySettings.vSyncCount = on ? 1 : 0;

    private void SetShaderQuality() => Shader.globalMaximumLOD = this.GetShaderLOD();

    public int GetShaderLOD() => this.currentRenderSettings.shaderQuality != QualityManager.Level.Lowest ? 2000 : 1000;

    private void SetAntialiasing(QualityManager.Level currLevel)
    {
      if (currLevel != QualityManager.Level.Lowest)
      {
        if (currLevel == QualityManager.Level.Low)
          QualitySettings.antiAliasing = 2;
        else
          QualitySettings.antiAliasing = 4;
      }
      else
        QualitySettings.antiAliasing = 0;
    }

    private void SetFpsCap()
    {
      Log.Debug(string.Format("fps cap? {0} limit: {1}", (object) this.currentFrameRateSettings.fpsCap, (object) this.currentFrameRateSettings.fpsCapLimit));
      if (!this.currentFrameRateSettings.fpsCap)
        Application.targetFrameRate = -1;
      else if (this.state == QualityManager.State.Menu)
      {
        Application.targetFrameRate = 200;
      }
      else
      {
        Log.Debug(string.Format("Limiting Frame Rate to {0}", (object) this.currentFrameRateSettings.fpsCapLimit));
        Application.targetFrameRate = this.currentFrameRateSettings.fpsCapLimit;
      }
    }

    private void SetupMenu()
    {
      if (this.state == QualityManager.State.Menu)
        return;
      this.state = QualityManager.State.Menu;
      Log.Debug("QualityManager: Setting up for menu.");
      this.SetShadowCascades(this.currentRenderSettings.miscSettings);
      this.SetFpsCap();
      this.SetGraphicsTier();
    }

    private void SetupGame()
    {
      if (this.state == QualityManager.State.Game)
        return;
      this.state = QualityManager.State.Game;
      Log.Debug("QualityManager: Setting up for game.");
      this.SetShadowCascades(this.currentRenderSettings.miscSettings);
      this.SetFpsCap();
      this.SetGraphicsTier();
    }

    public enum Level
    {
      Lowest,
      Low,
      Medium,
      High,
    }

    public struct RenderSettings
    {
      public QualityManager.Level baseQuality;
      public QualityManager.Level vfx;
      public QualityManager.Level shaderQuality;
      public QualityManager.Level postProcessing;
      public QualityManager.Level antialiasing;
      public QualityManager.Level miscSettings;

      public override string ToString() => string.Format("RenderSettings: baseQuality {0} vfx {1} shaderQuality {2} postProcessing {3} antialiasing {4} miscSettings {5}", (object) this.baseQuality, (object) this.vfx, (object) this.shaderQuality, (object) this.postProcessing, (object) this.antialiasing, (object) this.miscSettings);
    }

    public struct FrameRateSettings
    {
      public bool vsync;
      public bool fpsCap;
      public int fpsCapLimit;

      public override string ToString() => string.Format("FrameRateSettings: vsync {0} fpsCap {1} fpsCapLimit {2}", (object) this.vsync, (object) this.fpsCap, (object) this.fpsCapLimit);
    }

    private enum State
    {
      Menu,
      Game,
    }
  }
}
