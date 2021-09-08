// Decompiled with JetBrains decompiler
// Type: NetStack.Threading.ArrayQueue
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Runtime.InteropServices;
using System.Threading;

namespace NetStack.Threading
{
  [StructLayout(LayoutKind.Explicit, Size = 192)]
  public sealed class ArrayQueue
  {
    [FieldOffset(0)]
    private readonly ArrayQueue.Entry[] _array;
    [FieldOffset(8)]
    private readonly int _arrayMask;
    [FieldOffset(64)]
    private int _enqueuePosition;
    [FieldOffset(128)]
    private int _dequeuePosition;

    public int Count => this._enqueuePosition - this._dequeuePosition;

    public ArrayQueue(int capacity)
    {
      if (capacity < 2)
        throw new ArgumentException("Queue size should be greater than or equal to two");
      if ((capacity & capacity - 1) != 0)
        throw new ArgumentException("Queue size should be a power of two");
      this._arrayMask = capacity - 1;
      this._array = new ArrayQueue.Entry[capacity];
      this._enqueuePosition = 0;
      this._dequeuePosition = 0;
    }

    public void Enqueue(object item)
    {
      while (!this.TryEnqueue(item))
        Thread.SpinWait(1);
    }

    public bool TryEnqueue(object item)
    {
      ArrayQueue.Entry[] array = this._array;
      int enqueuePosition = this._enqueuePosition;
      int index = enqueuePosition & this._arrayMask;
      if (array[index].IsSet != 0)
        return false;
      array[index].element = item;
      array[index].IsSet = 1;
      Volatile.Write(ref this._enqueuePosition, enqueuePosition + 1);
      return true;
    }

    public object Dequeue()
    {
      object result;
      do
        ;
      while (!this.TryDequeue(out result));
      return result;
    }

    public bool TryDequeue(out object result)
    {
      ArrayQueue.Entry[] array = this._array;
      int dequeuePosition = this._dequeuePosition;
      int index = dequeuePosition & this._arrayMask;
      if (array[index].IsSet == 0)
      {
        result = (object) null;
        return false;
      }
      result = array[index].element;
      array[index].element = (object) null;
      array[index].IsSet = 0;
      Volatile.Write(ref this._dequeuePosition, dequeuePosition + 1);
      return true;
    }

    [StructLayout(LayoutKind.Explicit, Size = 16)]
    private struct Entry
    {
      [FieldOffset(0)]
      private int isSet;
      [FieldOffset(8)]
      internal object element;

      internal int IsSet
      {
        get => Volatile.Read(ref this.isSet);
        set => Volatile.Write(ref this.isSet, value);
      }
    }
  }
}
