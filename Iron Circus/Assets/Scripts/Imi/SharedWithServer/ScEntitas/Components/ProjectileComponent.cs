// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.ScEntitas.Components.ProjectileComponent
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;

namespace Imi.SharedWithServer.ScEntitas.Components
{
  [Game]
  public class ProjectileComponent : ImiComponent
  {
    public ProjectileType projectileType;
    public ulong owner;
    public ProjectileImpactEffect projectileImpactEffect;
    public float spinSpeed;
    public int bounceOnImpact;
    public int bounces;
    public float lifeTimeLimit;
    public float timeAlive;
    public float maxTravelDistance;
    public float traveledDistance;
    public Action<ImpactParameters> onImpact;
    public Action onDestroy;
  }
}
