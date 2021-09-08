// Decompiled with JetBrains decompiler
// Type: Jitter.IDebugDrawer
// Assembly: _Jitter_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 3D8E961C-37CE-4442-B7D4-43B7DDE057B6
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Jitter_AssemblyDefinition.dll

using Jitter.LinearMath;

namespace Jitter
{
  public interface IDebugDrawer
  {
    void DrawLine(JVector start, JVector end);

    void DrawPoint(JVector pos);

    void DrawTriangle(JVector pos1, JVector pos2, JVector pos3);

    void DebugDrawBox(JVector size, JMatrix orientation, JVector position);

    void DrawCylinder(float height, float radius, JMatrix orientation, JVector position);

    void DrawCapsule(float height, float radius, JMatrix orientation, JVector position);

    void DrawSphere(float radius, JMatrix orientation, JVector position);

    void DrawAABB(JBBox bbox);
  }
}
