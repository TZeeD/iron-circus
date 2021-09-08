// Decompiled with JetBrains decompiler
// Type: ControllerRumble
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas;
using SteelCircus.Core.Services;
using UnityEngine;

public class ControllerRumble
{
  public static void SetRumbleIfLocalPlayer(ulong callingPlayer, float strength = 1f, float duration = 1f)
  {
    if (!ControllerRumble.IsLocalEntity(callingPlayer))
      return;
    ControllerRumble.RumbleController(callingPlayer, strength, duration);
  }

  private static bool IsLocalEntity(ulong callingPlayer)
  {
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(callingPlayer);
    return entityWithPlayerId != null && entityWithPlayerId.isLocalEntity;
  }

  public static void StartLocalPlayerRumble(ulong callingPlayer, float strength = 1f)
  {
    if (!ControllerRumble.IsLocalEntity(callingPlayer))
      return;
    ImiServices.Instance.InputService.StartRumble(strength);
  }

  public static void StopLocalPlayerRumble() => ImiServices.Instance.InputService.StopRumble();

  public static void RumbleController(ulong playerId, float strength = 1f, float duration = 1f)
  {
    if (!ControllerRumble.IsLocalEntity(playerId))
      return;
    strength = Mathf.Clamp01(strength);
    ImiServices.Instance.InputService.StartRumble(strength, duration);
  }
}
