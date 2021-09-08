// Decompiled with JetBrains decompiler
// Type: PlayerArenaLoadedInfoBig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Extensions;
using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.ScriptableObjects;
using Newtonsoft.Json.Linq;
using SteelCircus.UI;
using SteelCircus.UI.Menu;
using System.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class PlayerArenaLoadedInfoBig : MonoBehaviour
{
  [SerializeField]
  private GameObject loadingGroup;
  [SerializeField]
  private GameObject loadingFinishedGroup;
  [SerializeField]
  private RectTransform playerAvatar;
  [SerializeField]
  private SwitchAvatarIcon avatarIconObject;
  [SerializeField]
  private Image loadingBackground;
  [SerializeField]
  private Image usernameBackground;
  [SerializeField]
  private TextMeshProUGUI usernameTxt;
  [SerializeField]
  private TextMeshProUGUI playerLvlTxt;
  private ulong playerId;
  private string twitchUserName;
  private bool playerLevelFetched;
  [Header("Sprites for Background")]
  [SerializeField]
  private Sprite alphaBG;
  [SerializeField]
  private Sprite betaBg;
  [Header("Twitch UI Objects")]
  [SerializeField]
  private GameObject twitchLogo;
  [SerializeField]
  private GameObject viewerCountObject;
  [SerializeField]
  private TextMeshProUGUI viewerCountText;
  [SerializeField]
  private LayoutGroup nameLayoutGroup;
  [SerializeField]
  private LayoutGroup parentLayoutGroup;
  [SerializeField]
  private LayoutGroup viewerCountLayoutGroup;

  private void OnGetPlayerLevel(ulong playerId, JObject obj)
  {
    if (obj["msg"] != null || obj["error"] != null)
      Log.Warning("GetPlayerLevel failed!");
    else
      this.playerLvlTxt.text = obj["currentLevel"].ToString();
  }

  public void OpenTwitchUrl() => Application.OpenURL("https://www.twitch.tv/" + this.twitchUserName);

  public void SetLoadingState(bool finishedLoading)
  {
    if (finishedLoading)
    {
      this.loadingGroup.SetActive(false);
      this.loadingFinishedGroup.SetActive(true);
    }
    else
    {
      this.loadingGroup.SetActive(true);
      this.loadingFinishedGroup.SetActive(false);
    }
  }

  public void SetTwitchUIVisible(
    bool visible,
    bool viewerCountVisible,
    string twitchUserName,
    int viewerCount,
    ulong playerId)
  {
    if (!visible)
    {
      this.usernameTxt.gameObject.GetComponent<Button>().enabled = false;
      this.twitchLogo.SetActive(false);
      this.viewerCountObject.SetActive(false);
    }
    else
    {
      Log.Debug(string.Format("Set TwitchUI visible for {0}, {1}", (object) twitchUserName, (object) playerId));
      this.usernameTxt.gameObject.GetComponent<Button>().enabled = true;
      this.twitchLogo.SetActive(true);
      if (viewerCountVisible)
      {
        this.viewerCountObject.SetActive(true);
        this.viewerCountObject.GetComponent<TwitchViewerCountUpdater>().Initialize(playerId);
      }
      else
        this.viewerCountObject.SetActive(false);
      this.twitchUserName = twitchUserName;
      this.viewerCountText.text = string.Format("{0:n0}", (object) viewerCount);
    }
    this.RebuildLayout();
  }

  private void RebuildLayout()
  {
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.nameLayoutGroup.GetComponent<RectTransform>());
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.viewerCountLayoutGroup.GetComponent<RectTransform>());
    this.StartCoroutine(this.RebuildLayoutDelayed());
  }

  private IEnumerator RebuildLayoutDelayed()
  {
    yield return (object) null;
    LayoutRebuilder.ForceRebuildLayoutImmediate(this.parentLayoutGroup.GetComponent<RectTransform>());
  }

  public void SetTeamStyle(Team team, bool loadingState)
  {
    if (loadingState)
      this.loadingBackground.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(team);
    else
      this.loadingBackground.color = Color.gray.WithAlpha(0.5f);
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.playerId);
    this.usernameBackground.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(team);
    if (entityWithPlayerId.isLocalEntity)
    {
      this.loadingBackground.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
      this.usernameBackground.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
    }
    switch (team)
    {
      case Team.Alpha:
        this.GetComponent<Animator>().SetTrigger("showLeft");
        this.GetComponent<RectTransform>().GetSiblingIndex();
        goto default;
      case Team.Beta:
        this.GetComponent<RectTransform>().GetSiblingIndex();
        this.GetComponent<Animator>().SetTrigger("showLeft");
        this.usernameBackground.sprite = this.betaBg;
        this.usernameBackground.GetComponent<RectTransform>().localScale = new Vector3(-1f, 1f, 1f);
        Vector3 localScale = this.transform.localScale;
        this.transform.localScale = new Vector3(-1f, localScale.y, localScale.z);
        this.loadingBackground.GetComponent<RectTransform>().localScale = new Vector3(-2f, 2f, 1f);
        this.loadingFinishedGroup.GetComponent<RectTransform>().localScale = new Vector3(1f, 1f, 1f);
        this.loadingGroup.GetComponent<RectTransform>().localScale = new Vector3(-1f, 1f, 1f);
        this.playerAvatar.localScale = new Vector3(-1f, 1f, 1f);
        this.usernameTxt.text = entityWithPlayerId.hasPlayerUsername ? entityWithPlayerId.playerUsername.username : "Loading...";
        this.usernameTxt.alignment = TextAlignmentOptions.Left;
        this.usernameTxt.GetComponent<RectTransform>().localScale = new Vector3(-1f, 1f, 1f);
        this.twitchLogo.GetComponent<RectTransform>().anchorMin = new Vector2(1f, 0.5f);
        this.twitchLogo.GetComponent<RectTransform>().anchorMax = new Vector2(1f, 0.5f);
        this.twitchLogo.GetComponent<RectTransform>().anchoredPosition = new Vector2(35f, 0.0f);
        this.twitchLogo.GetComponent<RectTransform>().localScale = new Vector3(-1f, 1f, 1f);
        this.usernameTxt.GetComponent<RectTransform>().pivot = new Vector2(0.5f, 0.5f);
        this.nameLayoutGroup.childAlignment = TextAnchor.MiddleLeft;
        this.viewerCountObject.GetComponent<RectTransform>().localScale = new Vector3(-1f, 1f, 1f);
        break;
      default:
        this.loadingBackground.GetComponent<RectTransform>().localScale = new Vector3(2f, 2f, 1f);
        this.loadingFinishedGroup.GetComponent<RectTransform>().localScale = new Vector3(1f, 1f, 1f);
        this.loadingGroup.GetComponent<RectTransform>().localScale = new Vector3(1f, 1f, 1f);
        this.usernameTxt.text = entityWithPlayerId.hasPlayerUsername ? entityWithPlayerId.playerUsername.username : "Loading...";
        break;
    }
    this.RebuildLayout();
  }

  public void SetPlayerId(ulong pid)
  {
    this.playerId = pid;
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.playerId);
    this.avatarIconObject.SetPlayerID(pid);
    if (this.playerLevelFetched)
      return;
    if (entityWithPlayerId.isFakePlayer)
    {
      this.playerLvlTxt.text = 0.ToString();
      this.playerLevelFetched = true;
    }
    else
    {
      if (!entityWithPlayerId.hasPlayerUsername)
        return;
      if (entityWithPlayerId.playerUsername.playerLevel == 0)
        this.playerLvlTxt.text = "?";
      else
        this.playerLvlTxt.text = entityWithPlayerId.playerUsername.playerLevel.ToString();
    }
  }

  private void OnDisable()
  {
    if (!((Object) ToolTipManager.Instance != (Object) null))
      return;
    ToolTipManager.Instance.HideTooltip();
  }
}
