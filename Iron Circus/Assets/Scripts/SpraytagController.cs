// Decompiled with JetBrains decompiler
// Type: SpraytagController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Networking.Messages;
using Imi.SharedWithServer.Networking.Messages;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using System.Timers;
using UnityEngine;

public class SpraytagController
{
  private readonly GameContext gameContext;
  private Timer aTimer;
  private bool spraytagTriggered;
  private bool spraytagHasCoolDown;
  private float resetZone = 0.5f;
  private int coolDown = 500;

  public SpraytagController(GameContext gameContext)
  {
    this.gameContext = gameContext;
    this.aTimer = new Timer();
    this.aTimer.Elapsed += new ElapsedEventHandler(this.OnTimedEvent);
    this.aTimer.Interval = (double) this.coolDown;
    this.aTimer.Enabled = false;
  }

  private void OnTimedEvent(object sender, ElapsedEventArgs e)
  {
    this.spraytagHasCoolDown = false;
    this.aTimer.Stop();
  }

  public void SpawnSpraytag(ulong playerId, int spraytag)
  {
    if (this.spraytagHasCoolDown || this.IsSpawnSpraytagLockedInMatchState(this.gameContext.matchState.value))
      return;
    AudioController.Play("ShowEmote");
    Debug.Log((object) ("Spawn spraytag for player " + (object) playerId));
    GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(playerId);
    JVector jvector = entityWithPlayerId.transform.position + entityWithPlayerId.transform.Forward * 2f + new Vector3(-40f, 0.0f, 0.0f).ToJVector();
    Contexts.sharedInstance.meta.metaNetwork.value.SendReliable((Message) new SpawnSpraytagInstructionMessage(playerId, spraytag));
    this.spraytagHasCoolDown = true;
    this.aTimer.Start();
  }

  private static char[] TryToGetSpraytagFromService(string spraytag) => !PlayerPrefs.HasKey(spraytag) ? "piping_hot_spray".ToCharArray() : PlayerPrefs.GetString(spraytag).ToCharArray();

  public bool HandleJoystickSpraytagSpawn(Vector2 v, ulong playerId)
  {
    if ((double) v.x > (double) this.resetZone)
    {
      this.SpawnSpraytag(playerId, 2);
      return true;
    }
    if ((double) v.x < -(double) this.resetZone)
    {
      this.SpawnSpraytag(playerId, 4);
      return true;
    }
    if ((double) v.y > (double) this.resetZone)
    {
      this.SpawnSpraytag(playerId, 3);
      return true;
    }
    if ((double) v.y >= -(double) this.resetZone)
      return false;
    this.SpawnSpraytag(playerId, 1);
    return true;
  }

  public bool CheckForJoyStickReset(Vector2 v) => (double) v.x < (double) this.resetZone && (double) v.x > -(double) this.resetZone && (double) v.y < (double) this.resetZone && (double) v.y > -(double) this.resetZone;

  public bool IsSpawnSpraytagLockedInMatchState() => this.IsSpawnSpraytagLockedInMatchState(this.gameContext.matchState.value);

  private bool IsSpawnSpraytagLockedInMatchState(Imi.SharedWithServer.Game.MatchState state) => state == Imi.SharedWithServer.Game.MatchState.Intro || state == Imi.SharedWithServer.Game.MatchState.MatchOver || state == Imi.SharedWithServer.Game.MatchState.VictoryPose || state == Imi.SharedWithServer.Game.MatchState.WaitingForPlayers;

  public void ResetSpraytagTrigger() => this.spraytagTriggered = false;
}
