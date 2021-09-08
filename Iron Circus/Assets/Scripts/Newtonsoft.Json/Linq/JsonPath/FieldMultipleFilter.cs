// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Linq.JsonPath.FieldMultipleFilter
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using Newtonsoft.Json.Utilities;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace Newtonsoft.Json.Linq.JsonPath
{
  internal class FieldMultipleFilter : PathFilter
  {
    public List<string> Names { get; set; }

    public override IEnumerable<JToken> ExecuteFilter(
      JToken root,
      IEnumerable<JToken> current,
      bool errorWhenNoMatch)
    {
      foreach (JToken t in current)
      {
        if (t is JObject o2)
        {
          foreach (string name in this.Names)
          {
            JToken jtoken = o2[name];
            if (jtoken != null)
              yield return jtoken;
            if (errorWhenNoMatch)
              throw new JsonException("Property '{0}' does not exist on JObject.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) name));
          }
        }
        else if (errorWhenNoMatch)
          throw new JsonException("Properties {0} not valid on {1}.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) string.Join(", ", this.Names.Select<string, string>((Func<string, string>) (n => "'" + n + "'"))), (object) t.GetType().Name));
        o2 = (JObject) null;
      }
    }
  }
}
