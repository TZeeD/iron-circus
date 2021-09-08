// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.JsonObjectAttribute
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System;

namespace Newtonsoft.Json
{
  [AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Interface, AllowMultiple = false)]
  public sealed class JsonObjectAttribute : JsonContainerAttribute
  {
    private MemberSerialization _memberSerialization;
    internal Required? _itemRequired;
    internal NullValueHandling? _itemNullValueHandling;

    public MemberSerialization MemberSerialization
    {
      get => this._memberSerialization;
      set => this._memberSerialization = value;
    }

    public NullValueHandling ItemNullValueHandling
    {
      get => this._itemNullValueHandling ?? NullValueHandling.Include;
      set => this._itemNullValueHandling = new NullValueHandling?(value);
    }

    public Required ItemRequired
    {
      get => this._itemRequired ?? Required.Default;
      set => this._itemRequired = new Required?(value);
    }

    public JsonObjectAttribute()
    {
    }

    public JsonObjectAttribute(MemberSerialization memberSerialization) => this.MemberSerialization = memberSerialization;

    public JsonObjectAttribute(string id)
      : base(id)
    {
    }
  }
}
