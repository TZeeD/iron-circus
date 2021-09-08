// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.ArbiterKey
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

namespace Jitter.Dynamics
{
  public struct ArbiterKey
  {
    internal JRigidbody body1;
    internal JRigidbody body2;

    public ArbiterKey(JRigidbody body1, JRigidbody body2)
    {
      this.body1 = body1;
      this.body2 = body2;
    }

    internal void SetBodies(JRigidbody body1, JRigidbody body2)
    {
      this.body1 = body1;
      this.body2 = body2;
    }

    public override bool Equals(object obj)
    {
      ArbiterKey arbiterKey = (ArbiterKey) obj;
      if (arbiterKey.body1.Equals(this.body1) && arbiterKey.body2.Equals(this.body2))
        return true;
      return arbiterKey.body1.Equals(this.body2) && arbiterKey.body2.Equals(this.body1);
    }

    public override int GetHashCode() => this.body1.GetHashCode() + this.body2.GetHashCode();
  }
}
