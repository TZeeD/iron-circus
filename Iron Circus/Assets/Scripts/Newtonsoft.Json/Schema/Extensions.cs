﻿// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Schema.Extensions
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using Newtonsoft.Json.Linq;
using Newtonsoft.Json.Utilities;
using System;
using System.Collections.Generic;

namespace Newtonsoft.Json.Schema
{
  [Obsolete("JSON Schema validation has been moved to its own package. See http://www.newtonsoft.com/jsonschema for more details.")]
  public static class Extensions
  {
    [Obsolete("JSON Schema validation has been moved to its own package. See http://www.newtonsoft.com/jsonschema for more details.")]
    public static bool IsValid(this JToken source, JsonSchema schema)
    {
      bool valid = true;
      source.Validate(schema, (ValidationEventHandler) ((sender, args) => valid = false));
      return valid;
    }

    [Obsolete("JSON Schema validation has been moved to its own package. See http://www.newtonsoft.com/jsonschema for more details.")]
    public static bool IsValid(
      this JToken source,
      JsonSchema schema,
      out IList<string> errorMessages)
    {
      IList<string> errors = (IList<string>) new List<string>();
      source.Validate(schema, (ValidationEventHandler) ((sender, args) => errors.Add(args.Message)));
      errorMessages = errors;
      return errorMessages.Count == 0;
    }

    [Obsolete("JSON Schema validation has been moved to its own package. See http://www.newtonsoft.com/jsonschema for more details.")]
    public static void Validate(this JToken source, JsonSchema schema) => source.Validate(schema, (ValidationEventHandler) null);

    [Obsolete("JSON Schema validation has been moved to its own package. See http://www.newtonsoft.com/jsonschema for more details.")]
    public static void Validate(
      this JToken source,
      JsonSchema schema,
      ValidationEventHandler validationEventHandler)
    {
      ValidationUtils.ArgumentNotNull((object) source, nameof (source));
      ValidationUtils.ArgumentNotNull((object) schema, nameof (schema));
      using (JsonValidatingReader validatingReader = new JsonValidatingReader(source.CreateReader()))
      {
        validatingReader.Schema = schema;
        if (validationEventHandler != null)
          validatingReader.ValidationEventHandler += validationEventHandler;
        do
          ;
        while (validatingReader.Read());
      }
    }
  }
}
