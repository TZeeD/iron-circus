// Decompiled with JetBrains decompiler
// Type: Steamworks.EChatMemberStateChange
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;

namespace Steamworks
{
  [Flags]
  public enum EChatMemberStateChange
  {
    k_EChatMemberStateChangeEntered = 1,
    k_EChatMemberStateChangeLeft = 2,
    k_EChatMemberStateChangeDisconnected = 4,
    k_EChatMemberStateChangeKicked = 8,
    k_EChatMemberStateChangeBanned = 16, // 0x00000010
  }
}
