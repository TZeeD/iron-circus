// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.SpawnProjectileAction
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.ScEntitas.Components;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.Game.Skills
{
  public class SpawnProjectileAction : SkillAction
  {
    public ConfigValue<ProjectileType> type;
    public ConfigValue<JVector> velocity;
    public ConfigValue<float> projectileSize;
    public ConfigValue<AreaOfEffect> aoe;
    public ConfigValue<int> aoeDamage;
    public ConfigValue<float> aoePushback;

    public SpawnProjectileAction(SkillGraph skillGraph, string name = "unnamed")
      : base(skillGraph, name)
    {
    }

    protected override void PerformActionInternal()
    {
      GameEntity owner = this.skillGraph.GetOwner();
      JVector position = owner.transform.position;
      position.Y = 1.5f;
      ProjectileImpactEffect impactEffect = new ProjectileImpactEffect(this.aoe.Get(), this.aoeDamage.Get(), this.aoePushback.Get());
      GameEntity projectile = this.skillGraph.GetEntityFactory().CreateProjectile(owner.playerId.value, this.type.Get(), this.projectileSize.Get(), 0.5f, position, owner.transform.rotation, this.velocity.Get(), impactEffect);
      if (projectile == null)
        return;
      this.skillGraph.GetContext().gamePhysics.world.AddBody(projectile.rigidbody.value);
    }
  }
}
