// Decompiled with JetBrains decompiler
// Type: SteelCircus.UI.Menu.CustomLobbyBotTeamAssignButton
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using SteelCircus.Core.Services;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SteelCircus.UI.Menu
{
  public class CustomLobbyBotTeamAssignButton : 
    MonoBehaviour,
    IPointerExitHandler,
    IEventSystemHandler,
    IPointerEnterHandler
  {
    private Team team;
    public CustomLobbyUi customLobbyManager;
    public Button removeBotButton;
    public GameObject border;
    [SerializeField]
    private Image teamAlphaImage;
    [SerializeField]
    private Image teamBetaImage;

    public Team Team
    {
      get => this.team;
      set
      {
        this.team = value;
        this.SetTeamImage(this.team);
      }
    }

    private void Update()
    {
      if (ImiServices.Instance.PartyService.IsGroupOwner())
        this.removeBotButton.gameObject.SetActive(true);
      else
        this.removeBotButton.gameObject.SetActive(false);
    }

    public void OnPointerEnter(PointerEventData eventData) => this.ShowBorder(true);

    public void OnPointerExit(PointerEventData eventData) => this.ShowBorder(false);

    private void SetTeamImage(Team team)
    {
      if (team == Team.Alpha)
      {
        this.teamAlphaImage.gameObject.SetActive(true);
        this.teamBetaImage.gameObject.SetActive(false);
      }
      else
      {
        this.teamAlphaImage.gameObject.SetActive(false);
        this.teamBetaImage.gameObject.SetActive(true);
      }
    }

    public void RemoveFromTeam() => this.customLobbyManager.RemoveBot(this);

    public void ShowBorder(bool show) => this.border.SetActive(show);
  }
}
