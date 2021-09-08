// Decompiled with JetBrains decompiler
// Type: Entitas.Matcher`1
// Assembly: Entitas, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 87CB13EB-019D-4E45-AA72-F4DCEC6EDD6B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Entitas.dll

using System;
using System.Collections.Generic;
using System.Text;

namespace Entitas
{
  public class Matcher<TEntity> : 
    IAllOfMatcher<TEntity>,
    IAnyOfMatcher<TEntity>,
    INoneOfMatcher<TEntity>,
    ICompoundMatcher<TEntity>,
    IMatcher<TEntity>
    where TEntity : class, IEntity
  {
    private int[] _indices;
    private int[] _allOfIndices;
    private int[] _anyOfIndices;
    private int[] _noneOfIndices;
    private string _toStringCache;
    private StringBuilder _toStringBuilder;
    private int _hash;
    private bool _isHashCached;

    public int[] indices
    {
      get
      {
        if (this._indices == null)
          this._indices = Matcher<TEntity>.mergeIndices(this._allOfIndices, this._anyOfIndices, this._noneOfIndices);
        return this._indices;
      }
    }

    public int[] allOfIndices => this._allOfIndices;

    public int[] anyOfIndices => this._anyOfIndices;

    public int[] noneOfIndices => this._noneOfIndices;

    public string[] componentNames { get; set; }

    private Matcher()
    {
    }

    IAnyOfMatcher<TEntity> IAllOfMatcher<TEntity>.AnyOf(
      params int[] indices)
    {
      this._anyOfIndices = Matcher<TEntity>.distinctIndices((IList<int>) indices);
      this._indices = (int[]) null;
      this._isHashCached = false;
      return (IAnyOfMatcher<TEntity>) this;
    }

    IAnyOfMatcher<TEntity> IAllOfMatcher<TEntity>.AnyOf(
      params IMatcher<TEntity>[] matchers)
    {
      return ((IAllOfMatcher<TEntity>) this).AnyOf(Matcher<TEntity>.mergeIndices(matchers));
    }

    public INoneOfMatcher<TEntity> NoneOf(params int[] indices)
    {
      this._noneOfIndices = Matcher<TEntity>.distinctIndices((IList<int>) indices);
      this._indices = (int[]) null;
      this._isHashCached = false;
      return (INoneOfMatcher<TEntity>) this;
    }

    public INoneOfMatcher<TEntity> NoneOf(params IMatcher<TEntity>[] matchers) => this.NoneOf(Matcher<TEntity>.mergeIndices(matchers));

    public bool Matches(TEntity entity)
    {
      if (this._allOfIndices != null && !entity.HasComponents(this._allOfIndices) || this._anyOfIndices != null && !entity.HasAnyComponent(this._anyOfIndices))
        return false;
      return this._noneOfIndices == null || !entity.HasAnyComponent(this._noneOfIndices);
    }

    public override string ToString()
    {
      if (this._toStringCache == null)
      {
        if (this._toStringBuilder == null)
          this._toStringBuilder = new StringBuilder();
        this._toStringBuilder.Length = 0;
        if (this._allOfIndices != null)
          Matcher<TEntity>.appendIndices(this._toStringBuilder, "AllOf", this._allOfIndices, this.componentNames);
        if (this._anyOfIndices != null)
        {
          if (this._allOfIndices != null)
            this._toStringBuilder.Append(".");
          Matcher<TEntity>.appendIndices(this._toStringBuilder, "AnyOf", this._anyOfIndices, this.componentNames);
        }
        if (this._noneOfIndices != null)
          Matcher<TEntity>.appendIndices(this._toStringBuilder, ".NoneOf", this._noneOfIndices, this.componentNames);
        this._toStringCache = this._toStringBuilder.ToString();
      }
      return this._toStringCache;
    }

    private static void appendIndices(
      StringBuilder sb,
      string prefix,
      int[] indexArray,
      string[] componentNames)
    {
      sb.Append(prefix);
      sb.Append("(");
      int num = indexArray.Length - 1;
      for (int index1 = 0; index1 < indexArray.Length; ++index1)
      {
        int index2 = indexArray[index1];
        if (componentNames == null)
          sb.Append(index2);
        else
          sb.Append(componentNames[index2]);
        if (index1 < num)
          sb.Append(", ");
      }
      sb.Append(")");
    }

    public override bool Equals(object obj)
    {
      if (obj == null || obj.GetType() != this.GetType() || obj.GetHashCode() != this.GetHashCode())
        return false;
      Matcher<TEntity> matcher = (Matcher<TEntity>) obj;
      return Matcher<TEntity>.equalIndices(matcher.allOfIndices, this._allOfIndices) && Matcher<TEntity>.equalIndices(matcher.anyOfIndices, this._anyOfIndices) && Matcher<TEntity>.equalIndices(matcher.noneOfIndices, this._noneOfIndices);
    }

    private static bool equalIndices(int[] i1, int[] i2)
    {
      if (i1 == null != (i2 == null))
        return false;
      if (i1 == null)
        return true;
      if (i1.Length != i2.Length)
        return false;
      for (int index = 0; index < i1.Length; ++index)
      {
        if (i1[index] != i2[index])
          return false;
      }
      return true;
    }

    public override int GetHashCode()
    {
      if (!this._isHashCached)
      {
        this._hash = Matcher<TEntity>.applyHash(Matcher<TEntity>.applyHash(Matcher<TEntity>.applyHash(this.GetType().GetHashCode(), this._allOfIndices, 3, 53), this._anyOfIndices, 307, 367), this._noneOfIndices, 647, 683);
        this._isHashCached = true;
      }
      return this._hash;
    }

    private static int applyHash(int hash, int[] indices, int i1, int i2)
    {
      if (indices != null)
      {
        for (int index = 0; index < indices.Length; ++index)
          hash ^= indices[index] * i1;
        hash ^= indices.Length * i2;
      }
      return hash;
    }

    public static IAllOfMatcher<TEntity> AllOf(params int[] indices) => (IAllOfMatcher<TEntity>) new Matcher<TEntity>()
    {
      _allOfIndices = Matcher<TEntity>.distinctIndices((IList<int>) indices)
    };

    public static IAllOfMatcher<TEntity> AllOf(params IMatcher<TEntity>[] matchers)
    {
      Matcher<TEntity> matcher = (Matcher<TEntity>) Matcher<TEntity>.AllOf(Matcher<TEntity>.mergeIndices(matchers));
      Matcher<TEntity>.setComponentNames(matcher, matchers);
      return (IAllOfMatcher<TEntity>) matcher;
    }

    public static IAnyOfMatcher<TEntity> AnyOf(params int[] indices) => (IAnyOfMatcher<TEntity>) new Matcher<TEntity>()
    {
      _anyOfIndices = Matcher<TEntity>.distinctIndices((IList<int>) indices)
    };

    public static IAnyOfMatcher<TEntity> AnyOf(params IMatcher<TEntity>[] matchers)
    {
      Matcher<TEntity> matcher = (Matcher<TEntity>) Matcher<TEntity>.AnyOf(Matcher<TEntity>.mergeIndices(matchers));
      Matcher<TEntity>.setComponentNames(matcher, matchers);
      return (IAnyOfMatcher<TEntity>) matcher;
    }

    private static int[] mergeIndices(int[] allOfIndices, int[] anyOfIndices, int[] noneOfIndices)
    {
      List<int> intList = EntitasCache.GetIntList();
      if (allOfIndices != null)
        intList.AddRange((IEnumerable<int>) allOfIndices);
      if (anyOfIndices != null)
        intList.AddRange((IEnumerable<int>) anyOfIndices);
      if (noneOfIndices != null)
        intList.AddRange((IEnumerable<int>) noneOfIndices);
      int[] numArray = Matcher<TEntity>.distinctIndices((IList<int>) intList);
      EntitasCache.PushIntList(intList);
      return numArray;
    }

    private static int[] mergeIndices(IMatcher<TEntity>[] matchers)
    {
      int[] numArray = new int[matchers.Length];
      for (int index = 0; index < matchers.Length; ++index)
      {
        IMatcher<TEntity> matcher = matchers[index];
        if (matcher.indices.Length != 1)
          throw new MatcherException(matcher.indices.Length);
        numArray[index] = matcher.indices[0];
      }
      return numArray;
    }

    private static string[] getComponentNames(IMatcher<TEntity>[] matchers)
    {
      for (int index = 0; index < matchers.Length; ++index)
      {
        if (matchers[index] is Matcher<TEntity> matcher1 && matcher1.componentNames != null)
          return matcher1.componentNames;
      }
      return (string[]) null;
    }

    private static void setComponentNames(Matcher<TEntity> matcher, IMatcher<TEntity>[] matchers)
    {
      string[] componentNames = Matcher<TEntity>.getComponentNames(matchers);
      if (componentNames == null)
        return;
      matcher.componentNames = componentNames;
    }

    private static int[] distinctIndices(IList<int> indices)
    {
      HashSet<int> intHashSet = EntitasCache.GetIntHashSet();
      foreach (int index in (IEnumerable<int>) indices)
        intHashSet.Add(index);
      int[] array = new int[intHashSet.Count];
      intHashSet.CopyTo(array);
      Array.Sort<int>(array);
      EntitasCache.PushIntHashSet(intHashSet);
      return array;
    }
  }
}
