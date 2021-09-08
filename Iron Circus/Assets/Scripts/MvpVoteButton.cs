// Decompiled with JetBrains decompiler
// Type: MvpVoteButton
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Extensions;
using Imi.Game;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class MvpVoteButton : 
  MonoBehaviour,
  IPointerClickHandler,
  IEventSystemHandler,
  IPointerEnterHandler,
  IPointerExitHandler,
  ISubmitHandler,
  ISelectHandler,
  IDeselectHandler
{
  private static readonly string upvoteAudioString = "LobbyMatchCountdown";
  private static readonly string upvoteAudioStringFinal = "LobbyMatchCountdownFinal";
  [SerializeField]
  private TextMeshProUGUI voteCountBtnTxt;
  [SerializeField]
  private TextMeshProUGUI voteCountImgTxt;
  [SerializeField]
  private Image voteBtnArrowImg;
  [SerializeField]
  private GameObject voteStateText;
  [SerializeField]
  private GameObject voteStateBG;
  [SerializeField]
  private GameObject voteStateBorder;
  [SerializeField]
  private Image thumbsUpImg;
  [SerializeField]
  private Image thumbsUpImgGlow;
  [SerializeField]
  private GameObject voteSelectedBorder;
  private int votes;
  private int voteTextState = -1;
  private bool localPlayerAlreadyVoted;
  private Team team;

  public void SetUi(int playerVotes, Team playerTeam)
  {
    this.votes = playerVotes;
    this.team = playerTeam;
    this.voteCountBtnTxt.text = this.votes.ToString();
    this.voteCountImgTxt.text = this.votes.ToString();
    if (this.team == Team.Alpha)
      this.voteCountBtnTxt.color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
    else
      this.voteCountBtnTxt.color = SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight;
    switch (playerVotes)
    {
      case 0:
      case 1:
        if (this.voteTextState != 0)
        {
          this.SetVoteTextState(0);
          break;
        }
        break;
      case 2:
      case 3:
        if (this.voteTextState != 1)
        {
          this.SetVoteTextState(1);
          break;
        }
        break;
      case 4:
      case 5:
        if (this.voteTextState != 2)
        {
          this.SetVoteTextState(2);
          break;
        }
        break;
      case 6:
        if (this.voteTextState != 3)
        {
          this.SetVoteTextState(3);
          break;
        }
        break;
    }
    this.EnableVoteUi();
  }

  public void SetVoteTextState(int state)
  {
    this.voteTextState = state;
    Animator component1 = this.voteStateBG.GetComponent<Animator>();
    TextMeshProUGUI component2 = this.voteStateText.GetComponent<TextMeshProUGUI>();
    switch (state)
    {
      case 0:
        component2.text = "";
        component1.SetTrigger("hide");
        this.voteStateBG.SetActive(false);
        break;
      case 1:
        component2.text = ImiServices.Instance.LocaService.GetLocalizedValue("@UpvoteMessageNice");
        component1.SetTrigger("show");
        AudioController.Play(MvpVoteButton.upvoteAudioString);
        this.voteStateBG.SetActive(true);
        break;
      case 2:
        component2.text = ImiServices.Instance.LocaService.GetLocalizedValue("@UpvoteMessageAwesome");
        component1.SetTrigger("upgrade");
        AudioController.Play(MvpVoteButton.upvoteAudioString);
        this.voteStateBG.SetActive(true);
        break;
      case 3:
        component2.text = ImiServices.Instance.LocaService.GetLocalizedValue("@UpvoteMessageLegendary");
        component1.SetTrigger("upgrade");
        AudioController.Play(MvpVoteButton.upvoteAudioStringFinal);
        this.voteStateBG.SetActive(true);
        break;
    }
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.voteStateBG.GetComponent<RectTransform>());
  }

  public void EnableVoteUi()
  {
    if (this.localPlayerAlreadyVoted)
    {
      if (this.votes > 0)
      {
        this.SetSecondaryVoteCountUiActive(true);
        this.SetVoteCountContainerUiActive();
        this.GetComponent<Button>().interactable = false;
        this.thumbsUpImgGlow.gameObject.SetActive(false);
        this.thumbsUpImg.color = this.thumbsUpImg.color.WithAlpha(0.3f);
      }
      else
      {
        this.SetSecondaryVoteCountUiActive(true);
        this.SetVoteCountContainerUiActive();
        this.GetComponent<Button>().interactable = false;
        this.thumbsUpImgGlow.gameObject.SetActive(false);
        this.thumbsUpImg.color = this.thumbsUpImg.color.WithAlpha(0.3f);
      }
    }
    else
    {
      this.SetVoteButtonUiActive();
      if (this.votes > 0)
        this.SetSecondaryVoteCountUiActive(true);
      else
        this.SetSecondaryVoteCountUiActive(true);
    }
  }

  private void SetVoteCountContainerUiActive() => this.voteCountBtnTxt.gameObject.SetActive(true);

  private void SetVoteButtonUiActive() => this.voteBtnArrowImg.gameObject.SetActive(true);

  private void SetSecondaryVoteCountUiActive(bool active) => this.voteCountImgTxt.gameObject.SetActive(active);

  public void OnPointerClick(PointerEventData eventData)
  {
  }

  public void OnPointerEnter(PointerEventData eventData)
  {
    if (this.localPlayerAlreadyVoted)
      return;
    this.EnableVoteUi();
    this.SetSelected();
  }

  public void OnPointerExit(PointerEventData eventData)
  {
    this.EnableVoteUi();
    this.SetDeselected();
  }

  public void OnSubmit(BaseEventData eventData)
  {
  }

  public void OnSelect(BaseEventData eventData)
  {
    this.EnableVoteUi();
    this.SetSelected();
    this.thumbsUpImgGlow.gameObject.SetActive(true);
  }

  public void OnDeselect(BaseEventData eventData)
  {
    this.EnableVoteUi();
    this.SetDeselected();
    this.thumbsUpImgGlow.gameObject.SetActive(false);
  }

  private void SetSelected()
  {
    this.voteSelectedBorder.SetActive(true);
    if (this.team == Team.Alpha)
      this.voteSelectedBorder.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team1ColorLight;
    else
      this.voteSelectedBorder.GetComponent<Image>().color = SingletonScriptableObject<ColorsConfig>.Instance.team2ColorLight;
  }

  private void SetDeselected() => this.voteSelectedBorder.SetActive(false);

  public void StyleVoteButtonsAfterVote()
  {
    this.localPlayerAlreadyVoted = true;
    this.EnableVoteUi();
  }
}
