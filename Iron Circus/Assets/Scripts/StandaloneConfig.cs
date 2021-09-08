// Decompiled with JetBrains decompiler
// Type: StandaloneConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Diagnostics;
using System.IO;
using UnityEngine;

[CreateAssetMenu(fileName = "StandaloneConfig", menuName = "SteelCircus/Configs/StandaloneConfig")]
public class StandaloneConfig : SingletonScriptableObject<StandaloneConfig>
{
  public StandaloneSettings settings = new StandaloneSettings();
  public StandalonePlayerConfig[] players;

  public void CreateStandaloneJson() => File.WriteAllText(Application.streamingAssetsPath + "/StandaloneSettings.json", this.settings.SaveToJson());

  public void LoadConfigFromJson()
  {
    this.settings = StandaloneSettings.ReadStandaloneSettingsAsJson();
    Log.Debug("Standalone JSON Loaded: " + this.settings.ToString());
  }

  public string GetUsernameForPlayerId(ulong id)
  {
    foreach (StandalonePlayerConfig player in this.players)
    {
      if ((long) player.PlayerId == (long) id)
        return player.username;
    }
    return "NoName" + (object) id;
  }
}
