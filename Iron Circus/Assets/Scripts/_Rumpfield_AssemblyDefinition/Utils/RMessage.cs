// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Networking.Rumpfield.Utils.RMessage
// Assembly: _Rumpfield_AssemblyDefinition, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2AEA7BF5-2F28-40B9-90B7-2EF49603B6E2
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\_Rumpfield_AssemblyDefinition.dll

namespace Imi.SharedWithServer.Networking.Rumpfield.Utils
{
  public class RMessage
  {
    public byte[] buffer;

    public RMessage(byte[] buffer, ushort bufferSize)
    {
      this.buffer = buffer;
      this.BufferSize = bufferSize;
    }

    public RMessage(ushort id, byte[] buffer, ushort size)
    {
      this.Id = id;
      this.BufferSize = size;
      this.buffer = buffer;
    }

    public ushort Id { get; set; }

    public byte[] Buffer => this.buffer;

    public int TotalSize => (int) this.BufferSize + 4;

    public ushort BufferSize { get; }
  }
}
