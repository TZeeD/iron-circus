// Decompiled with JetBrains decompiler
// Type: MVPPlayerAvatar
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.ScriptableObjects;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class MVPPlayerAvatar : MonoBehaviour
{
  [SerializeField]
  private Image champIcon;
  [SerializeField]
  private Image outineBg;
  [SerializeField]
  private Image glowBg;
  [SerializeField]
  private TextMeshProUGUI usernameTxt;
  [SerializeField]
  private TextMeshProUGUI lvlText;
  [SerializeField]
  private GameObject alphaMvpParticles;
  [SerializeField]
  private GameObject betaMvpParticles;
  [SerializeField]
  private GameObject twitchViewerCountObject;
  private string username;
  public ulong PlayerId;
  private Team team;
  private ChampionType championType;
  private readonly string championAvatarIconPath = "UI/MVP/";

  public void SetMvpAvatar(
    Team playerTeam,
    ChampionType championType,
    ulong playerId,
    string playerUsername,
    bool twitchUserName = false)
  {
    this.PlayerId = playerId;
    this.team = playerTeam;
    this.username = playerUsername;
    this.championType = championType;
    this.lvlText.text = "-";
    if (twitchUserName)
    {
      this.usernameTxt.gameObject.GetComponentInChildren<Button>().enabled = true;
    }
    else
    {
      this.usernameTxt.gameObject.GetComponentInChildren<Button>().enabled = false;
      this.twitchViewerCountObject.SetActive(false);
    }
    this.UpdateUi();
  }

  public void OpenTwitchPage() => Application.OpenURL("https://www.twitch.tv/" + this.username);

  public void SetLevel(string level) => this.lvlText.text = level;

  private void UpdateUi()
  {
    this.outineBg.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(this.team);
    this.glowBg.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(this.team);
    this.usernameTxt.text = this.username;
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.PlayerId);
    if (entityWithPlayerId != null && entityWithPlayerId.hasPlayerLoadout && (Object) entityWithPlayerId.playerLoadout.PlayerAvatarSprite != (Object) null)
      this.champIcon.sprite = entityWithPlayerId.playerLoadout.PlayerAvatarSprite;
    else
      this.champIcon.sprite = UnityEngine.Resources.Load<Sprite>(this.championAvatarIconPath + "mvp_side_avatar_" + this.championType.ToString().ToLower() + "_ui");
  }

  public void ActivateParticles(bool isMvp)
  {
    this.PlayParticles();
    if (!isMvp)
      return;
    this.PlayMvpParticles();
  }

  private void PlayMvpParticles()
  {
    if (this.team == Team.Alpha)
    {
      this.alphaMvpParticles.transform.Find("stripes").gameObject.SetActive(true);
      this.alphaMvpParticles.transform.Find("sprinkles").gameObject.SetActive(true);
    }
    else
    {
      this.betaMvpParticles.transform.Find("stripes").gameObject.SetActive(true);
      this.betaMvpParticles.transform.Find("sprinkles").gameObject.SetActive(true);
    }
  }

  private void PlayParticles()
  {
    if (this.team == Team.Alpha)
      this.alphaMvpParticles.SetActive(true);
    else
      this.betaMvpParticles.SetActive(true);
  }
}
