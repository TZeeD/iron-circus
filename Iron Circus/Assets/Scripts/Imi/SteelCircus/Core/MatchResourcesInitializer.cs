// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Core.MatchResourcesInitializer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using AmplifyBloom;
using Entitas;
using Entitas.Unity;
using Imi.Game;
using Imi.SteelCircus.CameraSystem;
using Imi.SteelCircus.FX;
using Imi.SteelCircus.GameElements;
using SharedWithServer.ScEvents;
using SteelCircus.Analytics;
using SteelCircus.Client_Components;
using SteelCircus.Core;
using SteelCircus.Core.Services;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.PostProcessing;
using UnityEngine.SceneManagement;

namespace Imi.SteelCircus.Core
{
  public class MatchResourcesInitializer : MonoBehaviour
  {
    private Events events;
    public string arenaName;

    private void Awake() => this.events = Events.Global;

    public void LoadArena(string arenaName, Action<string, uint> arenaLoadedCallback)
    {
      this.arenaName = arenaName;
      string arenaName1 = "";
      if (arenaName.Contains("Variation") || arenaName.Contains("PlayGround"))
      {
        int length = arenaName.LastIndexOf("_");
        if (length > 0)
          arenaName1 = arenaName.Substring(0, length);
        GameObject go = new GameObject("InGameAnalyticsCollector");
        MatchObjectsParent.Add(go);
        go.AddComponent<InGameAnalyticsCollector>().Init(arenaName1);
        ArenaConfig arenaConfig = (ArenaConfig) Resources.Load("Configs/Arenas/" + arenaName1, typeof (ArenaConfig));
        if ((UnityEngine.Object) arenaConfig == (UnityEngine.Object) null)
        {
          Imi.Diagnostics.Log.Error("ArenaConfig " + arenaName + " does not exist. Check your server commandline settings.");
        }
        else
        {
          arenaConfig.arenaSceneName = arenaName;
          this.StartCoroutine(this.LoadArenaCR(arenaConfig, arenaLoadedCallback));
        }
      }
      else
        Imi.Diagnostics.Log.Error("Malformed Arena Name " + arenaName + ". The Client tried to load an invalid Arena.");
    }

    private IEnumerator LoadArenaCR(
      ArenaConfig arenaConfig,
      Action<string, uint> arenaLoadedCallback)
    {
      MatchResourcesInitializer resourcesInitializer = this;
      Stopwatch stopwatch = Stopwatch.StartNew();
      Imi.Diagnostics.Log.Debug("Server says to load arena: " + arenaConfig.arenaSceneName);
      resourcesInitializer.events.FireEventArenaLoadingProgress("Loading Arena " + arenaConfig.arenaSceneName + "...");
      yield return (object) resourcesInitializer.StartCoroutine(resourcesInitializer.LoadArenaAsyncScene(arenaConfig.arenaSceneName, LoadSceneMode.Additive));
      Imi.Diagnostics.Log.Debug(string.Format("1 - {0}", (object) (uint) stopwatch.Elapsed.TotalMilliseconds));
      resourcesInitializer.events.FireEventArenaLoadingProgress("Loading Environment " + arenaConfig.environmentSceneName + "...", 0.5f);
      yield return (object) resourcesInitializer.StartCoroutine(resourcesInitializer.LoadArenaAsyncScene(arenaConfig.environmentSceneName, LoadSceneMode.Additive));
      Imi.Diagnostics.Log.Debug(string.Format("2 - {0}", (object) (uint) stopwatch.Elapsed.TotalMilliseconds));
      Scene matchScene = SceneManager.GetActiveScene();
      yield return (object) null;
      resourcesInitializer.SetupCameras(arenaConfig, matchScene);
      yield return (object) null;
      SceneManager.SetActiveScene(SceneManager.GetSceneByName(arenaConfig.arenaSceneName));
      Imi.Diagnostics.Log.Debug(string.Format("3 - {0}", (object) (uint) stopwatch.Elapsed.TotalMilliseconds));
      resourcesInitializer.events.FireEventArenaLoadingProgress("Warming up assets...", 0.7f);
      yield return (object) null;
      MatchObjectsParent.FloorStateManager.Setup(arenaConfig);
      yield return (object) resourcesInitializer.StartCoroutine(resourcesInitializer.WarmupAssets());
      yield return (object) resourcesInitializer.StartCoroutine(resourcesInitializer.RenderCompleteSceneOnce(arenaConfig, matchScene));
      resourcesInitializer.events.FireEventArenaLoadingProgress("Setting up Lights for " + arenaConfig.arenaSceneName + "...");
      resourcesInitializer.SetupSkyboxAndReflections(arenaConfig);
      resourcesInitializer.events.FireEventArenaLoadingProgress("Loading complete!", 1f);
      Imi.Diagnostics.Log.Debug(string.Format("4 - {0}", (object) (uint) stopwatch.Elapsed.TotalMilliseconds));
      resourcesInitializer.LinkBumperUnityViewsToEntitas();
      yield return (object) resourcesInitializer.StartCoroutine(resourcesInitializer.WaitForFramerateToRecover());
      yield return (object) resourcesInitializer.StartCoroutine(resourcesInitializer.CollectGarbage());
      SceneManager.SetActiveScene(matchScene);
      resourcesInitializer.events.FireEventArenaLoadingProgress("Waiting for other Players.", 1f);
      Imi.Diagnostics.Log.Debug(string.Format("Loading done {0}", (object) (uint) stopwatch.Elapsed.TotalMilliseconds));
      Action<string, uint> action = arenaLoadedCallback;
      if (action != null)
        action(resourcesInitializer.arenaName, (uint) stopwatch.Elapsed.TotalMilliseconds);
    }

