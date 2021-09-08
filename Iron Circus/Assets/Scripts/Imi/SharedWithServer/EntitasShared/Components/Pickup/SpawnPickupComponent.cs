// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.EntitasShared.Components.Pickup.SpawnPickupComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.EntitasShared.Components.Pickup
{
  [global::Game]
  public class SpawnPickupComponent : ImiComponent
  {
    public JVector position;
    public PickupType type;
    public UniqueId idOfSpawnedPickup;

    public SpawnPickupComponent()
    {
    }

    public SpawnPickupComponent(JVector position, PickupType type, UniqueId idOfSpawnedPickup)
    {
      this.position = position;
      this.type = type;
      this.idOfSpawnedPickup = idOfSpawnedPickup;
    }
  }
}
