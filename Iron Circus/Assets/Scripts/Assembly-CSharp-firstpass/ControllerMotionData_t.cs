// Decompiled with JetBrains decompiler
// Type: Steamworks.ControllerMotionData_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System.Runtime.InteropServices;

namespace Steamworks
{
  [StructLayout(LayoutKind.Sequential, Pack = 8)]
  public struct ControllerMotionData_t
  {
    public float rotQuatX;
    public float rotQuatY;
    public float rotQuatZ;
    public float rotQuatW;
    public float posAccelX;
    public float posAccelY;
    public float posAccelZ;
    public float rotVelX;
    public float rotVelY;
    public float rotVelZ;
  }
}
