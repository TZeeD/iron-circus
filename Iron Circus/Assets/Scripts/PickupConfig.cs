// Decompiled with JetBrains decompiler
// Type: PickupConfig
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using UnityEngine;

[CreateAssetMenu(fileName = "PickupConfig", menuName = "SteelCircus/Configs/PickupConfig")]
public class PickupConfig : SingletonScriptableObject<PickupConfig>
{
  public GameObject healthPickupPrefab;
  public GameObject refreshPickupPrefab;
  public GameObject sprintPickupPrefab;
  public GameObject healthSmallPickupPrefab;
  public GameObject refreshSmallPickupPrefab;
  public GameObject sprintSmallPickupPrefab;

  public GameObject GetPickup(PickupType type, PickupSize size)
  {
    if (size == PickupSize.Small)
    {
      switch (type)
      {
        case PickupType.RefreshSkills:
          return this.refreshSmallPickupPrefab;
        case PickupType.RegainHealth:
          return this.healthSmallPickupPrefab;
        case PickupType.RefreshSprint:
          return this.sprintSmallPickupPrefab;
        default:
          return this.healthSmallPickupPrefab;
      }
    }
    else
    {
      switch (type)
      {
        case PickupType.RefreshSkills:
          return this.refreshPickupPrefab;
        case PickupType.RegainHealth:
          return this.healthPickupPrefab;
        case PickupType.RefreshSprint:
          return this.sprintPickupPrefab;
        default:
          return this.healthPickupPrefab;
      }
    }
  }
}
