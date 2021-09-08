// Decompiled with JetBrains decompiler
// Type: PlayerArenaLoadedInfo
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class PlayerArenaLoadedInfo : 
  MonoBehaviour,
  IPointerEnterHandler,
  IEventSystemHandler,
  IPointerExitHandler,
  ISelectHandler,
  IDeselectHandler
{
  [SerializeField]
  private GameObject loadingGroup;
  [SerializeField]
  private GameObject loadingFinishedGroup;
  private Image background;
  private ulong playerId;

  public void SetLoadingState(bool finishedLoading)
  {
    if ((Object) this.background == (Object) null)
      this.background = this.GetComponent<Image>();
    if (finishedLoading)
    {
      this.background.color = Color.white;
      this.loadingGroup.SetActive(false);
      this.loadingFinishedGroup.SetActive(true);
    }
    else
    {
      this.background.color = Color.black;
      this.loadingGroup.SetActive(true);
      this.loadingFinishedGroup.SetActive(false);
    }
  }

  public void SetTeamStyle(Team team)
  {
    this.background.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(team);
    if (team != Team.Beta)
      return;
    Vector3 vector3 = new Vector3(-1f, 1f, 1f);
    this.transform.localScale = vector3;
    this.loadingFinishedGroup.GetComponent<RectTransform>().localScale = vector3;
  }

  public void SetPlayerId(ulong pid) => this.playerId = pid;

  public void OnPointerEnter(PointerEventData eventData)
  {
  }

  public void OnPointerExit(PointerEventData eventData)
  {
  }

  public void OnSelect(BaseEventData eventData)
  {
  }

  public void OnDeselect(BaseEventData eventData)
  {
  }

  private void StartHover(Vector3 position)
  {
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.playerId);
    if (entityWithPlayerId != null)
    {
      string str = "";
      if (entityWithPlayerId.hasArenaLoaded)
        str = entityWithPlayerId.arenaLoaded.arenaLoadingFinished ? "done." : "loading...";
      if (entityWithPlayerId.hasPlayerUsername)
        ToolTipManager.Instance.ShowTooltip(entityWithPlayerId.playerUsername.username + " " + str, position);
      else
        ToolTipManager.Instance.ShowTooltip(this.playerId.ToString() + " no username component.", position);
    }
    else
      ToolTipManager.Instance.ShowTooltip(this.playerId.ToString(), position);
  }

  private void StopHover() => ToolTipManager.Instance.HideTooltip();

  private void OnDisable()
  {
    if (!((Object) ToolTipManager.Instance != (Object) null))
      return;
    ToolTipManager.Instance.HideTooltip();
  }
}
