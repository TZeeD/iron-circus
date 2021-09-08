// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem.ChannelTransport
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

using Imi.SharedWithServer.Networking.Rumpfield.Utils;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem
{
  public class ChannelTransport : IChannelTransport
  {
    private readonly List<RMessage> messages;

    public ChannelTransport(int capacity) => this.messages = new List<RMessage>(capacity);

    public bool TryToAdd(RMessage message)
    {
      this.messages.Add(message);
      return true;
    }

    public List<RMessage> GetMessages() => this.messages;

    public ushort GetCount() => (ushort) this.messages.Count;
  }
}
