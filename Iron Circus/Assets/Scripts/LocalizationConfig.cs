// Decompiled with JetBrains decompiler
// Type: LocalizationConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using UnityEngine;

[CreateAssetMenu(fileName = "LocalizationConfig", menuName = "SteelCircus/Configs/Localization")]
public class LocalizationConfig : SingletonScriptableObject<LocalizationConfig>
{
  public string exportFilename = "export";
  [HideInInspector]
  public List<string> fixedKeys;
  [HideInInspector]
  public List<ItemLocaData> itemKeys;
  [HideInInspector]
  public List<string> keys;
  [HideInInspector]
  public List<string> unusedEntries;
  [HideInInspector]
  public ScLanguage[] languages;
  private string path;
  private List<string[]> rowData = new List<string[]>();

  private void OnEnable() => this.path = Application.streamingAssetsPath + "/" + this.exportFilename + ".tsv";

  public void ExportCsv()
  {
    this.path = Application.streamingAssetsPath + "/" + this.exportFilename + ".tsv";
    this.rowData = new List<string[]>();
    if (File.Exists(this.path))
      this.LoadCsv(this.path);
    else
      this.InitializeCsvKeyHeader();
    this.AddFixedKeysToCsvContainer();
    this.AddKeysToCsvContainer();
    this.AddItemKeysToCsvContainer();
    Debug.Log((object) string.Format("Exporting: {0} keys To {1}", (object) this.rowData.Count, (object) this.path));
    this.WriteToCsv();
  }

  private void LoadCsv(string filePath)
  {
    string[] strArray1 = File.ReadAllText(filePath).Split('\n');
    this.InitializeCsvKeyHeader(strArray1[0].Split('\t'));
    for (int index1 = 1; index1 < strArray1.Length; ++index1)
    {
      string[] strArray2 = strArray1[index1].Split('\t');
      for (int index2 = 0; index2 < strArray2.Length; ++index2)
        strArray2[index2] = strArray2[index2].TrimEnd();
      this.rowData.Add(strArray2);
    }
  }

  private void WriteToCsv()
  {
    string[][] strArray = new string[this.rowData.Count][];
    for (int index = 0; index < strArray.Length; ++index)
      strArray[index] = this.rowData[index];
    int length = strArray.GetLength(0);
    string separator = "\t";
    StringBuilder stringBuilder = new StringBuilder();
    for (int index = 0; index < length; ++index)
      stringBuilder.AppendLine(string.Join(separator, strArray[index]));
    string contents = stringBuilder.ToString().Remove(stringBuilder.ToString().Length - 2);
    Debug.Log((object) ("Exported:\n" + contents));
    File.WriteAllText(this.path, contents);
    this.ResetItemKeyChangeFlags();
  }

  public void GetUnusedEntriesFromCsv()
  {
    this.LoadCsv(this.path);
    this.unusedEntries = new List<string>();
    foreach (string[] strArray in this.rowData)
    {
      bool flag = false;
      foreach (string fixedKey in this.fixedKeys)
      {
        if (fixedKey.Equals(strArray[0]))
          flag = true;
      }
      if (!flag)
      {
        foreach (string key in this.keys)
        {
          if (key.Equals(strArray[0]))
            flag = true;
        }
      }
      if (!flag)
      {
        foreach (ItemLocaData itemKey in this.itemKeys)
        {
          if (itemKey.locaString.Equals(strArray[0]))
            flag = true;
        }
      }
      if (!flag)
        this.unusedEntries.Add(strArray[0]);
    }
  }

