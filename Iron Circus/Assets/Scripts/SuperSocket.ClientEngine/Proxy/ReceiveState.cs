// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.Proxy.ReceiveState
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

namespace SuperSocket.ClientEngine.Proxy
{
  internal class ReceiveState
  {
    public ReceiveState(byte[] buffer) => this.Buffer = buffer;

    public byte[] Buffer { get; private set; }

    public int Length { get; set; }
  }
}
