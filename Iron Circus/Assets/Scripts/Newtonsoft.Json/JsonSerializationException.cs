// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.JsonSerializationException
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System;
using System.Runtime.Serialization;

namespace Newtonsoft.Json
{
  [Serializable]
  public class JsonSerializationException : JsonException
  {
    public JsonSerializationException()
    {
    }

    public JsonSerializationException(string message)
      : base(message)
    {
    }

    public JsonSerializationException(string message, Exception innerException)
      : base(message, innerException)
    {
    }

    public JsonSerializationException(SerializationInfo info, StreamingContext context)
      : base(info, context)
    {
    }

    internal static JsonSerializationException Create(
      JsonReader reader,
      string message)
    {
      return JsonSerializationException.Create(reader, message, (Exception) null);
    }

    internal static JsonSerializationException Create(
      JsonReader reader,
      string message,
      Exception ex)
    {
      return JsonSerializationException.Create(reader as IJsonLineInfo, reader.Path, message, ex);
    }

    internal static JsonSerializationException Create(
      IJsonLineInfo lineInfo,
      string path,
      string message,
      Exception ex)
    {
      message = JsonPosition.FormatMessage(lineInfo, path, message);
      return new JsonSerializationException(message, ex);
    }
  }
}
