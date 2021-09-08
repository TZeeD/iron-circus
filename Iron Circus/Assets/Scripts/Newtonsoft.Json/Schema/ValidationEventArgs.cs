// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Schema.ValidationEventArgs
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using Newtonsoft.Json.Utilities;
using System;

namespace Newtonsoft.Json.Schema
{
  [Obsolete("JSON Schema validation has been moved to its own package. See http://www.newtonsoft.com/jsonschema for more details.")]
  public class ValidationEventArgs : EventArgs
  {
    private readonly JsonSchemaException _ex;

    internal ValidationEventArgs(JsonSchemaException ex)
    {
      ValidationUtils.ArgumentNotNull((object) ex, nameof (ex));
      this._ex = ex;
    }

    public JsonSchemaException Exception => this._ex;

    public string Path => this._ex.Path;

    public string Message => this._ex.Message;
  }
}
