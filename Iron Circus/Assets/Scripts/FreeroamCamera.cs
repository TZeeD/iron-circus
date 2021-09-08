// Decompiled with JetBrains decompiler
// Type: FreeroamCamera
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.CameraSystem;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.UI;
using Imi.SteelCircus.UI.Floor;
using SteelCircus.Core.Services;
using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Rendering.PostProcessing;

public class FreeroamCamera : MonoBehaviour
{
  public InputService input;
  public float MoveSpeed = 10f;
  public float LookSpeed = 35f;
  public bool IsFollowingPlayer;
  public bool IsCameraMovementLocked;
  public bool IsCameraRotationLocked;
  public bool IsControllingPlayer;
  public bool IsSpectatorCamera;
  public bool LookAtPlayer;
  public bool LookAtPlayerFace;
  public FreeroamCameraManager Manager;
  private FreeroamCameraUI freeroamCameraUi;
  private int screenshotCount;
  private int cameraPoseCount;
  private GameContext gameContext;
  private IGroup<GameEntity> playerGroup;
  private IDictionary<int, CameraPose> dict;
  private int playerIndex;
  private int poseIndex;
  private int cameraSpeedIndex = 1;
  private SCCamera scCamera;
  private bool toggleUi;
  private bool togglePlayers;
  private bool toggleFreeRoamUi;
  private GameObject ui;
  private GameObject debugUi;
  private GameObject debugNetworkUi;
  private GameObject debugFPSUi;
  private Canvas[] sceneCanvases;
  private PlayerFloorUI[] pUis;
  private Vector3 customOffset;
  public string ActiveCharacter = "";
  public string ActiveCameraPose = "";
  private string cameraPosePath = "MarketingCameraPoses";

  private void Start()
  {
    this.input = ImiServices.Instance.InputService;
    this.input.SetInputMapCategory(InputMapCategory.FreeroamCamera);
    string currentArena = ImiServices.Instance.isInMatchService.CurrentArena;
    string str = "";
    if (currentArena.Contains("Variation") || currentArena.Contains("PlayGround"))
    {
      int length = currentArena.LastIndexOf("_");
      if (length > 0)
        str = currentArena.Substring(0, length);
    }
    this.SetupCamerasWithArenaConfig((ArenaConfig) Resources.Load("Configs/Arenas/" + str, typeof (ArenaConfig)));
    this.Init();
    this.IsFollowingPlayer = false;
  }

  public void Init()
  {
    this.dict = (IDictionary<int, CameraPose>) new Dictionary<int, CameraPose>();
    this.dict.Add(new KeyValuePair<int, CameraPose>(0, new CameraPose(new Vector3(30.90286f, 15.45114f, -9.591768f), new Quaternion(0.1889661f, -0.6813897f, 0.1889661f, 0.6813897f), hasRotation: true)));
    this.dict.Add(new KeyValuePair<int, CameraPose>(1, new CameraPose(new Vector3(0.0f, 1.5f, 0.0f), Quaternion.identity)));
    this.dict.Add(new KeyValuePair<int, CameraPose>(2, new CameraPose(new Vector3(0.0f, 2.5f, 0.0f), Quaternion.identity)));
    this.dict.Add(new KeyValuePair<int, CameraPose>(3, new CameraPose(new Vector3(0.0f, 4f, 0.0f), Quaternion.identity)));
    this.dict.Add(new KeyValuePair<int, CameraPose>(4, new CameraPose(new Vector3(0.0f, 8f, 0.0f), Quaternion.identity)));
    string currentDirectory = Directory.GetCurrentDirectory();
    char directorySeparatorChar = Path.DirectorySeparatorChar;
    string str1 = directorySeparatorChar.ToString();
    string cameraPosePath = this.cameraPosePath;
    directorySeparatorChar = Path.DirectorySeparatorChar;
    string str2 = directorySeparatorChar.ToString();
    this.LoadSavedCameraPoses(currentDirectory + str1 + cameraPosePath + str2);
    this.gameContext = Contexts.sharedInstance.game;
    this.playerGroup = this.gameContext.GetGroup(GameMatcher.Player);
    this.SetupCameraPose(this.playerIndex % this.playerGroup.GetEntities().Length, this.poseIndex % this.dict.Count);
  }

