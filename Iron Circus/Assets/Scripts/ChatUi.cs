// Decompiled with JetBrains decompiler
// Type: ChatUi
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.Networking.Messages;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.EventSystem;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.ScriptableObjects;
using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChatUi : MonoBehaviour
{
  public Transform content;
  public GameObject chatMessageObjPrefab;
  public float timeToFadeAway;
  public float fadeOutTime;
  private CanvasGroup chatCanvasGroup;
  private bool displayWarning = true;
  [SerializeField]
  private bool usePooling;
  [SerializeField]
  private int poolSize = 8;
  public List<ChatMessageObj> chatData = new List<ChatMessageObj>();
  private Coroutine fadeAwayCoroutine;
  private InputService input;

  private void Awake()
  {
    if (!this.usePooling)
      return;
    this.CreatePool();
  }

  private void CreatePool()
  {
    for (int index = 0; index < this.poolSize; ++index)
    {
      ChatMessageObj chatMessageObj = this.CreateChatMessageObj();
      chatMessageObj.messageTxt.text = "";
      chatMessageObj.usernameTxt.text = "";
      chatMessageObj.canvasGroup.alpha = 0.0f;
      chatMessageObj.gameObject.name = "ChatObj_" + (object) index;
      this.chatData.Add(chatMessageObj);
    }
  }

  private void Start()
  {
    Events.Global.OnEventQuickChat += new Events.EventQuickChat(this.OnQuickChatEvent);
    Events.Global.OnEventPlayerLeft += new Events.EventPlayerLeft(this.OnPlayerLeftEvent);
    Events.Global.OnEventPlayerForfeitMatch += new Events.EventPlayerForfeitMatch(this.OnPlayerForfeit);
    Events.Global.OnEventForfeitMatchOver += new Events.EventForfeitMatchOver(this.OnForfeitMatchOver);
    this.chatCanvasGroup = this.content.gameObject.GetComponent<CanvasGroup>();
    this.input = ImiServices.Instance.InputService;
  }

  private void OnDestroy()
  {
    Events.Global.OnEventQuickChat -= new Events.EventQuickChat(this.OnQuickChatEvent);
    Events.Global.OnEventPlayerLeft -= new Events.EventPlayerLeft(this.OnPlayerLeftEvent);
    Events.Global.OnEventPlayerForfeitMatch -= new Events.EventPlayerForfeitMatch(this.OnPlayerForfeit);
    Events.Global.OnEventForfeitMatchOver -= new Events.EventForfeitMatchOver(this.OnForfeitMatchOver);
  }

  private void OnPlayerLeftEvent(string username, Color usernameColor) => this.ShowChatMessage(username, usernameColor, "@IngameDisconnectChatMessage", "", Color.red);

  private void OnForfeitMatchOver(ulong playerId, Team team) => this.ShowChatMessage("System", SingletonScriptableObject<ColorsConfig>.Instance.LightColor(team), "@ForfeitMatchOverChatMsg", "", Color.red);

  private void OnPlayerForfeit(ulong playerId, bool forfeit)
  {
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(playerId);
    GameEntity firstLocalEntity = Contexts.sharedInstance.game.GetFirstLocalEntity();
    HashSet<GameEntity> entitiesWithPlayerTeam = Contexts.sharedInstance.game.GetEntitiesWithPlayerTeam(entityWithPlayerId.playerTeam.value);
    int num = 0;
    foreach (GameEntity gameEntity in entitiesWithPlayerTeam)
    {
      if (gameEntity.hasPlayerForfeit && gameEntity.playerForfeit.hasForfeit)
        ++num;
    }
    if (firstLocalEntity.playerTeam.value != entityWithPlayerId.playerTeam.value)
      return;
    Color usernameColor = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(entityWithPlayerId.playerTeam.value);
    string username = entityWithPlayerId.playerUsername.username;
    string additionalMessageString1 = string.Format(" [{0}/{1}]", (object) num, (object) entitiesWithPlayerTeam.Count);
    if (forfeit)
    {
      this.ShowChatMessage(username, usernameColor, "@ForfeitChatMsg", additionalMessageString1, Color.red);
    }
    else
    {
      if ((long) firstLocalEntity.playerId.value != (long) playerId)
        return;
      string additionalMessageString2 = string.Format(" [{0}/{1}]", (object) 0, (object) entitiesWithPlayerTeam.Count);
      this.ShowChatMessage(username, usernameColor, "@NotForfeitChatMsg", additionalMessageString2, Color.green);
    }
  }

  private void OnAnotherPlayerDisconnected(NetworkEvent<DisconnectMessage> e)
  {
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(e.msg.id);
    Color usernameColor = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(entityWithPlayerId.playerTeam.value);
    this.ShowChatMessage(entityWithPlayerId.playerUsername.username, usernameColor, "@IngameDisconnectChatMessage", "", Color.red);
  }

  private void Update()
  {
    if (!this.input.GetButtonDown(DigitalInput.UIModifier))
      return;
    this.chatCanvasGroup.alpha = 1f;
    if (this.fadeAwayCoroutine != null)
      this.StopCoroutine(this.fadeAwayCoroutine);
    this.fadeAwayCoroutine = this.StartCoroutine(this.FadeAway(this.timeToFadeAway));
  }

  private void OnQuickChatEvent(ulong playerId, int msgType) => this.ProcessChatEvent(playerId, msgType);

  private void ProcessChatEvent(ulong playerId, int msgType)
  {
    this.chatCanvasGroup.alpha = 1f;
    if (msgType != -1)
    {
      ChatMessageObj chatMessageObj = this.CreateChatMessageObj();
      GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(playerId);
      chatMessageObj.usernameTxt.text = entityWithPlayerId.playerUsername.username + ": ";
      chatMessageObj.usernameTxt.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(entityWithPlayerId.playerTeam.value);
      chatMessageObj.messageTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue("@Quickmessage" + (object) msgType);
      this.chatData.Add(chatMessageObj);
      this.ApplyFadeToMessages();
    }
    else if (this.displayWarning)
    {
      this.ShowChatMessage("", Color.white, "@QuickChatMessageOnCooldownWarning", "", Color.yellow);
      this.displayWarning = false;
      this.StartCoroutine(this.WarningTimeout(this.timeToFadeAway));
    }
    if (this.fadeAwayCoroutine != null)
      this.StopCoroutine(this.fadeAwayCoroutine);
    this.fadeAwayCoroutine = this.StartCoroutine(this.FadeAway(this.timeToFadeAway));
  }

  private void ShowChatMessage(
    string username,
    Color usernameColor,
    string message,
    string additionalMessageString,
    Color messageColor)
  {
    this.chatCanvasGroup.alpha = 1f;
    ChatMessageObj chatMessageObj = !this.usePooling ? this.CreateChatMessageObj() : this.PoolChatMessageObj();
    chatMessageObj.usernameTxt.text = username;
    chatMessageObj.usernameTxt.color = usernameColor;
    chatMessageObj.messageTxt.text = ImiServices.Instance.LocaService.GetLocalizedValue(message) + additionalMessageString;
    chatMessageObj.messageTxt.color = messageColor;
    if (!this.usePooling)
      this.chatData.Add(chatMessageObj);
    this.ApplyFadeToMessages();
    if (this.fadeAwayCoroutine != null)
      this.StopCoroutine(this.fadeAwayCoroutine);
    this.fadeAwayCoroutine = this.StartCoroutine(this.FadeAway(this.timeToFadeAway));
  }

  private ChatMessageObj CreateChatMessageObj()
  {
    GameObject gameObject = Object.Instantiate<GameObject>(this.chatMessageObjPrefab);
    ChatMessageObj component = gameObject.GetComponent<ChatMessageObj>();
    gameObject.transform.SetParent(this.content, false);
    return component;
  }

  private ChatMessageObj PoolChatMessageObj()
  {
    ChatMessageObj component = this.content.GetChild(0).GetComponent<ChatMessageObj>();
    component.transform.SetParent(this.content, false);
    component.transform.SetSiblingIndex(this.content.childCount);
    return component;
  }

  private void ApplyFadeToMessagesOLD()
  {
    foreach (ChatMessageObj chatMessageObj in this.chatData)
      chatMessageObj.canvasGroup.alpha = 1f;
    if (this.chatData.Count > 6)
    {
      this.chatData[this.chatData.Count - 7].canvasGroup.alpha = 0.2f;
      this.chatData[this.chatData.Count - 6].canvasGroup.alpha = 0.4f;
      this.chatData[this.chatData.Count - 5].canvasGroup.alpha = 0.6f;
    }
    else if (this.chatData.Count == 6)
    {
      this.chatData[this.chatData.Count - 6].canvasGroup.alpha = 0.4f;
      this.chatData[this.chatData.Count - 5].canvasGroup.alpha = 0.6f;
    }
    if (this.usePooling || this.chatData.Count <= 7)
      return;
    ChatMessageObj chatMessageObj1 = this.chatData[0];
    this.chatData.RemoveAt(0);
    Object.Destroy((Object) chatMessageObj1.canvasGroup.gameObject);
  }

  private void ApplyFadeToMessages()
  {
    foreach (ChatMessageObj chatMessageObj in this.chatData)
      chatMessageObj.canvasGroup.alpha = (float) chatMessageObj.transform.GetSiblingIndex() * 0.2f;
  }

  private IEnumerator WarningTimeout(float time)
  {
    yield return (object) new WaitForSeconds(time);
    this.displayWarning = true;
  }

  private IEnumerator FadeAway(float time)
  {
    yield return (object) new WaitForSeconds(time);
    for (float i = 0.0f; (double) i < (double) this.fadeOutTime; i += Time.deltaTime)
    {
      this.chatCanvasGroup.alpha = 1f - i;
      yield return (object) null;
    }
    this.chatCanvasGroup.alpha = 0.0f;
    if (!this.usePooling)
    {
      foreach (ChatMessageObj chatMessageObj in this.chatData)
        Object.Destroy((Object) chatMessageObj.canvasGroup.gameObject);
      this.chatData = new List<ChatMessageObj>();
    }
  }
}
