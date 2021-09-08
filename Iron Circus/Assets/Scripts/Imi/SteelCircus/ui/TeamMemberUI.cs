// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.TeamMemberUI
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Config;
using UnityEngine;
using UnityEngine.UI;

namespace Imi.SteelCircus.UI
{
  public class TeamMemberUI : MonoBehaviour
  {
    public Image champIcon;
    public Image champIconBG;
    public Text usernameTxt;
    private string username;

    public void SetData(ChampionConfig config, Team team)
    {
      this.champIcon.sprite = config.icon;
      this.usernameTxt.text = this.username;
    }

    public void setUsername(string incomingUsername) => this.username = incomingUsername;
  }
}
