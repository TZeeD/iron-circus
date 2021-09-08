// Decompiled with JetBrains decompiler
// Type: DeathCounterUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using UnityEngine;

public class DeathCounterUi : MonoBehaviour
{
  [SerializeField]
  private GameObject deathIconPrefab;
  [SerializeField]
  private Transform alpha_List;
  [SerializeField]
  private Transform beta_List;

  public void AddDeath(Team team)
  {
    GameObject gameObject = Object.Instantiate<GameObject>(this.deathIconPrefab);
    if (team == Team.Alpha)
      gameObject.transform.SetParent(this.beta_List);
    else if (team == Team.Beta)
    {
      gameObject.transform.SetParent(this.alpha_List);
    }
    else
    {
      Debug.LogError((object) "Death Counter got a player death from an invalid team!");
      Object.Destroy((Object) gameObject);
    }
  }
}
