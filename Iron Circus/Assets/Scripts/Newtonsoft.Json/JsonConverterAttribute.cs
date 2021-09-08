// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.JsonConverterAttribute
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System;

namespace Newtonsoft.Json
{
  [AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Interface | AttributeTargets.Parameter, AllowMultiple = false)]
  public sealed class JsonConverterAttribute : Attribute
  {
    private readonly Type _converterType;

    public Type ConverterType => this._converterType;

    public object[] ConverterParameters { get; }

    public JsonConverterAttribute(Type converterType) => this._converterType = !(converterType == (Type) null) ? converterType : throw new ArgumentNullException(nameof (converterType));

    public JsonConverterAttribute(Type converterType, params object[] converterParameters)
      : this(converterType)
    {
      this.ConverterParameters = converterParameters;
    }
  }
}
