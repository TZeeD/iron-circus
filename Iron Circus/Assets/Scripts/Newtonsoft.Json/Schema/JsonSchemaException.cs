// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Schema.JsonSchemaException
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System;
using System.Runtime.Serialization;

namespace Newtonsoft.Json.Schema
{
  [Obsolete("JSON Schema validation has been moved to its own package. See http://www.newtonsoft.com/jsonschema for more details.")]
  [Serializable]
  public class JsonSchemaException : JsonException
  {
    public int LineNumber { get; }

    public int LinePosition { get; }

    public string Path { get; }

    public JsonSchemaException()
    {
    }

    public JsonSchemaException(string message)
      : base(message)
    {
    }

    public JsonSchemaException(string message, Exception innerException)
      : base(message, innerException)
    {
    }

    public JsonSchemaException(SerializationInfo info, StreamingContext context)
      : base(info, context)
    {
    }

    internal JsonSchemaException(
      string message,
      Exception innerException,
      string path,
      int lineNumber,
      int linePosition)
      : base(message, innerException)
    {
      this.Path = path;
      this.LineNumber = lineNumber;
      this.LinePosition = linePosition;
    }
  }
}
