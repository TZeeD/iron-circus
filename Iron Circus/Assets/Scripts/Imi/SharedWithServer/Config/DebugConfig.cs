// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.DebugConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Newtonsoft.Json;
using UnityEngine;

namespace Imi.SharedWithServer.Config
{
  public class DebugConfig : GameConfigEntry
  {
    public const float skippedCutsceneDuration = 1f;
    public int numLocalPlayers = 1;
    public bool skipCutscenes;
    public bool useClientPrediction;
    public bool useSnapshotInterpolation;
    public bool debugDrawObjects = true;
    public bool disableVisualSmoothing;
    public bool useNewVisualSmoothing;
    public bool showServerProxies;
    public bool updateSkillsNetworked;
    public bool overrideRemoteLerpSettings;
    public float remoteLerpOffsetInSeconds = 0.1f;
    public float remoteLerpWeightBlendDurationInSeconds = 0.05f;
    [JsonIgnore]
    public Color debugDrawColor;
  }
}
