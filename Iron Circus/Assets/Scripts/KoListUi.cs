// Decompiled with JetBrains decompiler
// Type: KoListUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.ScEntitas;
using SharedWithServer.ScEvents;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KoListUi : MonoBehaviour
{
  [SerializeField]
  private GameObject killEntryPrefab;
  [SerializeField]
  private GameObject alphaKilledPrefab;
  [SerializeField]
  private GameObject betaKilledPrefab;
  [SerializeField]
  private Transform alpha_List;
  [SerializeField]
  private Transform beta_List;
  [SerializeField]
  private Color teamAlphaColor;
  [SerializeField]
  private Color teamBetaColor;
  private List<KoListEntry> killedPlayersList;
  private List<Coroutine> coroutines;
  private float[] y_position = new float[5]
  {
    -50f,
    -162f,
    -274f,
    -386f,
    -498f
  };
  private bool[] alphaSpotOccupied = new bool[5];
  private bool[] betaSpotOccupied = new bool[5];

  private void Start() => Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);

  private void OnDestroy() => Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);

  private void OnGameStateChangedEvent(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    if (matchState != Imi.SharedWithServer.Game.MatchState.MatchOver && matchState != Imi.SharedWithServer.Game.MatchState.StartPoint)
      return;
    this.ClearAllKills();
  }

  public void DisplayPlayerKill(ulong killingPlayerId, ulong killedPlayerId, float respawnDuration)
  {
    if (this.killedPlayersList == null)
      this.killedPlayersList = new List<KoListEntry>();
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(killedPlayerId);
    GameObject go = (GameObject) null;
    if (entityWithPlayerId.playerTeam.value == Team.Alpha)
    {
      go = Object.Instantiate<GameObject>(this.alphaKilledPrefab);
      go.transform.SetParent(this.alpha_List);
      int freeKillSpot = this.GetFreeKillSpot(entityWithPlayerId.playerTeam.value);
      go.GetComponent<RectTransform>().localPosition = (Vector3) new Vector2(-200f, this.y_position[freeKillSpot]);
      go.GetComponent<Animator>().SetTrigger("alphaEnter");
      this.StartCoroutine(this.StartExit(5f, go, "alphaExit"));
      this.StartCoroutine(this.FreeUpSpot(respawnDuration + 1f, freeKillSpot, entityWithPlayerId.playerTeam.value));
    }
    else if (entityWithPlayerId.playerTeam.value == Team.Beta)
    {
      go = Object.Instantiate<GameObject>(this.betaKilledPrefab);
      go.transform.SetParent(this.beta_List);
      int freeKillSpot = this.GetFreeKillSpot(entityWithPlayerId.playerTeam.value);
      go.GetComponent<RectTransform>().localPosition = (Vector3) new Vector2(700f, this.y_position[this.GetFreeKillSpot(entityWithPlayerId.playerTeam.value)]);
      go.GetComponent<Animator>().SetTrigger("betaEnter");
      this.StartCoroutine(this.StartExit(5f, go, "betaExit"));
      this.StartCoroutine(this.FreeUpSpot(respawnDuration + 1f, freeKillSpot, entityWithPlayerId.playerTeam.value));
    }
    else
      Debug.LogError((object) string.Format("Player's {0} team was {1}. This is Invalid for the kill List.", (object) killedPlayerId, (object) entityWithPlayerId.playerTeam.value));
    KoListEntry component = go.GetComponent<KoListEntry>();
    component.SetKillValues(killingPlayerId, killedPlayerId);
    this.killedPlayersList.Add(component);
    component.DisplayKill(this.teamAlphaColor, this.teamBetaColor, respawnDuration);
    this.StartCoroutine(this.RemoveFromList(respawnDuration + 1f, component));
  }

  private IEnumerator StartShrink(float waitTime, GameObject go, string trigger)
  {
    yield return (object) new WaitForSeconds(waitTime);
    if ((Object) go != (Object) null)
      go.GetComponent<Animator>().SetTrigger(trigger);
  }

  private IEnumerator StartExit(float waitTime, GameObject go, string trigger)
  {
    yield return (object) new WaitForSeconds(waitTime);
    if ((Object) go != (Object) null)
      go.GetComponent<Animator>().SetTrigger(trigger);
  }

  private IEnumerator RemoveFromList(float waitTime, KoListEntry entry)
  {
    yield return (object) new WaitForSeconds(waitTime);
    if (this.killedPlayersList.Contains(entry))
    {
      this.killedPlayersList.Remove(entry);
      Debug.Log((object) string.Format("Removing {0} from List. {1} left.", (object) entry, (object) this.killedPlayersList.Count));
    }
    if ((Object) entry != (Object) null)
      Object.Destroy((Object) entry.gameObject);
  }

  private IEnumerator FreeUpSpot(float waitTime, int index, Team team)
  {
    yield return (object) new WaitForSeconds(waitTime);
    switch (team)
    {
      case Team.Alpha:
        this.alphaSpotOccupied[index] = false;
        break;
      case Team.Beta:
        this.betaSpotOccupied[index] = false;
        break;
    }
  }

  private int GetFreeKillSpot(Team team)
  {
    switch (team)
    {
      case Team.Alpha:
        for (int index = 0; index < this.alphaSpotOccupied.Length; ++index)
        {
          if (!this.alphaSpotOccupied[index])
          {
            this.alphaSpotOccupied[index] = true;
            return index;
          }
        }
        break;
      case Team.Beta:
        for (int index = 0; index < this.betaSpotOccupied.Length; ++index)
        {
          if (!this.betaSpotOccupied[index])
          {
            this.betaSpotOccupied[index] = true;
            return index;
          }
        }
        break;
    }
    return 0;
  }

  private void ClearAllKills()
  {
    if (this.killedPlayersList == null)
      return;
    foreach (KoListEntry killedPlayers in this.killedPlayersList)
    {
      if ((Object) killedPlayers != (Object) null && (Object) killedPlayers.gameObject != (Object) null)
        Object.Destroy((Object) killedPlayers.gameObject);
    }
    for (int index = 0; index < this.alphaSpotOccupied.Length; ++index)
    {
      this.alphaSpotOccupied[index] = false;
      this.betaSpotOccupied[index] = false;
    }
  }
}
