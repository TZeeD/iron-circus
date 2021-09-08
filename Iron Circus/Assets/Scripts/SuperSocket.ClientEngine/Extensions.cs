﻿// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.Extensions
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.Collections.Generic;
using System.Collections.Specialized;

namespace SuperSocket.ClientEngine
{
  public static class Extensions
  {
    private static Random m_Random = new Random();

    public static int IndexOf<T>(this IList<T> source, T target, int pos, int length) where T : IEquatable<T>
    {
      for (int index = pos; index < pos + length; ++index)
      {
        if (source[index].Equals(target))
          return index;
      }
      return -1;
    }

    public static int? SearchMark<T>(this IList<T> source, T[] mark) where T : IEquatable<T> => source.SearchMark<T>(0, source.Count, mark, 0);

    public static int? SearchMark<T>(this IList<T> source, int offset, int length, T[] mark) where T : IEquatable<T> => source.SearchMark<T>(offset, length, mark, 0);

    public static int? SearchMark<T>(
      this IList<T> source,
      int offset,
      int length,
      T[] mark,
      int matched)
      where T : IEquatable<T>
    {
      int pos = offset;
      int num1 = offset + length - 1;
      int index1 = matched;
      if (matched > 0)
      {
        for (int index2 = index1; index2 < mark.Length && source[pos++].Equals(mark[index2]); ++index2)
        {
          ++index1;
          if (pos > num1)
            return index1 == mark.Length ? new int?(offset) : new int?(-index1);
        }
        if (index1 == mark.Length)
          return new int?(offset);
        pos = offset;
        index1 = 0;
      }
      int num2;
      while (true)
      {
        num2 = source.IndexOf<T>(mark[index1], pos, length - pos + offset);
        if (num2 >= 0)
        {
          int num3 = index1 + 1;
          for (int index3 = num3; index3 < mark.Length; ++index3)
          {
            int index4 = num2 + index3;
            if (index4 > num1)
              return new int?(-num3);
            if (source[index4].Equals(mark[index3]))
              ++num3;
            else
              break;
          }
          if (num3 != mark.Length)
          {
            pos = num2 + 1;
            index1 = 0;
          }
          else
            goto label_20;
        }
        else
          break;
      }
      return new int?();
label_20:
      return new int?(num2);
    }

    public static int SearchMark<T>(
      this IList<T> source,
      int offset,
      int length,
      SearchMarkState<T> searchState)
      where T : IEquatable<T>
    {
      int? nullable = source.SearchMark<T>(offset, length, searchState.Mark, searchState.Matched);
      if (!nullable.HasValue)
      {
        searchState.Matched = 0;
        return -1;
      }
      if (nullable.Value < 0)
      {
        searchState.Matched = -nullable.Value;
        return -1;
      }
      searchState.Matched = 0;
      return nullable.Value;
    }

    public static int StartsWith<T>(this IList<T> source, T[] mark) where T : IEquatable<T> => source.StartsWith<T>(0, source.Count, mark);

    public static int StartsWith<T>(this IList<T> source, int offset, int length, T[] mark) where T : IEquatable<T>
    {
      int num1 = offset;
      int num2 = offset + length - 1;
      for (int index1 = 0; index1 < mark.Length; ++index1)
      {
        int index2 = num1 + index1;
        if (index2 > num2)
          return index1;
        if (!source[index2].Equals(mark[index1]))
          return -1;
      }
      return mark.Length;
    }

    public static bool EndsWith<T>(this IList<T> source, T[] mark) where T : IEquatable<T> => source.EndsWith<T>(0, source.Count, mark);

    public static bool EndsWith<T>(this IList<T> source, int offset, int length, T[] mark) where T : IEquatable<T>
    {
      if (mark.Length > length)
        return false;
      for (int index = 0; index < Math.Min(length, mark.Length); ++index)
      {
        if (!mark[index].Equals(source[offset + length - mark.Length + index]))
          return false;
      }
      return true;
    }

    public static T[] CloneRange<T>(this T[] source, int offset, int length)
    {
      T[] objArray = new T[length];
      Array.Copy((Array) source, offset, (Array) objArray, 0, length);
      return objArray;
    }

    public static T[] RandomOrder<T>(this T[] source)
    {
      int num = source.Length / 2;
      for (int index1 = 0; index1 < num; ++index1)
      {
        int index2 = Extensions.m_Random.Next(0, source.Length - 1);
        int index3 = Extensions.m_Random.Next(0, source.Length - 1);
        if (index2 != index3)
        {
          T obj = source[index3];
          source[index3] = source[index2];
          source[index2] = obj;
        }
      }
      return source;
    }

    public static string GetValue(this NameValueCollection collection, string key) => collection.GetValue(key, string.Empty);

    public static string GetValue(
      this NameValueCollection collection,
      string key,
      string defaultValue)
    {
      if (string.IsNullOrEmpty(key))
        throw new ArgumentNullException(nameof (key));
      return collection == null ? defaultValue : collection[key] ?? defaultValue;
    }
  }
}
