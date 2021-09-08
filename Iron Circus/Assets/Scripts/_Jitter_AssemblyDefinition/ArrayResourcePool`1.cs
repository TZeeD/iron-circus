// Decompiled with JetBrains decompiler
// Type: Jitter.ArrayResourcePool`1
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System.Collections.Generic;

namespace Jitter
{
  public class ArrayResourcePool<T>
  {
    private readonly int arrayLength;
    private readonly Stack<T[]> stack = new Stack<T[]>();

    public ArrayResourcePool(int arrayLength) => this.arrayLength = arrayLength;

    public int Count => this.stack.Count;

    public void ResetResourcePool()
    {
      lock (this.stack)
        this.stack.Clear();
    }

    public void GiveBack(T[] obj)
    {
      lock (this.stack)
        this.stack.Push(obj);
    }

    public T[] GetNew()
    {
      lock (this.stack)
      {
        if (this.stack.Count == 0)
          this.stack.Push(new T[this.arrayLength]);
        return this.stack.Pop();
      }
    }
  }
}
