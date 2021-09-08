// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Messages.SerDes.Int32SingleUnion
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System.Runtime.InteropServices;

namespace Imi.SharedWithServer.Networking.Messages.SerDes
{
  [StructLayout(LayoutKind.Explicit)]
  internal struct Int32SingleUnion
  {
    [FieldOffset(0)]
    private int i;
    [FieldOffset(0)]
    private float f;

    internal Int32SingleUnion(int i)
    {
      this.f = 0.0f;
      this.i = i;
    }

    internal Int32SingleUnion(float f)
    {
      this.i = 0;
      this.f = f;
    }

    internal int AsInt32 => this.i;

    internal float AsSingle => this.f;
  }
}
