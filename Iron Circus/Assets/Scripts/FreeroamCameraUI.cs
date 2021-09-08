// Decompiled with JetBrains decompiler
// Type: FreeroamCameraUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class FreeroamCameraUI : MonoBehaviour
{
  public FreeroamCamera freeRoamCamera;
  private Canvas canvas;
  private Text text;
  public Button togglePlayerLockBtn;
  public Button toggleCameraRotationLockedBtn;
  public Button toggleCameraMoveLockBtn;
  public Button toggleCameraPlayerFollowBtn;
  public Button hideUiBtn;
  public Slider fovSlider;
  public TextMeshProUGUI fovTxt;

  private void Start()
  {
    this.canvas = this.GetComponent<Canvas>();
    this.text = this.GetComponentInChildren<Text>();
    this.fovSlider.onValueChanged.AddListener((UnityAction<float>) (_param1 => this.OnSliderValueChange()));
  }

  private void OnSliderValueChange() => this.freeRoamCamera.SetFov(this.fovSlider.value);

  private void Update()
  {
    if ((Object) this.freeRoamCamera == (Object) null)
      return;
    this.text.text = this.freeRoamCamera.ToString();
    this.fovTxt.text = string.Concat((object) this.freeRoamCamera.GetCameraFov());
  }

  public void SetFreeroamCamera(FreeroamCamera freeroamCamera)
  {
    this.freeRoamCamera = freeroamCamera;
    this.fovSlider.value = this.freeRoamCamera.GetCameraFov();
  }

  public void ToggleUI(bool toggle) => this.canvas.enabled = toggle;

  public void RenderBtns(
    bool isPlayerLocked,
    bool isFollowingPlayer,
    bool isCamRotationLocked,
    bool isCamMoveLocked)
  {
    if (!isPlayerLocked)
    {
      this.togglePlayerLockBtn.GetComponentInChildren<Text>().text = "Player Movement Locked";
      this.togglePlayerLockBtn.GetComponent<Image>().color = Color.red;
    }
    else
    {
      this.togglePlayerLockBtn.GetComponentInChildren<Text>().text = "Player Movement Unlocked";
      this.togglePlayerLockBtn.GetComponent<Image>().color = Color.green;
    }
    if (!isFollowingPlayer)
    {
      this.toggleCameraPlayerFollowBtn.GetComponentInChildren<Text>().text = "Camera Is Not Following Player";
      this.toggleCameraPlayerFollowBtn.GetComponent<Image>().color = Color.red;
    }
    else
    {
      this.toggleCameraPlayerFollowBtn.GetComponentInChildren<Text>().text = "Camera Is Following Player";
      this.toggleCameraPlayerFollowBtn.GetComponent<Image>().color = Color.green;
    }
    if (isCamRotationLocked)
    {
      this.toggleCameraRotationLockedBtn.GetComponentInChildren<Text>().text = "Camera Rotation Locked";
      this.toggleCameraRotationLockedBtn.GetComponent<Image>().color = Color.red;
    }
    else
    {
      this.toggleCameraRotationLockedBtn.GetComponentInChildren<Text>().text = "Camera Rotation Unlocked";
      this.toggleCameraRotationLockedBtn.GetComponent<Image>().color = Color.green;
    }
    if (isCamMoveLocked)
    {
      this.toggleCameraMoveLockBtn.GetComponentInChildren<Text>().text = isFollowingPlayer ? "Camera cannot move while Player moves." : "Camera Movement Locked";
      this.toggleCameraMoveLockBtn.GetComponent<Image>().color = Color.red;
    }
    else
    {
      this.toggleCameraMoveLockBtn.GetComponentInChildren<Text>().text = isFollowingPlayer ? "Camera cannot move while following Player." : "Camera Movement Unlocked";
      this.toggleCameraMoveLockBtn.GetComponent<Image>().color = isFollowingPlayer ? Color.red : Color.green;
    }
  }
}
