// Decompiled with JetBrains decompiler
// Type: Discord.Utility
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Runtime.InteropServices;

namespace Discord
{
  internal class Utility
  {
    internal static IntPtr Retain<T>(T value) => GCHandle.ToIntPtr(GCHandle.Alloc((object) value, GCHandleType.Normal));

    internal static void Release(IntPtr ptr) => GCHandle.FromIntPtr(ptr).Free();
  }
}
