// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.StatusEffectType
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SharedWithServer.Game
{
  [Flags]
  public enum StatusEffectType
  {
    None = 0,
    Custom = 1,
    DamageOverTime = 2,
    Push = 4,
    Stun = 8,
    Invisible = 16, // 0x00000010
    Invulnerable = 32, // 0x00000020
    Unstoppable = 64, // 0x00000040
    ModMoveSpeed = 128, // 0x00000080
    Dazed = 256, // 0x00000100
    Asleep = 512, // 0x00000200
    FasterCooldown = 1024, // 0x00000400
    SlowerCooldown = 2048, // 0x00000800
    Dead = 4096, // 0x00001000
    Scrambled = 32768, // 0x00008000
  }
}
