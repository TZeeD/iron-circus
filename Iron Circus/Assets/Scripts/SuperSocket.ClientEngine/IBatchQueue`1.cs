// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.IBatchQueue`1
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System.Collections.Generic;

namespace SuperSocket.ClientEngine
{
  public interface IBatchQueue<T>
  {
    bool Enqueue(T item);

    bool Enqueue(IList<T> items);

    bool TryDequeue(IList<T> outputItems);

    bool IsEmpty { get; }

    int Count { get; }
  }
}
