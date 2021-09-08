// Decompiled with JetBrains decompiler
// Type: PostGoalTile
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.ScriptableObjects;
using SteelCircus.Core.Services;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class PostGoalTile : MonoBehaviour
{
  [SerializeField]
  private Image championIcon;
  [SerializeField]
  private Image slash;
  [SerializeField]
  private TextMeshProUGUI usernamerTxt;
  [SerializeField]
  private TextMeshProUGUI eventTxt;
  [Header("AsisstedPlayer")]
  [SerializeField]
  private GameObject assistedContainer;
  [SerializeField]
  private Image assistedChampionIcon;
  [SerializeField]
  private TextMeshProUGUI assistedUsernamerTxt;
  private readonly string championAvatarIconPath = "UI/Avatars/";
  private string eventString = "@Goal";

  public void SetupTileForPlayer(GameEntity player)
  {
    Team team = player.playerTeam.value;
    if (player.hasPlayerUsername)
      this.usernamerTxt.text = player.playerUsername.username;
    this.usernamerTxt.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(team);
    this.slash.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(team);
    this.championIcon.sprite = UnityEngine.Resources.Load<Sprite>(this.championAvatarIconPath + "avatar_" + player.playerChampionData.value.type.ToString().ToLower() + "_ui");
    this.eventTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.eventString);
  }

  public void SetupEventText(string text)
  {
    this.eventString = text;
    this.eventTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue(this.eventString);
    this.assistedContainer.SetActive(false);
  }

  public void SetupGoalAssist(ulong assistingPlayerId)
  {
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(assistingPlayerId);
    if (entityWithPlayerId.hasPlayerUsername)
      this.assistedUsernamerTxt.text = entityWithPlayerId.playerUsername.username;
    this.usernamerTxt.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(entityWithPlayerId.playerTeam.value);
    this.assistedChampionIcon.sprite = UnityEngine.Resources.Load<Sprite>(this.championAvatarIconPath + "avatar_" + entityWithPlayerId.playerChampionData.value.type.ToString().ToLower() + "_ui");
    this.assistedContainer.SetActive(true);
  }
}
