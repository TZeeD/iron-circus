// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEvents.StatEvents.MatchOutcomeUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Imi.SharedWithServer.ScEvents.StatEvents
{
  public static class MatchOutcomeUtils
  {
    public static bool IsDraw(this MatchOutcome outcome) => outcome == MatchOutcome.Draw;

    public static bool IsWin(this MatchOutcome outcome) => outcome == MatchOutcome.Win;

    public static bool IsLoose(this MatchOutcome outcome) => outcome == MatchOutcome.Loose;
  }
}
