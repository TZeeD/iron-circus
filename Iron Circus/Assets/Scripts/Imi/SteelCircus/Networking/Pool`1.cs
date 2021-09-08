// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Networking.Pool`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Collections.Concurrent;

namespace Imi.SteelCircus.Networking
{
  public class Pool<T> where T : new()
  {
    private readonly ConcurrentBag<T> items;
    private int counter;
    private int size;

    public Pool(int size)
    {
      this.size = size;
      this.items = new ConcurrentBag<T>();
      for (int index = 0; index < size; ++index)
      {
        this.items.Add(new T());
        ++this.counter;
      }
    }

    public int Counter => this.counter;

    public void Release(T item)
    {
      if (this.counter >= this.size)
        return;
      this.items.Add(item);
      ++this.counter;
    }

    public T Get()
    {
      T result;
      if (this.items.TryTake(out result))
      {
        --this.counter;
        return result;
      }
      T obj = new T();
      this.items.Add(obj);
      ++this.counter;
      return obj;
    }
  }
}
