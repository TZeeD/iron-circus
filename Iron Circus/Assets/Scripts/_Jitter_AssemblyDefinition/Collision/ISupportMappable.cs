// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.ISupportMappable
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;

namespace Jitter.Collision
{
  public interface ISupportMappable
  {
    void SupportMapping(ref JVector direction, out JVector result);

    void SupportCenter(out JVector center);
  }
}
