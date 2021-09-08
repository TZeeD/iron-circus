// Decompiled with JetBrains decompiler
// Type: TrackingEventController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.ScEvents;
using Imi.ScGameStats;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.ScriptableObjects;
using SharedWithServer.Game;
using SharedWithServer.ScEvents;
using System.Collections;
using TMPro;
using UnityEngine;

public class TrackingEventController : MonoBehaviour
{
  [SerializeField]
  private GameObject eventTxtObj;
  [SerializeField]
  private GameObject eventTxtObjT1;
  [SerializeField]
  private GameObject eventFloorObj;
  [Header("T1 Event Prefabs")]
  [SerializeField]
  private GameObject eventPassPrefab;
  [SerializeField]
  private GameObject eventTacklePrefab;
  [SerializeField]
  private GameObject eventDodgePrefab;
  [SerializeField]
  private GameObject eventDamageDealtPrefab;
  [SerializeField]
  private GameObject eventKillAssistPrefab;
  [Header("T2 Event Prefabs")]
  [SerializeField]
  private GameObject eventDoublePassPrefab;
  [SerializeField]
  private GameObject eventKillPrefab;
  [SerializeField]
  private GameObject eventPassInterceptPrefab;
  [Header("T3 Event Prefabs")]
  [SerializeField]
  private GameObject eventDoubleKillPrefab;
  [Header("T4 Event Prefabs")]
  [SerializeField]
  private GameObject eventTripleKillPrefab;
  private bool audioDuckingInProgress;

