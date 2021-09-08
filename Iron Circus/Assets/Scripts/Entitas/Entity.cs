// Decompiled with JetBrains decompiler
// Type: Entitas.Entity
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using DesperateDevs.Utils;
using System;
using System.Collections.Generic;
using System.Text;

namespace Entitas
{
  public class Entity : IEntity, IAERC
  {
    private int _creationIndex;
    private bool _isEnabled;
    private int _totalComponents;
    private IComponent[] _components;
    private Stack<IComponent>[] _componentPools;
    private ContextInfo _contextInfo;
    private IAERC _aerc;
    private IComponent[] _componentsCache;
    private int[] _componentIndicesCache;
    private string _toStringCache;
    private StringBuilder _toStringBuilder;

    public event EntityComponentChanged OnComponentAdded;

    public event EntityComponentChanged OnComponentRemoved;

    public event EntityComponentReplaced OnComponentReplaced;

    public event EntityEvent OnEntityReleased;

    public event EntityEvent OnDestroyEntity;

    public int totalComponents => this._totalComponents;

    public int creationIndex => this._creationIndex;

    public bool isEnabled => this._isEnabled;

    public Stack<IComponent>[] componentPools => this._componentPools;

    public ContextInfo contextInfo => this._contextInfo;

    public IAERC aerc => this._aerc;

    public void Initialize(
      int creationIndex,
      int totalComponents,
      Stack<IComponent>[] componentPools,
      ContextInfo contextInfo = null,
      IAERC aerc = null)
    {
      this.Reactivate(creationIndex);
      this._totalComponents = totalComponents;
      this._components = new IComponent[totalComponents];
      this._componentPools = componentPools;
      this._contextInfo = contextInfo ?? this.createDefaultContextInfo();
      this._aerc = aerc ?? (IAERC) new SafeAERC((IEntity) this);
    }

    private ContextInfo createDefaultContextInfo()
    {
      string[] componentNames = new string[this.totalComponents];
      for (int index = 0; index < componentNames.Length; ++index)
        componentNames[index] = index.ToString();
      return new ContextInfo("No Context", componentNames, (Type[]) null);
    }

    public void Reactivate(int creationIndex)
    {
      this._creationIndex = creationIndex;
      this._isEnabled = true;
    }

    public void AddComponent(int index, IComponent component)
    {
      if (!this._isEnabled)
        throw new EntityIsNotEnabledException("Cannot add component '" + this._contextInfo.componentNames[index] + "' to " + (object) this + "!");
      if (this.HasComponent(index))
        throw new EntityAlreadyHasComponentException(index, "Cannot add component '" + this._contextInfo.componentNames[index] + "' to " + (object) this + "!", "You should check if an entity already has the component before adding it or use entity.ReplaceComponent().");
      this._components[index] = component;
      this._componentsCache = (IComponent[]) null;
      this._componentIndicesCache = (int[]) null;
      this._toStringCache = (string) null;
      if (this.OnComponentAdded == null)
        return;
      this.OnComponentAdded((IEntity) this, index, component);
    }

    public void RemoveComponent(int index)
    {
      if (!this._isEnabled)
        throw new EntityIsNotEnabledException("Cannot remove component '" + this._contextInfo.componentNames[index] + "' from " + (object) this + "!");
      if (!this.HasComponent(index))
        throw new EntityDoesNotHaveComponentException(index, "Cannot remove component '" + this._contextInfo.componentNames[index] + "' from " + (object) this + "!", "You should check if an entity has the component before removing it.");
      this.replaceComponent(index, (IComponent) null);
    }

    public void ReplaceComponent(int index, IComponent component)
    {
      if (!this._isEnabled)
        throw new EntityIsNotEnabledException("Cannot replace component '" + this._contextInfo.componentNames[index] + "' on " + (object) this + "!");
      if (this.HasComponent(index))
      {
        this.replaceComponent(index, component);
      }
      else
      {
        if (component == null)
          return;
        this.AddComponent(index, component);
      }
    }

    private void replaceComponent(int index, IComponent replacement)
    {
      this._toStringCache = (string) null;
      IComponent component = this._components[index];
      if (replacement != component)
      {
        this._components[index] = replacement;
        this._componentsCache = (IComponent[]) null;
        if (replacement != null)
        {
          if (this.OnComponentReplaced != null)
            this.OnComponentReplaced((IEntity) this, index, component, replacement);
        }
        else
        {
          this._componentIndicesCache = (int[]) null;
          if (this.OnComponentRemoved != null)
            this.OnComponentRemoved((IEntity) this, index, component);
        }
        this.GetComponentPool(index).Push(component);
      }
      else
      {
        if (this.OnComponentReplaced == null)
          return;
        this.OnComponentReplaced((IEntity) this, index, component, replacement);
      }
    }

