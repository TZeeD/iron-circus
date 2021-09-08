// Decompiled with JetBrains decompiler
// Type: UnityEngine.GetComponentExtension
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;

namespace UnityEngine
{
  public static class GetComponentExtension
  {
    public static T GetComponentInDirectChildren<T>(this Component parent) where T : Component => parent.GetComponentInDirectChildren<T>(false);

    public static T GetComponentInDirectChildren<T>(this Component parent, bool includeInactive) where T : Component
    {
      foreach (Transform transform in parent.transform)
      {
        if (includeInactive || transform.gameObject.activeInHierarchy)
        {
          T component = transform.GetComponent<T>();
          if ((Object) component != (Object) null)
            return component;
        }
      }
      return default (T);
    }

    public static T[] GetComponentsInDirectChildren<T>(this Component parent) where T : Component => parent.GetComponentsInDirectChildren<T>(false);

    public static T[] GetComponentsInDirectChildren<T>(this Component parent, bool includeInactive) where T : Component
    {
      List<T> objList = new List<T>();
      foreach (Transform transform in parent.transform)
      {
        if (includeInactive || transform.gameObject.activeInHierarchy)
          objList.AddRange((IEnumerable<T>) transform.GetComponents<T>());
      }
      return objList.ToArray();
    }

    public static T GetComponentInSiblings<T>(this Component sibling) where T : Component => sibling.GetComponentInSiblings<T>(false);

    public static T GetComponentInSiblings<T>(this Component sibling, bool includeInactive) where T : Component
    {
      Transform parent = sibling.transform.parent;
      if ((Object) parent == (Object) null)
        return default (T);
      foreach (Transform transform in parent)
      {
        if ((includeInactive || transform.gameObject.activeInHierarchy) && (Object) transform != (Object) sibling)
        {
          T component = transform.GetComponent<T>();
          if ((Object) component != (Object) null)
            return component;
        }
      }
      return default (T);
    }

    public static T[] GetComponentsInSiblings<T>(this Component sibling) where T : Component => sibling.GetComponentsInSiblings<T>(false);

    public static T[] GetComponentsInSiblings<T>(this Component sibling, bool includeInactive) where T : Component
    {
      Transform parent = sibling.transform.parent;
      if ((Object) parent == (Object) null)
        return (T[]) null;
      List<T> objList = new List<T>();
      foreach (Transform transform in parent)
      {
        if ((includeInactive || transform.gameObject.activeInHierarchy) && (Object) transform != (Object) sibling)
          objList.AddRange((IEnumerable<T>) transform.GetComponents<T>());
      }
      return objList.ToArray();
    }

    public static T GetComponentInDirectParent<T>(this Component child) where T : Component
    {
      Transform parent = child.transform.parent;
      return (Object) parent == (Object) null ? default (T) : parent.GetComponent<T>();
    }

    public static T[] GetComponentsInDirectParent<T>(this Component child) where T : Component
    {
      Transform parent = child.transform.parent;
      return (Object) parent == (Object) null ? (T[]) null : parent.GetComponents<T>();
    }
  }
}
