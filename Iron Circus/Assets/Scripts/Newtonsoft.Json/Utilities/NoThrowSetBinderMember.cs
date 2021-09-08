// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Utilities.NoThrowSetBinderMember
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System.Dynamic;

namespace Newtonsoft.Json.Utilities
{
  internal class NoThrowSetBinderMember : SetMemberBinder
  {
    private readonly SetMemberBinder _innerBinder;

    public NoThrowSetBinderMember(SetMemberBinder innerBinder)
      : base(innerBinder.Name, innerBinder.IgnoreCase)
    {
      this._innerBinder = innerBinder;
    }

    public override DynamicMetaObject FallbackSetMember(
      DynamicMetaObject target,
      DynamicMetaObject value,
      DynamicMetaObject errorSuggestion)
    {
      DynamicMetaObject dynamicMetaObject = this._innerBinder.Bind(target, new DynamicMetaObject[1]
      {
        value
      });
      return new DynamicMetaObject(new NoThrowExpressionVisitor().Visit(dynamicMetaObject.Expression), dynamicMetaObject.Restrictions);
    }
  }
}
