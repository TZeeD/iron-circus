// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.Utils.RPacketTransport
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

using Imi.SharedWithServer.Networking.Rumpfield.ChannelSystem;
using System.Collections.Generic;
using System.IO;

namespace Imi.SharedWithServer.Networking.Rumpfield.Utils
{
  public class RPacketTransport : IPacketTransport
  {
    private readonly List<IChannelTransport> channelTransports;

    public RPacketTransport(int channelCount) => this.channelTransports = new List<IChannelTransport>(channelCount);

    public void AddChannelTransport(IChannelTransport transport) => this.channelTransports.Add(transport);

    public byte[] ToByteArray()
    {
      int length = 0 + 2;
      for (int index1 = 0; index1 < this.channelTransports.Count; ++index1)
      {
        length += 2;
        for (int index2 = 0; index2 < this.channelTransports[index1].GetMessages().Count; ++index2)
          length += this.channelTransports[index1].GetMessages()[index2].TotalSize;
      }
      byte[] buffer = new byte[length];
      using (MemoryStream memoryStream = new MemoryStream(buffer))
      {
        using (BinaryWriter binaryWriter = new BinaryWriter((Stream) memoryStream))
        {
          binaryWriter.Write((ushort) this.channelTransports.Count);
          for (int index3 = 0; index3 < this.channelTransports.Count; ++index3)
          {
            binaryWriter.Write(this.channelTransports[index3].GetCount());
            for (int index4 = 0; index4 < this.channelTransports[index3].GetMessages().Count; ++index4)
            {
              RMessage message = this.channelTransports[index3].GetMessages()[index4];
              binaryWriter.Write(message.Id);
              binaryWriter.Write(message.BufferSize);
              binaryWriter.Write(message.Buffer, 0, (int) message.BufferSize);
            }
          }
        }
      }
      return buffer;
    }

    public void FillWithByteArray(byte[] buffer)
    {
      using (MemoryStream memoryStream = new MemoryStream(buffer))
      {
        using (BinaryReader reader = new BinaryReader((Stream) memoryStream))
        {
          if (buffer.Length == 0)
            return;
          int num = (int) reader.ReadUInt16();
          for (int index = 0; index < num; ++index)
          {
            ushort messageCountInChannel = reader.ReadUInt16();
            this.AddChannelTransport(this.ReadMessages(reader, messageCountInChannel));
          }
        }
      }
    }

    public IChannelTransport GetTransport(int index) => this.channelTransports[index];

    public int GetChannelTransportCount() => this.channelTransports.Count;

    private IChannelTransport ReadMessages(
      BinaryReader reader,
      ushort messageCountInChannel)
    {
      IChannelTransport channelTransport = (IChannelTransport) new ChannelTransport((int) messageCountInChannel);
      for (int index = 0; index < (int) messageCountInChannel; ++index)
      {
        ushort id = reader.ReadUInt16();
        ushort size = reader.ReadUInt16();
        byte[] buffer = reader.ReadBytes((int) size);
        channelTransport.TryToAdd(new RMessage(id, buffer, size));
      }
      return channelTransport;
    }
  }
}
