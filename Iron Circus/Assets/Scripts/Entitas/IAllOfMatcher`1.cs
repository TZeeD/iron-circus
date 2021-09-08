// Decompiled with JetBrains decompiler
// Type: Entitas.IAllOfMatcher`1
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

namespace Entitas
{
  public interface IAllOfMatcher<TEntity> : 
    IAnyOfMatcher<TEntity>,
    INoneOfMatcher<TEntity>,
    ICompoundMatcher<TEntity>,
    IMatcher<TEntity>
    where TEntity : class, IEntity
  {
    IAnyOfMatcher<TEntity> AnyOf(params int[] indices);

    IAnyOfMatcher<TEntity> AnyOf(params IMatcher<TEntity>[] matchers);
  }
}
