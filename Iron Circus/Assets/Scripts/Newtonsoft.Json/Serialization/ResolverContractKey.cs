// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Serialization.ResolverContractKey
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System;

namespace Newtonsoft.Json.Serialization
{
  internal readonly struct ResolverContractKey : IEquatable<ResolverContractKey>
  {
    private readonly Type _resolverType;
    private readonly Type _contractType;

    public ResolverContractKey(Type resolverType, Type contractType)
    {
      this._resolverType = resolverType;
      this._contractType = contractType;
    }

    public override int GetHashCode() => this._resolverType.GetHashCode() ^ this._contractType.GetHashCode();

    public override bool Equals(object obj) => obj is ResolverContractKey other && this.Equals(other);

    public bool Equals(ResolverContractKey other) => this._resolverType == other._resolverType && this._contractType == other._contractType;
  }
}
