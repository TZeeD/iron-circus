// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.Material
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

namespace Jitter.Dynamics
{
  public class Material
  {
    internal float kineticFriction = 0.3f;
    internal float staticFriction = 0.6f;
    internal float restitution;

    public float Restitution
    {
      get => this.restitution;
      set => this.restitution = value;
    }

    public float StaticFriction
    {
      get => this.staticFriction;
      set => this.staticFriction = value;
    }

    public float KineticFriction
    {
      get => this.kineticFriction;
      set => this.kineticFriction = value;
    }
  }
}
