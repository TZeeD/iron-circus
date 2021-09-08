// Decompiled with JetBrains decompiler
// Type: Steamworks.ESteamItemFlags
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;

namespace Steamworks
{
  [Flags]
  public enum ESteamItemFlags
  {
    k_ESteamItemNoTrade = 1,
    k_ESteamItemRemoved = 256, // 0x00000100
    k_ESteamItemConsumed = 512, // 0x00000200
  }
}
