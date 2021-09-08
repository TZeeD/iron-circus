// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Utils.GenericSingleton`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.Utils
{
  [DisallowMultipleComponent]
  public abstract class GenericSingleton<T> : MonoBehaviour where T : Component
  {
    private static T instance;

    public static T Instance
    {
      get
      {
        if ((Object) GenericSingleton<T>.instance == (Object) null)
        {
          GenericSingleton<T>.instance = Object.FindObjectOfType<T>();
          if ((Object) GenericSingleton<T>.instance == (Object) null)
          {
            GameObject gameObject = new GameObject();
            gameObject.name = typeof (T).Name;
            GenericSingleton<T>.instance = gameObject.AddComponent<T>();
          }
        }
        return GenericSingleton<T>.instance;
      }
    }

    public virtual void Awake()
    {
      if ((Object) GenericSingleton<T>.instance == (Object) null)
      {
        GenericSingleton<T>.instance = this as T;
        Object.DontDestroyOnLoad((Object) this.gameObject);
      }
      else
        Object.Destroy((Object) this.gameObject);
    }
  }
}
