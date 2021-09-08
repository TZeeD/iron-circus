// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Linq.JsonPath.ArraySliceFilter
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using Newtonsoft.Json.Utilities;
using System;
using System.Collections.Generic;
using System.Globalization;

namespace Newtonsoft.Json.Linq.JsonPath
{
  internal class ArraySliceFilter : PathFilter
  {
    public int? Start { get; set; }

    public int? End { get; set; }

    public int? Step { get; set; }

    public override IEnumerable<JToken> ExecuteFilter(
      JToken root,
      IEnumerable<JToken> current,
      bool errorWhenNoMatch)
    {
      int? nullable = this.Step;
      int num1 = 0;
      if ((nullable.GetValueOrDefault() == num1 ? (nullable.HasValue ? 1 : 0) : 0) != 0)
        throw new JsonException("Step cannot be zero.");
      foreach (JToken t in current)
      {
        if (t is JArray a2)
        {
          nullable = this.Step;
          int stepCount = nullable ?? 1;
          nullable = this.Start;
          int val1 = nullable ?? (stepCount > 0 ? 0 : a2.Count - 1);
          nullable = this.End;
          int stopIndex = nullable ?? (stepCount > 0 ? a2.Count : -1);
          nullable = this.Start;
          int num2 = 0;
          if ((nullable.GetValueOrDefault() < num2 ? (nullable.HasValue ? 1 : 0) : 0) != 0)
            val1 = a2.Count + val1;
          nullable = this.End;
          int num3 = 0;
          if ((nullable.GetValueOrDefault() < num3 ? (nullable.HasValue ? 1 : 0) : 0) != 0)
            stopIndex = a2.Count + stopIndex;
          int index = Math.Min(Math.Max(val1, stepCount > 0 ? 0 : int.MinValue), stepCount > 0 ? a2.Count : a2.Count - 1);
          stopIndex = Math.Max(stopIndex, -1);
          stopIndex = Math.Min(stopIndex, a2.Count);
          bool positiveStep = stepCount > 0;
          if (this.IsValid(index, stopIndex, positiveStep))
          {
            for (int i = index; this.IsValid(i, stopIndex, positiveStep); i += stepCount)
              yield return a2[i];
          }
          else if (errorWhenNoMatch)
          {
            CultureInfo invariantCulture = CultureInfo.InvariantCulture;
            nullable = this.Start;
            string str1;
            if (!nullable.HasValue)
            {
              str1 = "*";
            }
            else
            {
              nullable = this.Start;
              str1 = nullable.GetValueOrDefault().ToString((IFormatProvider) CultureInfo.InvariantCulture);
            }
            nullable = this.End;
            string str2;
            if (!nullable.HasValue)
            {
              str2 = "*";
            }
            else
            {
              nullable = this.End;
              str2 = nullable.GetValueOrDefault().ToString((IFormatProvider) CultureInfo.InvariantCulture);
            }
            throw new JsonException("Array slice of {0} to {1} returned no results.".FormatWith((IFormatProvider) invariantCulture, (object) str1, (object) str2));
          }
        }
        else if (errorWhenNoMatch)
          throw new JsonException("Array slice is not valid on {0}.".FormatWith((IFormatProvider) CultureInfo.InvariantCulture, (object) t.GetType().Name));
        a2 = (JArray) null;
      }
    }

    private bool IsValid(int index, int stopIndex, bool positiveStep) => positiveStep ? index < stopIndex : index > stopIndex;
  }
}
