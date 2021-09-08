// Decompiled with JetBrains decompiler
// Type: Stateless.ReflectionExtensions
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using System;
using System.Reflection;

namespace Stateless
{
  internal static class ReflectionExtensions
  {
    public static Assembly GetAssembly(this Type type) => type.Assembly;

    public static bool IsAssignableFrom(this Type type, Type otherType) => type.IsAssignableFrom(otherType);

    public static MethodInfo TryGetMethodInfo(this Delegate del) => del?.Method;

    public static string TryGetMethodName(this Delegate del) => del.TryGetMethodInfo()?.Name;
  }
}
