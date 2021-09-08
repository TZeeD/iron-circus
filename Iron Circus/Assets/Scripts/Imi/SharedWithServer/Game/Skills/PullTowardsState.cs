// Decompiled with JetBrains decompiler
// Type: Imi.SharedWithServer.Game.Skills.PullTowardsState
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.ScEntitas.Components;
using Imi.Utils.Extensions;
using Jitter.LinearMath;

namespace Imi.SharedWithServer.Game.Skills
{
  public class PullTowardsState : SkillState
  {
    public SyncableValue<JVector> moveTowards;
    public SyncableValue<float> pullSpeed;
    public SyncableValue<float> radius;
    public SkillVar<UniqueId> targetEntities;

    protected override SkillStateExecutionFlag SkillStateExecutionFlag => SkillStateExecutionFlag.TickRemoteEntities;

    protected override void TickDerived()
    {
      for (int i = 0; i < this.targetEntities.Length; ++i)
      {
        GameEntity entity = this.skillGraph.GetEntity(this.targetEntities[i]);
        if (entity != null && entity.hasTransform && entity.hasVelocityOverride && entity.hasChampionConfig)
        {
          JVector vector = (JVector) this.moveTowards - entity.transform.position;
          JVector jvector = vector.Normalized();
          float num1 = (float) this.pullSpeed * this.skillGraph.GetFixedTimeStep();
          float num2 = vector.Length() - (float) this.radius - entity.championConfig.value.colliderRadius;
          float pullSpeed = (float) this.pullSpeed;
          if ((double) num2 > 0.0)
          {
            if ((double) num1 > (double) num2)
              pullSpeed *= num2 / num1;
            entity.AddMovementModifier(MovementModifier.AddVelocity(jvector * pullSpeed));
          }
        }
      }
    }
  }
}
