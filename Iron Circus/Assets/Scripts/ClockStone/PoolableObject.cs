// Decompiled with JetBrains decompiler
// Type: ClockStone.PoolableObject
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace ClockStone
{
  [AddComponentMenu("ClockStone/PoolableObject")]
  public class PoolableObject : MonoBehaviour
  {
    public int maxPoolSize = 10;
    public int preloadCount;
    public bool doNotDestroyOnLoad;
    public bool sendAwakeStartOnDestroyMessage = true;
    public bool sendPoolableActivateDeactivateMessages;
    public bool useReflectionInsteadOfMessages;
    internal bool _isInPool;
    internal ObjectPoolController.ObjectPool _pool;
    internal int _serialNumber;
    internal int _usageCount;
    internal bool _awakeJustCalledByUnity;
    internal bool _instantiatedByObjectPoolController;
    private bool _justInvokingOnDestroy;

    protected void Awake() => this._awakeJustCalledByUnity = true;

    protected void OnDestroy()
    {
      if (this._justInvokingOnDestroy || this._pool == null)
        return;
      this._pool.Remove(this);
    }

    public int GetSerialNumber() => this._serialNumber;

    public int GetUsageCount() => this._usageCount;

    public int DeactivateAllPoolableObjectsOfMyKind() => this._pool != null ? this._pool._SetAllAvailable() : 0;

    public bool IsDeactivated() => this._isInPool;

    internal void _PutIntoPool()
    {
      if (this._pool == null)
        Debug.LogError((object) "Tried to put object into pool which was not created with ObjectPoolController", (Object) this);
      else if (this._isInPool)
      {
        if ((Object) this.transform.parent != (Object) this._pool.poolParent)
        {
          Debug.LogWarning((object) "Object was already in pool but parented to Pool-Parent. Reparented.", (Object) this);
          this.transform.parent = this._pool.poolParent;
        }
        else
          Debug.LogWarning((object) "Object is already in Pool", (Object) this);
      }
      else
      {
        if (!ObjectPoolController._isDuringInstantiate)
        {
          if (this.sendAwakeStartOnDestroyMessage)
          {
            this._justInvokingOnDestroy = true;
            this._pool.CallMethodOnObject(this.gameObject, "OnDestroy", true, true, this.useReflectionInsteadOfMessages);
            this._justInvokingOnDestroy = false;
          }
          if (this.sendPoolableActivateDeactivateMessages)
            this._pool.CallMethodOnObject(this.gameObject, "OnPoolableObjectDeactivated", true, true, this.useReflectionInsteadOfMessages);
        }
        this._isInPool = true;
        this.transform.parent = this._pool.poolParent;
        this.gameObject.SetActive(false);
      }
    }

    internal void TakeFromPool(Transform parent, bool activateObject)
    {
      if (!this._isInPool)
      {
        Debug.LogError((object) "Tried to take an object from Pool which is not available!", (Object) this);
      }
      else
      {
        this._isInPool = false;
        ++this._usageCount;
        this.transform.parent = parent;
        if (!activateObject)
          return;
        this._awakeJustCalledByUnity = false;
        this.gameObject.SetActive(true);
        if (this.sendAwakeStartOnDestroyMessage && !this._awakeJustCalledByUnity)
        {
          this._pool.CallMethodOnObject(this.gameObject, "Awake", true, false, this.useReflectionInsteadOfMessages);
          if (this.gameObject._GetActive())
            this._pool.CallMethodOnObject(this.gameObject, "Start", true, false, this.useReflectionInsteadOfMessages);
        }
        if (!this.sendPoolableActivateDeactivateMessages)
          return;
        this._pool.CallMethodOnObject(this.gameObject, "OnPoolableObjectActivated", true, true, this.useReflectionInsteadOfMessages);
      }
    }
  }
}
