// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Serialization.ReflectionAttributeProvider
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using Newtonsoft.Json.Utilities;
using System;
using System.Collections.Generic;

namespace Newtonsoft.Json.Serialization
{
  public class ReflectionAttributeProvider : IAttributeProvider
  {
    private readonly object _attributeProvider;

    public ReflectionAttributeProvider(object attributeProvider)
    {
      ValidationUtils.ArgumentNotNull(attributeProvider, nameof (attributeProvider));
      this._attributeProvider = attributeProvider;
    }

    public IList<Attribute> GetAttributes(bool inherit) => (IList<Attribute>) ReflectionUtils.GetAttributes(this._attributeProvider, (Type) null, inherit);

    public IList<Attribute> GetAttributes(Type attributeType, bool inherit) => (IList<Attribute>) ReflectionUtils.GetAttributes(this._attributeProvider, attributeType, inherit);
  }
}
