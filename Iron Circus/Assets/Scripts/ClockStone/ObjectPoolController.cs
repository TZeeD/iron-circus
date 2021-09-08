// Decompiled with JetBrains decompiler
// Type: ClockStone.ObjectPoolController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using MessengerExtensions;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace ClockStone
{
  public static class ObjectPoolController
  {
    internal static int _globalSerialNumber = 0;
    internal static bool _isDuringInstantiate = false;
    private static Dictionary<int, ObjectPoolController.ObjectPool> _pools = new Dictionary<int, ObjectPoolController.ObjectPool>();

    public static bool isDuringPreload { get; private set; }

    public static GameObject Instantiate(GameObject prefab, Transform parent = null)
    {
      PoolableObject component = prefab.GetComponent<PoolableObject>();
      return (Object) component == (Object) null ? ObjectPoolController._InstantiateGameObject(prefab, Vector3.zero, Quaternion.identity, parent) : ObjectPoolController._GetPool(component).GetPooledInstance(new Vector3?(), new Quaternion?(), prefab.activeSelf, parent) ?? ObjectPoolController.InstantiateWithoutPool(prefab, parent);
    }

    public static GameObject Instantiate(
      GameObject prefab,
      Vector3 position,
      Quaternion quaternion,
      Transform parent = null)
    {
      PoolableObject component = prefab.GetComponent<PoolableObject>();
      return (Object) component == (Object) null ? ObjectPoolController._InstantiateGameObject(prefab, position, quaternion, parent) : ObjectPoolController._GetPool(component).GetPooledInstance(new Vector3?(position), new Quaternion?(quaternion), prefab.activeSelf, parent) ?? ObjectPoolController.InstantiateWithoutPool(prefab, position, quaternion, parent);
    }

    public static GameObject InstantiateWithoutPool(GameObject prefab, Transform parent = null) => ObjectPoolController.InstantiateWithoutPool(prefab, Vector3.zero, Quaternion.identity, parent);

    public static GameObject InstantiateWithoutPool(
      GameObject prefab,
      Vector3 position,
      Quaternion quaternion,
      Transform parent = null)
    {
      ObjectPoolController._isDuringInstantiate = true;
      GameObject gameObject = ObjectPoolController._InstantiateGameObject(prefab, position, quaternion, parent);
      ObjectPoolController._isDuringInstantiate = false;
      PoolableObject component = gameObject.GetComponent<PoolableObject>();
      if ((Object) component != (Object) null)
      {
        component._instantiatedByObjectPoolController = true;
        if (component.doNotDestroyOnLoad)
          Object.DontDestroyOnLoad((Object) gameObject);
        Object.Destroy((Object) component);
      }
      return gameObject;
    }

    private static GameObject _InstantiateGameObject(
      GameObject prefab,
      Vector3 position,
      Quaternion rotation,
      Transform parent)
    {
      return Object.Instantiate<GameObject>(prefab, position, rotation, parent);
    }

    public static void Destroy(GameObject obj) => ObjectPoolController._DetachChildrenAndDestroy(obj.transform, false);

    public static void DestroyImmediate(GameObject obj) => ObjectPoolController._DetachChildrenAndDestroy(obj.transform, true);

    public static void Preload(GameObject prefab)
    {
      PoolableObject component = prefab.GetComponent<PoolableObject>();
      if ((Object) component == (Object) null)
      {
        Debug.LogWarning((object) ("Can not preload because prefab '" + prefab.name + "' is not poolable"));
      }
      else
      {
        ObjectPoolController.ObjectPool pool = ObjectPoolController._GetPool(component);
        int num = component.preloadCount - pool.GetObjectCount();
        if (num <= 0)
          return;
        ObjectPoolController.isDuringPreload = true;
        bool activeSelf = prefab.activeSelf;
        try
        {
          for (int index = 0; index < num; ++index)
            pool.PreloadInstance(activeSelf);
        }
        finally
        {
          ObjectPoolController.isDuringPreload = false;
        }
      }
    }

    internal static ObjectPoolController.ObjectPool _GetPool(
      PoolableObject prefabPoolComponent)
    {
      GameObject gameObject = prefabPoolComponent.gameObject;
      int instanceId = gameObject.GetInstanceID();
      ObjectPoolController.ObjectPool objectPool;
      if (!ObjectPoolController._pools.TryGetValue(instanceId, out objectPool))
      {
        objectPool = new ObjectPoolController.ObjectPool(gameObject);
        ObjectPoolController._pools.Add(instanceId, objectPool);
      }
      return objectPool;
    }

    private static void _DetachChildrenAndDestroy(Transform transform, bool destroyImmediate)
    {
      PoolableObject component = transform.GetComponent<PoolableObject>();
      if (transform.childCount > 0)
      {
        List<PoolableObject> result = new List<PoolableObject>();
        transform.GetComponentsInChildren<PoolableObject>(true, result);
        if ((Object) component != (Object) null)
          result.Remove(component);
        for (int index = 0; index < result.Count; ++index)
        {
          if (!((Object) result[index] == (Object) null) && !result[index]._isInPool)
          {
            if (destroyImmediate)
              ObjectPoolController.DestroyImmediate(result[index].gameObject);
            else
              ObjectPoolController.Destroy(result[index].gameObject);
          }
        }
      }
      if ((Object) component != (Object) null)
        component._PutIntoPool();
      else if (destroyImmediate)
        Object.DestroyImmediate((Object) transform.gameObject);
      else
        Object.Destroy((Object) transform.gameObject);
    }

    internal class ObjectPool
    {
      private List<PoolableObject> _pool;
      private GameObject _prefab;
      private PoolableObject _poolableObjectComponent;
      private Transform _poolParent;

      internal Transform poolParent
      {
        get
        {
          this._ValidatePoolParentDummy();
          return this._poolParent;
        }
      }

      public ObjectPool(GameObject prefab)
      {
        this._prefab = prefab;
        this._poolableObjectComponent = prefab.GetComponent<PoolableObject>();
      }

      private void _ValidatePooledObjectDataContainer()
      {
        if (this._pool != null)
          return;
        this._pool = new List<PoolableObject>();
        this._ValidatePoolParentDummy();
      }

      private void _ValidatePoolParentDummy()
      {
        if ((bool) (Object) this._poolParent)
          return;
        GameObject gameObject = new GameObject("POOL:" + this._poolableObjectComponent.name);
        this._poolParent = gameObject.transform;
        gameObject._SetActive(false);
        if (!this._poolableObjectComponent.doNotDestroyOnLoad)
          return;
        Object.DontDestroyOnLoad((Object) gameObject);
      }

      internal void Remove(PoolableObject poolObj) => this._pool.Remove(poolObj);

      internal int GetObjectCount() => this._pool != null ? this._pool.Count : 0;

      internal GameObject GetPooledInstance(
        Vector3? position,
        Quaternion? rotation,
        bool activateObject,
        Transform parent = null)
      {
        this._ValidatePooledObjectDataContainer();
        PoolableObject poolableObject1 = (PoolableObject) null;
        for (int index = 0; index < this._pool.Count; ++index)
        {
          PoolableObject poolableObject2 = this._pool.ElementAt<PoolableObject>(index);
          if ((Object) poolableObject2 != (Object) null && poolableObject2._isInPool)
          {
            poolableObject1 = poolableObject2;
            Transform transform = poolableObject2.transform;
            transform.position = position.HasValue ? position.Value : this._poolableObjectComponent.transform.position;
            transform.rotation = rotation.HasValue ? rotation.Value : this._poolableObjectComponent.transform.rotation;
            transform.localScale = this._poolableObjectComponent.transform.localScale;
            break;
          }
        }
        if ((Object) poolableObject1 == (Object) null && this._pool.Count < this._poolableObjectComponent.maxPoolSize)
        {
          PoolableObject poolableObject3 = this._NewPooledInstance(position, rotation, activateObject, false);
          poolableObject3.transform.parent = parent;
          return poolableObject3.gameObject;
        }
        if (!((Object) poolableObject1 != (Object) null))
          return (GameObject) null;
        poolableObject1.TakeFromPool(parent, activateObject);
        return poolableObject1.gameObject;
      }

      internal PoolableObject PreloadInstance(bool preloadActive)
      {
        this._ValidatePooledObjectDataContainer();
        return this._NewPooledInstance(new Vector3?(), new Quaternion?(), preloadActive, true);
      }

      private PoolableObject _NewPooledInstance(
        Vector3? position,
        Quaternion? rotation,
        bool createActive,
        bool addToPool)
      {
        ObjectPoolController._isDuringInstantiate = true;
        this._prefab._SetActive(false);
        GameObject gameObject = Object.Instantiate<GameObject>(this._prefab, position ?? Vector3.zero, rotation ?? Quaternion.identity);
        this._prefab._SetActive(true);
        PoolableObject component = gameObject.GetComponent<PoolableObject>();
        component._pool = this;
        component._serialNumber = ++ObjectPoolController._globalSerialNumber;
        component.name += (string) (object) component._serialNumber;
        if (component.doNotDestroyOnLoad)
          Object.DontDestroyOnLoad((Object) this.poolParent);
        this._pool.Add(component);
        if (addToPool)
        {
          component._PutIntoPool();
        }
        else
        {
          ++component._usageCount;
          if (createActive)
          {
            gameObject.SetActive(true);
            if (component.sendPoolableActivateDeactivateMessages)
              this.CallMethodOnObject(component.gameObject, "OnPoolableObjectActivated", true, true, component.useReflectionInsteadOfMessages);
          }
        }
        ObjectPoolController._isDuringInstantiate = false;
        return component;
      }

      internal int _SetAllAvailable()
      {
        int num = 0;
        for (int index = 0; index < this._pool.Count; ++index)
        {
          PoolableObject poolableObject = this._pool.ElementAt<PoolableObject>(index);
          if ((Object) poolableObject != (Object) null && !poolableObject._isInPool)
          {
            poolableObject._PutIntoPool();
            ++num;
          }
        }
        return num;
      }

      internal void CallMethodOnObject(
        GameObject obj,
        string method,
        bool includeChildren,
        bool includeInactive,
        bool useReflection)
      {
        if (useReflection)
        {
          if (includeChildren)
            obj.InvokeMethodInChildren(method, includeInactive);
          else
            obj.InvokeMethod(method, includeInactive);
        }
        else
        {
          if (!obj._GetActive())
            Debug.LogWarning((object) ("Tried to call method \"" + method + "\" on an inactive GameObject using Unity-Messaging-System. This only works on active GameObjects and Components! Check \"useReflectionInsteadOfMessages\"!"), (Object) obj);
          if (includeChildren)
            obj.BroadcastMessage(method, (object) null, SendMessageOptions.DontRequireReceiver);
          else
            obj.SendMessage(method, (object) null, SendMessageOptions.DontRequireReceiver);
        }
      }
    }
  }
}