  private void LoadSavedCameraPoses(string path)
  {
    if (!Directory.Exists(path))
      return;
    foreach (string file in Directory.GetFiles(path, "*.save"))
      this.LoadSavedCameraPose(file);
  }

  private void LoadSavedCameraPose(string camPosePath)
  {
    BinaryFormatter binaryFormatter = new BinaryFormatter();
    try
    {
      FileStream fileStream = File.Open(camPosePath, FileMode.Open);
      CameraPose cameraPose = (CameraPose) binaryFormatter.Deserialize((Stream) fileStream);
      string str1 = fileStream.Name.Substring(fileStream.Name.LastIndexOf(Path.DirectorySeparatorChar) + 1);
      string str2 = str1.Remove(str1.Length - ".save".Length);
      cameraPose.fileName = str2;
      fileStream.Close();
      this.dict.Add(new KeyValuePair<int, CameraPose>(this.dict.Count, cameraPose));
    }
    catch (Exception ex)
    {
      Log.Warning("Cannot Load Camera Pose for FreeroamCamera. Maybe you haven't checked out the file in Perforce?");
      Console.WriteLine(ex.StackTrace);
    }
  }

  private void SaveCameraPose(CameraPose camPose)
  {
    string formattedDateString = this.GetFormattedDateString();
    string filename = Directory.GetCurrentDirectory() + Path.DirectorySeparatorChar.ToString() + this.cameraPosePath + Path.DirectorySeparatorChar.ToString() + "sc_" + (object) this.cameraPoseCount + "_" + formattedDateString;
    if (Directory.Exists(Directory.GetCurrentDirectory() + Path.DirectorySeparatorChar.ToString() + this.cameraPosePath))
    {
      camPose.SaveCameraPose(filename);
    }
    else
    {
      string currentDirectory = Directory.GetCurrentDirectory();
      char directorySeparatorChar = Path.DirectorySeparatorChar;
      string str1 = directorySeparatorChar.ToString();
      string cameraPosePath = this.cameraPosePath;
      directorySeparatorChar = Path.DirectorySeparatorChar;
      string str2 = directorySeparatorChar.ToString();
      Directory.CreateDirectory(currentDirectory + str1 + cameraPosePath + str2);
      camPose.SaveCameraPose(filename);
    }
    Log.Debug("Saved new CameraPose to: " + filename);
    ++this.cameraPoseCount;
  }

  private void Update()
  {
    if (this.gameContext == null)
      this.gameContext = Contexts.sharedInstance.game;
    this.playerGroup = this.gameContext.GetGroup(GameMatcher.Player);
    if (this.playerGroup != null)
    {
      GameEntity entity = this.playerGroup.GetEntities()[this.playerIndex % this.playerGroup.GetEntities().Length];
      GameObject gameObject = entity.unityView.gameObject;
      if (entity.hasPlayerUsername)
        this.ActiveCharacter = entity.playerUsername.username;
      else if ((UnityEngine.Object) gameObject != (UnityEngine.Object) null)
        this.ActiveCharacter = gameObject.name;
      if (this.input.GetButtonUp(DigitalInput.FreeroamCButton))
      {
        this.LookAtPlayer = false;
        this.LookAtPlayerFace = false;
      }
      if (this.input.GetButtonUp(DigitalInput.FreeroamSButton))
        this.LookAtPlayer = !this.LookAtPlayer;
      if (this.input.GetButtonUp(DigitalInput.FreeroamXButotn))
        this.LookAtPlayerFace = !this.LookAtPlayerFace;
      this.MoveAndRotate(gameObject);
    }
    this.CycleThroughPlayersAndCameraPoses();
    this.AdjustCameraSpeed();
    if (Input.GetKeyUp(KeyCode.RightShift))
      this.TogglePlayerModels();
    this.DisableUiHotkeys();
    if (this.input.GetButtonUp(DigitalInput.FreeroamTButton) || Input.GetKeyUp(KeyCode.RightControl))
      this.TakeScreenshot();
    if (Input.GetKeyUp(KeyCode.Tab))
      this.TogglePlayerControl();
    if (!this.IsFollowingPlayer)
      return;
    this.FollowPlayer(this.playerIndex % this.playerGroup.GetEntities().Length);
  }

