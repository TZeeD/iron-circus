﻿// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Utilities.NoThrowExpressionVisitor
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System.Linq.Expressions;

namespace Newtonsoft.Json.Utilities
{
  internal class NoThrowExpressionVisitor : ExpressionVisitor
  {
    internal static readonly object ErrorResult = new object();

    protected override Expression VisitConditional(ConditionalExpression node) => node.IfFalse.NodeType == ExpressionType.Throw ? (Expression) Expression.Condition(node.Test, node.IfTrue, (Expression) Expression.Constant(NoThrowExpressionVisitor.ErrorResult)) : base.VisitConditional(node);
  }
}
