// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.ScriptableObjects.LocalPlayerVisualSmoothingConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.ScriptableObjects
{
  [CreateAssetMenu(fileName = "LocalPlayerVisualSmoothingConfig", menuName = "SteelCircus/Configs/LocalPlayerVisualSmoothingConfig")]
  public class LocalPlayerVisualSmoothingConfig : GameConfigEntry
  {
    public float snapThreshold = 2.5f;
    public float minSmoothDuration = 0.05f;
    public float maxSmoothDuration = 0.15f;
    public float positionDeltaMinSmooth = 0.2f;
    public float positionDeltaMaxSmooth = 1.2f;
    public float rotationDeltaMinSmooth = 30f;
    public float rotationDeltaMaxSmooth = 90f;
    public float startSmoothingThreshold = 0.1f;
    public float skipSmoothingThreshold = 10f;
    public float topSpeed = 40f;
    public float secondsToTopSpeed = 0.5f;
  }
}
