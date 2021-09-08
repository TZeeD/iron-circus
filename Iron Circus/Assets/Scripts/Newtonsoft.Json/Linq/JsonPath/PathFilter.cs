// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Linq.JsonPath.PathFilter
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using Newtonsoft.Json.Utilities;
using System;
using System.Collections.Generic;
using System.Globalization;

namespace Newtonsoft.Json.Linq.JsonPath
{
  internal abstract class PathFilter
  {
    public abstract IEnumerable<JToken> ExecuteFilter(
      JToken root,
      IEnumerable<JToken> current,
      bool errorWhenNoMatch);

    protected static JToken GetTokenIndex(JToken t, bool errorWhenNoMatch, int index)
    {
      if (t is JArray jarray)
      {
        if (jarray.Count > index)
          return jarray[index];
        if (errorWhenNoMatch)
          throw new JsonException("Index {0} outside the bounds of JArray.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) index));
        return (JToken) null;
      }
      if (t is JConstructor jconstructor)
      {
        if (jconstructor.Count > index)
          return jconstructor[(object) index];
        if (errorWhenNoMatch)
          throw new JsonException("Index {0} outside the bounds of JConstructor.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) index));
        return (JToken) null;
      }
      if (errorWhenNoMatch)
        throw new JsonException("Index {0} not valid on {1}.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) index, (object) t.GetType().Name));
      return (JToken) null;
    }

    protected static JToken GetNextScanValue(
      JToken originalParent,
      JToken container,
      JToken value)
    {
      if (container != null && container.HasValues)
      {
        value = container.First;
      }
      else
      {
        while (value != null && value != originalParent && value == value.Parent.Last)
          value = (JToken) value.Parent;
        if (value == null || value == originalParent)
          return (JToken) null;
        value = value.Next;
      }
      return value;
    }
  }
}
