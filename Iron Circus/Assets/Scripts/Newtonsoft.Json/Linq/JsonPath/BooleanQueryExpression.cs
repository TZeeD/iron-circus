// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Linq.JsonPath.BooleanQueryExpression
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using Newtonsoft.Json.Utilities;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;

namespace Newtonsoft.Json.Linq.JsonPath
{
  internal class BooleanQueryExpression : QueryExpression
  {
    public object Left { get; set; }

    public object Right { get; set; }

    private IEnumerable<JToken> GetResult(JToken root, JToken t, object o)
    {
      switch (o)
      {
        case JToken jtoken:
          return (IEnumerable<JToken>) new JToken[1]
          {
            jtoken
          };
        case List<PathFilter> filters:
          return JPath.Evaluate(filters, root, t, false);
        default:
          return (IEnumerable<JToken>) CollectionUtils.ArrayEmpty<JToken>();
      }
    }

    public override bool IsMatch(JToken root, JToken t)
    {
      if (this.Operator == QueryOperator.Exists)
        return this.GetResult(root, t, this.Left).Any<JToken>();
      using (IEnumerator<JToken> enumerator = this.GetResult(root, t, this.Left).GetEnumerator())
      {
        if (enumerator.MoveNext())
        {
          IEnumerable<JToken> result = this.GetResult(root, t, this.Right);
          if (!(result is ICollection<JToken> jtokens))
            jtokens = (ICollection<JToken>) result.ToList<JToken>();
          ICollection<JToken> jtokens2 = jtokens;
          do
          {
            JToken current = enumerator.Current;
            foreach (JToken rightResult in (IEnumerable<JToken>) jtokens2)
            {
              if (this.MatchTokens(current, rightResult))
                return true;
            }
          }
          while (enumerator.MoveNext());
        }
      }
      return false;
    }

    private bool MatchTokens(JToken leftResult, JToken rightResult)
    {
      if (leftResult is JValue input && rightResult is JValue jvalue)
      {
        switch (this.Operator)
        {
          case QueryOperator.Equals:
            if (this.EqualsWithStringCoercion(input, jvalue))
              return true;
            break;
          case QueryOperator.NotEquals:
            if (!this.EqualsWithStringCoercion(input, jvalue))
              return true;
            break;
          case QueryOperator.Exists:
            return true;
          case QueryOperator.LessThan:
            if (input.CompareTo(jvalue) < 0)
              return true;
            break;
          case QueryOperator.LessThanOrEquals:
            if (input.CompareTo(jvalue) <= 0)
              return true;
            break;
          case QueryOperator.GreaterThan:
            if (input.CompareTo(jvalue) > 0)
              return true;
            break;
          case QueryOperator.GreaterThanOrEquals:
            if (input.CompareTo(jvalue) >= 0)
              return true;
            break;
          case QueryOperator.RegexEquals:
            if (BooleanQueryExpression.RegexEquals(input, jvalue))
              return true;
            break;
        }
      }
      else
      {
        switch (this.Operator)
        {
          case QueryOperator.NotEquals:
          case QueryOperator.Exists:
            return true;
        }
      }
      return false;
    }

    private static bool RegexEquals(JValue input, JValue pattern)
    {
      if (input.Type != JTokenType.String || pattern.Type != JTokenType.String)
        return false;
      string str = (string) pattern.Value;
      int num = str.LastIndexOf('/');
      string pattern1 = str.Substring(1, num - 1);
      string optionsText = str.Substring(num + 1);
      return Regex.IsMatch((string) input.Value, pattern1, MiscellaneousUtils.GetRegexOptions(optionsText));
    }

    private bool EqualsWithStringCoercion(JValue value, JValue queryValue)
    {
      if (value.Equals(queryValue))
        return true;
      if (queryValue.Type != JTokenType.String)
        return false;
      string b = (string) queryValue.Value;
      string a;
      switch (value.Type)
      {
        case JTokenType.Date:
          using (StringWriter stringWriter = StringUtils.CreateStringWriter(64))
          {
            if (value.Value is DateTimeOffset dateTimeOffset3)
              DateTimeUtils.WriteDateTimeOffsetString((TextWriter) stringWriter, dateTimeOffset3, DateFormatHandling.IsoDateFormat, (string) null, CultureInfo.InvariantCulture);
            else
              DateTimeUtils.WriteDateTimeString((TextWriter) stringWriter, (DateTime) value.Value, DateFormatHandling.IsoDateFormat, (string) null, CultureInfo.InvariantCulture);
            a = stringWriter.ToString();
            break;
          }
        case JTokenType.Bytes:
          a = Convert.ToBase64String((byte[]) value.Value);
          break;
        case JTokenType.Guid:
        case JTokenType.TimeSpan:
          a = value.Value.ToString();
          break;
        case JTokenType.Uri:
          a = ((Uri) value.Value).OriginalString;
          break;
        default:
          return false;
      }
      return string.Equals(a, b, StringComparison.Ordinal);
    }
  }
}
