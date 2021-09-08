// Decompiled with JetBrains decompiler
// Type: KoListEntry
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using System.Collections;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

public class KoListEntry : MonoBehaviour
{
  [SerializeField]
  private Text killingPlayer;
  [SerializeField]
  private Text killedPlayer;
  [FormerlySerializedAs("killingPlayerBGIcon")]
  [SerializeField]
  private Image killingPlayerBgIcon;
  [FormerlySerializedAs("killedPlayerBGIcon")]
  [SerializeField]
  private Image killedPlayerBgIcon;
  [SerializeField]
  private Image killingPlayerIcon;
  [SerializeField]
  private Image killedPlayerIcon;
  private Team killingPlayerTeam;
  private Team killedPlayerTeam;
  private ChampionType killingPlayerChampionType;
  private ChampionType killedPlayerChampionType;
  private readonly string avatarIconsPath = "UI/Avatars/";

  public IEnumerator FadeOutEntry(float waitUntilFade, float fadeDuration)
  {
    yield return (object) new WaitForSeconds(waitUntilFade);
    for (float i = 0.0f; (double) i <= (double) fadeDuration; i += Time.deltaTime)
    {
      float a = (float) (1.0 - (double) i / (double) fadeDuration);
      this.killingPlayer.color = new Color(this.killingPlayer.color.r, this.killingPlayer.color.g, this.killingPlayer.color.b, a);
      this.killedPlayer.color = new Color(this.killedPlayer.color.r, this.killedPlayer.color.g, this.killedPlayer.color.b, a);
      yield return (object) null;
    }
    this.killingPlayer.color = new Color(this.killingPlayer.color.r, this.killingPlayer.color.g, this.killingPlayer.color.b, 0.0f);
    this.killedPlayer.color = new Color(this.killedPlayer.color.r, this.killedPlayer.color.g, this.killedPlayer.color.b, 0.0f);
  }

  public void SetKillValues(ulong killingPlayerId, ulong killedPlayerId)
  {
    GameEntity entityWithPlayerId1 = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(killingPlayerId);
    GameEntity entityWithPlayerId2 = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(killedPlayerId);
    this.killingPlayer.text = entityWithPlayerId1.playerUsername.username;
    this.killedPlayer.text = entityWithPlayerId2.playerUsername.username;
    this.killingPlayerTeam = entityWithPlayerId1.playerTeam.value;
    this.killedPlayerTeam = entityWithPlayerId2.playerTeam.value;
    this.killingPlayerChampionType = entityWithPlayerId1.championConfig.value.championType;
    this.killedPlayerChampionType = entityWithPlayerId2.championConfig.value.championType;
    Team team = this.killingPlayerTeam == Team.Alpha ? Team.Alpha : Team.Beta;
    this.killingPlayerIcon.sprite = UnityEngine.Resources.Load<Sprite>(this.avatarIconsPath + "avatar_" + team.ToString().ToLower() + "_" + this.killingPlayerChampionType.ToString().ToLower() + "_ui");
    this.killedPlayerIcon.sprite = UnityEngine.Resources.Load<Sprite>(this.avatarIconsPath + "avatar_" + team.ToString().ToLower() + "_" + this.killedPlayerChampionType.ToString().ToLower() + "_ui");
  }

  public void DisplayKill(Color teamAlpha, Color teamBeta, float respawnDuration)
  {
    if (this.killedPlayerTeam == Team.Alpha)
    {
      this.killedPlayer.color = new Color(teamAlpha.r, teamAlpha.g, teamAlpha.b, 1f);
      this.killedPlayerBgIcon.color = new Color(teamAlpha.r, teamAlpha.g, teamAlpha.b, 1f);
    }
    else
    {
      this.killedPlayer.color = new Color(teamBeta.r, teamBeta.g, teamBeta.b, 1f);
      this.killedPlayerBgIcon.color = new Color(teamBeta.r, teamBeta.g, teamBeta.b, 1f);
    }
    if (this.killingPlayerTeam == Team.Alpha)
    {
      this.killingPlayer.color = new Color(teamAlpha.r, teamAlpha.g, teamAlpha.b, 1f);
      this.killingPlayerBgIcon.color = new Color(teamAlpha.r, teamAlpha.g, teamAlpha.b, 1f);
    }
    else
    {
      this.killingPlayer.color = new Color(teamBeta.r, teamBeta.g, teamBeta.b, 1f);
      this.killingPlayerBgIcon.color = new Color(teamBeta.r, teamBeta.g, teamBeta.b, 1f);
    }
  }
}
