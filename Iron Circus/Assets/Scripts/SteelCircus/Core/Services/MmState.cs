// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.Services.MmState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;

namespace SteelCircus.Core.Services
{
  public class MmState
  {
    public bool hasEverBeenExecuted;
    public string type = "";
    public string ticket = "";
    public string region = "";
    public HashSet<ulong> playerIds = new HashSet<ulong>();
    public DateTime startTime;
    public bool allowStart;
    public bool allowCancel;
    public bool allowDisplayAcceptance;

    public override string ToString() => "Type: " + this.type + " | Ticket: " + this.ticket + " | Region: " + this.region + " | " + string.Format("startable: {0} | ", (object) this.allowStart) + string.Format("cancelable: {0} | ", (object) this.allowCancel) + string.Format("displayable {0}", (object) this.allowDisplayAcceptance);
  }
}
