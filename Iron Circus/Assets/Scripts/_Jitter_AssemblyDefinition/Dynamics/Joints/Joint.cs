// Decompiled with JetBrains decompiler
// Type: Jitter.Dynamics.Joints.Joint
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

namespace Jitter.Dynamics.Joints
{
  public abstract class Joint
  {
    public World World { get; private set; }

    public Joint(World world) => this.World = world;

    public abstract void Activate();

    public abstract void Deactivate();
  }
}
