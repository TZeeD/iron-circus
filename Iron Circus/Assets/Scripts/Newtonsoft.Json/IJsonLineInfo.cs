﻿// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.IJsonLineInfo
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

namespace Newtonsoft.Json
{
  public interface IJsonLineInfo
  {
    bool HasLineInfo();

    int LineNumber { get; }

    int LinePosition { get; }
  }
}
