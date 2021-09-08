// Decompiled with JetBrains decompiler
// Type: SelectionWheels
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.Core;
using SteelCircus.Core.Services;
using UnityEngine;

public class SelectionWheels : MonoBehaviour
{
  public SpraytagSelectionWheel spraytagSelectionWheel;
  public EmoteSelectionWheel emoteSelectionWheel;
  public QuickMessageSelectionWheel quickMessageSelectionWheel;
  private InputService input;
  private ulong playerId;
  private InputController inputController;

  public void Initialize(GameContext gameContext, InputController inputController, ulong playerId)
  {
    this.inputController = inputController;
    this.spraytagSelectionWheel.Initialize(gameContext, inputController, playerId);
    this.emoteSelectionWheel.Initialize(gameContext, inputController, playerId);
    this.quickMessageSelectionWheel.Initialize(gameContext, inputController, playerId);
  }

  public void Cleanup()
  {
    this.spraytagSelectionWheel.Cleanup();
    this.emoteSelectionWheel.Cleanup();
    this.quickMessageSelectionWheel.Cleanup();
  }

  private void Start()
  {
  }

  public void CloseAllWheels()
  {
    this.spraytagSelectionWheel.CloseSelectionWheel();
    this.emoteSelectionWheel.CloseSelectionWheel();
    this.quickMessageSelectionWheel.CloseSelectionWheel();
  }

  public void ShowSpraytagSelectionWheel()
  {
    this.CloseAllWheels();
    this.spraytagSelectionWheel.ShowSelectionWheel();
  }

  public void CloseSpraytagSelectionWheel() => this.spraytagSelectionWheel.CloseSelectionWheel();

  public void ShowEmoteSelectionWheel()
  {
    this.CloseAllWheels();
    this.emoteSelectionWheel.ShowSelectionWheel();
  }

  public void CloseEmoteSelectionWheel() => this.emoteSelectionWheel.CloseSelectionWheel();

  public void ShowQuickMessageSelectionWheel()
  {
    this.CloseAllWheels();
    this.quickMessageSelectionWheel.ShowSelectionWheel();
  }

  public void CloseQuickMessageSelectionWheel() => this.quickMessageSelectionWheel.CloseSelectionWheel();

  public bool IsAnyWheelOpen() => this.spraytagSelectionWheel.IsWheelOpen() || this.emoteSelectionWheel.IsWheelOpen() || this.quickMessageSelectionWheel.IsWheelOpen();
}
