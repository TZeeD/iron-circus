// Decompiled with JetBrains decompiler
// Type: SharedWithServer.JSONDotNet.SerializationUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using Imi.SharedWithServer.Config;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.IO;

namespace SharedWithServer.JSONDotNet
{
  public static class SerializationUtils
  {
    public static void WriteToJson(
      GameConfigEntry config,
      string folderPath,
      string serverPath = null,
      IList<JsonConverter> converters = null)
    {
      string str = string.Format("{0}/{1}.json", (object) folderPath, (object) config.name);
      if (!Directory.Exists(folderPath))
        throw new Exception(string.Format("Directory '{0}' does not exist!", (object) folderPath));
      Log.Debug("Exporting [" + config.name + "]\n to: " + str + "\n");
      try
      {
        if (File.Exists(str))
          new FileInfo(str).IsReadOnly = false;
        using (StreamWriter text = File.CreateText(str))
        {
          string json = SerializationUtils.ConfigToJson(config, converters);
          text.Write(json);
          text.Flush();
        }
      }
      catch (Exception ex)
      {
        Log.Debug(ex.Message + "\n" + ex.StackTrace);
      }
    }

    public static string ConfigToJson(GameConfigEntry config, IList<JsonConverter> converters)
    {
      TypeNameSerializationBinder serializationBinder = new TypeNameSerializationBinder();
      JsonSerializerSettings settings = new JsonSerializerSettings()
      {
        TypeNameHandling = TypeNameHandling.All,
        Formatting = Formatting.Indented,
        ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
        SerializationBinder = (ISerializationBinder) serializationBinder,
        Converters = converters
      };
      return JsonConvert.SerializeObject((object) config, config.GetType(), settings);
    }

    public static SkillGraphConfig SkillConfigFromJsonFile(string fullPath) => SerializationUtils.SkillConfigFromJson(SerializationUtils.LoadJsonFile(fullPath));

    public static SkillGraphConfig SkillConfigFromJson(string json)
    {
      TypeNameSerializationBinder serializationBinder = new TypeNameSerializationBinder();
      JsonSerializerSettings settings = new JsonSerializerSettings()
      {
        SerializationBinder = (ISerializationBinder) serializationBinder,
        TypeNameHandling = TypeNameHandling.Auto,
        Formatting = Formatting.Indented
      };
      return JsonConvert.DeserializeObject<SkillGraphConfig>(json, settings);
    }

    public static string LoadJsonFile(string fullPath)
    {
      using (StreamReader streamReader = new StreamReader(fullPath))
        return streamReader.ReadToEnd();
    }

    public static void CopyFileTo(GameConfigEntry config, string originPath, string destPath)
    {
      string str1 = destPath;
      char[] chArray = new char[1]{ ',' };
      foreach (string str2 in str1.Split(chArray))
      {
        string path = str2.Replace(" ", string.Empty);
        if (path != null)
        {
          if (!Directory.Exists(path))
            Directory.CreateDirectory(path);
          string destFileName = string.Format("{0}/{1}.json", (object) path, (object) config.name);
          File.Copy(originPath, destFileName, true);
          Log.Debug("Copied File: '" + originPath + "' To: '" + Path.GetFullPath(path) + "'");
        }
      }
    }
  }
}
