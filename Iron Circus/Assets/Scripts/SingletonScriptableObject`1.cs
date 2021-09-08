// Decompiled with JetBrains decompiler
// Type: SingletonScriptableObject`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public abstract class SingletonScriptableObject<T> : ScriptableObject where T : ScriptableObject
{
  private static T _instance;

  public static T Instance
  {
    get
    {
      if (!(bool) (Object) SingletonScriptableObject<T>._instance)
        SingletonScriptableObject<T>._instance = ((IEnumerable<T>) Resources.FindObjectsOfTypeAll<T>()).FirstOrDefault<T>();
      return SingletonScriptableObject<T>._instance;
    }
  }
}
