// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.EntitasShared.Components.Pickup.PickupComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Imi.SharedWithServer.EntitasShared.Components.Pickup
{
  [global::Game]
  public class PickupComponent : ImiComponent
  {
    public List<PickupData> pickupsToSpawn;
    public PickupType activeType;
    public PickupSize pickupSize;
    public PickupType nextActiveType;
    public bool isActive;
    public bool isActiveOnStart;
    public float respawnDuration;
    public float currentDuration;

    public PickupComponent()
    {
    }

    public PickupComponent(
      List<PickupData> pickupsToSpawn,
      PickupType activeType,
      PickupSize pickupSize,
      bool isActiveOnStart,
      float respawnDuration)
    {
      this.isActiveOnStart = isActiveOnStart;
      this.activeType = activeType;
      this.pickupSize = pickupSize;
      this.nextActiveType = activeType;
      this.isActive = false;
      this.respawnDuration = respawnDuration;
      this.pickupsToSpawn = pickupsToSpawn.OrderByDescending<PickupData, int>((Func<PickupData, int>) (pickupData => pickupData.spawnChance)).ToList<PickupData>();
      this.currentDuration = 0.0f;
    }
  }
}
