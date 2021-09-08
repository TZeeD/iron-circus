// Decompiled with JetBrains decompiler
// Type: Steamworks.ISteamMatchmakingPingResponse
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;
using System.Runtime.InteropServices;

namespace Steamworks
{
  public class ISteamMatchmakingPingResponse
  {
    private ISteamMatchmakingPingResponse.VTable m_VTable;
    private IntPtr m_pVTable;
    private GCHandle m_pGCHandle;
    private ISteamMatchmakingPingResponse.ServerResponded m_ServerResponded;
    private ISteamMatchmakingPingResponse.ServerFailedToRespond m_ServerFailedToRespond;

    public ISteamMatchmakingPingResponse(
      ISteamMatchmakingPingResponse.ServerResponded onServerResponded,
      ISteamMatchmakingPingResponse.ServerFailedToRespond onServerFailedToRespond)
    {
      this.m_ServerResponded = onServerResponded != null && onServerFailedToRespond != null ? onServerResponded : throw new ArgumentNullException();
      this.m_ServerFailedToRespond = onServerFailedToRespond;
      this.m_VTable = new ISteamMatchmakingPingResponse.VTable()
      {
        m_VTServerResponded = new ISteamMatchmakingPingResponse.InternalServerResponded(this.InternalOnServerResponded),
        m_VTServerFailedToRespond = new ISteamMatchmakingPingResponse.InternalServerFailedToRespond(this.InternalOnServerFailedToRespond)
      };
      this.m_pVTable = Marshal.AllocHGlobal(Marshal.SizeOf(typeof (ISteamMatchmakingPingResponse.VTable)));
      Marshal.StructureToPtr<ISteamMatchmakingPingResponse.VTable>(this.m_VTable, this.m_pVTable, false);
      this.m_pGCHandle = GCHandle.Alloc((object) this.m_pVTable, GCHandleType.Pinned);
    }

    ~ISteamMatchmakingPingResponse()
    {
      if (this.m_pVTable != IntPtr.Zero)
        Marshal.FreeHGlobal(this.m_pVTable);
      if (!this.m_pGCHandle.IsAllocated)
        return;
      this.m_pGCHandle.Free();
    }

    private void InternalOnServerResponded(IntPtr thisptr, gameserveritem_t server) => this.m_ServerResponded(server);

    private void InternalOnServerFailedToRespond(IntPtr thisptr) => this.m_ServerFailedToRespond();

    public static explicit operator IntPtr(ISteamMatchmakingPingResponse that) => that.m_pGCHandle.AddrOfPinnedObject();

    public delegate void ServerResponded(gameserveritem_t server);

    public delegate void ServerFailedToRespond();

    [UnmanagedFunctionPointer(CallingConvention.ThisCall)]
    private delegate void InternalServerResponded(IntPtr thisptr, gameserveritem_t server);

    [UnmanagedFunctionPointer(CallingConvention.ThisCall)]
    private delegate void InternalServerFailedToRespond(IntPtr thisptr);

    [StructLayout(LayoutKind.Sequential)]
    private class VTable
    {
      [MarshalAs(UnmanagedType.FunctionPtr)]
      [NonSerialized]
      public ISteamMatchmakingPingResponse.InternalServerResponded m_VTServerResponded;
      [MarshalAs(UnmanagedType.FunctionPtr)]
      [NonSerialized]
      public ISteamMatchmakingPingResponse.InternalServerFailedToRespond m_VTServerFailedToRespond;
    }
  }
}
