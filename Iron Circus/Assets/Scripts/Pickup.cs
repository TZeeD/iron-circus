// Decompiled with JetBrains decompiler
// Type: Pickup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.SharedWithServer.EntitasShared.Components.Pickup;
using Imi.SharedWithServer.Game;
using Imi.Utils.Common;
using SteelCircus;
using System.Collections.Generic;
using UnityEngine;

public class Pickup : MonoBehaviour, IConvertableToEntitas
{
  public List<PickupData> spawnData;
  [Header("First Pickup that spawns")]
  public PickupType activeType;
  [Readonly]
  public PickupSize pickupSize;
  public bool isActiveOnStart;
  public float respawnDuration;

  public IComponent ConvertToEntitasComponent() => (IComponent) new PickupComponent(this.spawnData, this.activeType, this.pickupSize, this.isActiveOnStart, this.respawnDuration);
}
