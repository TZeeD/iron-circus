// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Linq.JsonPath.QueryScanFilter
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System.Collections.Generic;

namespace Newtonsoft.Json.Linq.JsonPath
{
  internal class QueryScanFilter : PathFilter
  {
    public QueryExpression Expression { get; set; }

    public override IEnumerable<JToken> ExecuteFilter(
      JToken root,
      IEnumerable<JToken> current,
      bool errorWhenNoMatch)
    {
      foreach (JToken t1 in current)
      {
        if (t1 is JContainer jcontainer1)
        {
          foreach (JToken t2 in jcontainer1.DescendantsAndSelf())
          {
            if (this.Expression.IsMatch(root, t2))
              yield return t2;
          }
        }
        else if (this.Expression.IsMatch(root, t1))
          yield return t1;
      }
    }
  }
}
