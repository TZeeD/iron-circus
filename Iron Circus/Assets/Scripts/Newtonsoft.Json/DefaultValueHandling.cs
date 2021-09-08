// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.DefaultValueHandling
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System;

namespace Newtonsoft.Json
{
  [Flags]
  public enum DefaultValueHandling
  {
    Include = 0,
    Ignore = 1,
    Populate = 2,
    IgnoreAndPopulate = Populate | Ignore, // 0x00000003
  }
}
