﻿// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.IBufferSetter
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;

namespace SuperSocket.ClientEngine
{
  public interface IBufferSetter
  {
    void SetBuffer(ArraySegment<byte> bufferSegment);
  }
}
