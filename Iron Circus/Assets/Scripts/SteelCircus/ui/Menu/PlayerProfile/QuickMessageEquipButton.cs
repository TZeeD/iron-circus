// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.PlayerProfile.QuickMessageEquipButton
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace SteelCircus.UI.Menu.PlayerProfile
{
  public class QuickMessageEquipButton : 
    MonoBehaviour,
    ISubmitHandler,
    IEventSystemHandler,
    IPointerClickHandler
  {
    public int quickMessageNr;
    private QuickMessageButtonGenerator buttonGenerator;
    public GameObject checkMark;

    public void StyleButton(
      int messageNr,
      QuickMessageButtonGenerator buttonGenerator,
      bool equipped = false)
    {
      this.buttonGenerator = buttonGenerator;
      this.quickMessageNr = messageNr;
      if (equipped)
      {
        this.GetComponentInChildren<TextMeshProUGUI>().color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
        this.checkMark.SetActive(true);
      }
      else
        this.checkMark.SetActive(false);
      this.GetComponentInChildren<TextMeshProUGUI>().text = ImiServices.Instance.LocaService.GetLocalizedValue("@Quickmessage" + (object) this.quickMessageNr);
    }

    public void OnSubmit(BaseEventData eventData) => this.OpenQuickMessageEquipWheel(this.quickMessageNr);

    private void OpenQuickMessageEquipWheel(int quickMessageNr) => this.buttonGenerator.ShowEquipWheel(quickMessageNr);

    public void OnPointerClick(PointerEventData eventData) => this.OpenQuickMessageEquipWheel(this.quickMessageNr);
  }
}
