// Decompiled with JetBrains decompiler
// Type: Discord.DiscordActivitySender
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using Imi.SharedWithServer.Game;
using System;

namespace Discord
{
  public class DiscordActivitySender
  {
    private ActivityManager activityManager;
    private Activity currentActivity;
    private static readonly uint _SteamProductionID = 969680;
    private static readonly string _StateAlone = "Playing Solo";
    private static readonly string _StateInParty = "In Party";
    private static readonly string _DetailsPostGame = "Finished a match";
    private static readonly string _DetailsLobby = "Chilling in the lobby";
    private static readonly string _DetailsInGamePrefix = "In a ";
    private static readonly string _DetailsInGameSuffix = " match";
    private static readonly string _DetailsInGame1vs1 = "1vs1";
    private static readonly string _DetailsInGame2vs2 = "2vs2";
    private static readonly string _DetailsInGame3vs3 = "3vs3";
    private static readonly string _AssetLargeImageKey = "sc_logo_1024_px_w";
    private static readonly string _AssetLargeImageText = "Steel Circus Large";
    private static readonly string _PartyID = "foo partyID";

    public DiscordActivitySender(Discord.Discord discord)
    {
      this.activityManager = discord.GetActivityManager();
      this.RegisterSteamApplication();
      this.GameStarted();
    }

    private void RegisterSteamApplication() => this.activityManager.RegisterSteam(DiscordActivitySender._SteamProductionID);

    public void GameStarted()
    {
      Log.Debug("Discord: game started");
      this.currentActivity = new Activity()
      {
        State = DiscordActivitySender._StateAlone,
        Timestamps = {
          Start = new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds()
        },
        Assets = {
          LargeImage = DiscordActivitySender._AssetLargeImageKey,
          LargeText = DiscordActivitySender._AssetLargeImageText
        },
        Instance = false,
        Type = ActivityType.Playing
      };
      this.activityManager.UpdateActivity(this.currentActivity, (ActivityManager.UpdateActivityHandler) (result => Log.Debug("Discord: callback: " + (object) result)));
    }

    public void PartyLeft()
    {
      Log.Debug("Discord: left party, currently alone");
      this.currentActivity.State = DiscordActivitySender._StateAlone;
      this.currentActivity.Party = new ActivityParty();
      this.activityManager.UpdateActivity(this.currentActivity, (ActivityManager.UpdateActivityHandler) (result => Log.Debug("Discord: callback: " + (object) result)));
    }

    public void PartyChanged(int partySize, int partyCapacity)
    {
      Log.Debug("Discord: party size changed to " + (object) partySize);
      this.currentActivity.State = DiscordActivitySender._StateInParty;
      this.currentActivity.Party = new ActivityParty()
      {
        Id = DiscordActivitySender._PartyID,
        Size = {
          CurrentSize = partySize,
          MaxSize = partyCapacity
        }
      };
      this.activityManager.UpdateActivity(this.currentActivity, (ActivityManager.UpdateActivityHandler) (result => Log.Debug("Discord: callback: " + (object) result)));
    }

    public void MetaStateChanged(MetaState metaState)
    {
      string str = "";
      switch (metaState)
      {
        case MetaState.Lobby:
          str = DiscordActivitySender._DetailsLobby;
          break;
        case MetaState.Game:
          str = DiscordActivitySender._DetailsInGamePrefix + this.GetStringForMatchType(Contexts.sharedInstance.game.matchData.matchType) + DiscordActivitySender._DetailsInGameSuffix;
          break;
        case MetaState.PostGame:
          str = DiscordActivitySender._DetailsPostGame;
          break;
      }
      this.currentActivity.Details = str;
      this.activityManager.UpdateActivity(this.currentActivity, (ActivityManager.UpdateActivityHandler) (result => Log.Debug("Discord: callback: " + (object) result)));
    }

    public void MatchStarted(MatchType matchType)
    {
    }

    public void DoSomething() => this.activityManager.UpdateActivity(new Activity()
    {
      State = "In Play Mode",
      Details = "Playing the Trumpet!",
      Assets = {
        LargeImage = "sc_logo_1024_px_w",
        LargeText = "Steel Circus Large",
        SmallImage = "sc_logo_512px_w",
        SmallText = "Steel Circus Small"
      },
      Party = {
        Id = "foo partyID",
        Size = {
          CurrentSize = 1,
          MaxSize = 3
        }
      },
      Instance = true,
      Type = ActivityType.Playing
    }, (ActivityManager.UpdateActivityHandler) (result => Log.Debug("------ DISCORD CALLBACK: " + (object) result)));

    public void Clear() => this.activityManager.ClearActivity((ActivityManager.ClearActivityHandler) (result => Log.Debug("Discord: callback: " + (object) result)));

    private string GetStringForMatchType(MatchType type)
    {
      switch (type)
      {
        case MatchType.Match1Vs1:
          return DiscordActivitySender._DetailsInGame1vs1;
        case MatchType.Match2Vs2:
          return DiscordActivitySender._DetailsInGame2vs2;
        default:
          return DiscordActivitySender._DetailsInGame3vs3;
      }
    }
  }
}
