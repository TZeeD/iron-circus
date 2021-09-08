// Decompiled with JetBrains decompiler
// Type: ClockStone.PoolableReference`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace ClockStone
{
  public class PoolableReference<T> where T : Component
  {
    private PoolableObject _pooledObj;
    private int _initialUsageCount;
    private T _objComponent;

    public PoolableReference() => this.Reset();

    public PoolableReference(T componentOfPoolableObject) => this.Set(componentOfPoolableObject, false);

    public PoolableReference(PoolableReference<T> poolableReference)
    {
      this._objComponent = poolableReference._objComponent;
      this._pooledObj = poolableReference._pooledObj;
      this._initialUsageCount = poolableReference._initialUsageCount;
    }

    public void Reset()
    {
      this._pooledObj = (PoolableObject) null;
      this._objComponent = default (T);
      this._initialUsageCount = 0;
    }

    public T Get()
    {
      if (!(bool) (Object) this._objComponent)
        return default (T);
      if (!(bool) (Object) this._pooledObj || this._pooledObj._usageCount == this._initialUsageCount && !this._pooledObj._isInPool)
        return this._objComponent;
      this._objComponent = default (T);
      this._pooledObj = (PoolableObject) null;
      return default (T);
    }

    public void Set(T componentOfPoolableObject) => this.Set(componentOfPoolableObject, false);

    public void Set(T componentOfPoolableObject, bool allowNonePoolable)
    {
      if (!(bool) (Object) componentOfPoolableObject)
      {
        this.Reset();
      }
      else
      {
        this._objComponent = componentOfPoolableObject;
        this._pooledObj = this._objComponent.GetComponent<PoolableObject>();
        if (!(bool) (Object) this._pooledObj)
        {
          if (allowNonePoolable)
            this._initialUsageCount = 0;
          else
            Debug.LogError((object) "Object for PoolableReference must be poolable");
        }
        else
          this._initialUsageCount = this._pooledObj._usageCount;
      }
    }
  }
}
