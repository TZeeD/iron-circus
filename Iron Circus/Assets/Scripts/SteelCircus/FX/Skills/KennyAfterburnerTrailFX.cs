// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.KennyAfterburnerTrailFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.ScriptableObjects;
using Jitter.LinearMath;
using SteelCircus.Core;
using System.Collections.Generic;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class KennyAfterburnerTrailFX : MonoBehaviour, IVfx
  {
    [SerializeField]
    private GameObject fireFXPrefab;
    [SerializeField]
    private Texture2D teamAlphaFireRamp;
    [SerializeField]
    private Texture2D teamBetaFireRamp;
    private Texture2D rampTex;
    private Color glowColor;
    private Material material;
    private float radius;
    private SkillVar<JVector> positions;
    private SkillVar<JVector> lookDirs;
    private List<GameObject> instances;
    private static ParticleSystem.Particle[] particles = new ParticleSystem.Particle[500];

    private void Awake() => this.instances = new List<GameObject>(8);

    public void SetOwner(GameEntity entity)
    {
      this.rampTex = entity.playerTeam.value == Team.Alpha ? this.teamAlphaFireRamp : this.teamBetaFireRamp;
      this.glowColor = SingletonScriptableObject<ColorsConfig>.Instance.DarkColor(entity.playerTeam.value);
    }

    public void SetArgs(object args)
    {
      AfterBurner.FireArgs fireArgs = (AfterBurner.FireArgs) args;
      this.positions = fireArgs.positions;
      this.lookDirs = fireArgs.lookDirs;
      this.radius = fireArgs.radius;
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }

    private void Update()
    {
      for (int count = this.instances.Count; count < this.positions.Length; ++count)
        this.CreateFire(this.positions[count].ToVector3(), this.lookDirs[count].ToVector3());
    }

    private void CreateFire(Vector3 position, Vector3 lookDir)
    {
      GameObject go = Object.Instantiate<GameObject>(this.fireFXPrefab);
      MatchObjectsParent.Add(go);
      go.transform.position = position;
      go.transform.LookAt(lookDir);
      KennyAfterBurnerFlameFX component1 = go.GetComponent<KennyAfterBurnerFlameFX>();
      Renderer component2 = component1.MainParticles.GetComponent<Renderer>();
      if (this.instances.Count == 0)
      {
        this.material = component2.material;
        this.material.SetTexture("_ColorRamp", (Texture) this.rampTex);
      }
      component2.sharedMaterial = this.material;
      component1.MainParticles.shape.radius = this.radius;
      ParticleSystem.MainModule main = component1.GlowParticles.main;
      main.startColor = (ParticleSystem.MinMaxGradient) this.glowColor;
      main = component1.SootParticles.main;
      main.startColor = (ParticleSystem.MinMaxGradient) this.glowColor;
      component1.MainParticles.Simulate(0.5f);
      component1.MainParticles.Play(true);
      this.instances.Add(go);
    }

    private void OnDestroy()
    {
      for (int index = 0; index < this.instances.Count; ++index)
      {
        KennyAfterBurnerFlameFX component = this.instances[index].GetComponent<KennyAfterBurnerFlameFX>();
        this.DeactivateParticles(component.MainParticles, 0.2f, 0.4f);
        this.DeactivateParticles(component.GlowParticles, 0.15f, 0.3f);
        this.DeactivateParticles(component.SootParticles, 0.5f, 0.7f);
        Object.Destroy((Object) component.gameObject, 1f);
      }
    }

    private void DeactivateParticles(
      ParticleSystem system,
      float remainingLifeMin,
      float remainingLifeMax)
    {
      system.emission.rateOverTime = (ParticleSystem.MinMaxCurve) 0.0f;
      system.main.loop = false;
      int particles = system.GetParticles(KennyAfterburnerTrailFX.particles);
      for (int index = 0; index < particles; ++index)
      {
        ParticleSystem.Particle particle = KennyAfterburnerTrailFX.particles[index];
        particle.remainingLifetime = Random.Range(remainingLifeMin, remainingLifeMax);
        particle.startLifetime = 1f;
        KennyAfterburnerTrailFX.particles[index] = particle;
      }
      system.SetParticles(KennyAfterburnerTrailFX.particles, particles);
    }
  }
}
