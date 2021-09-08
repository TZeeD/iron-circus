// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Converters.StringEnumConverter
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using Newtonsoft.Json.Utilities;
using System;
using System.Globalization;

namespace Newtonsoft.Json.Converters
{
  public class StringEnumConverter : JsonConverter
  {
    public bool CamelCaseText { get; set; }

    public bool AllowIntegerValues { get; set; }

    public StringEnumConverter() => this.AllowIntegerValues = true;

    public StringEnumConverter(bool camelCaseText)
      : this()
    {
      this.CamelCaseText = camelCaseText;
    }

    public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
    {
      if (value == null)
      {
        writer.WriteNull();
      }
      else
      {
        Enum @enum = (Enum) value;
        string name;
        if (!EnumUtils.TryToString(@enum.GetType(), value, this.CamelCaseText, out name))
        {
          if (!this.AllowIntegerValues)
            throw JsonSerializationException.Create((IJsonLineInfo) null, writer.ContainerPath, "Integer value {0} is not allowed.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) @enum.ToString("D")), (Exception) null);
          writer.WriteValue(value);
        }
        else
          writer.WriteValue(name);
      }
    }

    public override object ReadJson(
      JsonReader reader,
      Type objectType,
      object existingValue,
      JsonSerializer serializer)
    {
      if (reader.TokenType == JsonToken.Null)
      {
        if (!ReflectionUtils.IsNullableType(objectType))
          throw JsonSerializationException.Create(reader, "Cannot convert null value to {0}.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) objectType));
        return (object) null;
      }
      bool flag = ReflectionUtils.IsNullableType(objectType);
      Type type = flag ? Nullable.GetUnderlyingType(objectType) : objectType;
      try
      {
        if (reader.TokenType == JsonToken.String)
        {
          string str = reader.Value.ToString();
          return str == string.Empty & flag ? (object) null : EnumUtils.ParseEnum(type, str, !this.AllowIntegerValues);
        }
        if (reader.TokenType == JsonToken.Integer)
        {
          if (!this.AllowIntegerValues)
            throw JsonSerializationException.Create(reader, "Integer value {0} is not allowed.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, reader.Value));
          return ConvertUtils.ConvertOrCast(reader.Value, CultureInfo.InvariantCulture, type);
        }
      }
      catch (Exception ex)
      {
        throw JsonSerializationException.Create(reader, "Error converting value {0} to type '{1}'.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) MiscellaneousUtils.FormatValueForPrint(reader.Value), (object) objectType), ex);
      }
      throw JsonSerializationException.Create(reader, "Unexpected token {0} when parsing enum.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) reader.TokenType));
    }

    public override bool CanConvert(Type objectType) => (ReflectionUtils.IsNullableType(objectType) ? Nullable.GetUnderlyingType(objectType) : objectType).IsEnum();
  }
}
