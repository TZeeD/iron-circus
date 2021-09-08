// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Utils.MatchUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.ScEntitas.Components;

namespace Imi.SteelCircus.Utils
{
  public class MatchUtils
  {
    public static float GetRemainingTime() => !Contexts.HasSharedInstance || !Contexts.sharedInstance.game.isRemainingMatchTime || !Contexts.sharedInstance.game.remainingMatchTimeEntity.hasCountdownAction ? 0.0f : Contexts.sharedInstance.game.remainingMatchTimeEntity.countdownAction.value.RemainingT;

    public static float GetElapsedMatchTime()
    {
      if (!Contexts.HasSharedInstance || !Contexts.sharedInstance.game.isRemainingMatchTime || !Contexts.sharedInstance.game.remainingMatchTimeEntity.hasCountdownAction)
        return 0.0f;
      CountdownAction countdownAction = Contexts.sharedInstance.game.remainingMatchTimeEntity.countdownAction.value;
      return countdownAction.duration - countdownAction.RemainingT;
    }

    public static float GetMatchDuration() => !Contexts.HasSharedInstance || !Contexts.sharedInstance.game.isRemainingMatchTime || !Contexts.sharedInstance.game.remainingMatchTimeEntity.hasCountdownAction ? 0.0f : Contexts.sharedInstance.game.remainingMatchTimeEntity.countdownAction.value.duration;

    public static int GetScore(Team team) => Contexts.sharedInstance.game.hasScore ? TeamExtensions.GetScore(Contexts.sharedInstance.game.score.score, team) : 0;
  }
}
