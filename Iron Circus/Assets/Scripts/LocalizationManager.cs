// Decompiled with JetBrains decompiler
// Type: LocalizationManager
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using SharedWithServer.Utils.Extensions;
using Steamworks;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class LocalizationManager
{
  private static Dictionary<string, string> localizedText;
  private bool isReady;
  [SerializeField]
  private bool loadLanguageFromSettings = true;
  private LocalizationConfig localizationConfig;

  public LocalizationManager() => this.localizationConfig = Resources.Load<LocalizationConfig>("Configs/LocalizationConfig");

  public void LoadLocalizedText(string fileName, bool useJson)
  {
    string locale = "";
    if (PlayerPrefs.HasKey("SystemLanguage"))
      locale = PlayerPrefs.GetString("SystemLanguage");
    else if (SteamManager.Initialized)
      locale = SingletonScriptableObject<LocalizationConfig>.Instance.GetLanguageBySteamAPICode(SteamUtils.GetSteamUILanguage()).ToString();
    LocalizationManager.localizedText = new Dictionary<string, string>();
    if (useJson)
      this.LoadLocalizedTextFromJSON(locale + "_" + fileName);
    else
      this.LoadLocalizedTextFromCSV(fileName, locale);
  }

  private void LoadLocalizedTextFromJSON(string fileName)
  {
    string str = Path.Combine(Application.streamingAssetsPath, fileName);
    if (File.Exists(str))
    {
      this.ReadJSONFrom_StreamingFolder(str);
      Debug.Log((object) ("Data loaded from JSON , dictionary contains: " + (object) LocalizationManager.localizedText.Count + " entries"));
    }
    else
      Debug.LogError((object) "Cannot find file!");
    this.isReady = true;
  }

  private void LoadLocalizedTextFromCSV(string fileName, string locale)
  {
    string str = Path.Combine(Application.streamingAssetsPath, fileName);
    if (File.Exists(str))
    {
      this.ReadCSVFrom_StreamingFolder(str, locale);
      Log.Debug("Localization loaded from file: [" + str + "] , dictionary contains: " + (object) LocalizationManager.localizedText.Count + " entries.");
    }
    else
      Log.Error("Cannot find Localization file! : " + str);
    this.isReady = true;
  }

  private void ReadJSONFrom_StreamingFolder(string filePath)
  {
    LocalizationData localizationData = JsonUtility.FromJson<LocalizationData>(File.ReadAllText(filePath));
    for (int index = 0; index < localizationData.items.Length; ++index)
      LocalizationManager.localizedText.Add(localizationData.items[index].key, localizationData.items[index].value);
  }

  private void ReadCSVFrom_StreamingFolder(string filePath, string locale)
  {
    string[] strArray1 = File.ReadAllText(filePath).Split('\n');
    int indexForLanguage = this.GetCSVColumnIndexForLanguage(strArray1[0].Split('\t'), locale);
    for (int index = 1; index < strArray1.Length; ++index)
    {
      string[] strArray2 = strArray1[index].Split('\t');
      if (strArray2 == null || indexForLanguage >= strArray2.Length)
      {
        Log.Error(string.Format("Loca entry in line {0}, position {1} does not exist. Makes sure to separate all entries with a tab.", (object) index, (object) indexForLanguage));
        LocalizationManager.localizedText.Add(strArray2[0], "_missing_");
      }
      else
        LocalizationManager.localizedText.Add(strArray2[0], strArray2[indexForLanguage]);
    }
  }

  public string GetLocalizedValue(string key)
  {
    if (LocalizationManager.localizedText == null)
      return "loca is null!";
    string str = "<color=red>" + key + "</color>";
    if (LocalizationManager.localizedText.ContainsKey(key) && !LocalizationManager.localizedText[key].IsNullOrEmpty() && LocalizationManager.localizedText[key] != "\r")
      str = LocalizationManager.localizedText[key];
    return str;
  }

  private int GetCSVColumnIndexForLanguage(string[] columns, string locale)
  {
    for (int index = 1; index < columns.Length; ++index)
    {
      if (columns[index].Trim() == locale)
        return index;
    }
    return 1;
  }

  private string GetLocalizationString(SystemLanguage systemLanguage)
  {
    if (this.loadLanguageFromSettings && PlayerPrefs.HasKey("SystemLanguage"))
    {
      Log.Debug("SystemLanguage loaded from Preferences " + PlayerPrefs.GetString("SystemLanguage"));
      return PlayerPrefs.GetString("SystemLanguage");
    }
    string str = systemLanguage != SystemLanguage.German ? SystemLanguage.English.ToString() : systemLanguage.ToString();
    Log.Debug("SystemLanguage loaded for the first time  " + str);
    PlayerPrefs.SetString("SystemLanguage", str);
    return str;
  }

  public bool GetIsReady() => this.isReady;
}