  private void LateUpdate()
  {
    if ((UnityEngine.Object) this.freeroamCameraUi == (UnityEngine.Object) null)
      return;
    this.freeroamCameraUi.RenderBtns(this.IsControllingPlayer, this.IsFollowingPlayer, this.IsCameraRotationLocked, this.IsCameraMovementLocked);
  }

  public void SetupButtonEventsForUi()
  {
    this.freeroamCameraUi.togglePlayerLockBtn.onClick.AddListener(new UnityAction(this.TogglePlayerControl));
    this.freeroamCameraUi.toggleCameraPlayerFollowBtn.onClick.AddListener((UnityAction) (() => this.ActivatePlayerFollow(this.playerGroup.GetEntities()[this.playerIndex % this.playerGroup.GetEntities().Length].unityView.gameObject)));
    this.freeroamCameraUi.toggleCameraMoveLockBtn.onClick.AddListener((UnityAction) (() => this.IsCameraMovementLocked = !this.IsCameraMovementLocked));
    this.freeroamCameraUi.toggleCameraRotationLockedBtn.onClick.AddListener((UnityAction) (() => this.IsCameraRotationLocked = !this.IsCameraRotationLocked));
  }

  private string GetFormattedDateString()
  {
    string str = DateTime.Now.ToString().Replace(" ", "_").Replace("/", "-").Replace(":", "-");
    return str.Substring(0, str.LastIndexOf("_", StringComparison.Ordinal));
  }

  private void TakeScreenshot()
  {
    string formattedDateString = this.GetFormattedDateString();
    if (Directory.Exists(Directory.GetCurrentDirectory() + Path.DirectorySeparatorChar.ToString() + this.Manager.ScreenshotPath))
    {
      ScreenCapture.CaptureScreenshot(Directory.GetCurrentDirectory() + Path.DirectorySeparatorChar.ToString() + this.Manager.ScreenshotPath + Path.DirectorySeparatorChar.ToString() + "sc_" + formattedDateString + "_#" + (object) this.screenshotCount + ".png", this.Manager.ScreeshotResolutionFactor);
    }
    else
    {
      string currentDirectory = Directory.GetCurrentDirectory();
      char directorySeparatorChar = Path.DirectorySeparatorChar;
      string str1 = directorySeparatorChar.ToString();
      string screenshotPath = this.Manager.ScreenshotPath;
      directorySeparatorChar = Path.DirectorySeparatorChar;
      string str2 = directorySeparatorChar.ToString();
      Directory.CreateDirectory(currentDirectory + str1 + screenshotPath + str2);
      ScreenCapture.CaptureScreenshot(Directory.GetCurrentDirectory() + Path.DirectorySeparatorChar.ToString() + this.Manager.ScreenshotPath + Path.DirectorySeparatorChar.ToString() + "sc_" + formattedDateString + "_#" + (object) this.screenshotCount + ".png");
    }
    ++this.screenshotCount;
  }

  private void AdjustCameraSpeed()
  {
    if (this.input.GetButtonUp(DigitalInput.FreeroamDPadLeft))
    {
      --this.cameraSpeedIndex;
      if (this.cameraSpeedIndex < 0)
        this.cameraSpeedIndex = 4;
      this.SetCameraSpeed(this.cameraSpeedIndex % 5);
    }
    if (!this.input.GetButtonUp(DigitalInput.FreeroamDPadRight))
      return;
    ++this.cameraSpeedIndex;
    this.SetCameraSpeed(this.cameraSpeedIndex % 5);
  }

  private void CycleThroughPlayersAndCameraPoses()
  {
    if (this.input.GetButtonUp(DigitalInput.FreeroamDPadUp))
      ++this.playerIndex;
    if (!this.input.GetButtonUp(DigitalInput.FreeroamDPadDown))
      return;
    --this.playerIndex;
    if (this.playerIndex >= 0)
      return;
    this.playerIndex = this.playerGroup.GetEntities().Length - 1;
  }

  private void AdjustFOV()
  {
    if (!this.input.GetButton(DigitalInput.FreeroamLeftTrigger2) && this.input.GetButton(DigitalInput.FreeroamRightTrigger2) && this.input.GetButton(DigitalInput.FreeroamDPadUp))
      ++this.scCamera.fov;
    if (this.input.GetButton(DigitalInput.FreeroamLeftTrigger2) || !this.input.GetButton(DigitalInput.FreeroamRightTrigger2) || !this.input.GetButton(DigitalInput.FreeroamDPadDown))
      return;
    --this.scCamera.fov;
  }

