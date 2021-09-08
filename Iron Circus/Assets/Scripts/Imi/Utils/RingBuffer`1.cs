// Decompiled with JetBrains decompiler
// Type: Imi.Utils.RingBuffer`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace Imi.Utils
{
  public class RingBuffer<T> where T : new()
  {
    private readonly int bufferSize;
    private readonly T[] buffer;
    private readonly int[] writtenAt;

    public RingBuffer(int bufferSize)
    {
      this.bufferSize = bufferSize;
      this.buffer = new T[bufferSize];
      this.writtenAt = new int[bufferSize];
      for (int index = 0; index < bufferSize; ++index)
        this.buffer[index] = new T();
    }

    public void SetObject(int tick, T t)
    {
      int index = this.GetIndex(tick);
      this.buffer[index] = t;
      this.writtenAt[index] = tick;
    }

    public T GetObject(int tick) => this.buffer[this.GetIndex(tick)];

    public void Fill(int tick, T t)
    {
      for (int index = 0; index < this.bufferSize; ++index)
      {
        this.buffer[index] = t;
        this.writtenAt[index] = tick;
      }
    }

    public int GetWritten(int tick) => this.writtenAt[this.GetIndex(tick)];

    private int GetIndex(int tick) => (tick % this.bufferSize + this.bufferSize) % this.bufferSize;
  }
}
