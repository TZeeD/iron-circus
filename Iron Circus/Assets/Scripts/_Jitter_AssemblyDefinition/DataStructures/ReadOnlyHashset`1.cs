// Decompiled with JetBrains decompiler
// Type: Jitter.DataStructures.ReadOnlyHashset`1
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System.Collections;
using System.Collections.Generic;

namespace Jitter.DataStructures
{
  public class ReadOnlyHashset<T> : IEnumerable, IEnumerable<T>
  {
    private readonly HashSet<T> hashset;

    public ReadOnlyHashset(HashSet<T> hashset) => this.hashset = hashset;

    public int Count => this.hashset.Count;

    public IEnumerator GetEnumerator() => (IEnumerator) this.hashset.GetEnumerator();

    IEnumerator<T> IEnumerable<T>.GetEnumerator() => (IEnumerator<T>) this.hashset.GetEnumerator();

    public bool Contains(T item) => this.hashset.Contains(item);
  }
}