  public void SetFov(float fov) => this.scCamera.fov = fov;

  public float GetCameraFov() => (UnityEngine.Object) this.scCamera != (UnityEngine.Object) null ? this.scCamera.fov : -1f;

  private void DisableUiHotkeys()
  {
    this.sceneCanvases = UnityEngine.Object.FindObjectsOfType<Canvas>();
    if (this.IsSpectatorCamera)
    {
      if (!this.input.GetButtonUp(DigitalInput.FreeroamSButton))
        return;
      if ((UnityEngine.Object) this.ui != (UnityEngine.Object) null)
        this.ui.SetActive(this.toggleUi);
      if ((UnityEngine.Object) this.debugUi != (UnityEngine.Object) null)
        this.debugUi.SetActive(this.toggleUi);
      if ((UnityEngine.Object) this.debugNetworkUi != (UnityEngine.Object) null)
        this.debugNetworkUi.SetActive(this.toggleUi);
      if ((UnityEngine.Object) this.debugFPSUi != (UnityEngine.Object) null)
        this.debugFPSUi.SetActive(this.toggleFreeRoamUi);
      this.freeroamCameraUi.ToggleUI(this.toggleUi);
      this.DisableAllUi(this.toggleUi);
      this.toggleUi = !this.toggleUi;
    }
    else
    {
      if (!this.input.GetButtonUp(DigitalInput.FreeroamRightJoystickButton))
        return;
      if ((UnityEngine.Object) this.ui != (UnityEngine.Object) null)
        this.ui.SetActive(this.toggleUi);
      if ((UnityEngine.Object) this.debugUi != (UnityEngine.Object) null)
        this.debugUi.SetActive(this.toggleUi);
      if ((UnityEngine.Object) this.debugNetworkUi != (UnityEngine.Object) null)
        this.debugNetworkUi.SetActive(this.toggleUi);
      if ((UnityEngine.Object) this.debugFPSUi != (UnityEngine.Object) null)
        this.debugFPSUi.SetActive(this.toggleFreeRoamUi);
      this.freeroamCameraUi.ToggleUI(this.toggleUi);
      this.DisableAllUi(this.toggleUi);
      this.toggleUi = !this.toggleUi;
    }
  }

  private void DisableAllUi(bool isEnabled)
  {
    foreach (Canvas sceneCanvase in this.sceneCanvases)
    {
      if ((UnityEngine.Object) sceneCanvase.transform.parent != (UnityEngine.Object) null)
      {
        if (sceneCanvase.transform.parent.gameObject.name != "Emissive")
          sceneCanvase.enabled = isEnabled;
      }
      else if (sceneCanvase.gameObject.name != "Debug_ConnectionUI")
        sceneCanvase.enabled = isEnabled;
    }
    GameEntity firstLocalEntity = Contexts.sharedInstance.game.GetFirstLocalEntity();
    if (firstLocalEntity == null || !firstLocalEntity.hasUnityView)
      return;
    firstLocalEntity.unityView.gameObject.GetComponentInChildren<Player3DArrow>(true).gameObject.SetActive(this.toggleUi);
  }

  private void ActivatePlayerFollow(GameObject go)
  {
    this.IsFollowingPlayer = !this.IsFollowingPlayer;
    if (!((UnityEngine.Object) go != (UnityEngine.Object) null))
      return;
    this.customOffset = this.transform.position - go.transform.position;
  }

  private void TogglePlayerControl()
  {
    if (!this.IsControllingPlayer)
      this.Manager.EnableInput("Champions");
    else
      this.Manager.DisableInput("Champions");
    this.IsControllingPlayer = !this.IsControllingPlayer;
  }