    private void LinkBumperUnityViewsToEntitas()
    {
      GameEntity[] array = ((IEnumerable<GameEntity>) Contexts.sharedInstance.game.GetGroup(GameMatcher.Bumper).GetEntities()).Concat<GameEntity>((IEnumerable<GameEntity>) Contexts.sharedInstance.game.GetGroup(GameMatcher.Pickup).GetEntities()).ToArray<GameEntity>();
      foreach (GameUniqueId gameUniqueId in UnityEngine.Object.FindObjectsOfType<GameUniqueId>())
      {
        foreach (GameEntity gameEntity in array)
        {
          if (gameUniqueId.GetId() == (int) gameEntity.uniqueId.id.Value())
          {
            Imi.Diagnostics.Log.Debug(string.Format("Linked Bumper: {0} to {1}", (object) gameEntity, (object) gameUniqueId.gameObject.name));
            gameEntity.ReplaceUnityView(gameUniqueId.gameObject);
            gameUniqueId.gameObject.Link((IEntity) gameEntity, (IContext) Contexts.sharedInstance.game);
          }
        }
      }
    }

    private IEnumerator WarmupAssets()
    {
      yield return (object) null;
    }

    private IEnumerator RenderCompleteSceneOnce(ArenaConfig arenaConfig, Scene scene)
    {
      GameObject temporaryCam = UnityEngine.Object.Instantiate<GameObject>((GameObject) Resources.Load("Prefabs/Camera/SCCamera", typeof (GameObject)), Vector3.up * 250f, Quaternion.identity);
      yield return (object) null;
      temporaryCam.transform.localEulerAngles = new Vector3(90f, 0.0f, 0.0f);
      Camera[] cams = temporaryCam.GetComponentsInChildren<Camera>();
      yield return (object) null;
      PostProcessVolume pb = temporaryCam.GetComponentInChildren<PostProcessVolume>();
      if ((UnityEngine.Object) pb != (UnityEngine.Object) null)
      {
        pb.profile = arenaConfig.profile;
        pb.enabled = false;
        pb.enabled = true;
      }
      yield return (object) null;
      if ((UnityEngine.Object) pb != (UnityEngine.Object) null)
      {
        pb.profile = arenaConfig.colorGrading;
        pb.enabled = false;
        pb.enabled = true;
      }
      yield return (object) null;
      AmplifyBloomEffect componentInChildren = temporaryCam.GetComponentInChildren<AmplifyBloomEffect>();
      componentInChildren.CurrentPrecisionMode = PrecisionModes.Low;
      componentInChildren.TemporalFilteringActive = true;
      componentInChildren.ApplyLensDirt = true;
      componentInChildren.ApplyLensGlare = true;
      yield return (object) null;
      foreach (Camera camera in cams)
      {
        camera.fieldOfView = 170f;
        camera.farClipPlane = 3000f;
      }
      yield return (object) null;
      UnityEngine.Object.Destroy((UnityEngine.Object) temporaryCam);
      yield return (object) null;
    }

    private IEnumerator CollectGarbage()
    {
      GC.Collect(GC.MaxGeneration, GCCollectionMode.Forced, true);
      GC.Collect(GC.MaxGeneration, GCCollectionMode.Forced, true);
      yield return (object) null;
      GC.Collect(GC.MaxGeneration, GCCollectionMode.Forced, true);
      yield return (object) null;
    }

    private IEnumerator WaitForFramerateToRecover()
    {
      yield return (object) null;
    }

    public IEnumerator LoadArenaAsyncScene(string scene, LoadSceneMode mode)
    {
      AsyncOperation asyncLoad = SceneManager.LoadSceneAsync(scene, mode);
      yield return (object) null;
      while (!asyncLoad.isDone)
        yield return (object) null;
      yield return (object) null;
    }

