// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Serialization.SerializationBinderAdapter
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System;
using System.Runtime.Serialization;

namespace Newtonsoft.Json.Serialization
{
  internal class SerializationBinderAdapter : ISerializationBinder
  {
    public readonly SerializationBinder SerializationBinder;

    public SerializationBinderAdapter(SerializationBinder serializationBinder) => this.SerializationBinder = serializationBinder;

    public Type BindToType(string assemblyName, string typeName) => this.SerializationBinder.BindToType(assemblyName, typeName);

    public void BindToName(Type serializedType, out string assemblyName, out string typeName) => this.SerializationBinder.BindToName(serializedType, out assemblyName, out typeName);
  }
}
