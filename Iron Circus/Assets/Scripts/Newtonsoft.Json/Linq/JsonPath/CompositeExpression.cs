// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Linq.JsonPath.CompositeExpression
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System;
using System.Collections.Generic;

namespace Newtonsoft.Json.Linq.JsonPath
{
  internal class CompositeExpression : QueryExpression
  {
    public List<QueryExpression> Expressions { get; set; }

    public CompositeExpression() => this.Expressions = new List<QueryExpression>();

    public override bool IsMatch(JToken root, JToken t)
    {
      switch (this.Operator)
      {
        case QueryOperator.And:
          foreach (QueryExpression expression in this.Expressions)
          {
            if (!expression.IsMatch(root, t))
              return false;
          }
          return true;
        case QueryOperator.Or:
          foreach (QueryExpression expression in this.Expressions)
          {
            if (expression.IsMatch(root, t))
              return true;
          }
          return false;
        default:
          throw new ArgumentOutOfRangeException();
      }
    }
  }
}
