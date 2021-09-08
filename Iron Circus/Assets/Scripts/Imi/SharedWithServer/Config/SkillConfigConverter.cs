// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.SkillConfigConverter
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Newtonsoft.Json;
using SharedWithServer.JSONDotNet;
using System;
using System.Collections.Generic;

namespace Imi.SharedWithServer.Config
{
  public class SkillConfigConverter : JsonConverter<SkillGraphConfig>
  {
    private string outputPath;
    private string copyPath;
    private string loadPath;
    private Dictionary<string, SkillGraphConfig> skillConfigLookup;

    public SkillConfigConverter(
      string loadPath,
      Dictionary<string, SkillGraphConfig> skillConfigLookup)
    {
      this.loadPath = loadPath;
      this.skillConfigLookup = skillConfigLookup;
    }

    public SkillConfigConverter(string outputPath, string copyPath)
    {
      this.outputPath = outputPath;
      this.copyPath = copyPath;
    }

    public override void WriteJson(
      JsonWriter writer,
      SkillGraphConfig value,
      JsonSerializer serializer)
    {
      writer.WriteValue(value.name);
      SerializationUtils.WriteToJson((GameConfigEntry) value, this.outputPath, this.copyPath);
    }

    public override SkillGraphConfig ReadJson(
      JsonReader reader,
      Type objectType,
      SkillGraphConfig existingValue,
      bool hasExistingValue,
      JsonSerializer serializer)
    {
      string key = (string) reader.Value;
      string fullPath = this.loadPath + "/" + key + ".json";
      if (!this.skillConfigLookup.ContainsKey(key))
      {
        SkillGraphConfig skillGraphConfig = SerializationUtils.SkillConfigFromJsonFile(fullPath);
        this.skillConfigLookup[key] = skillGraphConfig;
      }
      return this.skillConfigLookup[key];
    }
  }
}
