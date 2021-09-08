// Decompiled with JetBrains decompiler
// Type: OnSelectedChampionAvatarUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.ScriptableObjects;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class OnSelectedChampionAvatarUi : 
  MonoBehaviour,
  IPointerClickHandler,
  IEventSystemHandler,
  ISubmitHandler,
  ISelectHandler,
  IDeselectHandler,
  IPointerEnterHandler,
  IPointerExitHandler
{
  [SerializeField]
  private GameObject background;
  [SerializeField]
  private GameObject championPickedByPlayerUi;
  [SerializeField]
  private GameObject[] selectedChampionIcons;
  [SerializeField]
  private Image championIcon;
  [SerializeField]
  private Text champNameTxt;
  [SerializeField]
  private Material grayscaleMat;
  [SerializeField]
  private GameObject weeklyRotationIcon;
  [Header("Swap Assets")]
  [SerializeField]
  private Sprite solidIcon;
  [SerializeField]
  private Sprite transparentIcon;
  private bool isDisabled;

  private void Awake()
  {
    this.championIcon.material = new Material(this.grayscaleMat);
    this.championIcon.material.SetFloat("_EffectAmount", 0.0f);
  }

  public void OnSelect(BaseEventData eventData) => this.SetSelected();

  public void OnDeselect(BaseEventData eventData) => this.SetDeselected();

  public void OnPointerEnter(PointerEventData eventData) => this.SetSelected();

  public void OnPointerExit(PointerEventData eventData) => this.SetDeselected();

  private void SetSelected() => this.background.SetActive(true);

  private void SetDeselected() => this.background.SetActive(false);

  public void SetChampionButtonData(string championName, Sprite icon)
  {
    this.champNameTxt.text = championName;
    this.championIcon.sprite = icon;
  }

  public void DisableAllSelectedChampionIcons()
  {
    foreach (GameObject selectedChampionIcon in this.selectedChampionIcons)
      selectedChampionIcon.SetActive(false);
  }

  public void EnableIconForPlayer(GameEntity player, int order, PlayerPickingState pickState)
  {
    GameEntity firstLocalEntity = Contexts.sharedInstance.game.GetFirstLocalEntity();
    this.selectedChampionIcons[order].SetActive(true);
    Image component = this.selectedChampionIcons[order].GetComponent<Image>();
    if (firstLocalEntity.uniqueId.id.Equals(player.uniqueId.id))
      component.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
    else
      component.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(firstLocalEntity.playerChampionData.value.team);
    TextMeshProUGUI componentInChildren = this.selectedChampionIcons[order].GetComponentInChildren<TextMeshProUGUI>();
    componentInChildren.text = (order + 1).ToString();
    if (pickState != PlayerPickingState.PostPick)
      return;
    this.SetButtonInactive();
    component.sprite = this.transparentIcon;
    if (firstLocalEntity.uniqueId.id.Equals(player.uniqueId.id))
      componentInChildren.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
    else
      componentInChildren.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(firstLocalEntity.playerChampionData.value.team);
  }

  public void SetButtonInactive()
  {
    this.GetComponent<Button>().interactable = false;
    this.GetComponent<OnChampionSelected>().SetButtonDisabled(true);
    this.championIcon.material.SetFloat("_EffectAmount", 1f);
  }

  public void SetButtonActive()
  {
    this.GetComponent<Button>().interactable = true;
    this.GetComponent<OnChampionSelected>().SetButtonDisabled(false);
    this.championIcon.material.SetFloat("_EffectAmount", 0.0f);
  }

  public void SetWeeklyRotationIcon(bool active) => this.weeklyRotationIcon.SetActive(active);

  public void SetButtonInactive(int order)
  {
    this.GetComponent<Button>().interactable = false;
    this.GetComponent<OnChampionSelected>().SetButtonDisabled(true);
    this.championIcon.material.SetFloat("_EffectAmount", 1f);
    Contexts.sharedInstance.game.GetFirstLocalEntity();
  }

  public void OnPointerClick(PointerEventData eventData)
  {
    if (!this.isDisabled)
      return;
    AudioController.Play("SelectChampionAlreadySelected");
  }

  public void OnSubmit(BaseEventData eventData)
  {
    if (!this.isDisabled)
      return;
    AudioController.Play("SelectChampionAlreadySelected");
  }
}
