// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.ArbiterMap
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System.Collections;
using System.Collections.Generic;

namespace Jitter.Dynamics
{
  public class ArbiterMap : IEnumerable
  {
    private Dictionary<ArbiterKey, Arbiter> dictionary = new Dictionary<ArbiterKey, Arbiter>(2048, (IEqualityComparer<ArbiterKey>) ArbiterMap.arbiterKeyComparer);
    private ArbiterKey lookUpKey;
    private static ArbiterKeyComparer arbiterKeyComparer = new ArbiterKeyComparer();

    public ArbiterMap() => this.lookUpKey = new ArbiterKey((JRigidbody) null, (JRigidbody) null);

    public bool LookUpArbiter(JRigidbody body1, JRigidbody body2, out Arbiter arbiter)
    {
      this.lookUpKey.SetBodies(body1, body2);
      return this.dictionary.TryGetValue(this.lookUpKey, out arbiter);
    }

    public Dictionary<ArbiterKey, Arbiter>.ValueCollection Arbiters => this.dictionary.Values;

    internal void Add(ArbiterKey key, Arbiter arbiter) => this.dictionary.Add(key, arbiter);

    internal void Clear() => this.dictionary.Clear();

    internal void Remove(Arbiter arbiter)
    {
      this.lookUpKey.SetBodies(arbiter.body1, arbiter.body2);
      this.dictionary.Remove(this.lookUpKey);
    }

    public bool ContainsArbiter(JRigidbody body1, JRigidbody body2)
    {
      this.lookUpKey.SetBodies(body1, body2);
      return this.dictionary.ContainsKey(this.lookUpKey);
    }

    public IEnumerator GetEnumerator() => (IEnumerator) this.dictionary.Values.GetEnumerator();
  }
}
