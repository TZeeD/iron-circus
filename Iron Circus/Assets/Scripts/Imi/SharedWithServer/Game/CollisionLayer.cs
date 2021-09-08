// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.CollisionLayer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SharedWithServer.Game
{
  [Flags]
  public enum CollisionLayer
  {
    None = 0,
    Default = 1,
    LvlBorder = 2,
    TeamA = 4,
    TeamB = 8,
    ProjectilesTeamA = 16, // 0x00000010
    ProjectilesTeamB = 32, // 0x00000020
    Pickups = 64, // 0x00000040
    Dodging = 128, // 0x00000080
    Bumper = 256, // 0x00000100
    Ball = 512, // 0x00000200
    Forcefield = 1024, // 0x00000400
    Barrier = 2048, // 0x00000800
    Goal = 4096, // 0x00001000
    Everything = 2147483647, // 0x7FFFFFFF
  }
}
