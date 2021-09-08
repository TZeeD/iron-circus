// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.ConfigProvider
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SteelCircus.ScriptableObjects;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using SharedWithServer.JSONDotNet;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  public class ConfigProvider : GameConfigEntry
  {
    [JsonIgnore]
    public string outputPath;
    [JsonIgnore]
    public string serverJsonDir;
    [Space]
    [JsonIgnore]
    public ColorsConfig colorsConfig;
    [JsonIgnore]
    public LocalPlayerVisualSmoothingConfig visualSmoothingConfig;
    [JsonIgnore]
    public FactionConfig factionConfig;
    public BallConfig ballConfig;
    public BumperConfig bumperConfig;
    public DebugConfig debugConfig;
    public MatchConfig matchConfig;
    public PhysicsEngineConfig physicsEngineConfig;
    [Space]
    [JsonIgnore]
    public ChampionConfigProvider ChampionConfigProvider;
    public ChampionConfig bagpipes;
    public ChampionConfig servitor;
    public ChampionConfig li;
    public ChampionConfig mali;
    public ChampionConfig hildegard;
    public ChampionConfig acrid;
    public ChampionConfig galena;
    public ChampionConfig kenny;
    public ChampionConfig robot;

    public List<T> GetConfigsOfType<T>() where T : GameConfigEntry
    {
      List<T> objList = new List<T>();
      foreach (FieldInfo field in this.GetType().GetFields())
      {
        if (typeof (T).IsAssignableFrom(field.FieldType))
          objList.Add((T) field.GetValue((object) this));
      }
      return objList;
    }

    public void WriteToJsons() => SerializationUtils.WriteToJson((GameConfigEntry) this, this.outputPath, this.serverJsonDir, (IList<JsonConverter>) new List<JsonConverter>()
    {
      (JsonConverter) new SkillConfigConverter(this.outputPath, this.serverJsonDir)
    });

    public static ConfigProvider LoadFromJsons(
      string folderPath,
      Dictionary<string, SkillGraphConfig> skillConfigLookup)
    {
      ConfigProvider configProvider = new ConfigProvider();
      using (StreamReader streamReader = new StreamReader(folderPath + "/ConfigProvider.json"))
      {
        string end = streamReader.ReadToEnd();
        TypeNameSerializationBinder serializationBinder = new TypeNameSerializationBinder();
        JsonSerializerSettings serializerSettings = new JsonSerializerSettings();
        serializerSettings.SerializationBinder = (ISerializationBinder) serializationBinder;
        serializerSettings.TypeNameHandling = TypeNameHandling.Auto;
        serializerSettings.Formatting = Formatting.Indented;
        serializerSettings.Converters.Add((JsonConverter) new SkillConfigConverter(folderPath, skillConfigLookup));
        JsonSerializerSettings settings = serializerSettings;
        return JsonConvert.DeserializeObject<ConfigProvider>(end, settings);
      }
    }
  }
}
