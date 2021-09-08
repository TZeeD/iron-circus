// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.UI.Network.SteamAuthHelper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Steamworks;
using System;
using System.Collections.Generic;
using System.Text;

namespace Imi.SteelCircus.UI.Network
{
  public class SteamAuthHelper
  {
    private static readonly byte[] ticketBuffer = new byte[1023];
    private Action<string, HAuthTicket> onAuthSessionTicketHexString;
    private Callback<GetAuthSessionTicketResponse_t> m_getAuthSessionTicketResponse_t;

    public void RequestAuthSessionTicket(
      bool isSteam,
      Action<string, HAuthTicket> onAuthSessionTicketHexString)
    {
      if (isSteam)
      {
        this.m_getAuthSessionTicketResponse_t = Callback<GetAuthSessionTicketResponse_t>.Create(new Callback<GetAuthSessionTicketResponse_t>.DispatchDelegate(this.OnGetAuthSessionTicketResponse));
        Log.Debug(string.Format("GetAuthSessionTicket returned  {0}", (object) SteamUser.GetAuthSessionTicket(SteamAuthHelper.ticketBuffer, 1024, out uint _)));
        this.onAuthSessionTicketHexString = onAuthSessionTicketHexString;
      }
      else
        onAuthSessionTicketHexString("", HAuthTicket.Invalid);
    }

    private void OnGetAuthSessionTicketResponse(GetAuthSessionTicketResponse_t response)
    {
      Log.Debug(string.Format("[OnGetAuthSessionTicketResponse] - Ticket = {0} -- Result = {1}", (object) response.m_hAuthTicket, (object) response.m_eResult));
      this.onAuthSessionTicketHexString(SteamAuthHelper.ByteArrayToString((IReadOnlyCollection<byte>) SteamAuthHelper.ticketBuffer), response.m_hAuthTicket);
    }

    private static string ByteArrayToString(IReadOnlyCollection<byte> ba)
    {
      StringBuilder stringBuilder = new StringBuilder(ba.Count * 2);
      foreach (byte num in (IEnumerable<byte>) ba)
        stringBuilder.AppendFormat("{0:x2}", (object) num);
      return stringBuilder.ToString();
    }
  }
}
