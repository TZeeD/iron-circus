// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.MatchTypeUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Imi.SharedWithServer.Game
{
  public static class MatchTypeUtils
  {
    public static MatchType GetMatchType(int numPlayers)
    {
      MatchType matchType = MatchType.Match1Vs1;
      if (numPlayers <= 2)
        matchType = MatchType.Match1Vs1;
      else if (numPlayers <= 4)
        matchType = MatchType.Match2Vs2;
      else if (numPlayers <= 6)
        matchType = MatchType.Match3Vs3;
      else if (numPlayers <= 8)
        matchType = MatchType.Match4Vs4;
      else if (numPlayers <= 10)
        matchType = MatchType.Match5Vs5;
      return matchType;
    }

    public static bool IsQuickMatch(this GameType gameType) => gameType == GameType.QuickMatch;

    public static bool IsRankedMatch(this GameType gameType) => gameType == GameType.RankedMatch;

    public static bool IsPlayground(this GameType gameType) => gameType == GameType.PlayGround;

    public static bool IsCustomMatch(this GameType gameType) => gameType == GameType.CustomMatch;

    public static bool IsBasicTraining(this GameType gameType) => gameType == GameType.BasicTraining;

    public static bool IsAdvancedTraining(this GameType gameType) => gameType == GameType.AdvancedTraining;
  }
}