  private void MoveAndRotate(GameObject go)
  {
    float x = this.input.GetAnalogInput(AnalogInput.FreeroamLeftStick).x;
    float y = this.input.GetAnalogInput(AnalogInput.FreeroamLeftStick).y;
    float num = (float) ((this.input.GetButton(DigitalInput.FreeroamRightTrigger2) ? 1.0 : 0.0) - (this.input.GetButton(DigitalInput.FreeroamLeftTrigger2) ? 1.0 : 0.0));
    if (!this.IsCameraMovementLocked)
      this.transform.Translate(x * this.MoveSpeed * Time.deltaTime, num * this.MoveSpeed * Time.deltaTime, y * this.MoveSpeed * Time.deltaTime);
    if (!this.IsCameraRotationLocked)
    {
      this.transform.Rotate(Vector3.up, this.input.GetAnalogInput(AnalogInput.FreeroamRightStick).x * this.LookSpeed * Time.deltaTime);
      this.transform.Rotate(Vector3.left, this.input.GetAnalogInput(AnalogInput.FreeroamRightStick).y * this.LookSpeed * Time.deltaTime);
      if (this.input.GetButton(DigitalInput.FreeroamLeftTrigger1))
        this.transform.Rotate(Vector3.forward, this.LookSpeed * Time.deltaTime);
      if (this.input.GetButton(DigitalInput.FreeroamRightTrigger1))
        this.transform.Rotate(Vector3.forward, -this.LookSpeed * Time.deltaTime);
    }
    if (this.LookAtPlayerFace && this.LookAtPlayer)
    {
      this.LookAtPlayer = false;
      this.LookAtPlayerFace = false;
    }
    if (this.LookAtPlayerFace)
      this.transform.LookAt(go.transform.position + new Vector3(0.0f, 2f, 0.0f));
    if (this.LookAtPlayer)
      this.transform.LookAt(go.transform.position);
    if (!this.input.GetButton(DigitalInput.FreeroamRightTrigger1) || !this.input.GetButton(DigitalInput.FreeroamLeftTrigger1))
      return;
    Vector3 forward = this.transform.forward;
    this.transform.up = Vector3.up;
    this.transform.forward = forward;
  }

  private void SetupCameraPose(int playerIdx, int cameraPose)
  {
    GameObject gameObject = this.playerGroup.GetEntities()[playerIdx].unityView.gameObject;
    if (!((UnityEngine.Object) gameObject != (UnityEngine.Object) null))
      return;
    CameraPose cameraPose1 = (CameraPose) null;
    this.dict.TryGetValue(cameraPose % this.dict.Count, out cameraPose1);
    this.ActiveCameraPose = cameraPose1 == null ? string.Concat((object) (FreeroamCamera.CameraPoseType) (cameraPose % this.dict.Count)) : (!string.IsNullOrEmpty(cameraPose1.fileName) ? cameraPose1.fileName : string.Concat((object) (FreeroamCamera.CameraPoseType) (cameraPose % this.dict.Count)));
    if (cameraPose % this.dict.Count == 0)
    {
      this.transform.position = (Vector3) cameraPose1.positionOffset;
      this.transform.rotation = (Quaternion) cameraPose1.rotationOffset;
      this.scCamera.fov = cameraPose1.fov;
    }
    else if (cameraPose % this.dict.Count == 1)
    {
      this.transform.position = gameObject.transform.position + gameObject.transform.forward / 2f + (Vector3) cameraPose1.positionOffset;
      this.transform.rotation = gameObject.transform.rotation;
    }
    else if (cameraPose % this.dict.Count == 2)
    {
      this.transform.position = gameObject.transform.position - gameObject.transform.forward * 2f + (Vector3) cameraPose1.positionOffset;
      this.transform.rotation = gameObject.transform.rotation;
      this.transform.Rotate(Vector3.right * 25f);
    }
    else if (cameraPose % this.dict.Count == 3)
    {
      this.transform.position = gameObject.transform.position - gameObject.transform.forward * 4f + (Vector3) cameraPose1.positionOffset;
      this.transform.rotation = gameObject.transform.rotation;
      this.transform.Rotate(Vector3.right * 30f);
    }
    else if (cameraPose % this.dict.Count == 4)
    {
      this.transform.position = gameObject.transform.position - gameObject.transform.forward * 8f + (Vector3) cameraPose1.positionOffset;
      this.transform.rotation = gameObject.transform.rotation;
      this.transform.Rotate(Vector3.right * 30f);
    }
    else
    {
      this.transform.position = (Vector3) cameraPose1.positionOffset;
      this.scCamera.fov = cameraPose1.fov;
      if (cameraPose1.hasRotation)
        this.transform.rotation = (Quaternion) cameraPose1.rotationOffset;
    }
    this.customOffset = this.transform.position - gameObject.transform.position;
  }

