// Decompiled with JetBrains decompiler
// Type: ChangeMouseCursor
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.Controls;
using SteelCircus.Core.Services;
using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.SceneManagement;

public class ChangeMouseCursor : MonoBehaviour
{
  public Texture2D cursorTextureTeamAlpha;
  public Texture2D cursorTextureTeamBeta;
  public CursorMode cursorMode;
  public Vector2 hotSpot = Vector2.zero;

  private void Start()
  {
    SharedWithServer.ScEvents.Events.Global.OnEventMatchStateChanged += new SharedWithServer.ScEvents.Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
    SceneManager.sceneLoaded += new UnityAction<Scene, LoadSceneMode>(this.OnSceneLoaded);
    ImiServices.Instance.InputService.lastInputSourceChangedEvent += new Action<InputSource>(this.LastInputSourceTypeChanged);
  }

  private void LastInputSourceTypeChanged(InputSource lastInputSource) => Cursor.visible = lastInputSource == InputSource.Keyboard || lastInputSource == InputSource.Mouse;

  private void OnSceneLoaded(Scene scene, LoadSceneMode mode)
  {
    if (!scene.name.Contains("MainMenu"))
      return;
    Cursor.SetCursor((Texture2D) null, Vector2.zero, this.cursorMode);
  }

  private void OnGameStateChangedEvent(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    switch (matchState)
    {
      case Imi.SharedWithServer.Game.MatchState.GetReady:
      case Imi.SharedWithServer.Game.MatchState.StartPoint:
        GameEntity firstLocalEntity = Contexts.sharedInstance.game.GetFirstLocalEntity();
        if (firstLocalEntity != null && firstLocalEntity.hasPlayerTeam)
        {
          if (firstLocalEntity.playerTeam.value == Team.Alpha)
          {
            Cursor.SetCursor(this.cursorTextureTeamAlpha, this.hotSpot, this.cursorMode);
            break;
          }
          Cursor.SetCursor(this.cursorTextureTeamBeta, this.hotSpot, this.cursorMode);
          break;
        }
        Cursor.SetCursor(this.cursorTextureTeamAlpha, this.hotSpot, this.cursorMode);
        break;
      case Imi.SharedWithServer.Game.MatchState.MatchOver:
        Cursor.SetCursor((Texture2D) null, Vector2.zero, this.cursorMode);
        break;
    }
  }

  private void OnDestroy()
  {
    ImiServices.Instance.InputService.lastInputSourceChangedEvent -= new Action<InputSource>(this.LastInputSourceTypeChanged);
    SharedWithServer.ScEvents.Events.Global.OnEventMatchStateChanged -= new SharedWithServer.ScEvents.Events.EventMatchStateChanged(this.OnGameStateChangedEvent);
    SceneManager.sceneLoaded -= new UnityAction<Scene, LoadSceneMode>(this.OnSceneLoaded);
  }
}