    public void SetupCameras(ArenaConfig config, Scene scene)
    {
      CameraManager cameraManager = ImiServices.Instance.CameraManager;
      if ((UnityEngine.Object) config.profile != (UnityEngine.Object) null && (UnityEngine.Object) config.colorGrading != (UnityEngine.Object) null)
        cameraManager.SetPostProcessingProfile(config.profile, config.colorGrading);
      else
        Imi.Diagnostics.Log.Error("No PostProcessing found for: " + config.name);
      if ((UnityEngine.Object) config.cameraSkybox != (UnityEngine.Object) null)
        cameraManager.SetSkyboxes(config.cameraSkybox, config.skybox);
      else
        Imi.Diagnostics.Log.Error("No Skybox found.: " + config.name);
      cameraManager.SetClippingPlanes(config.cameraNearPlane, config.cameraFarPlane);
      if ((UnityEngine.Object) config.IntroCamera != (UnityEngine.Object) null)
        cameraManager.SetCameraPrefab(Imi.SteelCircus.CameraSystem.CameraType.IntroCamera, config.IntroCamera);
      if ((UnityEngine.Object) config.VictoryCameras != (UnityEngine.Object) null)
        cameraManager.SetCameraPrefab(Imi.SteelCircus.CameraSystem.CameraType.VictoryCameras, config.VictoryCameras);
      if ((UnityEngine.Object) config.GoalCameras != (UnityEngine.Object) null)
        cameraManager.SetCameraPrefab(Imi.SteelCircus.CameraSystem.CameraType.GoalCameras, config.GoalCameras);
      IntroSpawnPoint[] array1 = ((IEnumerable<IntroSpawnPoint>) UnityEngine.Object.FindObjectsOfType<IntroSpawnPoint>()).OrderBy<IntroSpawnPoint, Team>((Func<IntroSpawnPoint, Team>) (sp => sp.team)).ThenBy<IntroSpawnPoint, int>((Func<IntroSpawnPoint, int>) (pos => (int) pos.spawnPosition)).ToArray<IntroSpawnPoint>();
      cameraManager.GetCamera(Imi.SteelCircus.CameraSystem.CameraType.IntroCamera).GetComponentInChildren<IntroAnimationEvents>().ProvideIntroSpawnPoints(array1);
      VictorySpawnPoint[] array2 = ((IEnumerable<VictorySpawnPoint>) UnityEngine.Object.FindObjectsOfType<VictorySpawnPoint>()).OrderBy<VictorySpawnPoint, Team>((Func<VictorySpawnPoint, Team>) (sp => sp.team)).ThenBy<VictorySpawnPoint, int>((Func<VictorySpawnPoint, int>) (pos => (int) pos.spawnPosition)).ToArray<VictorySpawnPoint>();
      cameraManager.GetCamera(Imi.SteelCircus.CameraSystem.CameraType.VictoryCameras).GetComponentInChildren<VictoryAnimationEvents>().ProvideSpawnPoints(array2);
    }

    public void SetupSkyboxAndReflections(ArenaConfig config)
    {
      if ((UnityEngine.Object) config.reflectionProbe != (UnityEngine.Object) null)
      {
        UnityEngine.RenderSettings.customReflection = config.reflectionProbe;
        UnityEngine.RenderSettings.defaultReflectionMode = DefaultReflectionMode.Custom;
      }
      else
        Imi.Diagnostics.Log.Debug("No Reflection Probe set for : " + config.name);
      if ((UnityEngine.Object) config.skybox != (UnityEngine.Object) null)
      {
        UnityEngine.RenderSettings.skybox = config.skybox;
        UnityEngine.RenderSettings.ambientMode = AmbientMode.Skybox;
        DynamicGI.UpdateEnvironment();
      }
      else
        Imi.Diagnostics.Log.Debug("No Skybox set for : " + config.name);
    }

    public IEnumerator UnloadArena(string arenaName)
    {
      ArenaConfig config = (ArenaConfig) Resources.Load("Configs/Arenas/" + arenaName, typeof (ArenaConfig));
      yield return (object) this.UnloadScene(config.arenaSceneName);
      yield return (object) this.UnloadScene(config.environmentSceneName);
      this.events.FireEventArenaUnloaded(arenaName);
    }

    private IEnumerator UnloadScene(string scene)
    {
      if (MatchResourcesInitializer.IsSceneLoaded(scene))
      {
        AsyncOperation asyncLoad = SceneManager.UnloadSceneAsync(scene);
        while (!asyncLoad.isDone)
          yield return (object) null;
        asyncLoad = (AsyncOperation) null;
      }
    }

    private static bool IsSceneLoaded(string scene)
    {
      int sceneCount = SceneManager.sceneCount;
      for (int index = 0; index < sceneCount; ++index)
      {
        Scene sceneAt = SceneManager.GetSceneAt(index);
        if (sceneAt.name == scene && sceneAt.isLoaded)
          return true;
      }
      return false;
    }
  }
}
