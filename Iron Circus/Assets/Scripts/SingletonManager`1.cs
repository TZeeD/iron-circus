// Decompiled with JetBrains decompiler
// Type: SingletonManager`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

public class SingletonManager<T> : MonoBehaviour where T : Component
{
  private static T instance;

  public static T Instance
  {
    get
    {
      if ((Object) SingletonManager<T>.instance == (Object) null)
      {
        SingletonManager<T>.instance = Object.FindObjectOfType<T>();
        if ((Object) SingletonManager<T>.instance == (Object) null)
        {
          GameObject gameObject = new GameObject();
          gameObject.name = typeof (T).Name;
          SingletonManager<T>.instance = gameObject.AddComponent<T>();
        }
      }
      return SingletonManager<T>.instance;
    }
  }

  public virtual void Awake()
  {
    if ((Object) SingletonManager<T>.instance == (Object) null)
      SingletonManager<T>.instance = this as T;
    else
      Object.Destroy((Object) this.gameObject);
  }
}
