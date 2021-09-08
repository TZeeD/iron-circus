// Decompiled with JetBrains decompiler
// Type: SoftMasking.ClearListAtExit`1
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;

namespace SoftMasking
{
  internal struct ClearListAtExit<T> : IDisposable
  {
    private List<T> _list;

    public ClearListAtExit(List<T> list) => this._list = list;

    public void Dispose() => this._list.Clear();
  }
}
