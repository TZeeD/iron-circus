// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Serialization.CamelCasePropertyNamesContractResolver
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using Newtonsoft.Json.Utilities;
using System;
using System.Collections.Generic;

namespace Newtonsoft.Json.Serialization
{
  public class CamelCasePropertyNamesContractResolver : DefaultContractResolver
  {
    private static readonly object TypeContractCacheLock = new object();
    private static readonly PropertyNameTable NameTable = new PropertyNameTable();
    private static Dictionary<ResolverContractKey, JsonContract> _contractCache;

    public CamelCasePropertyNamesContractResolver()
    {
      CamelCaseNamingStrategy caseNamingStrategy = new CamelCaseNamingStrategy();
      caseNamingStrategy.ProcessDictionaryKeys = true;
      caseNamingStrategy.OverrideSpecifiedNames = true;
      this.NamingStrategy = (NamingStrategy) caseNamingStrategy;
    }

    public override JsonContract ResolveContract(Type type)
    {
      ResolverContractKey key = !(type == (Type) null) ? new ResolverContractKey(this.GetType(), type) : throw new ArgumentNullException(nameof (type));
      Dictionary<ResolverContractKey, JsonContract> contractCache1 = CamelCasePropertyNamesContractResolver._contractCache;
      JsonContract contract;
      if (contractCache1 == null || !contractCache1.TryGetValue(key, out contract))
      {
        contract = this.CreateContract(type);
        lock (CamelCasePropertyNamesContractResolver.TypeContractCacheLock)
        {
          Dictionary<ResolverContractKey, JsonContract> contractCache2 = CamelCasePropertyNamesContractResolver._contractCache;
          Dictionary<ResolverContractKey, JsonContract> dictionary = contractCache2 != null ? new Dictionary<ResolverContractKey, JsonContract>((IDictionary<ResolverContractKey, JsonContract>) contractCache2) : new Dictionary<ResolverContractKey, JsonContract>();
          dictionary[key] = contract;
          CamelCasePropertyNamesContractResolver._contractCache = dictionary;
        }
      }
      return contract;
    }

    internal override PropertyNameTable GetNameTable() => CamelCasePropertyNamesContractResolver.NameTable;
  }
}
