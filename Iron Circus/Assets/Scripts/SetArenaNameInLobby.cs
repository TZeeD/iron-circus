// Decompiled with JetBrains decompiler
// Type: SetArenaNameInLobby
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.Core.Services;
using UnityEngine;
using UnityEngine.UI;

public class SetArenaNameInLobby : MonoBehaviour
{
  [SerializeField]
  private Text arenaText;
  [SerializeField]
  private Image arenaMinimapIcon;
  [SerializeField]
  private GameObject minimapObject;
  private string currentArena;

  private void Start()
  {
    this.arenaText = this.GetComponent<Text>();
    this.arenaText.text = ImiServices.Instance.LocaService.GetLocalizedValue("@" + ImiServices.Instance.isInMatchService.CurrentArena);
    this.arenaMinimapIcon.sprite = UnityEngine.Resources.Load<Sprite>("UI/Lobby_ArenaIcons/" + ImiServices.Instance.isInMatchService.CurrentArena);
  }

  public void ShowMinimap() => this.minimapObject.SetActive(true);
}
