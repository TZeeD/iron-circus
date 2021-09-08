// Decompiled with JetBrains decompiler
// Type: PlayerPrefsUtility
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Sabresaurus.PlayerPrefsExtensions;
using System;
using System.Globalization;
using UnityEngine;

public static class PlayerPrefsUtility
{
  public const string KEY_PREFIX = "ENC-";
  public const string VALUE_FLOAT_PREFIX = "0";
  public const string VALUE_INT_PREFIX = "1";
  public const string VALUE_STRING_PREFIX = "2";

  public static bool IsEncryptedKey(string key) => key.StartsWith("ENC-");

  public static string DecryptKey(string encryptedKey) => encryptedKey.StartsWith("ENC-") ? SimpleEncryption.DecryptString(encryptedKey.Substring("ENC-".Length)) : throw new InvalidOperationException("Could not decrypt item, no match found in known encrypted key prefixes");

  public static void SetEncryptedFloat(string key, float value) => PlayerPrefs.SetString("ENC-" + SimpleEncryption.EncryptString(key), "0" + SimpleEncryption.EncryptFloat(value));

  public static void SetEncryptedInt(string key, int value) => PlayerPrefs.SetString("ENC-" + SimpleEncryption.EncryptString(key), "1" + SimpleEncryption.EncryptInt(value));

  public static void SetEncryptedString(string key, string value) => PlayerPrefs.SetString("ENC-" + SimpleEncryption.EncryptString(key), "2" + SimpleEncryption.EncryptString(value));

  public static object GetEncryptedValue(string encryptedKey, string encryptedValue)
  {
    if (encryptedValue.StartsWith("0"))
      return (object) PlayerPrefsUtility.GetEncryptedFloat(SimpleEncryption.DecryptString(encryptedKey.Substring("ENC-".Length)));
    if (encryptedValue.StartsWith("1"))
      return (object) PlayerPrefsUtility.GetEncryptedInt(SimpleEncryption.DecryptString(encryptedKey.Substring("ENC-".Length)));
    if (encryptedValue.StartsWith("2"))
      return (object) PlayerPrefsUtility.GetEncryptedString(SimpleEncryption.DecryptString(encryptedKey.Substring("ENC-".Length)));
    throw new InvalidOperationException("Could not decrypt item, no match found in known encrypted key prefixes");
  }

  public static float GetEncryptedFloat(string key, float defaultValue = 0.0f)
  {
    string str = PlayerPrefs.GetString("ENC-" + SimpleEncryption.EncryptString(key));
    return !string.IsNullOrEmpty(str) ? SimpleEncryption.DecryptFloat(str.Remove(0, 1)) : defaultValue;
  }

  public static int GetEncryptedInt(string key, int defaultValue = 0)
  {
    string str = PlayerPrefs.GetString("ENC-" + SimpleEncryption.EncryptString(key));
    return !string.IsNullOrEmpty(str) ? SimpleEncryption.DecryptInt(str.Remove(0, 1)) : defaultValue;
  }

  public static string GetEncryptedString(string key, string defaultValue = "")
  {
    string str = PlayerPrefs.GetString("ENC-" + SimpleEncryption.EncryptString(key));
    return !string.IsNullOrEmpty(str) ? SimpleEncryption.DecryptString(str.Remove(0, 1)) : defaultValue;
  }

  public static void SetBool(string key, bool value)
  {
    if (value)
      PlayerPrefs.SetInt(key, 1);
    else
      PlayerPrefs.SetInt(key, 0);
  }

  public static bool GetBool(string key, bool defaultValue = false)
  {
    if (!PlayerPrefs.HasKey(key))
      return defaultValue;
    return PlayerPrefs.GetInt(key) != 0;
  }

  public static void SetEnum(string key, Enum value) => PlayerPrefs.SetString(key, value.ToString());

  public static T GetEnum<T>(string key, T defaultValue = default (T)) where T : struct
  {
    string str = PlayerPrefs.GetString(key);
    return !string.IsNullOrEmpty(str) ? (T) Enum.Parse(typeof (T), str) : defaultValue;
  }

  public static object GetEnum(string key, System.Type enumType, object defaultValue)
  {
    string str = PlayerPrefs.GetString(key);
    return !string.IsNullOrEmpty(str) ? Enum.Parse(enumType, str) : defaultValue;
  }

  public static void SetDateTime(string key, DateTime value) => PlayerPrefs.SetString(key, value.ToString("o", (IFormatProvider) CultureInfo.InvariantCulture));

  public static DateTime GetDateTime(string key, DateTime defaultValue = default (DateTime))
  {
    string s = PlayerPrefs.GetString(key);
    return !string.IsNullOrEmpty(s) ? DateTime.Parse(s, (IFormatProvider) CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind) : defaultValue;
  }

  public static void SetTimeSpan(string key, TimeSpan value) => PlayerPrefs.SetString(key, value.ToString());

  public static TimeSpan GetTimeSpan(string key, TimeSpan defaultValue = default (TimeSpan))
  {
    string s = PlayerPrefs.GetString(key);
    return !string.IsNullOrEmpty(s) ? TimeSpan.Parse(s) : defaultValue;
  }
}
