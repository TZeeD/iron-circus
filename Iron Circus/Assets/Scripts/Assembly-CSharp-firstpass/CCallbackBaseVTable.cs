﻿// Decompiled with JetBrains decompiler
// Type: Steamworks.CCallbackBaseVTable
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System;
using System.Runtime.InteropServices;

namespace Steamworks
{
  [StructLayout(LayoutKind.Sequential)]
  internal class CCallbackBaseVTable
  {
    private const CallingConvention cc = CallingConvention.Cdecl;
    [MarshalAs(UnmanagedType.FunctionPtr)]
    [NonSerialized]
    public CCallbackBaseVTable.RunCRDel m_RunCallResult;
    [MarshalAs(UnmanagedType.FunctionPtr)]
    [NonSerialized]
    public CCallbackBaseVTable.RunCBDel m_RunCallback;
    [MarshalAs(UnmanagedType.FunctionPtr)]
    [NonSerialized]
    public CCallbackBaseVTable.GetCallbackSizeBytesDel m_GetCallbackSizeBytes;

    [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
    public delegate void RunCBDel(IntPtr thisptr, IntPtr pvParam);

    [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
    public delegate void RunCRDel(
      IntPtr thisptr,
      IntPtr pvParam,
      [MarshalAs(UnmanagedType.I1)] bool bIOFailure,
      ulong hSteamAPICall);

    [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
    public delegate int GetCallbackSizeBytesDel(IntPtr thisptr);
  }
}
