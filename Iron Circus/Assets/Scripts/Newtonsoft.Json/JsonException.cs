// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.JsonException
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System;
using System.Runtime.Serialization;

namespace Newtonsoft.Json
{
  [Serializable]
  public class JsonException : Exception
  {
    public JsonException()
    {
    }

    public JsonException(string message)
      : base(message)
    {
    }

    public JsonException(string message, Exception innerException)
      : base(message, innerException)
    {
    }

    public JsonException(SerializationInfo info, StreamingContext context)
      : base(info, context)
    {
    }

    internal static JsonException Create(
      IJsonLineInfo lineInfo,
      string path,
      string message)
    {
      message = JsonPosition.FormatMessage(lineInfo, path, message);
      return new JsonException(message);
    }
  }
}
