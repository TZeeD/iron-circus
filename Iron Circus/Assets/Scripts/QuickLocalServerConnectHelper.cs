// Decompiled with JetBrains decompiler
// Type: QuickLocalServerConnectHelper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.UI;
using SharedWithServer.ScEvents;
using System.Collections;
using UnityEngine;

public class QuickLocalServerConnectHelper : MonoBehaviour
{
  public ChampionType champType = ChampionType.Li;
  public Team team = Team.Beta;

  public void Connect()
  {
    this.transform.parent = (Transform) null;
    this.gameObject.SetActive(true);
    this.StartCoroutine(this.ConnectCR());
  }

  private IEnumerator ConnectCR()
  {
    while ((Object) Object.FindObjectOfType<ConnectedPlayersUI>() == (Object) null)
      yield return (object) null;
    yield return (object) new WaitForSeconds(0.2f);
    Debug.Log((object) "QuickLocalServerConnectHelper: Selecting Team");
    Events.Global.FireEventSelectTeam(this.team);
    yield return (object) new WaitForSeconds(0.2f);
    Debug.Log((object) "QuickLocalServerConnectHelper: Selecting Champ");
    Events.Global.FireEventSelectChampion(this.champType, 0, true);
    yield return (object) new WaitForSeconds(0.2f);
    Debug.Log((object) "QuickLocalServerConnectHelper: Ready");
    Events.Global.FireEventChampionSelectionReady();
  }
}
