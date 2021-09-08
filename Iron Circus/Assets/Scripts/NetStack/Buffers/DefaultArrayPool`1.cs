// Decompiled with JetBrains decompiler
// Type: NetStack.Buffers.DefaultArrayPool`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Threading;

namespace NetStack.Buffers
{
  internal sealed class DefaultArrayPool<T> : ArrayPool<T>
  {
    private const int DefaultMaxArrayLength = 1048576;
    private const int DefaultMaxNumberOfArraysPerBucket = 50;
    private static T[] s_emptyArray;
    private readonly DefaultArrayPool<T>.Bucket[] _buckets;

    internal DefaultArrayPool()
      : this(1048576, 50)
    {
    }

    internal DefaultArrayPool(int maxArrayLength, int maxArraysPerBucket)
    {
      if (maxArrayLength <= 0)
        throw new ArgumentOutOfRangeException(nameof (maxArrayLength));
      if (maxArraysPerBucket <= 0)
        throw new ArgumentOutOfRangeException(nameof (maxArraysPerBucket));
      if (maxArrayLength > 1073741824)
        maxArrayLength = 1073741824;
      else if (maxArrayLength < 16)
        maxArrayLength = 16;
      int id = this.Id;
      DefaultArrayPool<T>.Bucket[] bucketArray = new DefaultArrayPool<T>.Bucket[Utilities.SelectBucketIndex(maxArrayLength) + 1];
      for (int binIndex = 0; binIndex < bucketArray.Length; ++binIndex)
        bucketArray[binIndex] = new DefaultArrayPool<T>.Bucket(Utilities.GetMaxSizeForBucket(binIndex), maxArraysPerBucket, id);
      this._buckets = bucketArray;
    }

    private int Id => this.GetHashCode();

    public override T[] Rent(int minimumLength)
    {
      if (minimumLength < 0)
        throw new ArgumentOutOfRangeException(nameof (minimumLength));
      if (minimumLength == 0)
        return DefaultArrayPool<T>.s_emptyArray ?? (DefaultArrayPool<T>.s_emptyArray = new T[0]);
      int index1 = Utilities.SelectBucketIndex(minimumLength);
      T[] objArray1;
      if (index1 < this._buckets.Length)
      {
        int index2 = index1;
        do
        {
          T[] objArray2 = this._buckets[index2].Rent();
          if (objArray2 != null)
            return objArray2;
        }
        while (++index2 < this._buckets.Length && index2 != index1 + 2);
        objArray1 = new T[this._buckets[index1]._bufferLength];
      }
      else
        objArray1 = new T[minimumLength];
      return objArray1;
    }

    public override void Return(T[] array, bool clearArray = false)
    {
      if (array == null)
        throw new ArgumentNullException(nameof (array));
      if (array.Length == 0)
        return;
      int index = Utilities.SelectBucketIndex(array.Length);
      if (index >= this._buckets.Length)
        return;
      if (clearArray)
        Array.Clear((Array) array, 0, array.Length);
      this._buckets[index].Return(array);
    }

    private sealed class Bucket
    {
      internal readonly int _bufferLength;
      private readonly T[][] _buffers;
      private SpinLock _lock;
      private int _index;

      internal Bucket(int bufferLength, int numberOfBuffers, int poolId)
      {
        this._lock = new SpinLock();
        this._buffers = new T[numberOfBuffers][];
        this._bufferLength = bufferLength;
      }

      internal int Id => this.GetHashCode();

      internal T[] Rent()
      {
        T[][] buffers = this._buffers;
        T[] objArray = (T[]) null;
        bool flag = false;
        bool lockTaken = false;
        try
        {
          this._lock.Enter(ref lockTaken);
          if (this._index < buffers.Length)
          {
            objArray = buffers[this._index];
            buffers[this._index++] = (T[]) null;
            flag = objArray == null;
          }
        }
        finally
        {
          if (lockTaken)
            this._lock.Exit(false);
        }
        if (flag)
          objArray = new T[this._bufferLength];
        return objArray;
      }

      internal void Return(T[] array)
      {
        if (array.Length != this._bufferLength)
          throw new ArgumentException("BufferNotFromPool", nameof (array));
        bool lockTaken = false;
        try
        {
          this._lock.Enter(ref lockTaken);
          if (this._index == 0)
            return;
          this._buffers[--this._index] = array;
        }
        finally
        {
          if (lockTaken)
            this._lock.Exit(false);
        }
      }
    }
  }
}
