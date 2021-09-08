// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.ConcurrentBatchQueue`1
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.Collections.Generic;
using System.Threading;

namespace SuperSocket.ClientEngine
{
  public class ConcurrentBatchQueue<T> : IBatchQueue<T>
  {
    private object m_Entity;
    private ConcurrentBatchQueue<T>.Entity m_BackEntity;
    private static readonly T m_Null;
    private Func<T, bool> m_NullValidator;

    public ConcurrentBatchQueue()
      : this(16)
    {
    }

    public ConcurrentBatchQueue(int capacity)
      : this(new T[capacity])
    {
    }

    public ConcurrentBatchQueue(int capacity, Func<T, bool> nullValidator)
      : this(new T[capacity], nullValidator)
    {
    }

    public ConcurrentBatchQueue(T[] array)
      : this(array, (Func<T, bool>) (t => (object) t == null))
    {
    }

    public ConcurrentBatchQueue(T[] array, Func<T, bool> nullValidator)
    {
      this.m_Entity = (object) new ConcurrentBatchQueue<T>.Entity()
      {
        Array = array
      };
      this.m_BackEntity = new ConcurrentBatchQueue<T>.Entity();
      this.m_BackEntity.Array = new T[array.Length];
      this.m_NullValidator = nullValidator;
    }

    public bool Enqueue(T item)
    {
      bool full;
      do
        ;
      while (!(this.TryEnqueue(item, out full) | full));
      return !full;
    }

    private bool TryEnqueue(T item, out bool full)
    {
      full = false;
      ConcurrentBatchQueue<T>.Entity entity = this.m_Entity as ConcurrentBatchQueue<T>.Entity;
      T[] array = entity.Array;
      int count = entity.Count;
      if (count >= array.Length)
      {
        full = true;
        return false;
      }
      if (entity != this.m_Entity || Interlocked.CompareExchange(ref entity.Count, count + 1, count) != count)
        return false;
      array[count] = item;
      return true;
    }

    public bool Enqueue(IList<T> items)
    {
      bool full;
      do
        ;
      while (!(this.TryEnqueue(items, out full) | full));
      return !full;
    }

    private bool TryEnqueue(IList<T> items, out bool full)
    {
      full = false;
      ConcurrentBatchQueue<T>.Entity entity = this.m_Entity as ConcurrentBatchQueue<T>.Entity;
      T[] array = entity.Array;
      int count1 = entity.Count;
      int count2 = items.Count;
      int num = count1 + count2;
      if (num > array.Length)
      {
        full = true;
        return false;
      }
      if (entity != this.m_Entity || Interlocked.CompareExchange(ref entity.Count, num, count1) != count1)
        return false;
      foreach (T obj in (IEnumerable<T>) items)
        array[count1++] = obj;
      return true;
    }

    public bool TryDequeue(IList<T> outputItems)
    {
      ConcurrentBatchQueue<T>.Entity entity = this.m_Entity as ConcurrentBatchQueue<T>.Entity;
      if (entity.Count <= 0 || Interlocked.CompareExchange(ref this.m_Entity, (object) this.m_BackEntity, (object) entity) != entity)
        return false;
      SpinWait spinWait = new SpinWait();
      spinWait.SpinOnce();
      int count = entity.Count;
      T[] array = entity.Array;
      int index = 0;
      while (true)
      {
        T obj;
        for (obj = array[index]; this.m_NullValidator(obj); obj = array[index])
          spinWait.SpinOnce();
        outputItems.Add(obj);
        array[index] = ConcurrentBatchQueue<T>.m_Null;
        if (entity.Count > index + 1)
          ++index;
        else
          break;
      }
      entity.Count = 0;
      this.m_BackEntity = entity;
      return true;
    }

    public bool IsEmpty => this.Count <= 0;

    public int Count => ((ConcurrentBatchQueue<T>.Entity) this.m_Entity).Count;

    private class Entity
    {
      public int Count;

      public T[] Array { get; set; }
    }
  }
}
