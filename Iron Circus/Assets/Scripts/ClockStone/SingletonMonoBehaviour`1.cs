// Decompiled with JetBrains decompiler
// Type: ClockStone.SingletonMonoBehaviour`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace ClockStone
{
  public abstract class SingletonMonoBehaviour<T> : MonoBehaviour, ISingletonMonoBehaviour
    where T : MonoBehaviour
  {
    public static T Instance => UnitySingleton<T>.GetSingleton(true, true);

    public static T DoesInstanceExist() => UnitySingleton<T>.GetSingleton(false, false);

    public static void ActivateSingletonInstance() => UnitySingleton<T>.GetSingleton(true, true);

    public static void SetSingletonAutoCreate(GameObject autoCreatePrefab) => UnitySingleton<T>._autoCreatePrefab = autoCreatePrefab;

    protected virtual void Awake()
    {
      if (!this.isSingletonObject)
        return;
      UnitySingleton<T>._Awake(this as T);
    }

    protected virtual void OnDestroy()
    {
      if (!this.isSingletonObject)
        return;
      UnitySingleton<T>._Destroy();
    }

    public virtual bool isSingletonObject => true;
  }
}
