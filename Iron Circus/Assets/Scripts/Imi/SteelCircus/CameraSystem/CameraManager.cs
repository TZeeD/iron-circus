// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.CameraSystem.CameraManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace Imi.SteelCircus.CameraSystem
{
  public class CameraManager : MonoBehaviour
  {
    [SerializeField]
    private GameObject defaultInGameCamera;
    [SerializeField]
    private GameObject defaultIntroCamera;
    [SerializeField]
    private GameObject defaultGoalCameras;
    [SerializeField]
    private GameObject defaultVictoryCameras;
    [SerializeField]
    private GameObject defaultMenuUICamera;
    private Dictionary<CameraType, GameObject> cameras = new Dictionary<CameraType, GameObject>(5);
    private CameraType activeCameraType;
    private bool currentProfileSet;
    private PostProcessProfile currentProfile;
    private PostProcessProfile currentColorGrading;
    private bool currentSkyboxSet;
    private Material currentSkyboxBG;
    private Material currentSkyboxReflections;
    private bool currentClipSet;
    private float currentNearClip;
    private float currentFarClip;
    private static CameraManager _instance;

    private void Awake()
    {
      CameraManager._instance = this;
      this.SetCameraPrefab(CameraType.InGameCamera, this.defaultInGameCamera);
      this.SetCameraPrefab(CameraType.IntroCamera, this.defaultIntroCamera);
      this.SetCameraPrefab(CameraType.GoalCameras, this.defaultGoalCameras);
      this.SetCameraPrefab(CameraType.VictoryCameras, this.defaultVictoryCameras);
      this.SetCameraPrefab(CameraType.MenuUICamera, this.defaultMenuUICamera);
      Object.DontDestroyOnLoad((Object) this.gameObject);
      this.ActivateCamera(CameraType.MenuUICamera);
    }

    public void SetCameraPrefab(CameraType type, GameObject prefab)
    {
      bool activeSelf = this.gameObject.activeSelf;
      this.gameObject.SetActive(false);
      if (this.cameras.ContainsKey(type))
      {
        GameObject camera = this.cameras[type];
        if ((Object) camera != (Object) null)
          Object.Destroy((Object) camera);
      }
      GameObject cam = (GameObject) null;
      if ((Object) prefab != (Object) null)
        cam = Object.Instantiate<GameObject>(prefab, this.transform);
      this.cameras[type] = cam;
      if ((Object) cam != (Object) null)
      {
        this.SetPostProcessingProfileInternal(cam);
        this.SetSkyboxesInternal(cam);
        this.SetClippingPlanesInternal(cam);
      }
      if ((Object) cam != (Object) null)
        cam.SetActive(this.activeCameraType == type);
      this.gameObject.SetActive(activeSelf);
    }

    public void ActivateCamera(CameraType type)
    {
      this.DeactivateAll();
      GameObject camera = this.GetCamera(type);
      if ((Object) camera != (Object) null)
        camera.SetActive(true);
      this.activeCameraType = type;
    }

    public GameObject GetCamera(CameraType type)
    {
      GameObject gameObject = (GameObject) null;
      if (this.cameras.ContainsKey(type))
        gameObject = this.cameras[type];
      return gameObject;
    }

    public CameraType GetActiveCameraType() => this.activeCameraType;

    public Camera GetActiveCameraComponent()
    {
      GameObject camera = this.GetCamera(this.activeCameraType);
      if (!((Object) camera != (Object) null))
        return (Camera) null;
      SCCamera componentInChildren = camera.GetComponentInChildren<SCCamera>();
      return (Object) componentInChildren != (Object) null ? componentInChildren.GetMain() : camera.GetComponentInChildren<Camera>();
    }

    public void DeactivateAll()
    {
      foreach (GameObject gameObject in this.cameras.Values)
      {
        if ((Object) gameObject != (Object) null)
          gameObject.SetActive(false);
      }
    }

    public void SetPostProcessingProfile(
      PostProcessProfile profile,
      PostProcessProfile colorGrading)
    {
      this.currentProfileSet = true;
      this.currentProfile = profile;
      this.currentColorGrading = colorGrading;
      foreach (GameObject cam in this.cameras.Values)
      {
        if ((Object) cam != (Object) null)
          this.SetPostProcessingProfileInternal(cam);
      }
    }

    public void SetSkyboxes(Material skyboxBG, Material skyboxReflections)
    {
      this.currentSkyboxSet = true;
      this.currentSkyboxBG = skyboxBG;
      this.currentSkyboxReflections = skyboxReflections;
      foreach (GameObject cam in this.cameras.Values)
      {
        if ((Object) cam != (Object) null)
          this.SetSkyboxesInternal(cam);
      }
    }

    public void SetClippingPlanes(float nearClip, float farClip)
    {
      this.currentClipSet = true;
      this.currentNearClip = nearClip;
      this.currentFarClip = farClip;
      foreach (GameObject cam in this.cameras.Values)
      {
        if ((Object) cam != (Object) null)
          this.SetClippingPlanesInternal(cam);
      }
    }

    public void SetArenaEstablishingShot(RuntimeAnimatorController establishingShotAnimator) => this.GetCamera(CameraType.IntroCamera).GetComponentInChildren<Animator>(true).runtimeAnimatorController = establishingShotAnimator;

    public void ShowVictoryCamera(Team winningTeam)
    {
      this.ActivateCamera(CameraType.VictoryCameras);
      this.cameras[CameraType.VictoryCameras].GetComponent<VictoryCamera>().ShowVictoryCamera(winningTeam);
    }

    public void ShowGoalCamera(Team scoringTeam)
    {
      this.ActivateCamera(CameraType.GoalCameras);
      this.cameras[CameraType.GoalCameras].GetComponent<GoalCamera>().ShowGoalCamera(scoringTeam);
    }

    public void ResetInGameCamera() => this.GetCamera(CameraType.InGameCamera).GetComponent<InGameCameraBehaviour>().Reset();

    private void SetPostProcessingProfileInternal(GameObject cam)
    {
      if (!this.currentProfileSet)
        return;
      foreach (SCCamera componentsInChild in cam.GetComponentsInChildren<SCCamera>(true))
      {
        PostProcessVolume generalPostProcessing;
        PostProcessVolume colorGrading;
        componentsInChild.GetPostprocessingVolumes(out generalPostProcessing, out colorGrading);
        generalPostProcessing.profile = this.currentProfile;
        generalPostProcessing.enabled = (Object) this.currentProfile != (Object) null;
        colorGrading.profile = this.currentColorGrading;
        colorGrading.enabled = (Object) this.currentColorGrading != (Object) null;
      }
    }

    private void SetSkyboxesInternal(GameObject cam)
    {
      if (!this.currentSkyboxSet)
        return;
      foreach (SCCamera componentsInChild in cam.GetComponentsInChildren<SCCamera>(true))
        componentsInChild.SetSkyboxes(this.currentSkyboxBG, this.currentSkyboxReflections);
    }

    private void SetClippingPlanesInternal(GameObject cam)
    {
      if (!this.currentClipSet)
        return;
      foreach (SCCamera componentsInChild in cam.GetComponentsInChildren<SCCamera>(true))
      {
        componentsInChild.nearClip = this.currentNearClip;
        componentsInChild.farClip = this.currentFarClip;
      }
    }
  }
}
