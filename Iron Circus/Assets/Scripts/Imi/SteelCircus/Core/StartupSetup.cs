// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Core.StartupSetup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SteelCircus.ScriptableObjects;
using Rewired;
using SteelCircus.Core;
using SteelCircus.Core.Services;
using SteelCircus.ScriptableObjects;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

namespace Imi.SteelCircus.Core
{
  public static class StartupSetup
  {
    public static ConfigProvider configProvider;

    public static ColorsConfig Colors => StartupSetup.configProvider.colorsConfig;

    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
    private static void OnStartupBeforeSceneLoad()
    {
      Imi.Diagnostics.Log.Debug("Client Version: 20191126-216_live_Update_0.8");
      ImiServices.Create();
    }

    public static void Initialize(SetupConfig setupConfig)
    {
      Imi.Diagnostics.Log.Debug("StartupSetup-Start");
      if ((UnityEngine.Object) GameObject.Find("StartupSetupObjects") != (UnityEngine.Object) null)
        return;
      Stopwatch stopwatch1 = Stopwatch.StartNew();
      StartupSetup.LoadStoredGraphicsSettings();
      StartupSetup.configProvider = setupConfig.configProvider;
      MatchObjectsParent.Init();
      if (SceneManager.GetSceneAt(0).name == "SceneA")
        return;
      StartupSetup.SetupShaderKeywords();
      Stopwatch stopwatch2 = Stopwatch.StartNew();
      GameObject gameObject1 = new GameObject("StartupSetupObjects");
      foreach (GameObject gameObject2 in setupConfig.dontDestroyOnLoad)
        StartupSetup.InstantiateGameObject(gameObject2, gameObject1.transform);
      UnityEngine.Object.DontDestroyOnLoad((UnityEngine.Object) gameObject1);
      TimeSpan elapsed = stopwatch2.Elapsed;
      Imi.Diagnostics.Log.Debug(string.Format("SetupConfig Object instantiation: {0}", (object) (uint) elapsed.TotalMilliseconds));
      SceneManager.sceneLoaded += new UnityAction<Scene, LoadSceneMode>(StartupSetup.CheckForUnityUiEventSystem);
      Cursor.lockState = CursorLockMode.Confined;
      elapsed = stopwatch1.Elapsed;
      Imi.Diagnostics.Log.Debug(string.Format("StartupSetup-End: {0}", (object) (uint) elapsed.TotalMilliseconds));
    }

    public static IEnumerator LoadSetupConfigAsync(
      Action<SetupConfig> OnSetupConfigLoaded)
    {
      yield return (object) null;
      Stopwatch stopwatch = Stopwatch.StartNew();
      ResourceRequest setupConfigResource = Resources.LoadAsync<SetupConfig>("Configs/SetupConfig");
      while (!setupConfigResource.isDone)
        yield return (object) null;
      Action<SetupConfig> action = OnSetupConfigLoaded;
      if (action != null)
        action(setupConfigResource.asset as SetupConfig);
      Imi.Diagnostics.Log.Debug(string.Format("LoadSetupConfigAsync Resources Load . {0}", (object) (uint) stopwatch.Elapsed.TotalMilliseconds));
    }

    private static void SetupShaderKeywords() => Shader.EnableKeyword("VIDEO_LINEAR_NO");

    private static void SetupRewiredSystemPlayer()
    {
      Player systemPlayer = ReInput.players.GetSystemPlayer();
      systemPlayer.controllers.AddController((Controller) ReInput.controllers.GetJoystick(0), false);
      systemPlayer.controllers.AddController((Controller) ReInput.controllers.Keyboard, false);
    }

    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
    private static void OnStartupAfterSceneLoad()
    {
    }

    public static void LoadStoredGraphicsSettings()
    {
      if (PlayerPrefs.HasKey("UnityGraphicsQualitySave"))
      {
        QualitySettings.SetQualityLevel(PlayerPrefs.GetInt("UnityGraphicsQualitySave"));
      }
      else
      {
        if (!PlayerPrefs.HasKey("UnityGraphicsQuality"))
          return;
        QualitySettings.SetQualityLevel(PlayerPrefs.GetInt("UnityGraphicsQuality"));
      }
    }

    public static void RewiredSetup()
    {
      ReInput.players.GetSystemPlayer().controllers.AddController((Controller) ReInput.controllers.GetJoystick(0), false);
      ReInput.ShutDownEvent += (Action) (() => Imi.Diagnostics.Log.Debug("Rewired has shut down."));
      StartupSetup.ResetControlMappingIfObsolete(17);
    }

