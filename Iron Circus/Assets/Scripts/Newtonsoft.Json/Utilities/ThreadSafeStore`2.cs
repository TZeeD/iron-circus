// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Utilities.ThreadSafeStore`2
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System;
using System.Collections.Concurrent;

namespace Newtonsoft.Json.Utilities
{
  internal class ThreadSafeStore<TKey, TValue>
  {
    private readonly ConcurrentDictionary<TKey, TValue> _concurrentStore;
    private readonly Func<TKey, TValue> _creator;

    public ThreadSafeStore(Func<TKey, TValue> creator)
    {
      ValidationUtils.ArgumentNotNull((object) creator, nameof (creator));
      this._creator = creator;
      this._concurrentStore = new ConcurrentDictionary<TKey, TValue>();
    }

    public TValue Get(TKey key) => this._concurrentStore.GetOrAdd(key, this._creator);
  }
}
