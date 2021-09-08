// Decompiled with JetBrains decompiler
// Type: Stateless.ParameterConversion
// Assembly: Stateless, Version=4.0.0.0, Culture=neutral, PublicKeyToken=93038f0927583c9a
// MVID: D5FEF726-C279-4B52-9490-86A1B7282D93
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Stateless.dll

using System;

namespace Stateless
{
  internal static class ParameterConversion
  {
    public static object Unpack(object[] args, Type argType, int index)
    {
      if (args == null)
        throw new ArgumentNullException(nameof (args));
      if (args.Length <= index)
        throw new ArgumentException(string.Format(ParameterConversionResources.ArgOfTypeRequiredInPosition, (object) argType, (object) index));
      object obj = args[index];
      return obj == null || argType.IsAssignableFrom(obj.GetType()) ? obj : throw new ArgumentException(string.Format(ParameterConversionResources.WrongArgType, (object) index, (object) obj.GetType(), (object) argType));
    }

    public static TArg Unpack<TArg>(object[] args, int index) => (TArg) ParameterConversion.Unpack(args, typeof (TArg), index);

    public static void Validate(object[] args, Type[] expected)
    {
      if (args.Length > expected.Length)
        throw new ArgumentException(string.Format(ParameterConversionResources.TooManyParameters, (object) expected.Length, (object) args.Length));
      for (int index = 0; index < expected.Length; ++index)
        ParameterConversion.Unpack(args, expected[index], index);
    }
  }
}
