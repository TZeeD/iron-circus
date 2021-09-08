// Decompiled with JetBrains decompiler
// Type: ArrayHelper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using UnityEngine;

public static class ArrayHelper
{
  public static T AddArrayElement<T>(ref T[] array) where T : new() => ArrayHelper.AddArrayElement<T>(ref array, new T());

  public static T AddArrayElement<T>(ref T[] array, T elToAdd)
  {
    if (array == null)
    {
      array = new T[1];
      array[0] = elToAdd;
      return elToAdd;
    }
    T[] objArray = new T[array.Length + 1];
    array.CopyTo((Array) objArray, 0);
    objArray[array.Length] = elToAdd;
    array = objArray;
    return elToAdd;
  }

  public static void DeleteArrayElement<T>(ref T[] array, int index)
  {
    if (index >= array.Length || index < 0)
    {
      Debug.LogWarning((object) ("invalid index in DeleteArrayElement: " + (object) index));
    }
    else
    {
      T[] objArray = new T[array.Length - 1];
      for (int index1 = 0; index1 < index; ++index1)
        objArray[index1] = array[index1];
      for (int index2 = index + 1; index2 < array.Length; ++index2)
        objArray[index2 - 1] = array[index2];
      array = objArray;
    }
  }
}
