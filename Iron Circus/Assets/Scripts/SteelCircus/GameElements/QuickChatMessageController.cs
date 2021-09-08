// Decompiled with JetBrains decompiler
// Type: SteelCircus.GameElements.QuickChatMessageController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Networking.Messages;
using SharedWithServer.Networking.Messages;
using SharedWithServer.ScEvents;
using System.Timers;
using UnityEngine;

namespace SteelCircus.GameElements
{
  public class QuickChatMessageController
  {
    private readonly GameContext gameContext;
    private Timer aTimer;
    private bool quickChatMessageHasCoolDown;
    private float resetZone = 0.5f;
    private int coolDown = 3000;
    private int messagesSentInCooldownWindow;

    public QuickChatMessageController(GameContext gameContext)
    {
      this.gameContext = gameContext;
      this.gameContext = gameContext;
      this.aTimer = new Timer();
      this.aTimer.Elapsed += new ElapsedEventHandler(this.OnTimedEvent);
      this.aTimer.Interval = (double) this.coolDown;
    }

    private void OnTimedEvent(object sender, ElapsedEventArgs e)
    {
      this.quickChatMessageHasCoolDown = false;
      this.messagesSentInCooldownWindow = 0;
      this.aTimer.Stop();
    }

    public void TriggerChatMessage(int msg)
    {
      if (this.IsQuickMessageLockedInMatchState(this.gameContext.matchState.value))
        return;
      if (this.quickChatMessageHasCoolDown)
      {
        Log.Debug("QuickChatMessage is still on Cooldown.");
        Events.Global.FireEventQuickChat(0UL, -1);
      }
      else
        Contexts.sharedInstance.meta.metaNetwork.value.SendReliable((Message) new QuickChatMessage(ulong.MaxValue, msg));
      if (this.messagesSentInCooldownWindow == 0)
        this.aTimer.Start();
      ++this.messagesSentInCooldownWindow;
      if (this.messagesSentInCooldownWindow != 3)
        return;
      this.quickChatMessageHasCoolDown = true;
    }

    public bool HandleJoystickQuickMessage(Vector2 v)
    {
      if ((double) v.x > (double) this.resetZone)
      {
        this.TriggerChatMessage(1);
        return true;
      }
      if ((double) v.x < -(double) this.resetZone)
      {
        this.TriggerChatMessage(3);
        return true;
      }
      if ((double) v.y > (double) this.resetZone)
      {
        this.TriggerChatMessage(2);
        return true;
      }
      if ((double) v.y >= -(double) this.resetZone)
        return false;
      this.TriggerChatMessage(0);
      return true;
    }

    public bool CheckForJoyStickReset(Vector2 v) => (double) v.x < (double) this.resetZone && (double) v.x > -(double) this.resetZone && (double) v.y < (double) this.resetZone && (double) v.y > -(double) this.resetZone;

    public bool IsQuickMessageLockedInMatchState() => this.IsQuickMessageLockedInMatchState(this.gameContext.matchState.value);

    private bool IsQuickMessageLockedInMatchState(Imi.SharedWithServer.Game.MatchState state) => state == Imi.SharedWithServer.Game.MatchState.Intro || state == Imi.SharedWithServer.Game.MatchState.StatsScreens || state == Imi.SharedWithServer.Game.MatchState.WaitingForPlayers;
  }
}
