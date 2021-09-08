﻿// Decompiled with JetBrains decompiler
// Type: Newtonsoft.Json.Utilities.StringUtils
// Assembly: Newtonsoft.Json, Version=11.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
// MVID: 07E38931-19A9-45B2-9A35-E81930B1C8AD
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Newtonsoft.Json.dll

using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;

namespace Newtonsoft.Json.Utilities
{
  internal static class StringUtils
  {
    public const string CarriageReturnLineFeed = "\r\n";
    public const string Empty = "";
    public const char CarriageReturn = '\r';
    public const char LineFeed = '\n';
    public const char Tab = '\t';

    public static string FormatWith(this string format, IFormatProvider provider, object arg0) => StringUtils.FormatWith(format, provider, new object[1]
    {
      arg0
    });

    public static string FormatWith(
      this string format,
      IFormatProvider provider,
      object arg0,
      object arg1)
    {
      return StringUtils.FormatWith(format, provider, new object[2]
      {
        arg0,
        arg1
      });
    }

    public static string FormatWith(
      this string format,
      IFormatProvider provider,
      object arg0,
      object arg1,
      object arg2)
    {
      return StringUtils.FormatWith(format, provider, new object[3]
      {
        arg0,
        arg1,
        arg2
      });
    }

    public static string FormatWith(
      this string format,
      IFormatProvider provider,
      object arg0,
      object arg1,
      object arg2,
      object arg3)
    {
      return StringUtils.FormatWith(format, provider, new object[4]
      {
        arg0,
        arg1,
        arg2,
        arg3
      });
    }

    private static string FormatWith(
      this string format,
      IFormatProvider provider,
      params object[] args)
    {
      ValidationUtils.ArgumentNotNull((object) format, nameof (format));
      return string.Format(provider, format, args);
    }

    public static bool IsWhiteSpace(string s)
    {
      switch (s)
      {
        case "":
          return false;
        case null:
          throw new ArgumentNullException(nameof (s));
        default:
          for (int index = 0; index < s.Length; ++index)
          {
            if (!char.IsWhiteSpace(s[index]))
              return false;
          }
          return true;
      }
    }

    public static StringWriter CreateStringWriter(int capacity) => new StringWriter(new StringBuilder(capacity), (IFormatProvider) CultureInfo.InvariantCulture);

    public static void ToCharAsUnicode(char c, char[] buffer)
    {
      buffer[0] = '\\';
      buffer[1] = 'u';
      buffer[2] = MathUtils.IntToHex((int) c >> 12 & 15);
      buffer[3] = MathUtils.IntToHex((int) c >> 8 & 15);
      buffer[4] = MathUtils.IntToHex((int) c >> 4 & 15);
      buffer[5] = MathUtils.IntToHex((int) c & 15);
    }

    public static TSource ForgivingCaseSensitiveFind<TSource>(
      this IEnumerable<TSource> source,
      Func<TSource, string> valueSelector,
      string testValue)
    {
      if (source == null)
        throw new ArgumentNullException(nameof (source));
      if (valueSelector == null)
        throw new ArgumentNullException(nameof (valueSelector));
      IEnumerable<TSource> source1 = source.Where<TSource>((Func<TSource, bool>) (s => string.Equals(valueSelector(s), testValue, StringComparison.OrdinalIgnoreCase)));
      return source1.Count<TSource>() <= 1 ? source1.SingleOrDefault<TSource>() : source.Where<TSource>((Func<TSource, bool>) (s => string.Equals(valueSelector(s), testValue, StringComparison.Ordinal))).SingleOrDefault<TSource>();
    }

    public static string ToCamelCase(string s)
    {
      if (string.IsNullOrEmpty(s) || !char.IsUpper(s[0]))
        return s;
      char[] charArray = s.ToCharArray();
      for (int index = 0; index < charArray.Length && (index != 1 || char.IsUpper(charArray[index])); ++index)
      {
        bool flag = index + 1 < charArray.Length;
        if (index > 0 & flag && !char.IsUpper(charArray[index + 1]))
        {
          if (char.IsSeparator(charArray[index + 1]))
          {
            charArray[index] = StringUtils.ToLower(charArray[index]);
            break;
          }
          break;
        }
        charArray[index] = StringUtils.ToLower(charArray[index]);
      }
      return new string(charArray);
    }

    private static char ToLower(char c)
    {
      c = char.ToLower(c, CultureInfo.InvariantCulture);
      return c;
    }

    public static string ToSnakeCase(string s)
    {
      if (string.IsNullOrEmpty(s))
        return s;
      StringBuilder stringBuilder = new StringBuilder();
      StringUtils.SnakeCaseState snakeCaseState = StringUtils.SnakeCaseState.Start;
      for (int index = 0; index < s.Length; ++index)
      {
        if (s[index] == ' ')
        {
          if (snakeCaseState != StringUtils.SnakeCaseState.Start)
            snakeCaseState = StringUtils.SnakeCaseState.NewWord;
        }
        else if (char.IsUpper(s[index]))
        {
          switch (snakeCaseState)
          {
            case StringUtils.SnakeCaseState.Lower:
            case StringUtils.SnakeCaseState.NewWord:
              stringBuilder.Append('_');
              break;
            case StringUtils.SnakeCaseState.Upper:
              bool flag = index + 1 < s.Length;
              if (index > 0 & flag)
              {
                char c = s[index + 1];
                if (!char.IsUpper(c) && c != '_')
                {
                  stringBuilder.Append('_');
                  break;
                }
                break;
              }
              break;
          }
          char lower = char.ToLower(s[index], CultureInfo.InvariantCulture);
          stringBuilder.Append(lower);
          snakeCaseState = StringUtils.SnakeCaseState.Upper;
        }
        else if (s[index] == '_')
        {
          stringBuilder.Append('_');
          snakeCaseState = StringUtils.SnakeCaseState.Start;
        }
        else
        {
          if (snakeCaseState == StringUtils.SnakeCaseState.NewWord)
            stringBuilder.Append('_');
          stringBuilder.Append(s[index]);
          snakeCaseState = StringUtils.SnakeCaseState.Lower;
        }
      }
      return stringBuilder.ToString();
    }

    public static bool IsHighSurrogate(char c) => char.IsHighSurrogate(c);

    public static bool IsLowSurrogate(char c) => char.IsLowSurrogate(c);

    public static bool StartsWith(this string source, char value) => source.Length > 0 && (int) source[0] == (int) value;

    public static bool EndsWith(this string source, char value) => source.Length > 0 && (int) source[source.Length - 1] == (int) value;

    public static string Trim(this string s, int start, int length)
    {
      if (s == null)
        throw new ArgumentNullException();
      if (start < 0)
        throw new ArgumentOutOfRangeException(nameof (start));
      if (length < 0)
        throw new ArgumentOutOfRangeException(nameof (length));
      int index = start + length - 1;
      if (index >= s.Length)
        throw new ArgumentOutOfRangeException(nameof (length));
      while (start < index && char.IsWhiteSpace(s[start]))
        ++start;
      while (index >= start && char.IsWhiteSpace(s[index]))
        --index;
      return s.Substring(start, index - start + 1);
    }

    internal enum SnakeCaseState
    {
      Start,
      Lower,
      Upper,
      NewWord,
    }
  }
}
