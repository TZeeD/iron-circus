// Decompiled with JetBrains decompiler
// Type: SharedWithServer.Utils.Extensions.ArrayExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace SharedWithServer.Utils.Extensions
{
  public static class ArrayExtensions
  {
    private static Random rng = new Random();

    public static void Shuffle<T>(this T[] array)
    {
      ArrayExtensions.rng = new Random();
      int length = array.Length;
      while (length > 1)
      {
        int index = ArrayExtensions.rng.Next(length);
        --length;
        T obj = array[length];
        array[length] = array[index];
        array[index] = obj;
      }
    }
  }
}
