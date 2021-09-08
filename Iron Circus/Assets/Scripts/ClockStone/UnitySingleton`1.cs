// Decompiled with JetBrains decompiler
// Type: ClockStone.UnitySingleton`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace ClockStone
{
  public class UnitySingleton<T> where T : MonoBehaviour
  {
    private static T _instance;
    internal static GameObject _autoCreatePrefab;
    private static int _GlobalInstanceCount;
    private static bool _awakeSingletonCalled;

    public static T GetSingleton(
      bool throwErrorIfNotFound,
      bool autoCreate,
      bool searchInObjectHierarchy = true)
    {
      if (!(bool) (Object) UnitySingleton<T>._instance)
      {
        T instance = default (T);
        if (searchInObjectHierarchy)
        {
          T[] objectsOfType = Object.FindObjectsOfType<T>();
          for (int index = 0; index < objectsOfType.Length; ++index)
          {
            if (objectsOfType[index] is ISingletonMonoBehaviour singletonMonoBehaviour5 && singletonMonoBehaviour5.isSingletonObject)
            {
              instance = objectsOfType[index];
              break;
            }
          }
        }
        if (!(bool) (Object) instance)
        {
          if (autoCreate && (Object) UnitySingleton<T>._autoCreatePrefab != (Object) null)
          {
            Object.Instantiate<GameObject>(UnitySingleton<T>._autoCreatePrefab).name = UnitySingleton<T>._autoCreatePrefab.name;
            if (!(bool) (Object) Object.FindObjectOfType<T>())
            {
              Debug.LogError((object) ("Auto created object does not have component " + typeof (T).Name));
              return default (T);
            }
          }
          else
          {
            if (throwErrorIfNotFound)
              Debug.LogError((object) ("No singleton component " + typeof (T).Name + " found in the scene."));
            return default (T);
          }
        }
        else
          UnitySingleton<T>._AwakeSingleton(instance);
        UnitySingleton<T>._instance = instance;
      }
      return UnitySingleton<T>._instance;
    }

    private UnitySingleton()
    {
    }

    internal static void _Awake(T instance)
    {
      ++UnitySingleton<T>._GlobalInstanceCount;
      if (UnitySingleton<T>._GlobalInstanceCount > 1)
        Debug.LogError((object) ("More than one instance of SingletonMonoBehaviour " + typeof (T).Name));
      else
        UnitySingleton<T>._instance = instance;
      UnitySingleton<T>._AwakeSingleton(instance);
    }

    internal static void _Destroy()
    {
      if (UnitySingleton<T>._GlobalInstanceCount <= 0)
        return;
      --UnitySingleton<T>._GlobalInstanceCount;
      if (UnitySingleton<T>._GlobalInstanceCount != 0)
        return;
      UnitySingleton<T>._awakeSingletonCalled = false;
      UnitySingleton<T>._instance = default (T);
    }

    private static void _AwakeSingleton(T instance)
    {
      if (UnitySingleton<T>._awakeSingletonCalled)
        return;
      UnitySingleton<T>._awakeSingletonCalled = true;
      instance.SendMessage("AwakeSingleton", SendMessageOptions.DontRequireReceiver);
    }
  }
}
