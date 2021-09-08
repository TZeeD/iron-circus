// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Utils.Extensions.EnumerationExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SharedWithServer.Utils.Extensions
{
  public static class EnumerationExtensions
  {
    public static bool Has<T>(this Enum type, T value)
    {
      try
      {
        return ((int) type & (int) (object) value) == (int) (object) value;
      }
      catch
      {
        return false;
      }
    }

    public static bool Is<T>(this Enum type, T value)
    {
      try
      {
        return (int) type == (int) (object) value;
      }
      catch
      {
        return false;
      }
    }

    public static T Add<T>(this Enum type, T value)
    {
      try
      {
        return (T) (ValueType) ((int) type | (int) (object) value);
      }
      catch (Exception ex)
      {
        throw new ArgumentException(string.Format("Could not append value from enumerated type '{0}'.", (object) typeof (T).Name), ex);
      }
    }

    public static T Remove<T>(this Enum type, T value)
    {
      try
      {
        return (T) (ValueType) ((int) type & ~(int) (object) value);
      }
      catch (Exception ex)
      {
        throw new ArgumentException(string.Format("Could not remove value from enumerated type '{0}'.", (object) typeof (T).Name), ex);
      }
    }
  }
}
