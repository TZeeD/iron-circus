// Decompiled with JetBrains decompiler
// Type: Stateless.Reflection.InvocationInfo
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using System;

namespace Stateless.Reflection
{
  public class InvocationInfo
  {
    private readonly string _description;
    private readonly InvocationInfo.Timing _timing;

    internal static InvocationInfo Create(
      Delegate method,
      string description,
      InvocationInfo.Timing timing = InvocationInfo.Timing.Synchronous)
    {
      return new InvocationInfo((object) method != null ? method.TryGetMethodName() : (string) null, description, timing);
    }

    private InvocationInfo(string methodName, string description, InvocationInfo.Timing timing)
    {
      this.MethodName = methodName;
      this._description = description;
      this._timing = timing;
    }

    public string MethodName { get; private set; }

    public static string DefaultFunctionDescription { get; set; } = "Function";

    public string Description
    {
      get
      {
        if (this._description != null)
          return this._description;
        return this.MethodName.IndexOfAny(new char[3]
        {
          '<',
          '>',
          '`'
        }) >= 0 ? InvocationInfo.DefaultFunctionDescription : this.MethodName ?? "<null>";
      }
    }

    public bool IsAsync => this._timing == InvocationInfo.Timing.Asynchronous;

    internal enum Timing
    {
      Synchronous,
      Asynchronous,
    }
  }
}
