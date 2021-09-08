// Decompiled with JetBrains decompiler
// Type: SwitchMenuSkyboxLighting
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SteelCircus.ScriptableObjects;
using UnityEngine;

public class SwitchMenuSkyboxLighting : MonoBehaviour
{
  [SerializeField]
  private MainMenuLightingType type;
  [Header("Only for Custom Lighting Mode.")]
  [SerializeField]
  private Material customSkyBox;
  [SerializeField]
  private Cubemap customReflectionProbe;
  private static MainMenuLightingConfig config;

  private void OnEnable()
  {
    if ((Object) SwitchMenuSkyboxLighting.config == (Object) null)
    {
      Log.Debug("Loading MainMenuLightingConfig to switch Lighting.");
      SwitchMenuSkyboxLighting.config = Resources.Load<MainMenuLightingConfig>("Configs/Visual/MainMenuLightingConfig");
    }
    Log.Debug(string.Format("Applying Lighting for {0}.", (object) this.type));
    switch (this.type)
    {
      case MainMenuLightingType.MainMenu:
        SwitchMenuSkyboxLighting.config.ApplyLightingForMainMenu();
        break;
      case MainMenuLightingType.Gallery:
        SwitchMenuSkyboxLighting.config.ApplyLightingForGallery();
        break;
      case MainMenuLightingType.Lobby:
        SwitchMenuSkyboxLighting.config.ApplyLightingForLobby();
        break;
      case MainMenuLightingType.Custom:
        SwitchMenuSkyboxLighting.config.ApplyCustomLighting(this.customSkyBox, this.customReflectionProbe);
        break;
      default:
        SwitchMenuSkyboxLighting.config.ApplyLightingForMainMenu();
        break;
    }
  }
}
