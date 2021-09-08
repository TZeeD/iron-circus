// Decompiled with JetBrains decompiler
// Type: ArenaConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Utils.Common;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[CreateAssetMenu(fileName = "New Arena Config", menuName = "SteelCircus/Configs/ArenaConfig")]
public class ArenaConfig : ScriptableObject
{
  [Readonly]
  public string arenaSceneName;
  [Readonly]
  public string environmentSceneName;
  [Readonly]
  public Material skybox;
  public Material cameraSkybox;
  public Material floorNormals;
  public float cameraNearPlane = 0.3f;
  public float cameraFarPlane = 1810f;
  [Readonly]
  public Cubemap reflectionProbe;
  public PostProcessProfile profile;
  public PostProcessProfile colorGrading;
  public GameObject IntroCamera;
  public GameObject VictoryCameras;
  public GameObject GoalCameras;
}
