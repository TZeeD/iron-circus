// Decompiled with JetBrains decompiler
// Type: Discord.DiscordService
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.Game;
using SharedWithServer.ScEvents;
using SteelCircus.Core.Services;
using UnityEngine;

namespace Discord
{
  public class DiscordService : MonoBehaviour
  {
    private Discord.Discord discord;
    private DiscordActivitySender activitySender;
    private ApplicationManager applicationManager;
    private ImageManager imageManager;
    private UserManager userManager;

    private void Awake()
    {
      try
      {
        this.discord = new Discord.Discord(540512714246717461L, 1UL);
        this.InitializeDiscordService();
      }
      catch (ResultException ex)
      {
        Log.Warning("Discord service not initialized: " + (object) ex);
        this.InitializingDiscordFailed();
      }
    }

    private void Update()
    {
      if (this.discord == null)
        return;
      try
      {
        this.discord.RunCallbacks();
      }
      catch (ResultException ex)
      {
        Log.Debug("Discord: " + ex.Message);
        if (!(ex.Message == "NotRunning"))
          return;
        this.discord.Dispose();
        this.discord = (Discord.Discord) null;
        Object.Destroy((Object) this);
      }
    }

    private void OnDestroy()
    {
      Log.Warning("Discord: Destroying the DiscordManager.prefab.");
      ImiServices.Instance.PartyService.OnGroupEntered -= new APartyService.OnGroupEnteredEventHandler(this.OnGroupEntered);
      ImiServices.Instance.PartyService.OnGroupMemberJoined -= new APartyService.OnGroupMemberJoinedEventHandler(this.OnGroupMemberJoined);
      ImiServices.Instance.PartyService.OnGroupMemberLeft -= new APartyService.OnGroupMemberLeftEventHandler(this.OnGroupMemberLeft);
      ImiServices.Instance.PartyService.OnGroupLeft -= new APartyService.OnGroupLeftEventHandler(this.OnGroupLeft);
      ImiServices.Instance.PartyService.OnGroupMatchmakingStarted -= new APartyService.OnGroupMatchmakingStartedEventHandler(this.OnGroupMatchmakingStarted);
      Events.Global.OnEventMetaStateChanged -= new Events.EventMetaStateChanged(this.OnMetaStateChanged);
      Events.Global.OnEventMatchStarted -= new Events.EventMatchStarted(this.OnMatchStartedEvent);
      if (this.discord == null)
        return;
      this.ClearActivity();
      this.discord.Dispose();
    }

    private void InitializeDiscordService()
    {
      this.discord.SetLogHook(LogLevel.Debug, (Discord.Discord.SetLogHookHandler) ((level, message) => Log.Warning(string.Format("Log[{0}] {1}", (object) level, (object) message))));
      this.activitySender = new DiscordActivitySender(this.discord);
      ImiServices.Instance.PartyService.OnGroupEntered += new APartyService.OnGroupEnteredEventHandler(this.OnGroupEntered);
      ImiServices.Instance.PartyService.OnGroupMemberJoined += new APartyService.OnGroupMemberJoinedEventHandler(this.OnGroupMemberJoined);
      ImiServices.Instance.PartyService.OnGroupMemberLeft += new APartyService.OnGroupMemberLeftEventHandler(this.OnGroupMemberLeft);
      ImiServices.Instance.PartyService.OnGroupLeft += new APartyService.OnGroupLeftEventHandler(this.OnGroupLeft);
      ImiServices.Instance.PartyService.OnGroupMatchmakingStarted += new APartyService.OnGroupMatchmakingStartedEventHandler(this.OnGroupMatchmakingStarted);
      Events.Global.OnEventMetaStateChanged += new Events.EventMetaStateChanged(this.OnMetaStateChanged);
      Events.Global.OnEventMatchStarted += new Events.EventMatchStarted(this.OnMatchStartedEvent);
    }

    private void InitializingDiscordFailed() => Log.Debug("Discord is not installed or running");

    private void OnMetaStateChanged(in MetaState metaState) => this.activitySender.MetaStateChanged(metaState);

    private void OnMatchStartedEvent(float durationInSeconds)
    {
    }

    private void OnGroupMatchmakingStarted(string gameliftkey, string matchmakerRegion)
    {
      Log.Debug("Discord: group count: " + (object) ImiServices.Instance.PartyService.GetCurrentGroup().Count);
      this.activitySender.PartyChanged(ImiServices.Instance.PartyService.GetCurrentGroup().Count, 3);
    }

    private void OnGroupEntered()
    {
      Log.Debug("Discord: group count: " + (object) ImiServices.Instance.PartyService.GetCurrentGroup().Count);
      this.activitySender.PartyChanged(ImiServices.Instance.PartyService.GetCurrentGroup().Count, 3);
    }

    private void OnGroupLeft()
    {
      Log.Debug("Discord: group count: " + (object) ImiServices.Instance.PartyService.GetCurrentGroup().Count);
      this.activitySender.PartyLeft();
    }

    private void OnGroupMemberJoined(APartyService.GroupMember groupMember)
    {
      Log.Debug("Discord: group count: " + (object) ImiServices.Instance.PartyService.GetCurrentGroup().Count);
      this.activitySender.PartyChanged(ImiServices.Instance.PartyService.GetCurrentGroup().Count, 3);
    }

    private void OnGroupMemberLeft(APartyService.GroupMember groupMember)
    {
      Log.Debug("Discord: group count: " + (object) ImiServices.Instance.PartyService.GetCurrentGroup().Count);
      this.activitySender.PartyChanged(ImiServices.Instance.PartyService.GetCurrentGroup().Count, 3);
    }

    public void ClearActivity() => this.activitySender.Clear();
  }
}
