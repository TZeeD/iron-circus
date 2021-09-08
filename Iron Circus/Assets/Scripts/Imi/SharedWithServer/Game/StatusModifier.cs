// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.StatusModifier
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SharedWithServer.Game
{
  [Flags]
  public enum StatusModifier
  {
    None = 0,
    DamageOverTime = 1,
    BlockMove = 2,
    BlockSkills = 4,
    BlockHoldBall = 8,
    Flying = 16, // 0x00000010
    ImmuneToBlockMove = 32, // 0x00000020
    ImmuneToSlow = 64, // 0x00000040
    ImmuneToTackle = 128, // 0x00000080
    SpeedMod = 256, // 0x00000100
    CooldownMod = 512, // 0x00000200
    Invisible = 1024, // 0x00000400
    BlockTranslate = 2048, // 0x00000800
  }
}