  private void FollowPlayer(int playerIdx)
  {
    GameObject gameObject = this.playerGroup.GetEntities()[playerIdx].unityView.gameObject;
    if (!((UnityEngine.Object) gameObject != (UnityEngine.Object) null))
      return;
    this.transform.position = gameObject.transform.position + this.customOffset;
  }

  public override string ToString()
  {
    string str1 = "";
    string str2 = this.IsFollowingPlayer ? "Is Following Player:" : "Freeroam Mode";
    string str3 = this.LookAtPlayer ? "Is Looking at Player:" : str2;
    string str4 = this.LookAtPlayerFace ? "Is Looking at Player Face:" : str3;
    return str1 + str4 + "\n" + this.ActiveCharacter + "\n" + "\n" + "CameraSpeed:  " + this.GetCameraSpeedString(this.cameraSpeedIndex % 5) + "\n" + "CameraFOV:  " + (object) this.scCamera.fov + "\n";
  }

  private void SetCameraSpeed(int camSpeedMode)
  {
    switch (camSpeedMode)
    {
      case 0:
        this.MoveSpeed = 1f;
        this.LookSpeed = 5f;
        break;
      case 1:
        this.MoveSpeed = 10f;
        this.LookSpeed = 35f;
        break;
      case 2:
        this.MoveSpeed = 20f;
        this.LookSpeed = 50f;
        break;
      case 3:
        this.MoveSpeed = 50f;
        this.LookSpeed = 75f;
        break;
      case 4:
        this.MoveSpeed = 100f;
        this.LookSpeed = 100f;
        break;
      default:
        this.MoveSpeed = 10f;
        this.LookSpeed = 35f;
        break;
    }
  }

  private string GetCameraSpeedString(int camSpeedMode)
  {
    switch (camSpeedMode)
    {
      case 0:
        return "<color=green>Very Slow</color>";
      case 1:
        return "<color=green>Slow</color>";
      case 2:
        return "<color=yellow>Medium</color>";
      case 3:
        return "<color=orange>Fast</color>";
      case 4:
        return "<color=red>Very Fast</color>";
      default:
        return "<color=green>Slow</color>";
    }
  }

  public void SetFreeRoamCameraUi(FreeroamCameraUI ui) => this.freeroamCameraUi = ui;

  public void SetScCamera(SCCamera sCCamera) => this.scCamera = sCCamera;

  private void TogglePlayerModels()
  {
    foreach (GameEntity entity in this.playerGroup.GetEntities())
      entity.unityView.gameObject.transform.Find("ViewContainer").gameObject.SetActive(this.togglePlayers);
    if (this.pUis == null)
    {
      this.pUis = UnityEngine.Object.FindObjectsOfType<PlayerFloorUI>();
      Debug.Log((object) string.Format("{0}", (object) this.pUis.Length));
    }
    foreach (Component pUi in this.pUis)
      pUi.gameObject.SetActive(this.togglePlayers);
    this.togglePlayers = !this.togglePlayers;
  }

  public void SetupCamerasWithArenaConfig(ArenaConfig config)
  {
    this.scCamera.SetSkyboxes(config.skybox, config.skybox);
    PostProcessVolume generalPostProcessing;
    PostProcessVolume colorGrading;
    this.scCamera.GetPostprocessingVolumes(out generalPostProcessing, out colorGrading);
    generalPostProcessing.profile = config.profile;
    generalPostProcessing.enabled = (UnityEngine.Object) config.profile != (UnityEngine.Object) null;
    colorGrading.profile = config.colorGrading;
    colorGrading.enabled = (UnityEngine.Object) config.profile != (UnityEngine.Object) null;
  }

  private void OnDestroy()
  {
    if (!((UnityEngine.Object) this.freeroamCameraUi != (UnityEngine.Object) null))
      return;
    UnityEngine.Object.Destroy((UnityEngine.Object) this.freeroamCameraUi.gameObject);
  }

  public enum CameraPoseType
  {
    Freeroam,
    Ego,
    ThirdPerson_Near,
    ThirdPerson_Halfway,
    ThirdPerson_Far,
    custom_01,
    custom_02,
    custom_03,
    custom_04,
    custom_05,
  }
}
