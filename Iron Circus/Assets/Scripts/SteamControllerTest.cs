// Decompiled with JetBrains decompiler
// Type: SteamControllerTest
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Steamworks;
using SteelCircus.UI;
using System.IO;
using UnityEngine;
using UnityEngine.UI;

public class SteamControllerTest : MonoBehaviour
{
  private ControllerActionSetHandle_t ingameActionSet;
  private ControllerActionSetHandle_t menuActionSet;
  private ControllerDigitalActionHandle_t submitHandle;
  private ControllerDigitalActionHandle_t menuUpHandle;
  private ControllerDigitalActionHandle_t menuDownHandle;
  private ControllerDigitalActionHandle_t menuLeftHandle;
  private ControllerDigitalActionHandle_t menuRightHandle;
  [SerializeField]
  private RawImage[] glyphImages;
  [SerializeField]
  private GameObject glyphGroup;
  private ControllerAnalogActionHandle_t menuGyroTestHandle;
  private ControllerAnalogActionHandle_t menuTriggerTestHandle;
  private ControllerHandle_t[] allControllerHandles;
  private ControllerHandle_t handleForAllControllers;
  private ControllerHandle_t player0Input;
  [SerializeField]
  private GameObject upImage;
  [SerializeField]
  private GameObject downImage;
  [SerializeField]
  private GameObject leftImage;
  [SerializeField]
  private GameObject rightImage;
  [SerializeField]
  private GameObject submitImage;
  [SerializeField]
  private GameObject gyroTestImage;
  private bool controllerFound;
  private ControllerDigitalActionData_t submitData;
  private ControllerDigitalActionData_t menuUpData;
  private ControllerDigitalActionData_t menuDownData;
  private ControllerDigitalActionData_t menuLeftData;
  private ControllerDigitalActionData_t menuRightData;
  private ControllerAnalogActionData_t menuGyroTestData;
  private ControllerAnalogActionData_t menuTriggerTestData;

  private void Start()
  {
    if (SteamManager.Initialized)
      Debug.Log((object) ("STEAMMANAGER - NAME: " + SteamFriends.GetPersonaName()));
    Debug.Log((object) ("SteamId:" + (object) SteamUser.GetSteamID()));
    Debug.Log((object) ("AppId: " + (object) SteamUtils.GetAppID()));
    Debug.Log((object) ("is steam running: " + SteamAPI.IsSteamRunning().ToString()));
    SteamController.Init();
    this.allControllerHandles = new ControllerHandle_t[16];
    SteamController.GetConnectedControllers(this.allControllerHandles);
    this.handleForAllControllers = new ControllerHandle_t(ulong.MaxValue);
    this.ingameActionSet = SteamController.GetActionSetHandle("IngameControls");
    this.menuActionSet = SteamController.GetActionSetHandle("MenuControls");
    this.submitHandle = SteamController.GetDigitalActionHandle("menu_select");
    this.menuUpHandle = SteamController.GetDigitalActionHandle("menu_up");
    this.menuDownHandle = SteamController.GetDigitalActionHandle("menu_down");
    this.menuRightHandle = SteamController.GetDigitalActionHandle("menu_right");
    this.menuLeftHandle = SteamController.GetDigitalActionHandle("menu_left");
    this.menuGyroTestHandle = SteamController.GetAnalogActionHandle("menugyro");
    this.menuTriggerTestHandle = SteamController.GetAnalogActionHandle("menutriggertest");
  }

  private void pollForGlyphs()
  {
    this.glyphImages[0].texture = (Texture) this.pollForDigitalGlyph(this.player0Input, this.menuActionSet, this.menuUpHandle);
    this.glyphImages[1].texture = (Texture) this.pollForDigitalGlyph(this.player0Input, this.menuActionSet, this.menuDownHandle);
    this.glyphImages[2].texture = (Texture) this.pollForDigitalGlyph(this.player0Input, this.menuActionSet, this.submitHandle);
    this.glyphImages[3].texture = (Texture) this.pollForAnalogGlyph(this.player0Input, this.menuActionSet, this.menuGyroTestHandle);
    this.glyphImages[4].texture = (Texture) this.pollForAnalogGlyph(this.player0Input, this.menuActionSet, this.menuTriggerTestHandle);
  }

