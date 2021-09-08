// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.GameElements.OnChampionSelected
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using SharedWithServer.ScEvents;
using SteelCircus.UI;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Imi.SteelCircus.GameElements
{
  public class OnChampionSelected : 
    MonoBehaviour,
    IPointerClickHandler,
    IEventSystemHandler,
    IPointerEnterHandler,
    IPointerExitHandler,
    ISubmitHandler,
    ISelectHandler,
    IDeselectHandler
  {
    public ChampionTurntableUI turntableUi;
    public ChampionConfig championConfig;
    public int skinIndex;
    public bool useSavedSkinIndex;
    public bool usePointerEnter;
    public bool SetPlayerReadyOnServer;
    public int pickOrder;
    private bool buttonIsDisabled;
    private bool isSelected;
    private float selectedTime;
    private float triggerActionInTime;
    [SerializeField]
    private DebugLobbySkillDescription champDescription;
    [SerializeField]
    private ChampionDescriptions champDescription2;

    private void Start()
    {
      this.LoadSavedSkinForChampion();
      this.champDescription = Object.FindObjectOfType<DebugLobbySkillDescription>();
      this.champDescription2 = Object.FindObjectOfType<ChampionDescriptions>();
    }

    public void OnPointerClick(PointerEventData eventData)
    {
      if (this.buttonIsDisabled)
        return;
      this.SelectChamp();
      this.FillChampionSkillInfoTile();
    }

    public void OnSubmit(BaseEventData eventData)
    {
      if (this.buttonIsDisabled)
        return;
      this.SelectChamp();
      this.FillChampionScreenInfo();
    }

    private void SelectChamp()
    {
      Events.Global.FireEventSelectChampion(this.championConfig.championType, this.skinIndex, this.SetPlayerReadyOnServer);
      this.isSelected = false;
    }

    public void OnSelect(BaseEventData eventData)
    {
      this.ResetTurntableActionTimer();
      this.FillChampionSkillInfoTile();
      this.FillChampionScreenInfo();
    }

    private void FillChampionSkillInfoTile()
    {
      if ((Object) this.champDescription == (Object) null)
        this.champDescription = Object.FindObjectOfType<DebugLobbySkillDescription>();
      if (!((Object) this.champDescription != (Object) null))
        return;
      this.champDescription.FillSkillData(this.championConfig);
    }

    private void FillChampionScreenInfo()
    {
      this.champDescription2 = Object.FindObjectOfType<ChampionDescriptions>();
      if (!((Object) this.champDescription2 != (Object) null))
        return;
      this.champDescription2.FillSkillData(this.championConfig);
    }

    private void LoadSavedSkinForChampion()
    {
      if (!this.useSavedSkinIndex)
        return;
      if (PlayerPrefs.HasKey(this.championConfig.displayName))
        this.skinIndex = PlayerPrefs.GetInt(this.championConfig.displayName);
      else
        this.skinIndex = 0;
    }

    public void OnDeselect(BaseEventData eventData) => this.isSelected = false;

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
      this.triggerActionInTime = Random.Range(45f, 60f);
      this.isSelected = true;
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
      if (!this.usePointerEnter || !this.GetComponent<Button>().interactable)
        return;
      this.ResetTurntableActionTimer();
      this.FillChampionSkillInfoTile();
    }

    public void OnPointerExit(PointerEventData eventData)
    {
      if (!this.usePointerEnter)
        return;
      int num = this.GetComponent<Button>().interactable ? 1 : 0;
    }

    public void SetButtonDisabled(bool isDisabled) => this.buttonIsDisabled = isDisabled;
  }
}
