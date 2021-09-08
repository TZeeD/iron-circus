// Decompiled with JetBrains decompiler
// Type: StandaloneSettings
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.IO;
using UnityEngine;

[Serializable]
public class StandaloneSettings
{
  public bool developerMode;
  public ulong LocalPlayerId;
  public int team;
  public string ipAddress;
  public int port;

  public string SaveToJson() => JsonUtility.ToJson((object) this, true);

  public static StandaloneSettings ReadStandaloneSettingsAsJson()
  {
    string json = File.ReadAllText(Application.streamingAssetsPath + "/StandaloneSettings.json");
    return !string.IsNullOrEmpty(json) ? JsonUtility.FromJson<StandaloneSettings>(json) : (StandaloneSettings) null;
  }

  public override string ToString() => "DeveloperMode: " + this.developerMode.ToString() + "\nLocalPlayerId: " + (object) this.LocalPlayerId + "\nIpAddress: " + this.ipAddress + "\nPort: " + (object) this.port + "\n";
}
