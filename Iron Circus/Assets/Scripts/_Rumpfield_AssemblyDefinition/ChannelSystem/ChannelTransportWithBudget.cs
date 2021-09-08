// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem.ChannelTransportWithBudget
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

using Imi.SharedWithServer.Networking.Rumpfield.Utils;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem
{
  public class ChannelTransportWithBudget : IChannelTransport
  {
    private Budget channelBudget;
    private readonly Budget initialBudget;
    private readonly List<RMessage> messages;

    public ChannelTransportWithBudget(Budget channelBudget)
    {
      this.channelBudget = channelBudget;
      this.initialBudget = channelBudget;
      this.messages = new List<RMessage>(channelBudget.messages);
    }

    public bool TryToAdd(RMessage message)
    {
      if (Budget.Starved(this.channelBudget) || this.messages.Count > this.channelBudget.messages)
        return false;
      this.messages.Add(message);
      this.channelBudget = Budget.Substract(this.channelBudget, new Budget(message.TotalSize, 1));
      return true;
    }

    public ushort GetCount() => (ushort) this.messages.Count;

    public List<RMessage> GetMessages() => this.messages;

    public void PrintBudget()
    {
      if (this.channelBudget.Equals(this.initialBudget))
        return;
      Console.WriteLine(this.channelBudget.bytes.ToString() + " Bytes - " + (object) this.channelBudget.messages);
    }
  }
}
