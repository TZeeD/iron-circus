// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.KennyDeathFromAboveSmokeTrailFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class KennyDeathFromAboveSmokeTrailFX : MonoBehaviour, IVfx
  {
    [SerializeField]
    private ParticleSystem particles;
    [SerializeField]
    private Transform movingTransform;
    [SerializeField]
    private float totalDuration = 1f;
    [SerializeField]
    private float totalDelay;
    [SerializeField]
    private float particlesDuration = 1f;
    [SerializeField]
    private float particlesYMoveDistance = 10f;
    [SerializeField]
    private AnimationCurve particlesYMoveCurve = AnimationCurve.Linear(0.0f, 0.0f, 1f, 1f);
    private float counter;

    private void Awake() => this.particles.emission.enabled = false;

    public void SetOwner(GameEntity entity)
    {
    }

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }

    private void Update()
    {
      this.counter += Time.deltaTime;
      float time = Mathf.Clamp01((this.counter - this.totalDelay) / this.particlesDuration);
      this.particles.emission.enabled = (double) time > 0.0 && (double) time < 1.0;
      Vector3 position = this.movingTransform.position;
      position.y = this.particlesYMoveCurve.Evaluate(time) * this.particlesYMoveDistance;
      this.movingTransform.position = position;
      if ((double) this.counter < (double) this.totalDuration)
        return;
      VfxManager.ReturnToPool(this.gameObject);
    }
  }
}
