// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.UIProgressionState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SteelCircus.UI;
using System;
using System.Collections.Generic;

namespace SteelCircus.Core.Services
{
  [Serializable]
  public class UIProgressionState
  {
    public int stateID;
    public int previosStateID;
    public Dictionary<UIProgressionService.uiProgressionButton, UIProgressionButtonState> playMenuButtonState;
    public UIProgressionButtonState challengeMenuState;
    public UIProgressionButtonState inviteButtonState;
    public bool hasReward;
    public DailyChallengeEntry.ChallengeRewardType rewardType;
    public int rewardAmount;
    public string rewardText;

    public UIProgressionState(
      int stateID,
      Dictionary<UIProgressionService.uiProgressionButton, UIProgressionButtonState> playMenuButtonStates,
      UIProgressionButtonState challengeMenuState)
    {
      this.stateID = stateID;
      this.playMenuButtonState = playMenuButtonStates;
      this.challengeMenuState = challengeMenuState;
    }

    public void SetStateReward(
      DailyChallengeEntry.ChallengeRewardType rewardType,
      int rewardAmount,
      string rewardText = "")
    {
      this.hasReward = true;
      this.rewardType = rewardType;
      this.rewardAmount = rewardAmount;
      this.rewardText = rewardText;
    }

    public List<UIProgressionService.uiProgressionButton> GetUnlockedUIButtons()
    {
      List<UIProgressionService.uiProgressionButton> progressionButtonList = new List<UIProgressionService.uiProgressionButton>();
      foreach (KeyValuePair<UIProgressionService.uiProgressionButton, UIProgressionButtonState> keyValuePair in this.playMenuButtonState)
      {
        if (keyValuePair.Value.newlyUnlocked)
          progressionButtonList.Add(keyValuePair.Key);
      }
      return progressionButtonList;
    }
  }
}
