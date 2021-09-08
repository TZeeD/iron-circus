// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.OnChampionSelectedInGallery
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using SharedWithServer.ScEvents;
using SteelCircus.UI.Menu.ChampionGallery;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI
{
  public class OnChampionSelectedInGallery : 
    MonoBehaviour,
    IPointerClickHandler,
    IEventSystemHandler,
    ISubmitHandler,
    ISelectHandler,
    IDeselectHandler,
    IPointerEnterHandler,
    IPointerExitHandler
  {
    public ChampionTurntableUI turntableUi;
    public ChampionConfig championConfig;
    public ChampionDescriptions championDescription;
    public MenuObject championGalleryMenu;
    public MenuObject championPageMenu;
    private int skinIndex;
    private bool isSelected;
    private float selectedTime;
    private float triggerActionInTime;

    public void OnPointerClick(PointerEventData eventData)
    {
      this.championDescription.activeChampion = this.championConfig;
      this.SelectChamp();
      this.championGalleryMenu.SetHighlightedButton((Selectable) this.GetComponent<Button>());
    }

    public void OnSubmit(BaseEventData eventData)
    {
      this.championDescription.activeChampion = this.championConfig;
      this.SelectChamp();
      this.championGalleryMenu.SetHighlightedButton((Selectable) this.GetComponent<Button>());
    }

    private void SelectChamp()
    {
      Events.Global.FireEventSelectChampion(this.championConfig.championType, this.skinIndex, false);
      this.isSelected = false;
      this.turntableUi.SetChampSubmitted();
      this.championPageMenu.ShowMenu(2);
      AudioController.Play("SelectChampion");
    }

    public void OnSelect(BaseEventData eventData)
    {
      this.championDescription.activeChampion = this.championConfig;
      MenuController.Instance.championGallery.GetComponent<StyleGalleryBackground>().StyleChampionInfo(this.championConfig);
      this.ResetTurntableActionTimer();
      this.SetTurntableChampion();
      this.FillChampionScreenInfo();
      this.FillChampionRotationInfo();
      this.SetChampionPagePanels();
    }

    private void SetTurntableChampion()
    {
      this.turntableUi.SetActiveChampion(this.championConfig);
      this.turntableUi.SetChampSelected();
    }

    public void OnDeselect(BaseEventData eventData) => this.isSelected = false;

    public void OnPointerEnter(PointerEventData eventData)
    {
      this.championDescription.activeChampion = this.championConfig;
      this.championGalleryMenu.SetHighlightedButton((Selectable) this.GetComponent<Button>());
      MenuController.Instance.championGallery.GetComponent<StyleGalleryBackground>().StyleChampionInfo(this.championConfig);
      this.ResetTurntableActionTimer();
      this.SetTurntableChampion();
      this.SetChampionPagePanels();
    }

    private void SetChampionPagePanels() => this.championPageMenu.GetComponent<ChampionPage>().UpdateSubPanels();

    private void FillChampionScreenInfo()
    {
      if ((Object) this.championDescription == (Object) null)
        this.championDescription = Object.FindObjectOfType<ChampionDescriptions>();
      if (!((Object) this.championDescription != (Object) null))
        return;
      this.championDescription.FillSkillData(this.championConfig);
    }

    private void FillChampionRotationInfo()
    {
      if ((Object) this.championDescription == (Object) null)
        this.championDescription = Object.FindObjectOfType<ChampionDescriptions>();
      if (!((Object) this.championDescription != (Object) null))
        return;
      this.championDescription.SetWeeklyRotationInfo(this.championConfig);
    }

    public void OnPointerExit(PointerEventData eventData) => this.isSelected = false;

    private void Start()
    {
      if (!((Object) MenuController.Instance.buttonFocusManager.currentlySelectedButton == (Object) this.GetComponent<Selectable>()))
        return;
      this.OnSelect((BaseEventData) null);
      this.isSelected = true;
    }

    private void Update()
    {
      if (!this.isSelected || (double) Time.time <= (double) this.selectedTime + (double) this.triggerActionInTime)
        return;
      this.turntableUi.TriggerChampSelectedAction(0);
      this.ResetTurntableActionTimer();
    }

    private void ResetTurntableActionTimer()
    {
      this.selectedTime = Time.time;
      this.triggerActionInTime = Random.Range(7f, 20f);
      this.isSelected = true;
    }
  }
}
