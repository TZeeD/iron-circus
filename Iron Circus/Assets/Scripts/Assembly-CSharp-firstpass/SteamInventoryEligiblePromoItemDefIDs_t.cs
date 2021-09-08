// Decompiled with JetBrains decompiler
// Type: Steamworks.SteamInventoryEligiblePromoItemDefIDs_t
// Assembly: Assembly-CSharp-firstpass, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: A34970A1-543C-410C-AD13-A4F24A08ED5B
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp-firstpass.dll

using System.Runtime.InteropServices;

namespace Steamworks
{
  [CallbackIdentity(4703)]
  [StructLayout(LayoutKind.Sequential, Pack = 8)]
  public struct SteamInventoryEligiblePromoItemDefIDs_t
  {
    public const int k_iCallback = 4703;
    public EResult m_result;
    public CSteamID m_steamID;
    public int m_numEligiblePromoItemDefs;
    [MarshalAs(UnmanagedType.I1)]
    public bool m_bCachedData;
  }
}