  private void AddFixedKeysToCsvContainer()
  {
    if (this.fixedKeys == null)
      return;
    for (int index1 = 0; index1 < this.fixedKeys.Count; ++index1)
    {
      string[] rowDataTemp = new string[this.languages.Length + 1];
      rowDataTemp[0] = this.fixedKeys[index1];
      for (int index2 = 1; index2 < this.languages.Length + 1; ++index2)
        rowDataTemp[index2] = "";
      if (this.rowData.FirstOrDefault<string[]>((Func<string[], bool>) (stringToCheck => ((IEnumerable<string>) stringToCheck).Contains<string>(rowDataTemp[0]))) == null)
        this.rowData.Add(rowDataTemp);
    }
  }

  public List<string[]> GetRowData()
  {
    this.rowData = new List<string[]>();
    this.LoadCsv(this.path);
    return this.rowData;
  }

  public void ResetItemKeyChangeFlags()
  {
    foreach (ItemLocaData itemKey in this.itemKeys)
    {
      itemKey.changed = false;
      itemKey.newlyAdded = false;
    }
  }

  private void AddItemKeysToCsvContainer()
  {
    if (this.itemKeys == null)
      return;
    for (int index1 = 0; index1 < this.itemKeys.Count; ++index1)
    {
      string[] rowDataTemp = new string[this.languages.Length + 1];
      rowDataTemp[0] = this.itemKeys[index1].locaString;
      for (int index2 = 1; index2 < this.languages.Length + 1; ++index2)
        rowDataTemp[index2] = "";
      if (this.itemKeys[index1].changed)
      {
        foreach (string[] strArray in this.rowData)
        {
          if (strArray[0] == this.itemKeys[index1].oldLocaString)
            strArray[0] = this.itemKeys[index1].locaString;
        }
      }
      if (this.rowData.FirstOrDefault<string[]>((Func<string[], bool>) (stringToCheck => ((IEnumerable<string>) stringToCheck).Contains<string>(rowDataTemp[0]))) == null)
        this.rowData.Add(rowDataTemp);
    }
  }

  private void AddKeysToCsvContainer()
  {
    for (int index1 = 0; index1 < this.keys.Count; ++index1)
    {
      string[] rowDataTemp = new string[this.languages.Length + 1];
      rowDataTemp[0] = this.keys[index1];
      for (int index2 = 1; index2 < this.languages.Length + 1; ++index2)
        rowDataTemp[index2] = "";
      if (this.rowData.FirstOrDefault<string[]>((Func<string[], bool>) (stringToCheck => ((IEnumerable<string>) stringToCheck).Contains<string>(rowDataTemp[0]))) == null)
        this.rowData.Add(rowDataTemp);
    }
  }

  private void InitializeCsvKeyHeader(string[] languagesToMerge = null)
  {
    string[] strArray = new string[this.languages.Length + 1];
    strArray[0] = "Key";
    for (int index = 1; index < this.languages.Length + 1; ++index)
      strArray[index] = this.languages[index - 1].Language.ToString();
    if (languagesToMerge != null)
    {
      for (int index = 0; index < languagesToMerge.Length; ++index)
        languagesToMerge[index] = languagesToMerge[index].Trim();
      this.rowData.Add(((IEnumerable<string>) languagesToMerge).Union<string>((IEnumerable<string>) strArray).ToArray<string>());
    }
    else
      this.rowData.Add(strArray);
  }

  public ScLanguage[] GetActiveLanguages()
  {
    List<ScLanguage> scLanguageList = new List<ScLanguage>();
    foreach (ScLanguage language in this.languages)
    {
      if (language.activeLanguage)
        scLanguageList.Add(language);
    }
    return scLanguageList.ToArray();
  }

  public ScLanguage GetLanguageBySteamAPICode(string code)
  {
    foreach (ScLanguage language in this.languages)
    {
      if (language.steamAPICode == code)
        return language;
    }
    return this.languages[0];
  }

  public ItemLocaData GetItemLocaEntryByName(ItemLocaData data)
  {
    foreach (ItemLocaData itemKey in this.itemKeys)
    {
      if (data.IsNameEqual(itemKey))
        return itemKey;
    }
    return (ItemLocaData) null;
  }
}
