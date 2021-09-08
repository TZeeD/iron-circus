// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Utils.RazerChampionSkillAnimations
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Imi.SharedWithServer.Utils
{
  public class RazerChampionSkillAnimations
  {
    public static void ShowChampionEffect(GameEntity player, int animation)
    {
      if (!player.isLocalEntity)
        return;
      RazerChromaHelper.ShowChampionEffect(player.championConfig.value.championType, animation);
    }

    public static void ShowTeamEffect(GameEntity player)
    {
      if (!player.isLocalEntity)
        return;
      RazerChromaHelper.ExecuteRazerAnimationForTeam(player.playerTeam.value);
    }

    public static void ShowBallEffect(GameEntity player, int animation)
    {
      if (!player.isLocalEntity)
        return;
      if (animation != 0)
      {
        if (animation != 1)
          return;
        RazerChromaHelper.ShowBallThrow();
      }
      else
        RazerChromaHelper.ShowBallCarry();
    }
  }
}
