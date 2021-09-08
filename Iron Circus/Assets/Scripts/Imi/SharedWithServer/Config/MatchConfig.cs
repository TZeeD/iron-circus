// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.MatchConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  public class MatchConfig : GameConfigEntry
  {
    [Header("Connection & Lobby Settings")]
    public bool allowServerRandom;
    public int ConnectionWindowDuration = 30;
    public int LoadWindowDuration = 60;
    public int PlayerSelectionWindowDuration = 60;
    [Header("Lobby Duration")]
    public int InitialLobbyEnteredPause = 5;
    public int WaitingForPlayersDuration = 5;
    public int PlayerChampionPickDuration = 10;
    public int PauseBetweenPicks = 1;
    public int GracePeriodWindowDuration = 5;
    public int MaximumChampionPicksPerTeamAllowed = 1;
    public ChampionType[] championsForRandomSelection;
    [Header("Cutscene Durations")]
    public int durationInSeconds = 180;
    public int playgroundDurationInSeconds = 3600;
    public float gameEndedCutsceneLengthInSeconds = 4f;
    public float goalCutsceneLengthInSeconds = 2f;
    public float introCutsceneLengthInSeconds = 5f;
    public float basicTrainingIntroCutsceneLengthInSeconds = 8f;
    public float getReadyCutsceneLengthInSeconds = 8f;
    public float startPointCutsceneLengthInSeconds = 3f;
    public float victoryScreenLength = 3f;
    public float victoryPosesLength = 3f;
    public float statsScreenLength = 3f;
    [Header("Overtime")]
    public bool overtimeEnabled = true;
    public float overtimeCutsceneLength = 3f;
    public float overtimeDuration = 60f;
    [Header("Forfeit Settings")]
    public float forfeitStartTime = 15f;
    public float forfeitVoteTime = 30f;
    [Header("Champion Respawn Times")]
    public float respawnTime = 7f;
    public float addedRespawnTime = 5f;
    public float respawnTimeCap = 30f;
    [Header("Loser Ball")]
    public bool enableLoserBall;
    public float loserBallTeamOrange = -5f;
    public float loserBallTeamBlue = 5f;
    public Imi.SharedWithServer.Game.MatchState playersAllowedToMove;
    [Header("Match Point")]
    [Tooltip("The number of goals a team needs to score to insta-win")]
    public int matchPoint;
    public int matchPointInPlayground;
    [Header("Pickups")]
    [Range(0.0f, 1f)]
    public float skillPickupRechargeAmount = 1f;
    [Range(0.0f, 1f)]
    public float sprintPickupRechargeAmount = 1f;
  }
}
