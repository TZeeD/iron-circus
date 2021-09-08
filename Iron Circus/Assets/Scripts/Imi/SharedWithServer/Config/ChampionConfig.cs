// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Config.ChampionConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SteelCircus.UI.Config;
using Imi.Utils.Common;
using Newtonsoft.Json;
using UnityEngine;
using UnityEngine.Serialization;

namespace Imi.SharedWithServer.Config
{
  [CreateAssetMenu(fileName = "ChampionConfig", menuName = "SteelCircus/Configs/ChampionConfig")]
  public class ChampionConfig : GameConfigEntry
  {
    public ChampionType championType;
    [JsonIgnore]
    public ChampionClass classType;
    public float colliderRadius = 0.5f;
    public int maxHealth = 2;
    [FormerlySerializedAs("ballHitRange")]
    public float ballPickupRange = 15f;
    [Header("Movement")]
    [Tooltip("Meters per Second (m/s)")]
    public float maxSpeed;
    public StaminaConfig stamina;
    [Tooltip("1-5")]
    public int uiDisplaySpeed;
    [Tooltip("Meters per Second per Second (m/s^2). Speed increases by this value every second. So if maxSpeed is 5 m/s and Acceleration is 20 m/s^2, the champion will reach 5m/s in 0.25 seconds. If acceleration is 5m/s^2, the champion will reach 5m/s in 1 second")]
    public float acceleration = 0.5f;
    public float deceleration = 0.1f;
    [Tooltip("Value [0, 1] how 'floaty' the movement should feel. 1 meand totally floaty, 0 means instant direction changes")]
    [Range(0.0f, 1f)]
    public float controlsThrusterContribution = 0.5f;
    [Tooltip("Should the champion only be able to move in the direction it is looking")]
    public bool moveOnlyForward;
    [Tooltip("Rotate champion over time using the 'turnSpeed'. If this is off, champion will always just look where the stick points.")]
    public bool useTurnSpeed = true;
    [Tooltip("Angles per Second")]
    public float turnSpeed = 360f;
    [Header("Skills")]
    [FormerlySerializedAs("playerSkillScripts")]
    public SkillGraphConfig[] playerSkillGraphs;
    [Header("Visual")]
    [JsonIgnore]
    public Sprite icon;
    [JsonIgnore]
    public Sprite dev_icon;
    [JsonIgnore]
    public FactionConfig faction;
    [JsonIgnore]
    public GameObject Champion3DIconPrefab;
    [JsonIgnore]
    public float inGameModelScale = 1f;
    [JsonIgnore]
    public SkinConfig[] skins;
    [JsonIgnore]
    public float maxAimRotation = 75f;
    [JsonIgnore]
    public float aimAnimRotationSpeed = 420f;
    [JsonIgnore]
    [Readonly]
    public string[] aimRotationBones;
    [JsonIgnore]
    public ChampionEmoteConfig emoteConfig;
    [JsonIgnore]
    public VictoryPoseConfig victoryPoseConfig;
    [JsonIgnore]
    public string displayName;
    [JsonIgnore]
    [SerializeField]
    public string ballHoldHandName = "leftArm1_LoResHand";
    [JsonIgnore]
    public Vector3 ballHoldOffsetFromHand = new Vector3(0.0f, 0.0f, 0.0f);
    [Header("UI Anchor")]
    [JsonIgnore]
    public Vector3 uiAnchor = new Vector3(0.0f, 2.1f, 0.0f);
    [Header("Optional: parent ui anchor to bone (if name isn't \"\")")]
    [JsonIgnore]
    public string uiAnchorBoneName = "";
    [JsonIgnore]
    public Vector3 uiAnchorBoneRestPos = new Vector3(0.0f, 1f, 0.0f);
    [JsonIgnore]
    public float uiAnchorBoneMinHeight = 1.5f;
    [JsonIgnore]
    public float uiAnchorBoneInfluence = 1f;
    [JsonIgnore]
    public float uiAnchorBoneSpringFrequency = 3f;
    [Header("Turntable")]
    [JsonIgnore]
    public float turntableModelScale = 1f;
    [JsonIgnore]
    public CameraSetting cameraFar;
    [JsonIgnore]
    public CameraSetting cameraClose;
    [JsonIgnore]
    public CameraSetting cameraMainMenu;
    [Header("Shop")]
    [JsonIgnore]
    public Vector2 shopIconTranslation;
    [JsonIgnore]
    public float shopIconScale;
  }
}