  private Texture2D pollForDigitalGlyph(
    ControllerHandle_t playerInput,
    ControllerActionSetHandle_t actionSet,
    ControllerDigitalActionHandle_t actionHandle)
  {
    EControllerActionOrigin[] originsOut = new EControllerActionOrigin[16];
    SteamController.GetDigitalActionOrigins(playerInput, actionSet, actionHandle, originsOut);
    string glyphForActionOrigin = SteamController.GetGlyphForActionOrigin(originsOut[0]);
    Texture2D tex = new Texture2D(256, 256);
    if (!string.IsNullOrEmpty(glyphForActionOrigin))
    {
      byte[] data = File.ReadAllBytes(glyphForActionOrigin);
      tex.LoadImage(data);
    }
    return tex;
  }

  private Texture2D pollForAnalogGlyph(
    ControllerHandle_t playerInput,
    ControllerActionSetHandle_t actionSet,
    ControllerAnalogActionHandle_t actionHandle)
  {
    EControllerActionOrigin[] originsOut = new EControllerActionOrigin[16];
    SteamController.GetAnalogActionOrigins(playerInput, actionSet, actionHandle, originsOut);
    string glyphForActionOrigin = SteamController.GetGlyphForActionOrigin(originsOut[0]);
    Texture2D tex = new Texture2D(1, 1);
    if (!string.IsNullOrEmpty(glyphForActionOrigin))
    {
      byte[] data = File.ReadAllBytes(glyphForActionOrigin);
      tex.LoadImage(data);
    }
    return tex;
  }

  private void Update()
  {
    SteamController.GetConnectedControllers(this.allControllerHandles);
    foreach (ControllerHandle_t controllerHandle in this.allControllerHandles)
    {
      if (controllerHandle.m_ControllerHandle != 0UL)
      {
        this.controllerFound = true;
        this.player0Input = controllerHandle;
      }
    }
    int num = this.controllerFound ? 1 : 0;
    SteamController.RunFrame();
    this.submitData = SteamController.GetDigitalActionData(this.player0Input, this.submitHandle);
    this.menuUpData = SteamController.GetDigitalActionData(this.player0Input, this.menuUpHandle);
    this.menuDownData = SteamController.GetDigitalActionData(this.player0Input, this.menuDownHandle);
    this.menuLeftData = SteamController.GetDigitalActionData(this.player0Input, this.menuLeftHandle);
    this.menuRightData = SteamController.GetDigitalActionData(this.player0Input, this.menuRightHandle);
    this.menuGyroTestData = SteamController.GetAnalogActionData(this.player0Input, this.menuGyroTestHandle);
    this.menuTriggerTestData = SteamController.GetAnalogActionData(this.player0Input, this.menuTriggerTestHandle);
    if (this.controllerFound)
      this.pollForGlyphs();
    if ((Object) MenuController.Instance.gameObject != (Object) null)
    {
      SteamController.ActivateActionSet(this.player0Input, this.menuActionSet);
      this.gyroTestImage.GetComponent<RectTransform>().localRotation = new Quaternion(SteamController.GetMotionData(this.player0Input).rotQuatX, SteamController.GetMotionData(this.player0Input).rotQuatY, SteamController.GetMotionData(this.player0Input).rotQuatZ, SteamController.GetMotionData(this.player0Input).rotQuatW);
      if (this.submitData.bState == (byte) 1)
      {
        this.submitImage.SetActive(true);
        this.gyroTestImage.SetActive(true);
        this.glyphGroup.SetActive(true);
      }
      else
        this.submitImage.SetActive(false);
      if (this.menuUpData.bState == (byte) 1)
        this.upImage.SetActive(true);
      else
        this.upImage.SetActive(false);
      if (this.menuDownData.bState == (byte) 1)
        this.downImage.SetActive(true);
      else
        this.downImage.SetActive(false);
      if (this.menuLeftData.bState == (byte) 1)
        this.leftImage.SetActive(true);
      else
        this.leftImage.SetActive(false);
      if (this.menuRightData.bState == (byte) 1)
        this.rightImage.SetActive(true);
      else
        this.rightImage.SetActive(false);
    }
    else
      SteamController.ActivateActionSet(this.handleForAllControllers, this.ingameActionSet);
  }
}
