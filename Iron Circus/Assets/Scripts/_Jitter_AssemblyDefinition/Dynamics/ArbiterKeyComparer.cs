// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.ArbiterKeyComparer
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using System.Collections.Generic;

namespace Jitter.Dynamics
{
  internal class ArbiterKeyComparer : IEqualityComparer<ArbiterKey>
  {
    public bool Equals(ArbiterKey x, ArbiterKey y)
    {
      if (x.body1.Equals(y.body1) && x.body2.Equals(y.body2))
        return true;
      return x.body1.Equals(y.body2) && x.body2.Equals(y.body1);
    }

    public int GetHashCode(ArbiterKey obj) => obj.body1.GetHashCode() + obj.body2.GetHashCode();
  }
}
