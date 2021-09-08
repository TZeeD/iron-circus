// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.VirtualSwapEnemyFloorParticlesFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.Utils;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class VirtualSwapEnemyFloorParticlesFX : MonoBehaviour, IVfx
  {
    private Vector3 startPos;
    private Vector3 endPos;
    private float duration;
    [SerializeField]
    private float emissionEaseCurve = 1f;
    [SerializeField]
    private ParticleSystem normalParticles;
    [SerializeField]
    private ParticleSystem emissiveParticles;
    [SerializeField]
    private ParticleSystem inAirParticles;
    [SerializeField]
    private float emissionRateNormals = 80f;
    [SerializeField]
    private float scatterRadiusNormals = 1f;
    private int emittedParticlesNormals;
    [SerializeField]
    private float emissionRateEmissive = 80f;
    [SerializeField]
    private float scatterRadiusEmissive = 1f;
    private int emittedParticlesEmissive;
    [SerializeField]
    private float emissionRateInAir = 80f;
    [SerializeField]
    private float scatterRadiusInAir = 1f;
    private int emittedParticlesInAir;
    private float counter;

    private void Update()
    {
      this.counter = Mathf.Clamp01(this.counter + Time.deltaTime / this.duration);
      if ((double) this.counter == 1.0)
        return;
      this.UpdateEmission(this.normalParticles, ref this.emittedParticlesNormals, this.emissionRateNormals, this.scatterRadiusNormals);
      this.UpdateEmission(this.emissiveParticles, ref this.emittedParticlesEmissive, this.emissionRateEmissive, this.scatterRadiusEmissive);
      this.UpdateEmission(this.inAirParticles, ref this.emittedParticlesInAir, this.emissionRateInAir, this.scatterRadiusInAir);
    }

    private void UpdateEmission(
      ParticleSystem particleSystem,
      ref int emittedCount,
      float emissionRate,
      float scatterRadius)
    {
      while ((double) emittedCount < (double) emissionRate * (double) this.counter * (double) this.duration)
      {
        Vector3 vector3_1 = Vector3.Lerp(this.startPos, this.endPos, Mathf.Pow((float) emittedCount / (this.duration * emissionRate), this.emissionEaseCurve));
        ++emittedCount;
        ParticleSystem.EmitParams emitParams = new ParticleSystem.EmitParams();
        Vector2 vector2 = MathUtils.RandomVector2() * scatterRadius;
        Vector3 vector3_2 = new Vector3(vector2.x, 0.0f, vector2.y);
        Vector3 vector3_3 = vector3_1 + vector3_2;
        emitParams.position = vector3_3;
        particleSystem.Emit(emitParams, 1);
      }
    }

    public void SetOwner(GameEntity entity)
    {
      Color color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(entity.playerTeam.value);
      this.emissiveParticles.main.startColor = (ParticleSystem.MinMaxGradient) color;
      this.inAirParticles.main.startColor = (ParticleSystem.MinMaxGradient) color;
    }

    public void SetArgs(object args)
    {
      if (args == null)
        return;
      VirtualSwapConfig.FloorSwapFxArgs floorSwapFxArgs = (VirtualSwapConfig.FloorSwapFxArgs) args;
      this.startPos = floorSwapFxArgs.startPos.ToVector3();
      this.endPos = floorSwapFxArgs.endPos.ToVector3();
      this.duration = floorSwapFxArgs.duration;
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }
  }
}
