// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.LastActiveController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using SteelCircus.UI.Popups;
using System;
using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class LastActiveController : MonoBehaviour
  {
    public string controllerName;
    public GameObject lobby;
    private GraphicRaycaster mainMenuRaycast;

    private void OnEnable()
    {
      this.mainMenuRaycast = this.GetComponent<GraphicRaycaster>();
      if ((UnityEngine.Object) this.mainMenuRaycast == (UnityEngine.Object) null)
        Log.Error("Main Menu Raycaster not found");
      ImiServices.Instance.InputService.lastInputSourceChangedEvent += new Action<InputSource>(this.LastInputSourceChanged);
    }

    private void Update()
    {
    }

    private void ForceChangeToController()
    {
      Cursor.visible = false;
      this.mainMenuRaycast.enabled = false;
      this.StartCoroutine(this.SelectButton(true));
    }

    private void LastInputSourceChanged(InputSource source)
    {
      if (source != InputSource.Keyboard)
      {
        if (source == InputSource.Mouse)
        {
          EventSystem.current.SetSelectedGameObject((GameObject) null);
          Cursor.visible = true;
          this.mainMenuRaycast.enabled = true;
        }
        else
        {
          Cursor.visible = false;
          this.mainMenuRaycast.enabled = false;
          this.StartCoroutine(this.SelectButton());
        }
      }
      else
      {
        Cursor.visible = true;
        this.mainMenuRaycast.enabled = false;
        this.StartCoroutine(this.SelectButton());
      }
    }

    private IEnumerator SelectButton(bool force = false)
    {
      yield return (object) null;
      if ((UnityEngine.Object) EventSystem.current.currentSelectedGameObject == (UnityEngine.Object) null)
      {
        if (PopupManager.Instance.IsActive())
        {
          if (PopupManager.Instance.btnLeft.gameObject.activeInHierarchy)
            PopupManager.Instance.btnLeft.Select();
          else
            PopupManager.Instance.verticalButtons[0].button.Select();
        }
        else
          MenuController.Instance.buttonFocusManager.FocusOnButton(force);
      }
    }

    private void OnDisable() => ImiServices.Instance.InputService.lastInputSourceChangedEvent -= new Action<InputSource>(this.LastInputSourceChanged);
  }
}
