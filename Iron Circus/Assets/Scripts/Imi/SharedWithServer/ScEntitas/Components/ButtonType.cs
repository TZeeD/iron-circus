// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.ButtonType
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [Flags]
  public enum ButtonType
  {
    None = 0,
    Sprint = 1,
    Tackle = 2,
    PrimarySkill = 4,
    SecondarySkill = 8,
    ThrowBall = 16, // 0x00000010
    Ping = 32, // 0x00000020
    Emote0 = 64, // 0x00000040
    Emote1 = 128, // 0x00000080
    Emote2 = 256, // 0x00000100
    Emote3 = 512, // 0x00000200
    Spraytag0 = 1024, // 0x00000400
    Spraytag1 = 2048, // 0x00000800
    Spraytag2 = 4096, // 0x00001000
    Spraytag3 = 8192, // 0x00002000
    QuickMessage0 = 16384, // 0x00004000
    QuickMessage1 = 32768, // 0x00008000
    QuickMessage2 = 65536, // 0x00010000
    QuickMessage3 = 131072, // 0x00020000
    EmoteModifier = 262144, // 0x00040000
    SpraytagModifier = 524288, // 0x00080000
    QuickMessageModifier = 1048576, // 0x00100000
    MoveToBall = 2097152, // 0x00200000
  }
}
