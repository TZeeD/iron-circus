// Decompiled with JetBrains decompiler
// Type: NetStack.Threading.ConcurrentBuffer
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Runtime.InteropServices;
using System.Threading;

namespace NetStack.Threading
{
  [StructLayout(LayoutKind.Explicit, Size = 192)]
  public sealed class ConcurrentBuffer
  {
    [FieldOffset(0)]
    private readonly ConcurrentBuffer.Cell[] _buffer;
    [FieldOffset(8)]
    private readonly int _bufferMask;
    [FieldOffset(64)]
    private int _enqueuePosition;
    [FieldOffset(128)]
    private int _dequeuePosition;

    public int Count => this._enqueuePosition - this._dequeuePosition;

    public ConcurrentBuffer(int bufferSize)
    {
      if (bufferSize < 2)
        throw new ArgumentException("Buffer size should be greater than or equal to two");
      if ((bufferSize & bufferSize - 1) != 0)
        throw new ArgumentException("Buffer size should be a power of two");
      this._bufferMask = bufferSize - 1;
      this._buffer = new ConcurrentBuffer.Cell[bufferSize];
      for (int sequence = 0; sequence < bufferSize; ++sequence)
        this._buffer[sequence] = new ConcurrentBuffer.Cell(sequence, (object) null);
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
      int enqueuePosition;
      ConcurrentBuffer.Cell cell;
      do
      {
        ConcurrentBuffer.Cell[] buffer = this._buffer;
        enqueuePosition = this._enqueuePosition;
        int index = enqueuePosition & this._bufferMask;
        cell = buffer[index];
        if (cell.Sequence == enqueuePosition && Interlocked.CompareExchange(ref this._enqueuePosition, enqueuePosition + 1, enqueuePosition) == enqueuePosition)
        {
          buffer[index].Element = item;
          Volatile.Write(ref buffer[index].Sequence, enqueuePosition + 1);
          return true;
        }
      }
      while (cell.Sequence >= enqueuePosition);
      return false;
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
      int dequeuePosition;
      ConcurrentBuffer.Cell cell;
      do
      {
        ConcurrentBuffer.Cell[] buffer = this._buffer;
        int bufferMask = this._bufferMask;
        dequeuePosition = this._dequeuePosition;
        int index = dequeuePosition & bufferMask;
        cell = buffer[index];
        if (cell.Sequence == dequeuePosition + 1 && Interlocked.CompareExchange(ref this._dequeuePosition, dequeuePosition + 1, dequeuePosition) == dequeuePosition)
        {
          result = cell.Element;
          buffer[index].Element = (object) null;
          Volatile.Write(ref buffer[index].Sequence, dequeuePosition + bufferMask + 1);
          return true;
        }
      }
      while (cell.Sequence >= dequeuePosition + 1);
      result = (object) null;
      return false;
    }

    [StructLayout(LayoutKind.Explicit, Size = 16)]
    private struct Cell
    {
      [FieldOffset(0)]
      public int Sequence;
      [FieldOffset(8)]
      public object Element;

      public Cell(int sequence, object element)
      {
        this.Sequence = sequence;
        this.Element = element;
      }
    }
  }
}
