// Decompiled with JetBrains decompiler
// Type: SteelCircus.ScriptableObjects.MainMenuLightingConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.Rendering;

namespace SteelCircus.ScriptableObjects
{
  [CreateAssetMenu(fileName = "MainMenuLightingConfig", menuName = "SteelCircus/Configs/MainMenuLightingConfig")]
  public class MainMenuLightingConfig : ScriptableObject
  {
    public Material MainMenuSkybox;
    public Cubemap MainMenuReflectionProbe;
    public Material LobbySkybox;
    public Cubemap LobbyReflectionProbe;
    public Material GallerySkybox;
    public Cubemap GalleryReflectionProbe;
    public MainMenuLightingConfig.OnMenuLightingChangedEventHandler OnMenuLightingChanged;

    public void ApplyCustomLighting(Material skybox, Cubemap reflectionProbe)
    {
      RenderSettings.customReflection = reflectionProbe;
      RenderSettings.defaultReflectionMode = DefaultReflectionMode.Custom;
      RenderSettings.skybox = skybox;
      RenderSettings.ambientMode = AmbientMode.Skybox;
      DynamicGI.UpdateEnvironment();
    }

    public void ApplyLightingForMainMenu()
    {
      this.ApplyCustomLighting(this.MainMenuSkybox, this.MainMenuReflectionProbe);
      MainMenuLightingConfig.OnMenuLightingChangedEventHandler menuLightingChanged = this.OnMenuLightingChanged;
      if (menuLightingChanged == null)
        return;
      menuLightingChanged(MainMenuLightingType.MainMenu);
    }

    public void ApplyLightingForLobby()
    {
      this.ApplyCustomLighting(this.LobbySkybox, this.LobbyReflectionProbe);
      MainMenuLightingConfig.OnMenuLightingChangedEventHandler menuLightingChanged = this.OnMenuLightingChanged;
      if (menuLightingChanged == null)
        return;
      menuLightingChanged(MainMenuLightingType.Lobby);
    }

    public void ApplyLightingForGallery()
    {
      this.ApplyCustomLighting(this.GallerySkybox, this.GalleryReflectionProbe);
      MainMenuLightingConfig.OnMenuLightingChangedEventHandler menuLightingChanged = this.OnMenuLightingChanged;
      if (menuLightingChanged == null)
        return;
      menuLightingChanged(MainMenuLightingType.Gallery);
    }

    public delegate void OnMenuLightingChangedEventHandler(MainMenuLightingType type);
  }
}
