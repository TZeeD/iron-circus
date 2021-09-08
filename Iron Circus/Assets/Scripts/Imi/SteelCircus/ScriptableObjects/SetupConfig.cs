// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScriptableObjects.SetupConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SteelCircus.Networking;
using UnityEngine;

namespace Imi.SteelCircus.ScriptableObjects
{
  [CreateAssetMenu(fileName = "SetupConfig", menuName = "SteelCircus/Configs/SetupConfig")]
  public class SetupConfig : ScriptableObject
  {
    [Tooltip("These Objects will be instantiated before when the first scene is loaded and they will not be destroyed when the scene changes")]
    public GameObject[] dontDestroyOnLoad;
    [Tooltip("The multiplayer scene auto connects.")]
    public string multiplayerScene;
    [Tooltip("The local scene does not connect at all.")]
    public string localScene;
    [Tooltip("The auto connecting data")]
    public SteelClientConfig steelClientConfig;
    public ConfigProvider configProvider;
    [Header("Singleton Configs")]
    public ChampionConfigProvider championConfigProvider;
    public ItemsConfig itemsConfig;
    public PickupConfig pickupConfig;
    public StandaloneConfig standaloneConfig;
  }
}
