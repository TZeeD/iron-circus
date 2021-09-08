// Decompiled with JetBrains decompiler
// Type: Steamworks.MMKVPMarshaller
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;
using System.Runtime.InteropServices;

namespace Steamworks
{
  public class MMKVPMarshaller
  {
    private IntPtr m_pNativeArray;
    private IntPtr m_pArrayEntries;

    public MMKVPMarshaller(MatchMakingKeyValuePair_t[] filters)
    {
      if (filters == null)
        return;
      int num = Marshal.SizeOf(typeof (MatchMakingKeyValuePair_t));
      this.m_pNativeArray = Marshal.AllocHGlobal(Marshal.SizeOf(typeof (IntPtr)) * filters.Length);
      this.m_pArrayEntries = Marshal.AllocHGlobal(num * filters.Length);
      for (int index = 0; index < filters.Length; ++index)
        Marshal.StructureToPtr<MatchMakingKeyValuePair_t>(filters[index], new IntPtr(this.m_pArrayEntries.ToInt64() + (long) (index * num)), false);
      Marshal.WriteIntPtr(this.m_pNativeArray, this.m_pArrayEntries);
    }

    ~MMKVPMarshaller()
    {
      if (this.m_pArrayEntries != IntPtr.Zero)
        Marshal.FreeHGlobal(this.m_pArrayEntries);
      if (!(this.m_pNativeArray != IntPtr.Zero))
        return;
      Marshal.FreeHGlobal(this.m_pNativeArray);
    }

    public static implicit operator IntPtr(MMKVPMarshaller that) => that.m_pNativeArray;
  }
}
