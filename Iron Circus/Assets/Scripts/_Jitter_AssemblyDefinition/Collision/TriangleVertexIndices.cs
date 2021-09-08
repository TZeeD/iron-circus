// Decompiled with JetBrains decompiler
// Type: Jitter.Collision.TriangleVertexIndices
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

namespace Jitter.Collision
{
  public struct TriangleVertexIndices
  {
    public int I0;
    public int I1;
    public int I2;

    public TriangleVertexIndices(int i0, int i1, int i2)
    {
      this.I0 = i0;
      this.I1 = i1;
      this.I2 = i2;
    }

    public void Set(int i0, int i1, int i2)
    {
      this.I0 = i0;
      this.I1 = i1;
      this.I2 = i2;
    }
  }
}
