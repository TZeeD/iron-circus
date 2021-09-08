// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.ConfigValue`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Microsoft.CSharp.RuntimeBinder;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Runtime.CompilerServices;

namespace Imi.SharedWithServer.Game.Skills
{
  public struct ConfigValue<T>
  {
    private T value;
    private Func<T> getCurrentValue;
    private bool isExpression;

    public T Get()
    {
      if (this.isExpression)
        this.value = this.getCurrentValue();
      return this.value;
    }

    public override bool Equals(object obj)
    {
      if (obj == null)
        return false;
      // ISSUE: reference to a compiler-generated field
      if (ConfigValue<T>.\u003C\u003Eo__4.\u003C\u003Ep__2 == null)
      {
        // ISSUE: reference to a compiler-generated field
        ConfigValue<T>.\u003C\u003Eo__4.\u003C\u003Ep__2 = CallSite<Func<CallSite, object, bool>>.Create(Binder.Convert(CSharpBinderFlags.None, typeof (bool), typeof (ConfigValue<T>)));
      }
      // ISSUE: reference to a compiler-generated field
      Func<CallSite, object, bool> target1 = ConfigValue<T>.\u003C\u003Eo__4.\u003C\u003Ep__2.Target;
      // ISSUE: reference to a compiler-generated field
      CallSite<Func<CallSite, object, bool>> p2 = ConfigValue<T>.\u003C\u003Eo__4.\u003C\u003Ep__2;
      bool flag = obj is ConfigValue<T>;
      object obj1;
      if (flag)
      {
        // ISSUE: reference to a compiler-generated field
        if (ConfigValue<T>.\u003C\u003Eo__4.\u003C\u003Ep__1 == null)
        {
          // ISSUE: reference to a compiler-generated field
          ConfigValue<T>.\u003C\u003Eo__4.\u003C\u003Ep__1 = CallSite<Func<CallSite, bool, object, object>>.Create(Binder.BinaryOperation(CSharpBinderFlags.BinaryOperationLogical, ExpressionType.And, typeof (ConfigValue<T>), (IEnumerable<CSharpArgumentInfo>) new CSharpArgumentInfo[2]
          {
            CSharpArgumentInfo.Create(CSharpArgumentInfoFlags.UseCompileTimeType, (string) null),
            CSharpArgumentInfo.Create(CSharpArgumentInfoFlags.None, (string) null)
          }));
        }
        // ISSUE: reference to a compiler-generated field
        Func<CallSite, bool, object, object> target2 = ConfigValue<T>.\u003C\u003Eo__4.\u003C\u003Ep__1.Target;
        // ISSUE: reference to a compiler-generated field
        CallSite<Func<CallSite, bool, object, object>> p1 = ConfigValue<T>.\u003C\u003Eo__4.\u003C\u003Ep__1;
        int num = flag ? 1 : 0;
        // ISSUE: reference to a compiler-generated field
        if (ConfigValue<T>.\u003C\u003Eo__4.\u003C\u003Ep__0 == null)
        {
          // ISSUE: reference to a compiler-generated field
          ConfigValue<T>.\u003C\u003Eo__4.\u003C\u003Ep__0 = CallSite<Func<CallSite, object, object, object>>.Create(Binder.BinaryOperation(CSharpBinderFlags.None, ExpressionType.Equal, typeof (ConfigValue<T>), (IEnumerable<CSharpArgumentInfo>) new CSharpArgumentInfo[2]
          {
            CSharpArgumentInfo.Create(CSharpArgumentInfoFlags.None, (string) null),
            CSharpArgumentInfo.Create(CSharpArgumentInfoFlags.None, (string) null)
          }));
        }
        // ISSUE: reference to a compiler-generated field
        // ISSUE: reference to a compiler-generated field
        object obj2 = ConfigValue<T>.\u003C\u003Eo__4.\u003C\u003Ep__0.Target((CallSite) ConfigValue<T>.\u003C\u003Eo__4.\u003C\u003Ep__0, (object) this.Get(), (object) ((ConfigValue<T>) obj).Get());
        obj1 = target2((CallSite) p1, num != 0, obj2);
      }
      else
        obj1 = (object) flag;
      return target1((CallSite) p2, obj1);
    }

    public override int GetHashCode() => this.Get().GetHashCode();

    public void Expression(Func<T> expression)
    {
      this.getCurrentValue = expression;
      this.isExpression = true;
    }

    public void Constant(T value)
    {
      this.value = value;
      this.getCurrentValue = (Func<T>) null;
      this.isExpression = false;
    }

    public override string ToString() => (object) this.value == null ? "null" : this.Get().ToString();
  }
}
