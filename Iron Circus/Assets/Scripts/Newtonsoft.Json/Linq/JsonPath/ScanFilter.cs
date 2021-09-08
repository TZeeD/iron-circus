// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Linq.JsonPath.ScanFilter
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System.Collections.Generic;

namespace Newtonsoft.Json.Linq.JsonPath
{
  internal class ScanFilter : PathFilter
  {
    public string Name { get; set; }

    public override IEnumerable<JToken> ExecuteFilter(
      JToken root,
      IEnumerable<JToken> current,
      bool errorWhenNoMatch)
    {
      foreach (JToken c in current)
      {
        if (this.Name == null)
          yield return c;
        JToken value = c;
        while (true)
        {
          do
          {
            value = PathFilter.GetNextScanValue(c, (JToken) (value as JContainer), value);
            if (value != null)
            {
              if (value is JProperty jproperty7)
              {
                if (jproperty7.Name == this.Name)
                  yield return jproperty7.Value;
              }
            }
            else
              goto label_10;
          }
          while (this.Name != null);
          yield return value;
        }
label_10:
        value = (JToken) null;
      }
    }
  }
}
