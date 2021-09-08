// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.CollisionLayerUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;

namespace Imi.SharedWithServer.Game
{
  public static class CollisionLayerUtils
  {
    public static CollisionLayer GetLayerForTeam(Team team) => team != Team.Alpha ? CollisionLayer.TeamB : CollisionLayer.TeamA;

    public static CollisionLayer GetMaskForTeam(Team team) => team != Team.Alpha ? CollisionLayerUtils.TeamBMask() : CollisionLayerUtils.TeamAMask();

    public static CollisionLayer TeamAMask() => CollisionLayerUtils.BaseTeamMask() | CollisionLayer.ProjectilesTeamB;

    public static CollisionLayer TeamBMask() => CollisionLayerUtils.BaseTeamMask() | CollisionLayer.ProjectilesTeamA;

    public static CollisionLayer GetTackleMask() => CollisionLayer.Default | CollisionLayer.LvlBorder | CollisionLayer.Pickups | CollisionLayer.Bumper;

    public static CollisionLayer GetTeamADodgeMask() => CollisionLayerUtils.TeamAMask() & ~CollisionLayer.TeamB;

    public static CollisionLayer GetTeamBDodgeMask() => CollisionLayerUtils.TeamBMask() & ~CollisionLayer.TeamA;

    private static CollisionLayer BaseTeamMask() => CollisionLayer.Default | CollisionLayer.LvlBorder | CollisionLayer.TeamA | CollisionLayer.TeamB | CollisionLayer.Pickups | CollisionLayer.Bumper | CollisionLayer.Ball | CollisionLayer.Forcefield | CollisionLayer.Barrier;

    public static CollisionLayer GetProjectileLayerForTeam(Team team) => team != Team.Alpha ? CollisionLayer.ProjectilesTeamB : CollisionLayer.ProjectilesTeamA;

    public static CollisionLayer GetProjectileMaskForTeam(Team team) => (CollisionLayer) (259 | (team == Team.Alpha ? 8 : 4) | (team == Team.Alpha ? 32 : 16));

    public static int GetBallCollisionMask() => 2147481999;
  }
}
