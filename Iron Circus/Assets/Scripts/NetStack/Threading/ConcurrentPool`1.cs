// Decompiled with JetBrains decompiler
// Type: NetStack.Threading.ConcurrentPool`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Threading;

namespace NetStack.Threading
{
  public sealed class ConcurrentPool<T> where T : class
  {
    private SpinLock _lock;
    private readonly Func<T> _factory;
    private ConcurrentPool<T>.Segment _head;
    private ConcurrentPool<T>.Segment _tail;

    public ConcurrentPool(int capacity, Func<T> factory)
    {
      this._lock = new SpinLock();
      this._head = this._tail = new ConcurrentPool<T>.Segment(capacity);
      this._factory = factory;
    }

    public T Acquire()
    {
      ConcurrentPool<T>.Segment head;
      int count;
      do
      {
        head = this._head;
        count = head.Count;
        if (count == 0)
        {
          if (head.Next == null)
            return this._factory();
          bool lockTaken = false;
          try
          {
            this._lock.Enter(ref lockTaken);
            if (this._head.Next != null)
            {
              if (this._head.Count == 0)
                this._head = this._head.Next;
            }
          }
          finally
          {
            if (lockTaken)
              this._lock.Exit(false);
          }
        }
      }
      while (Interlocked.CompareExchange(ref head.Count, count - 1, count) != count);
      int index = Interlocked.Increment(ref head.Low) - 1 & head.Mask;
      SpinWait spinWait = new SpinWait();
      T obj1;
      while (true)
      {
        ref T local = ref head.Items[index];
        T obj2 = default (T);
        if ((object) (obj1 = Interlocked.Exchange<T>(ref local, obj2)) == null)
          spinWait.SpinOnce();
        else
          break;
      }
      return obj1;
    }

    public void Release(T item)
    {
      ConcurrentPool<T>.Segment tail;
      int count;
      do
      {
        tail = this._tail;
        count = tail.Count;
        if (count == tail.Items.Length)
        {
          bool lockTaken = false;
          try
          {
            this._lock.Enter(ref lockTaken);
            if (this._tail.Next == null)
            {
              if (count == this._tail.Items.Length)
                this._tail = this._tail.Next = new ConcurrentPool<T>.Segment(this._tail.Items.Length << 1);
            }
          }
          finally
          {
            if (lockTaken)
              this._lock.Exit(false);
          }
        }
      }
      while (Interlocked.CompareExchange(ref tail.Count, count + 1, count) != count);
      int index = Interlocked.Increment(ref tail.High) - 1 & tail.Mask;
      SpinWait spinWait = new SpinWait();
      while ((object) Interlocked.CompareExchange<T>(ref tail.Items[index], item, default (T)) != null)
        spinWait.SpinOnce();
    }

    private class Segment
    {
      public readonly T[] Items;
      public readonly int Mask;
      public int Low;
      public int High;
      public int Count;
      public ConcurrentPool<T>.Segment Next;

      public Segment(int size)
      {
        this.Items = size > 0 && (size & size - 1) == 0 ? new T[size] : throw new ArgumentOutOfRangeException("Segment size must be power of two");
        this.Mask = size - 1;
      }
    }
  }
}
