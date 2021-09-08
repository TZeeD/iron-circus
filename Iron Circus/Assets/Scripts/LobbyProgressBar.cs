// Decompiled with JetBrains decompiler
// Type: LobbyProgressBar
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Extensions;
using Imi.Game;
using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SharedWithServer.ScEntitas.Components;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.ScriptableObjects;
using SharedWithServer.ScEvents;
using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class LobbyProgressBar : MonoBehaviour
{
  [SerializeField]
  private TextMeshProUGUI usernameTxt;
  [SerializeField]
  private TextMeshProUGUI pickOrderTxt;
  [SerializeField]
  private Image currentOutline;
  [SerializeField]
  private Image currentProgressBar;
  [SerializeField]
  private Image progressBarBG;
  [SerializeField]
  private Image progressBarHeader;
  [SerializeField]
  private Image localPlayerIndicator;
  [SerializeField]
  private Image localPlayerSpeechBubble;
  [SerializeField]
  private Animation localPlayerIndicatorAnim;
  [SerializeField]
  private Animation localPlayerSpeechBubbleAnim;
  [SerializeField]
  private int pickingDoneDelay = 30;
  [SerializeField]
  private Color activePickingColorAlpha;
  [SerializeField]
  private Color activePickingColorBeta;
  public Action<UniqueId> OnPickingDone;
  public Action<UniqueId, int> OnPickingStarted;
  public Action<ChampionType, int> OnPickingDoneDelayed;
  private GameEntity globalTimeEntity;
  private RectTransform currentProgressBarRectTransform;
  private UniqueId id;
  private int pickOrder;
  private Color teamColor;
  private int startTick;
  private int endTick;
  private float tickDifference;
  private float maxProgressBarSize;
  private bool pickingStart;
  private bool pickingDone;
  private bool pickingDoneDelayed;
  private const float ProgressBarLeftOffset = 9f;
  private const float ProgressBarRightOffset = 3f;
  private const float ProgressBarHeight = 22f;

  private void Awake()
  {
    this.pickingDoneDelay = (int) (((double) StartupSetup.configProvider.matchConfig.PauseBetweenPicks - 0.100000001490116) / (double) Contexts.sharedInstance.game.globalTimeEntity.globalTime.fixedSimTimeStep);
    this.currentProgressBarRectTransform = this.currentProgressBar.rectTransform;
    this.currentProgressBarRectTransform.offsetMax = new Vector2(9f, 22f);
    this.progressBarHeader.gameObject.SetActive(false);
  }

  private void Update()
  {
    if (this.globalTimeEntity == null)
      return;
    GameEntity entityWithUniqueId = Contexts.sharedInstance.game.GetFirstEntityWithUniqueId(this.id);
    if (entityWithUniqueId == null)
      return;
    if (entityWithUniqueId.hasPlayerUsername)
      this.usernameTxt.text = entityWithUniqueId.playerUsername.username;
    if (entityWithUniqueId.hasPlayerChampionData)
      this.teamColor = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(entityWithUniqueId.playerChampionData.value.team);
    if (this.pickingDoneDelayed)
      return;
    if (this.globalTimeEntity.globalTime.currentTick >= this.startTick - 15 && !this.pickingStart)
    {
      Action<UniqueId, int> onPickingStarted = this.OnPickingStarted;
      if (onPickingStarted != null)
        onPickingStarted(this.id, this.pickOrder);
      this.maxProgressBarSize = (float) ((double) this.GetComponent<RectTransform>().rect.size.x - 9.0 + 3.0);
      this.currentProgressBarRectTransform.offsetMax = new Vector2(9f, 22f);
      this.currentProgressBar.color = this.teamColor;
      this.progressBarHeader.rectTransform.anchoredPosition = new Vector2(9f, 0.0f);
      this.currentOutline.color = this.teamColor;
      this.pickingStart = true;
    }
    if (this.globalTimeEntity.globalTime.currentTick >= this.startTick && this.globalTimeEntity.globalTime.currentTick < this.endTick)
    {
      float num = (float) (this.globalTimeEntity.globalTime.currentTick - this.startTick) / this.tickDifference;
      this.currentProgressBarRectTransform.offsetMax = new Vector2((float) ((double) this.maxProgressBarSize * (double) num + 9.0), 22f);
      this.currentProgressBar.color = this.teamColor;
      this.progressBarHeader.gameObject.SetActive(true);
      this.progressBarHeader.rectTransform.anchoredPosition = new Vector2((float) ((double) this.maxProgressBarSize * (double) num + 9.0 - 6.0), 0.0f);
      this.usernameTxt.color = Color.black;
      this.pickOrderTxt.color = this.teamColor;
      if (entityWithUniqueId.hasPlayerChampionData)
        this.progressBarBG.color = entityWithUniqueId.playerChampionData.value.team == Team.Alpha ? this.activePickingColorAlpha : this.activePickingColorBeta;
    }
    if (this.globalTimeEntity.globalTime.currentTick >= this.endTick && !this.pickingDone)
    {
      this.currentOutline.color = this.teamColor;
      this.progressBarBG.color = this.teamColor.WithAlpha(0.3f);
      if (entityWithUniqueId.isLocalEntity)
        this.usernameTxt.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
      else
        this.usernameTxt.color = this.teamColor;
      this.pickOrderTxt.color = this.teamColor;
      this.localPlayerSpeechBubble.gameObject.SetActive(false);
      this.progressBarHeader.gameObject.SetActive(false);
      if (entityWithUniqueId.isLocalEntity)
      {
        PlayerChampionData playerChampionData = entityWithUniqueId.playerChampionData.value;
        Events.Global.FireEventSelectChampion(playerChampionData.type, playerChampionData.skinId, playerChampionData.isReady);
      }
      this.currentProgressBarRectTransform.offsetMax = new Vector2(this.maxProgressBarSize + 9f, 22f);
      Action<UniqueId> onPickingDone = this.OnPickingDone;
      if (onPickingDone != null)
        onPickingDone(this.id);
      this.pickingDone = true;
    }
    if (this.globalTimeEntity.globalTime.currentTick < this.endTick + this.pickingDoneDelay || this.pickingDoneDelayed)
      return;
    Action<ChampionType, int> pickingDoneDelayed = this.OnPickingDoneDelayed;
    if (pickingDoneDelayed != null)
      pickingDoneDelayed(entityWithUniqueId.playerChampionData.value.type, this.pickOrder);
    this.currentOutline.color = this.teamColor;
    this.progressBarBG.color = this.teamColor.WithAlpha(0.3f);
    if (entityWithUniqueId.isLocalEntity)
      this.usernameTxt.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
    else
      this.usernameTxt.color = this.teamColor;
    this.pickOrderTxt.color = this.teamColor;
    this.pickingDoneDelayed = true;
  }

  public void SetupProgressBar(UniqueId id, int order)
  {
    this.id = id;
    this.pickOrder = order;
    this.pickOrderTxt.text = (order + 1).ToString();
    GameEntity entityWithUniqueId = Contexts.sharedInstance.game.GetFirstEntityWithUniqueId(id);
    if (entityWithUniqueId.isLocalEntity)
    {
      this.localPlayerSpeechBubble.gameObject.SetActive(true);
      this.localPlayerIndicator.gameObject.SetActive(true);
      this.localPlayerSpeechBubble.GetComponentInChildren<TextMeshProUGUI>().text = "YOU GO " + this.GetOrderString();
      this.usernameTxt.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
      this.pickOrderTxt.color = SingletonScriptableObject<ColorsConfig>.Instance.localPlayerUIColor;
      this.localPlayerSpeechBubble.gameObject.SetActive(false);
    }
    if (!entityWithUniqueId.hasPlayerUsername)
      return;
    this.usernameTxt.text = entityWithUniqueId.playerUsername.username;
  }

  private string GetOrderString()
  {
    string str = "";
    switch (this.pickOrder)
    {
      case 0:
        str = "1ST!";
        break;
      case 1:
        str = "2ND!";
        break;
      case 2:
        str = "3RD!";
        break;
    }
    return str;
  }

  public void EnableLocalPlayerTag()
  {
    this.localPlayerSpeechBubble.GetComponentInChildren<TextMeshProUGUI>().text = "YOU GO " + this.GetOrderString();
    this.localPlayerSpeechBubble.gameObject.SetActive(true);
    this.localPlayerSpeechBubble.GetComponent<Animation>().Play();
  }

  public void DisableLocalPlayerTag() => this.localPlayerSpeechBubble.gameObject.SetActive(false);

  public void SetStartAndEndTick(int start, int end)
  {
    this.startTick = start;
    this.endTick = end;
    this.tickDifference = (float) (this.endTick - this.startTick);
    this.globalTimeEntity = Contexts.sharedInstance.game.globalTimeEntity;
  }
}
