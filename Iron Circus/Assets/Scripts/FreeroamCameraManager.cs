// Decompiled with JetBrains decompiler
// Type: FreeroamCameraManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.CameraSystem;
using Rewired;
using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using UnityEngine;

public class FreeroamCameraManager : MonoBehaviour
{
  private SCCamera cam;
  private FreeroamCamera freeroamCamera;
  private GameObject camPrefab;
  private GameObject canvasPrefab;
  private bool isActive;
  public string ScreenshotPath = "pics/Screenshot";
  public int ScreeshotResolutionFactor = 1;

  private void Start()
  {
    this.camPrefab = (GameObject) Resources.Load("Prefabs/Camera/SCCamera", typeof (GameObject));
    this.canvasPrefab = (GameObject) Resources.Load("Prefabs/UI/FreeroamCameraUI/FreeroamCameraUI", typeof (GameObject));
    Events.Global.OnEventDebug += new Events.EventDebug(this.OnDebugEvent);
  }

  private void OnDebugEvent(ulong playerId, DebugEventType type)
  {
    if (type != DebugEventType.FreeroamCamera)
      return;
    this.CreateNewFreeroamCamera(false);
  }

  private void OnDestroy() => Events.Global.OnEventDebug -= new Events.EventDebug(this.OnDebugEvent);

  private void CreateNewFreeroamCamera(bool isSpectatorCamera)
  {
    this.isActive = !this.isActive;
    ImiServices.Instance.CameraManager.gameObject.SetActive(!this.isActive);
    if (this.isActive)
    {
      GameObject gameObject1 = Object.Instantiate<GameObject>(this.camPrefab, new Vector3(0.0f, 2.5f, 0.0f), Quaternion.identity);
      gameObject1.transform.SetParent(this.transform);
      this.cam = gameObject1.GetComponent<SCCamera>();
      Object.Destroy((Object) this.cam.GetComponent<CameraShake2>());
      this.freeroamCamera = gameObject1.AddComponent<FreeroamCamera>();
      this.freeroamCamera.Manager = this;
      this.freeroamCamera.SetScCamera(this.cam);
      this.freeroamCamera.IsSpectatorCamera = isSpectatorCamera;
      ReInput.players.GetPlayer(0).controllers.maps.SetMapsEnabled(false, "Champions");
      GameObject gameObject2 = Object.Instantiate<GameObject>(this.canvasPrefab, new Vector3(), Quaternion.identity);
      gameObject2.transform.SetParent(this.transform);
      FreeroamCameraUI component = gameObject2.GetComponent<FreeroamCameraUI>();
      component.SetFreeroamCamera(this.freeroamCamera);
      this.freeroamCamera.SetFreeRoamCameraUi(component);
      this.freeroamCamera.SetupButtonEventsForUi();
    }
    else
    {
      if ((Object) this.cam != (Object) null)
      {
        ReInput.players.GetPlayer(0).controllers.maps.SetMapsEnabled(false, "FreeroamCamera");
        Object.Destroy((Object) this.cam.gameObject);
      }
      ReInput.players.GetPlayer(0).controllers.maps.SetMapsEnabled(true, "Champions");
    }
  }

  public void EnableInput(string inputName) => ReInput.players.GetPlayer(0).controllers.maps.SetMapsEnabled(true, inputName);

  public void DisableInput(string inputName) => ReInput.players.GetPlayer(0).controllers.maps.SetMapsEnabled(false, inputName);
}
