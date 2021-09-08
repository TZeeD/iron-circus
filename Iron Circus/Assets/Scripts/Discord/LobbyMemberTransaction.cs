// Decompiled with JetBrains decompiler
// Type: Discord.LobbyMemberTransaction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Runtime.InteropServices;

namespace Discord
{
  public struct LobbyMemberTransaction
  {
    internal IntPtr MethodsPtr;
    internal object MethodsStructure;

    private LobbyMemberTransaction.FFIMethods Methods
    {
      get
      {
        if (this.MethodsStructure == null)
          this.MethodsStructure = Marshal.PtrToStructure(this.MethodsPtr, typeof (LobbyMemberTransaction.FFIMethods));
        return (LobbyMemberTransaction.FFIMethods) this.MethodsStructure;
      }
    }

    public void SetMetadata(string key, string value)
    {
      if (!(this.MethodsPtr != IntPtr.Zero))
        return;
      Result result = this.Methods.SetMetadata(this.MethodsPtr, key, value);
      if (result != Result.Ok)
        throw new ResultException(result);
    }

    public void DeleteMetadata(string key)
    {
      if (!(this.MethodsPtr != IntPtr.Zero))
        return;
      Result result = this.Methods.DeleteMetadata(this.MethodsPtr, key);
      if (result != Result.Ok)
        throw new ResultException(result);
    }

    internal struct FFIMethods
    {
      internal LobbyMemberTransaction.FFIMethods.SetMetadataMethod SetMetadata;
      internal LobbyMemberTransaction.FFIMethods.DeleteMetadataMethod DeleteMetadata;

      [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
      internal delegate Result SetMetadataMethod(IntPtr methodsPtr, [MarshalAs(UnmanagedType.LPStr)] string key, [MarshalAs(UnmanagedType.LPStr)] string value);

      [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
      internal delegate Result DeleteMetadataMethod(IntPtr methodsPtr, [MarshalAs(UnmanagedType.LPStr)] string key);
    }
  }
}
