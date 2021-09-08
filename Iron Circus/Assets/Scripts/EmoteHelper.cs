// Decompiled with JetBrains decompiler
// Type: EmoteHelper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.Controls;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.GameElements;
using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EmoteHelper : MonoBehaviour
{
  [SerializeField]
  private GameObject emoteHelperText;
  private InputController inputController;
  private bool isActive;

  private void Start()
  {
    Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
    this.isActive = false;
    this.SetHelperTextActive(false);
  }

  private void OnDestroy() => Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnGameStateChangedEvent);

  public void InitializeEmoteHelper(InputController inputController) => this.inputController = inputController;

  private void Update()
  {
    if (this.isActive)
    {
      if (ImiServices.Instance.InputService.GetButtonDown(DigitalInput.EmoteModifier) || ImiServices.Instance.InputService.GetButtonDown(DigitalInput.Emote0) || ImiServices.Instance.InputService.GetButtonDown(DigitalInput.Emote1) || ImiServices.Instance.InputService.GetButtonDown(DigitalInput.Emote2) || ImiServices.Instance.InputService.GetButtonDown(DigitalInput.Emote3))
        this.SetHelperTextActive(false);
      if (!ImiServices.Instance.InputService.GetButtonDown(DigitalInput.Tackle) || !Contexts.HasSharedInstance || Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(ImiServices.Instance.LoginService.GetPlayerId()) == null)
        return;
      GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(ImiServices.Instance.LoginService.GetPlayerId());
      if (!entityWithPlayerId.hasPlayerLoadout || !entityWithPlayerId.hasPlayerChampionData)
        return;
      List<int> intList = new List<int>();
      int[] emotes = entityWithPlayerId.playerLoadout.itemLoadouts[entityWithPlayerId.playerChampionData.value.type].emotes;
      for (int index = 0; index < emotes.Length; ++index)
      {
        if (emotes[index] > 0 && emotes[index] < int.MaxValue)
          intList.Add(index);
      }
      if (intList.Count <= 0)
        return;
      int button = (int) Random.Range(0.0f, (float) intList.Count - 1f / 1000f);
      this.inputController.TriggerButton(DigitalInput.Emote0, false);
      this.inputController.TriggerButton(DigitalInput.Emote1, false);
      this.inputController.TriggerButton(DigitalInput.Emote2, false);
      this.inputController.TriggerButton(DigitalInput.Emote3, false);
      this.StartCoroutine(this.TriggerButtonDown(button));
    }
    else
      this.SetHelperTextActive(false);
  }

  private bool GetCharacterVisible() => Contexts.HasSharedInstance && Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(ImiServices.Instance.LoginService.GetPlayerId()) != null && Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(ImiServices.Instance.LoginService.GetPlayerId()).unityView.gameObject.GetComponent<Player>().MatManager.AreRenderersVisible();

  private IEnumerator TriggerButtonDown(int button)
  {
    yield return (object) null;
    DigitalInput triggeredInput = DigitalInput.Emote0;
    switch (button)
    {
      case 0:
        triggeredInput = DigitalInput.Emote0;
        break;
      case 1:
        triggeredInput = DigitalInput.Emote1;
        break;
      case 2:
        triggeredInput = DigitalInput.Emote2;
        break;
      case 3:
        triggeredInput = DigitalInput.Emote3;
        break;
    }
    this.inputController.TriggerButton(triggeredInput, true);
    yield return (object) new WaitForSeconds(0.1f);
    this.inputController.TriggerButton(triggeredInput, false);
    this.SetHelperTextActive(false);
  }

  private IEnumerator SetHelperActive(bool active)
  {
    this.isActive = active;
    yield return (object) new WaitForSeconds(0.5f);
    if (active)
      this.SetHelperTextActive(this.GetCharacterVisible());
    else
      this.SetHelperTextActive(false);
  }

  private void SetHelperTextActive(bool active) => this.emoteHelperText.SetActive(active);

  private void OnGameStateChangedEvent(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    switch (matchState)
    {
      case Imi.SharedWithServer.Game.MatchState.Intro:
        this.StartCoroutine(this.SetHelperActive(false));
        break;
      case Imi.SharedWithServer.Game.MatchState.StartPoint:
        this.StartCoroutine(this.SetHelperActive(false));
        break;
      case Imi.SharedWithServer.Game.MatchState.Goal:
        this.StartCoroutine(this.SetHelperActive(true));
        break;
      case Imi.SharedWithServer.Game.MatchState.MatchOver:
        this.StartCoroutine(this.SetHelperActive(false));
        break;
    }
  }
}