    public IComponent GetComponent(int index) => this.HasComponent(index) ? this._components[index] : throw new EntityDoesNotHaveComponentException(index, "Cannot get component '" + this._contextInfo.componentNames[index] + "' from " + (object) this + "!", "You should check if an entity has the component before getting it.");

    public IComponent[] GetComponents()
    {
      if (this._componentsCache == null)
      {
        List<IComponent> icomponentList = EntitasCache.GetIComponentList();
        for (int index = 0; index < this._components.Length; ++index)
        {
          IComponent component = this._components[index];
          if (component != null)
            icomponentList.Add(component);
        }
        this._componentsCache = icomponentList.ToArray();
        EntitasCache.PushIComponentList(icomponentList);
      }
      return this._componentsCache;
    }

    public int[] GetComponentIndices()
    {
      if (this._componentIndicesCache == null)
      {
        List<int> intList = EntitasCache.GetIntList();
        for (int index = 0; index < this._components.Length; ++index)
        {
          if (this._components[index] != null)
            intList.Add(index);
        }
        this._componentIndicesCache = intList.ToArray();
        EntitasCache.PushIntList(intList);
      }
      return this._componentIndicesCache;
    }

    public bool HasComponent(int index) => this._components[index] != null;

    public bool HasComponents(int[] indices)
    {
      for (int index = 0; index < indices.Length; ++index)
      {
        if (this._components[indices[index]] == null)
          return false;
      }
      return true;
    }

    public bool HasAnyComponent(int[] indices)
    {
      for (int index = 0; index < indices.Length; ++index)
      {
        if (this._components[indices[index]] != null)
          return true;
      }
      return false;
    }

    public void RemoveAllComponents()
    {
      this._toStringCache = (string) null;
      for (int index = 0; index < this._components.Length; ++index)
      {
        if (this._components[index] != null)
          this.replaceComponent(index, (IComponent) null);
      }
    }

    public Stack<IComponent> GetComponentPool(int index)
    {
      Stack<IComponent> componentStack = this._componentPools[index];
      if (componentStack == null)
      {
        componentStack = new Stack<IComponent>();
        this._componentPools[index] = componentStack;
      }
      return componentStack;
    }

    public IComponent CreateComponent(int index, Type type)
    {
      Stack<IComponent> componentPool = this.GetComponentPool(index);
      return componentPool.Count <= 0 ? (IComponent) Activator.CreateInstance(type) : componentPool.Pop();
    }

    public T CreateComponent<T>(int index) where T : new()
    {
      Stack<IComponent> componentPool = this.GetComponentPool(index);
      return componentPool.Count <= 0 ? new T() : (T) componentPool.Pop();
    }

    public int retainCount => this._aerc.retainCount;

    public void Retain(object owner)
    {
      this._aerc.Retain(owner);
      this._toStringCache = (string) null;
    }

    public void Release(object owner)
    {
      this._aerc.Release(owner);
      this._toStringCache = (string) null;
      if (this._aerc.retainCount != 0 || this.OnEntityReleased == null)
        return;
      this.OnEntityReleased((IEntity) this);
    }

    public void Destroy()
    {
      if (!this._isEnabled)
        throw new EntityIsNotEnabledException("Cannot destroy " + (object) this + "!");
      if (this.OnDestroyEntity == null)
        return;
      this.OnDestroyEntity((IEntity) this);
    }

    public void InternalDestroy()
    {
      this._isEnabled = false;
      this.RemoveAllComponents();
      this.OnComponentAdded = (EntityComponentChanged) null;
      this.OnComponentReplaced = (EntityComponentReplaced) null;
      this.OnComponentRemoved = (EntityComponentChanged) null;
      this.OnDestroyEntity = (EntityEvent) null;
    }

    public void RemoveAllOnEntityReleasedHandlers() => this.OnEntityReleased = (EntityEvent) null;

    public override string ToString()
    {
      if (this._toStringCache == null)
      {
        if (this._toStringBuilder == null)
          this._toStringBuilder = new StringBuilder();
        this._toStringBuilder.Length = 0;
        this._toStringBuilder.Append("Entity_").Append(this._creationIndex).Append("(*").Append(this.retainCount).Append(")").Append("(");
        IComponent[] components = this.GetComponents();
        int num = components.Length - 1;
        for (int index = 0; index < components.Length; ++index)
        {
          IComponent component = components[index];
          Type type = component.GetType();
          this._toStringBuilder.Append(type.GetMethod(nameof (ToString)).DeclaringType.ImplementsInterface<IComponent>() ? component.ToString() : type.ToCompilableString().RemoveComponentSuffix());
          if (index < num)
            this._toStringBuilder.Append(", ");
        }
        this._toStringBuilder.Append(")");
        this._toStringCache = this._toStringBuilder.ToString();
      }
      return this._toStringCache;
    }
  }
}
