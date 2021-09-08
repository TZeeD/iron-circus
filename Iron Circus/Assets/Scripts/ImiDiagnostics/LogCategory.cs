// Decompiled with JetBrains decompiler
// Type: Imi.Diagnostics.LogCategory
// Assembly: ImiDiagnostics, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 9CCF0324-3C3A-43B7-BFB6-8D5767C31D69
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\ImiDiagnostics.dll

using System;

namespace Imi.Diagnostics
{
  [Flags]
  public enum LogCategory
  {
    Debug = 1,
    Netcode = 2,
    Skills = 4,
    Api = 8,
    NetcodeTrace = 16, // 0x00000010
  }
}