  private void Start()
  {
    Events.Global.OnEventTrackingEvent += new Events.EventTrackingEvent(this.OnTrackingEvent);
    Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnGameStateChanged);
  }

  private void OnTrackingEvent(TrackingEvent e)
  {
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(e.playerId);
    if (entityWithPlayerId == null || !entityWithPlayerId.isLocalEntity)
      return;
    this.ProcessLocalEvent(e);
  }

  private void OnGameStateChanged(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    if (matchState != Imi.SharedWithServer.Game.MatchState.Goal)
    {
      if (matchState != Imi.SharedWithServer.Game.MatchState.MatchOver)
        return;
      this.DisableAllEvents();
    }
    else
      this.DisableAllEvents();
  }

  private void ProcessGlobalEvent(TrackingEvent e)
  {
    switch (e.statistics)
    {
      case Statistics.DoublePass:
      case Statistics.DamageDealt:
        AudioController.Play("PlayerDamageCrowd");
        break;
    }
  }

  private void ProcessLocalEvent(TrackingEvent e)
  {
    switch (e.statistics)
    {
      case Statistics.Pass:
        this.ShowTrackingEventNew(e.statistics, this.eventPassPrefab);
        break;
      case Statistics.DoublePass:
        this.ShowTrackingEventNew(e.statistics, this.eventDoublePassPrefab);
        this.StartCoroutine(this.ShowRazerChromaEffect());
        break;
      case Statistics.TackleSuccess:
        this.ShowT1TrackingEvent(e.statistics, SingletonScriptableObject<ColorsConfig>.Instance.TrackingEventT1Other, SingletonScriptableObject<ColorsConfig>.Instance.TrackingEventT1OtherText);
        break;
      case Statistics.WasStunned:
      case Statistics.DamageReceived:
        this.DuckAudioOnHit();
        break;
      case Statistics.DodgeSuccess:
        this.ShowT1TrackingEvent(e.statistics, SingletonScriptableObject<ColorsConfig>.Instance.TrackingEventT1Other, SingletonScriptableObject<ColorsConfig>.Instance.TrackingEventT1OtherText);
        break;
      case Statistics.DamageDealt:
        this.ShowTrackingEventNew(e.statistics, this.eventDamageDealtPrefab);
        break;
      case Statistics.Kills:
        this.ShowTrackingEventNew(e.statistics, this.eventKillPrefab);
        break;
      case Statistics.KillAssist:
        this.ShowTrackingEventNew(e.statistics, this.eventKillAssistPrefab);
        break;
      case Statistics.DoubleKill:
        this.ShowTrackingEventNew(e.statistics, this.eventDoubleKillPrefab);
        break;
      case Statistics.TripleKill:
        this.ShowTrackingEventNew(e.statistics, this.eventTripleKillPrefab);
        break;
      case Statistics.PassIntercept:
        this.ShowTrackingEventNew(e.statistics, this.eventPassInterceptPrefab);
        break;
    }
  }

  private void ProcessEventDelayed(TrackingEvent e)
  {
    switch (e.statistics)
    {
      case Statistics.Pass:
        this.StartCoroutine(this.ShowTrackingEventDelayed((float) this.transform.childCount * 0.2f, e.statistics, this.eventPassPrefab));
        break;
      case Statistics.DoublePass:
        this.StartCoroutine(this.ShowTrackingEventDelayed((float) this.transform.childCount * 0.2f, e.statistics, this.eventDoublePassPrefab));
        this.StartCoroutine(this.ShowRazerChromaEffect());
        break;
      case Statistics.TackleSuccess:
        this.StartCoroutine(this.ShowTrackingEventDelayed((float) this.transform.childCount * 0.2f, e.statistics, this.eventTacklePrefab));
        break;
      case Statistics.DodgeSuccess:
        this.StartCoroutine(this.ShowTrackingEventDelayed((float) this.transform.childCount * 0.2f, e.statistics, this.eventDodgePrefab));
        break;
      case Statistics.DamageDealt:
        this.StartCoroutine(this.ShowTrackingEventDelayed((float) this.transform.childCount * 0.2f, e.statistics, this.eventDamageDealtPrefab));
        break;
      case Statistics.Kills:
        this.StartCoroutine(this.ShowTrackingEventDelayed((float) this.transform.childCount * 0.2f, e.statistics, this.eventKillPrefab));
        break;
      case Statistics.KillAssist:
        this.StartCoroutine(this.ShowTrackingEventDelayed((float) this.transform.childCount * 0.2f, e.statistics, this.eventKillAssistPrefab));
        break;
      case Statistics.DoubleKill:
        this.StartCoroutine(this.ShowTrackingEventDelayed((float) this.transform.childCount * 0.2f, e.statistics, this.eventDoubleKillPrefab));
        break;
      case Statistics.TripleKill:
        this.ShowTrackingEvent(e.statistics);
        break;
      case Statistics.PassIntercept:
        this.StartCoroutine(this.ShowTrackingEventDelayed((float) this.transform.childCount * 0.2f, e.statistics, this.eventPassInterceptPrefab));
        break;
    }
  }

  private void DisableAllEvents()
  {
    for (int index = 0; index < this.transform.childCount; ++index)
      this.transform.GetChild(index).gameObject.SetActive(false);
  }

  private void ShowT1TrackingEvent(Statistics stat, Color color, Color textColor)
  {
    if (this.transform.childCount > 2)
      this.transform.GetChild(2).gameObject.SetActive(false);
    GameObject gameObject = Object.Instantiate<GameObject>(this.eventTxtObjT1, this.transform, false);
    gameObject.transform.SetSiblingIndex(0);
    gameObject.transform.localRotation = Quaternion.Euler(0.0f, 0.0f, -180f);
    gameObject.GetComponent<T1TrackingEventObject>().SetupEventUi("@" + (object) stat, color, textColor);
    AudioController.Play("ShowTrackingEvent");
    Object.Destroy((Object) gameObject, 3.5f);
  }

  private void ShowTrackingEventNew(Statistics stat, GameObject prefab)
  {
    if (this.transform.childCount > 2)
      this.transform.GetChild(2).gameObject.SetActive(false);
    GameObject gameObject = Object.Instantiate<GameObject>(prefab, this.transform, false);
    gameObject.transform.SetSiblingIndex(0);
    gameObject.transform.localRotation = Quaternion.Euler(0.0f, 0.0f, -180f);
    gameObject.GetComponent<T1TrackingEventObject>().SetupEventUiNew("@" + (object) stat);
    AudioController.Play("ShowTrackingEvent");
    Object.Destroy((Object) gameObject, 3.5f);
  }

  private IEnumerator ShowTrackingEventDelayed(
    float time,
    Statistics stat,
    GameObject prefab)
  {
    TrackingEventController trackingEventController = this;
    yield return (object) new WaitForSeconds(time);
    if (trackingEventController.transform.childCount > 2)
      trackingEventController.transform.GetChild(2).gameObject.SetActive(false);
    GameObject gameObject = Object.Instantiate<GameObject>(prefab, trackingEventController.transform, false);
    gameObject.transform.SetSiblingIndex(0);
    gameObject.transform.localRotation = Quaternion.Euler(0.0f, 0.0f, -180f);
    gameObject.GetComponent<T1TrackingEventObject>().SetupEventUiNew("@" + (object) stat);
    AudioController.Play("ShowTrackingEvent");
    Object.Destroy((Object) gameObject, 3.5f);
  }

  private void ShowTrackingEvent(Statistics stat)
  {
    if (this.transform.childCount > 2)
      this.transform.GetChild(2).gameObject.SetActive(false);
    GameObject gameObject = Object.Instantiate<GameObject>(this.eventTxtObj, this.transform, false);
    gameObject.transform.SetSiblingIndex(0);
    gameObject.transform.localRotation = Quaternion.Euler(0.0f, 0.0f, -180f);
    gameObject.GetComponent<TextMeshProUGUI>().text = stat.ToString();
    AudioController.Play(nameof (ShowTrackingEvent));
    Object.Destroy((Object) gameObject, 3.5f);
  }

  private void ShowTrackingEventInFloor(TrackingEvent e)
  {
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(e.playerId);
    if (entityWithPlayerId == null)
      return;
    GameObject gameObject = Object.Instantiate<GameObject>(this.eventFloorObj, entityWithPlayerId.transform.position.ToVector3() + new Vector3(0.0f, 0.2f, 0.0f), this.eventFloorObj.transform.rotation);
    gameObject.GetComponent<TextMeshPro>().text = e.statistics.ToString();
    Object.Destroy((Object) gameObject, 5f);
  }

  private IEnumerator ShowRazerChromaEffect()
  {
    RazerChromaHelper.ExecuteRazerAnimation(2);
    yield return (object) new WaitForSeconds(2f);
    RazerChromaHelper.ExecuteRazerAnimationForTeam(Contexts.sharedInstance.game.GetFirstLocalEntity().playerChampionData.value.team);
  }

  private void DuckAudioOnHit()
  {
    if (this.audioDuckingInProgress)
      return;
    this.StartCoroutine(this.DuckAudioCurve());
  }

  private IEnumerator DuckAudioCurve()
  {
    this.audioDuckingInProgress = true;
    float elapsedTime = 0.0f;
    float timeEaseIn = 0.45f;
    float timeEaseOut = 0.85f;
    float bypassfreq = 22000f;
    float LPfreq = bypassfreq;
    float targetFreq = 1500f;
    while ((double) elapsedTime < (double) timeEaseIn)
    {
      LPfreq = Mathf.Lerp(LPfreq, targetFreq, elapsedTime / timeEaseIn);
      AudioTriggerManager.SetAudioMixerValue("MUSIC_LP", LPfreq);
      AudioTriggerManager.SetAudioMixerValue("SFX_LP", LPfreq);
      elapsedTime += Time.deltaTime;
      yield return (object) null;
    }
    elapsedTime = 0.0f;
    AudioTriggerManager.SetAudioMixerValue("MUSIC_LP", targetFreq);
    AudioTriggerManager.SetAudioMixerValue("SFX_LP", targetFreq);
    while ((double) elapsedTime < (double) timeEaseOut)
    {
      LPfreq = Mathf.Lerp(targetFreq, bypassfreq, elapsedTime / timeEaseOut);
      AudioTriggerManager.SetAudioMixerValue("MUSIC_LP", LPfreq);
      AudioTriggerManager.SetAudioMixerValue("SFX_LP", LPfreq);
      elapsedTime += Time.deltaTime;
      yield return (object) null;
    }
    AudioTriggerManager.SetAudioMixerValue("MUSIC_LP", bypassfreq);
    AudioTriggerManager.SetAudioMixerValue("SFX_LP", bypassfreq);
    this.audioDuckingInProgress = false;
  }

  private void OnDestroy()
  {
    Events.Global.OnEventTrackingEvent -= new Events.EventTrackingEvent(this.OnTrackingEvent);
    Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnGameStateChanged);
  }
}
