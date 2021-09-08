// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Converters.CustomCreationConverter`1
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System;

namespace Newtonsoft.Json.Converters
{
  public abstract class CustomCreationConverter<T> : JsonConverter
  {
    public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer) => throw new NotSupportedException("CustomCreationConverter should only be used while deserializing.");

    public override object ReadJson(
      JsonReader reader,
      Type objectType,
      object existingValue,
      JsonSerializer serializer)
    {
      if (reader.TokenType == JsonToken.Null)
        return (object) null;
      T obj = this.Create(objectType);
      if ((object) obj == null)
        throw new JsonSerializationException("No object created.");
      serializer.Populate(reader, (object) obj);
      return (object) obj;
    }

    public abstract T Create(Type objectType);

    public override bool CanConvert(Type objectType) => typeof (T).IsAssignableFrom(objectType);

    public override bool CanWrite => false;
  }
}
