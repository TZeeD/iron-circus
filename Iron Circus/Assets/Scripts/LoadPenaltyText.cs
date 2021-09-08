// Decompiled with JetBrains decompiler
// Type: LoadPenaltyText
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SteelCircus.UI.Network;
using SteelCircus.Core.Services;
using System;
using System.Collections;
using TMPro;
using UnityEngine;

public class LoadPenaltyText : MonoBehaviour
{
  [SerializeField]
  private TextMeshProUGUI playeMenuPenaltyText;
  [SerializeField]
  private GameObject playMenuPanelObject;
  [SerializeField]
  private TextMeshProUGUI mainMenuPenaltyText;
  [SerializeField]
  private GameObject mainMenuPanelObject;
  public bool reloadOnEnable;

  private void Start()
  {
    this.ShowPenaltyPanel(false);
    SingletonManager<MetaServiceHelpers>.Instance.StartCoroutine(this.GetPenaltyAfterLogin());
  }

  private void OnEnable()
  {
    if (!this.reloadOnEnable)
      return;
    SingletonManager<MetaServiceHelpers>.Instance.StartCoroutine(this.GetPenaltyAfterLogin());
  }

  public void OnGetPenaltyText(int penaltyCount)
  {
    Log.Debug("Reloading Penalty Message");
    if (penaltyCount > 1)
    {
      this.ShowPenaltyPanel(true);
      if ((UnityEngine.Object) this.playeMenuPenaltyText != (UnityEngine.Object) null)
        this.playeMenuPenaltyText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@PenaltyFlagMessage") + " <b>" + (object) (penaltyCount - 1) + "</b>";
      if (!((UnityEngine.Object) this.mainMenuPenaltyText != (UnityEngine.Object) null))
        return;
      this.mainMenuPenaltyText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@PenaltyFlagMessage") + " <b>" + (object) (penaltyCount - 1) + "</b>";
    }
    else
      this.ShowPenaltyPanel(false);
  }

  private void ShowPenaltyPanel(bool show)
  {
    if ((UnityEngine.Object) this.mainMenuPanelObject != (UnityEngine.Object) null)
      this.mainMenuPanelObject.SetActive(show);
    if (!((UnityEngine.Object) this.playMenuPanelObject != (UnityEngine.Object) null))
      return;
    this.playMenuPanelObject.SetActive(show);
  }

  public IEnumerator GetPenaltyAfterLogin()
  {
    LoadPenaltyText loadPenaltyText = this;
    yield return (object) new WaitUntil((Func<bool>) (() => ImiServices.Instance.LoginService.IsLoginOk()));
    SingletonManager<MetaServiceHelpers>.Instance.StartCoroutine(MetaServiceHelpers.GetPlayerPenalty(ImiServices.Instance.LoginService.GetPlayerId(), new Action<int>(loadPenaltyText.OnGetPenaltyText)));
  }
}
