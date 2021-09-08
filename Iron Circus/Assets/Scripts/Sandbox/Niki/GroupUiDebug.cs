// Decompiled with JetBrains decompiler
// Type: Sandbox.Niki.GroupUiDebug
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SteelCircus.Core.Services;
using System;
using UnityEngine;
using UnityEngine.UI;

namespace Sandbox.Niki
{
  public class GroupUiDebug : MonoBehaviour
  {
    public Text text;

    private void OnEnable()
    {
      ImiServices.Instance.PartyService.OnChatMessageReceived += new APartyService.OnChatMessageReceivedEventHandler(this.OnChatMessageReceived);
      ImiServices.Instance.PartyService.OnGroupMatchmakingStarted += new APartyService.OnGroupMatchmakingStartedEventHandler(this.OnGroupMatchmakingStartet);
      ImiServices.Instance.PartyService.OnGroupMatchmakingCanceled += new APartyService.OnGroupMatchmakingCanceledEventHandler(this.OnGroupMatchmakingCanceled);
      ImiServices.Instance.MatchmakingService.OnMatchmakingStarted += new AMatchmakingService.OnMatchmakingStartedEventHandler(this.OnMatchmakingStartet);
    }

    private void OnDisable()
    {
      ImiServices.Instance.PartyService.OnChatMessageReceived -= new APartyService.OnChatMessageReceivedEventHandler(this.OnChatMessageReceived);
      ImiServices.Instance.PartyService.OnGroupMatchmakingStarted -= new APartyService.OnGroupMatchmakingStartedEventHandler(this.OnGroupMatchmakingStartet);
      ImiServices.Instance.PartyService.OnGroupMatchmakingCanceled -= new APartyService.OnGroupMatchmakingCanceledEventHandler(this.OnGroupMatchmakingCanceled);
      ImiServices.Instance.MatchmakingService.OnMatchmakingStarted -= new AMatchmakingService.OnMatchmakingStartedEventHandler(this.OnMatchmakingStartet);
    }

    private void OnGroupMatchmakingStartet(string gameliftkey, string matchmakerRegion) => Log.Debug("Group matchmaking has started. we should already poll..");

    private void OnGroupMatchmakingCanceled(string gameliftkey, string matchmakerRegion) => Log.Debug("Group matchmaking was canceled!");

    private void OnMatchmakingStartet(string gameliftkey, string matchmakerRegion)
    {
      Log.Api("Matchmaking started.");
      this.text.text = gameliftkey ?? "";
    }

    private void OnChatMessageReceived(ulong playerId, string username, string message)
    {
      Log.Api("Chat message received received");
      this.text.text = string.Format("{0} | {1}: {2}", (object) playerId, (object) username, (object) message);
    }

    public void SendRandomMessage()
    {
      Log.Api("Sending Random Message");
      Debug.Log((object) "Send Random Message.");
      ImiServices.Instance.PartyService.SendMessage(Guid.NewGuid().ToString("n").Substring(0, 32));
    }
  }
}
