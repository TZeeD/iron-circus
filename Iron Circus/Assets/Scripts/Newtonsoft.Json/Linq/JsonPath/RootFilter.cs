﻿// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Linq.JsonPath.RootFilter
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System.Collections.Generic;

namespace Newtonsoft.Json.Linq.JsonPath
{
  internal class RootFilter : PathFilter
  {
    public static readonly RootFilter Instance = new RootFilter();

    private RootFilter()
    {
    }

    public override IEnumerable<JToken> ExecuteFilter(
      JToken root,
      IEnumerable<JToken> current,
      bool errorWhenNoMatch)
    {
      return (IEnumerable<JToken>) new JToken[1]
      {
        root
      };
    }
  }
}
