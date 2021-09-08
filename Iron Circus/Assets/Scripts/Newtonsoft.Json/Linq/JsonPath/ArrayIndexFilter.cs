// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Linq.JsonPath.ArrayIndexFilter
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using Newtonsoft.Json.Utilities;
using System;
using System.Collections.Generic;
using System.Globalization;

namespace Newtonsoft.Json.Linq.JsonPath
{
  internal class ArrayIndexFilter : PathFilter
  {
    public int? Index { get; set; }

    public override IEnumerable<JToken> ExecuteFilter(
      JToken root,
      IEnumerable<JToken> current,
      bool errorWhenNoMatch)
    {
      foreach (JToken t1 in current)
      {
        int? index = this.Index;
        if (index.HasValue)
        {
          JToken t2 = t1;
          int num = errorWhenNoMatch ? 1 : 0;
          index = this.Index;
          int valueOrDefault = index.GetValueOrDefault();
          JToken tokenIndex = PathFilter.GetTokenIndex(t2, num != 0, valueOrDefault);
          if (tokenIndex != null)
            yield return tokenIndex;
        }
        else if (t1 is JArray || t1 is JConstructor)
        {
          foreach (JToken jtoken in (IEnumerable<JToken>) t1)
            yield return jtoken;
        }
        else if (errorWhenNoMatch)
          throw new JsonException("Index * not valid on {0}.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) t1.GetType().Name));
      }
    }
  }
}
