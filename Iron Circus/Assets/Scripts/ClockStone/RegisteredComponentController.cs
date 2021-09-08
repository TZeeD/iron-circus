// Decompiled with JetBrains decompiler
// Type: ClockStone.RegisteredComponentController
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Generic;
using UnityEngine;

namespace ClockStone
{
  public static class RegisteredComponentController
  {
    private static Dictionary<System.Type, RegisteredComponentController.InstanceContainer> _instanceContainers = new Dictionary<System.Type, RegisteredComponentController.InstanceContainer>();

    public static T[] GetAllOfType<T>() where T : IRegisteredComponent
    {
      RegisteredComponentController.InstanceContainer instanceContainer;
      if (!RegisteredComponentController._instanceContainers.TryGetValue(typeof (T), out instanceContainer))
        return new T[0];
      T[] objArray = new T[instanceContainer.Count];
      int num = 0;
      foreach (IRegisteredComponent registeredComponent in (HashSet<IRegisteredComponent>) instanceContainer)
        objArray[num++] = (T) registeredComponent;
      return objArray;
    }

    public static object[] GetAllOfType(System.Type type)
    {
      RegisteredComponentController.InstanceContainer instanceContainer;
      if (!RegisteredComponentController._instanceContainers.TryGetValue(type, out instanceContainer))
        return new object[0];
      object[] objArray = new object[instanceContainer.Count];
      int num = 0;
      foreach (IRegisteredComponent registeredComponent in (HashSet<IRegisteredComponent>) instanceContainer)
        objArray[num++] = (object) registeredComponent;
      return objArray;
    }

    public static int InstanceCountOfType<T>() where T : IRegisteredComponent
    {
      RegisteredComponentController.InstanceContainer instanceContainer;
      return !RegisteredComponentController._instanceContainers.TryGetValue(typeof (T), out instanceContainer) ? 0 : instanceContainer.Count;
    }

    private static RegisteredComponentController.InstanceContainer _GetInstanceContainer(
      System.Type type)
    {
      RegisteredComponentController.InstanceContainer instanceContainer1;
      if (RegisteredComponentController._instanceContainers.TryGetValue(type, out instanceContainer1))
        return instanceContainer1;
      RegisteredComponentController.InstanceContainer instanceContainer2 = new RegisteredComponentController.InstanceContainer();
      RegisteredComponentController._instanceContainers.Add(type, instanceContainer2);
      return instanceContainer2;
    }

    private static void _RegisterType(IRegisteredComponent component, System.Type type)
    {
      if (RegisteredComponentController._GetInstanceContainer(type).Add(component))
        return;
      Debug.LogError((object) "RegisteredComponentController error: Tried to register same instance twice");
    }

    internal static void _Register(IRegisteredComponent component)
    {
      System.Type type = component.GetType();
      do
      {
        RegisteredComponentController._RegisterType(component, type);
        type = type.BaseType;
      }
      while (type != component.GetRegisteredComponentBaseClassType());
    }

    internal static void _UnregisterType(IRegisteredComponent component, System.Type type)
    {
      if (RegisteredComponentController._GetInstanceContainer(type).Remove(component))
        return;
      Debug.LogError((object) "RegisteredComponentController error: Tried to unregister unknown instance");
    }

    internal static void _Unregister(IRegisteredComponent component)
    {
      System.Type type = component.GetType();
      do
      {
        RegisteredComponentController._UnregisterType(component, type);
        type = type.BaseType;
      }
      while (type != component.GetRegisteredComponentBaseClassType());
    }

    public class InstanceContainer : HashSet<IRegisteredComponent>
    {
    }
  }
}
