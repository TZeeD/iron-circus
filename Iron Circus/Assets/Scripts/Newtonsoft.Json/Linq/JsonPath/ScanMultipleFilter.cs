// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Linq.JsonPath.ScanMultipleFilter
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System.Collections.Generic;

namespace Newtonsoft.Json.Linq.JsonPath
{
  internal class ScanMultipleFilter : PathFilter
  {
    public List<string> Names { get; set; }

    public override IEnumerable<JToken> ExecuteFilter(
      JToken root,
      IEnumerable<JToken> current,
      bool errorWhenNoMatch)
    {
      foreach (JToken c in current)
      {
        JToken value = c;
        while (true)
        {
          value = PathFilter.GetNextScanValue(c, (JToken) (value as JContainer), value);
          if (value != null)
          {
            if (value is JProperty property6)
            {
              foreach (string name in this.Names)
              {
                if (property6.Name == name)
                  yield return property6.Value;
              }
            }
            property6 = (JProperty) null;
          }
          else
            break;
        }
        value = (JToken) null;
      }
    }
  }
}
