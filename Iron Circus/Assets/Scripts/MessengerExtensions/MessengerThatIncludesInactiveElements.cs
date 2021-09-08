// Decompiled with JetBrains decompiler
// Type: MessengerExtensions.MessengerThatIncludesInactiveElements
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Reflection;
using UnityEngine;

namespace MessengerExtensions
{
  public static class MessengerThatIncludesInactiveElements
  {
    private static BindingFlags flags = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;

    private static void InvokeIfExists(
      this object objectToCheck,
      string methodName,
      params object[] parameters)
    {
      System.Type type = objectToCheck.GetType();
      do
      {
        MethodInfo method = type.GetMethod(methodName, MessengerThatIncludesInactiveElements.flags);
        type = type.BaseType;
        if (method != (MethodInfo) null)
        {
          method.Invoke(objectToCheck, parameters);
          break;
        }
      }
      while (!(type == (System.Type) null));
    }

    private static void InvokeIfExists(this object objectToCheck, string methodName)
    {
      System.Type type = objectToCheck.GetType();
      do
      {
        MethodInfo method = type.GetMethod(methodName, MessengerThatIncludesInactiveElements.flags);
        type = type.BaseType;
        if (method != (MethodInfo) null)
        {
          method.Invoke(objectToCheck, (object[]) null);
          break;
        }
      }
      while (!(type == (System.Type) null));
    }

    public static void InvokeMethod(
      this GameObject gameobject,
      string methodName,
      bool includeInactive,
      params object[] parameters)
    {
      foreach (MonoBehaviour component in gameobject.GetComponents<MonoBehaviour>())
      {
        if (includeInactive || component.isActiveAndEnabled)
          component.InvokeIfExists(methodName, parameters);
      }
    }

    public static void InvokeMethod(
      this GameObject gameobject,
      string methodName,
      bool includeInactive)
    {
      foreach (MonoBehaviour component in gameobject.GetComponents<MonoBehaviour>())
      {
        if (includeInactive || component.isActiveAndEnabled)
          component.InvokeIfExists(methodName);
      }
    }

    public static void InvokeMethod(
      this Component component,
      string methodName,
      bool includeInactive,
      params object[] parameters)
    {
      component.gameObject.InvokeMethod(methodName, includeInactive, parameters);
    }

    public static void InvokeMethod(
      this Component component,
      string methodName,
      bool includeInactive)
    {
      component.gameObject.InvokeMethod(methodName, includeInactive);
    }

    public static void InvokeMethodInChildren(
      this GameObject gameobject,
      string methodName,
      bool includeInactive,
      params object[] parameters)
    {
      foreach (MonoBehaviour componentsInChild in gameobject.GetComponentsInChildren<MonoBehaviour>(includeInactive))
      {
        if (includeInactive || componentsInChild.isActiveAndEnabled)
          componentsInChild.InvokeIfExists(methodName, parameters);
      }
    }

    public static void InvokeMethodInChildren(
      this GameObject gameobject,
      string methodName,
      bool includeInactive)
    {
      foreach (MonoBehaviour componentsInChild in gameobject.GetComponentsInChildren<MonoBehaviour>(includeInactive))
      {
        if (includeInactive || componentsInChild.isActiveAndEnabled)
          componentsInChild.InvokeIfExists(methodName);
      }
    }

    public static void InvokeMethodInChildren(
      this Component component,
      string methodName,
      bool includeInactive,
      params object[] parameters)
    {
      component.gameObject.InvokeMethodInChildren(methodName, includeInactive, parameters);
    }

    public static void InvokeMethodInChildren(
      this Component component,
      string methodName,
      bool includeInactive)
    {
      component.gameObject.InvokeMethodInChildren(methodName, includeInactive);
    }

    public static void SendMessageUpwardsToAll(
      this GameObject gameobject,
      string methodName,
      bool includeInactive,
      params object[] parameters)
    {
      for (Transform transform = gameobject.transform; (UnityEngine.Object) transform != (UnityEngine.Object) null; transform = transform.parent)
        transform.gameObject.InvokeMethod(methodName, includeInactive, parameters);
    }

    public static void SendMessageUpwardsToAll(
      this Component component,
      string methodName,
      bool includeInactive,
      params object[] parameters)
    {
      component.gameObject.SendMessageUpwardsToAll(methodName, includeInactive, parameters);
    }
  }
}
