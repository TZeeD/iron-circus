// Decompiled with JetBrains decompiler
// Type: SteelCircus.ui.PauseUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

namespace SteelCircus.ui
{
  public class PauseUI : MonoBehaviour
  {
    private const string MENU_SCENE_NAME = "MenuScene";
    [SerializeField]
    private GameObject pauseUI;
    [SerializeField]
    private GameObject controlsScreen;

    private void Start()
    {
    }

    private void Update()
    {
    }

    public void TogglePause() => this.StartCoroutine(this.TogglePauseCR());

    public IEnumerator TogglePauseCR()
    {
      yield return (object) null;
      if ((double) Math.Abs(Time.timeScale) < (double) Mathf.Epsilon && this.pauseUI.activeSelf)
      {
        Time.timeScale = 1f;
        this.pauseUI.SetActive(false);
      }
      else if (!this.pauseUI.activeSelf)
      {
        Time.timeScale = 0.0f;
        this.pauseUI.SetActive(true);
        this.SetContinueBtnSelected();
      }
    }

    public void Exit()
    {
      SceneManager.LoadScene("MenuScene");
      Time.timeScale = 1f;
    }

    public void ShowControls(bool show)
    {
      this.controlsScreen.SetActive(show);
      this.pauseUI.SetActive(!show);
      if (show)
        this.SetCtrlsReturnBtnSelected();
      else
        this.SetCtrlsBtnSelected();
    }

    private void SetContinueBtnSelected()
    {
      GameObject gameObject = this.pauseUI.transform.Find("Btn_Continue").gameObject;
      UnityEngine.Object.FindObjectOfType<EventSystem>().SetSelectedGameObject(gameObject);
    }

    private void SetCtrlsBtnSelected()
    {
      GameObject gameObject = this.pauseUI.transform.Find("Btn_Controls").gameObject;
      UnityEngine.Object.FindObjectOfType<EventSystem>().SetSelectedGameObject(gameObject);
    }

    private void SetCtrlsReturnBtnSelected()
    {
      GameObject gameObject = this.controlsScreen.transform.Find("Btn_Return").gameObject;
      UnityEngine.Object.FindObjectOfType<EventSystem>().SetSelectedGameObject(gameObject);
    }
  }
}
