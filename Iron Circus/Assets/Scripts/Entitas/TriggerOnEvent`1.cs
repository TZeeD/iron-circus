// Decompiled with JetBrains decompiler
// Type: Entitas.TriggerOnEvent`1
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public struct TriggerOnEvent<TEntity> where TEntity : class, IEntity
  {
    public readonly IMatcher<TEntity> matcher;
    public readonly GroupEvent groupEvent;

    public TriggerOnEvent(IMatcher<TEntity> matcher, GroupEvent groupEvent)
    {
      this.matcher = matcher;
      this.groupEvent = groupEvent;
    }
  }
}