    private static void ResetControlMappingIfObsolete(int controlsVersion)
    {
      string key = "ControlsVersion";
      if (PlayerPrefs.HasKey(key) && PlayerPrefs.GetInt(key) >= controlsVersion)
        return;
      Imi.Diagnostics.Log.Debug(string.Format("Starting with new controls (Version {0}) for the first time. Resetting saved control mapping.", (object) controlsVersion));
      IList<Player> players = ReInput.players.Players;
      for (int index = 0; index < players.Count; ++index)
      {
        Player player = players[index];
        player.controllers.maps.LoadDefaultMaps(ControllerType.Joystick);
        player.controllers.maps.LoadDefaultMaps(ControllerType.Keyboard);
        player.controllers.maps.LoadDefaultMaps(ControllerType.Mouse);
      }
      ReInput.userDataStore.Save();
      PlayerPrefs.SetInt(key, controlsVersion);
    }

    private static void CheckForUnityUiEventSystem(Scene scene, LoadSceneMode loadSceneMode)
    {
      foreach (Component component in UnityEngine.Object.FindObjectsOfType<StandaloneInputModule>())
      {
        UnityEngine.Object.DestroyImmediate((UnityEngine.Object) component.gameObject);
        string str = "#ed3f4b";
        UnityEngine.Debug.LogWarning((object) ("<color=" + str + ">EventSystem/StandaloneInputModule</color> found in Scene <color=" + str + ">'" + scene.name + "'</color>! Make sure there are no 'EventSystem's in any Scenes! We are using a custom solution with RewiredStandaloneInputModule that is initialized automatically."));
      }
    }

    private static void InstantiateGameObject(GameObject gameObject, Transform parentTo)
    {
      GameObject gameObject1 = UnityEngine.Object.Instantiate<GameObject>(gameObject);
      gameObject1.transform.SetParent(parentTo);
      Imi.Diagnostics.Log.Debug("Initializing " + gameObject1.name);
    }

    public static IEnumerator LoadConfigsAsync()
    {
      Stopwatch stopwatch = Stopwatch.StartNew();
      Imi.Diagnostics.Log.Debug("Loading ItemConfigs Async.");
      ResourceRequest itemConfig = Resources.LoadAsync<ItemsConfig>("Configs/Items/ItemsConfig");
      while (!itemConfig.isDone)
        yield return (object) null;
      Imi.Diagnostics.Log.Debug("Loading ItemConfigs Async done.");
      Imi.Diagnostics.Log.Debug("Loading ChampionConfigProvider Async.");
      ResourceRequest provider = Resources.LoadAsync<ChampionConfigProvider>("Configs/ChampionConfigProvider");
      while (!provider.isDone)
        yield return (object) null;
      Imi.Diagnostics.Log.Debug("Loading ItemConfigs Async done.");
      Imi.Diagnostics.Log.Debug("Loading UIProgressionConfig Async.");
      ResourceRequest uiProgression = Resources.LoadAsync<UIProgressionConfig>("Configs/UIProgressionConfig");
      while (!uiProgression.isDone)
        yield return (object) null;
      ImiServices.Instance.UiProgressionService.SetupProgressionStates();
      Imi.Diagnostics.Log.Debug("Loading UIProgressionConfig Async done.");
      Imi.Diagnostics.Log.Debug("Loading StandaloneConfig Async.");
      ResourceRequest standaloneConfig = Resources.LoadAsync<StandaloneConfig>("Configs/Standalone/StandaloneConfig");
      while (!standaloneConfig.isDone)
        yield return (object) null;
      if (standaloneConfig.asset is StandaloneConfig asset)
        asset.LoadConfigFromJson();
      Imi.Diagnostics.Log.Debug("Loading StandaloneConfig Async done.");
      Imi.Diagnostics.Log.Debug("Loading PickupConfig Async.");
      ResourceRequest pickupConfig = Resources.LoadAsync<PickupConfig>("Configs/Visual/PickupConfig");
      while (!pickupConfig.isDone)
        yield return (object) null;
      Imi.Diagnostics.Log.Debug(string.Format("Loading configs finished: {0}", (object) (uint) stopwatch.Elapsed.TotalMilliseconds));
    }
  }
}
