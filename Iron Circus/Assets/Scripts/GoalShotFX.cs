// Decompiled with JetBrains decompiler
// Type: GoalShotFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SteelCircus.ScriptableObjects;
using SharedWithServer.ScEvents;
using UnityEngine;

public class GoalShotFX : MonoBehaviour
{
  public float lifeTime = 3f;
  private float lifeTimeCounter;
  public float flashAndGlowDuration = 1f;
  private float flashAndGlowCounter;
  [SerializeField]
  private GameObject fxParent;
  [SerializeField]
  private MeshRenderer flashRenderer;
  [SerializeField]
  private MeshRenderer glowRenderer;
  public int numConfettiParticles = 50;
  [SerializeField]
  private ParticleSystem[] confettiParticles;
  public int numGoalParticles = 80;
  [SerializeField]
  private ParticleSystem goalParticles;
  public Team team = Team.Alpha;
  private Material flashMaterial;
  private Material glowMaterial;

  private void Awake()
  {
    this.flashMaterial = this.flashRenderer.material;
    this.glowMaterial = this.glowRenderer.material;
    this.flashAndGlowCounter = 1f;
    this.lifeTimeCounter = 1f;
    this.SetColors(this.team == Team.Alpha ? SingletonScriptableObject<ColorsConfig>.Instance.team1ColorGoal : SingletonScriptableObject<ColorsConfig>.Instance.team2ColorGoal);
    this.fxParent.SetActive(false);
    Events.Global.OnEventMatchStateChanged += new Events.EventMatchStateChanged(this.OnMatchStateChangedEvent);
  }

  private void OnDestroy() => Events.Global.OnEventMatchStateChanged -= new Events.EventMatchStateChanged(this.OnMatchStateChangedEvent);

  private void OnMatchStateChangedEvent(
    Imi.SharedWithServer.Game.MatchState matchState,
    float cutsceneDuration,
    float remainingMatchTime)
  {
    if (matchState != Imi.SharedWithServer.Game.MatchState.Goal || this.team != Contexts.sharedInstance.game.score.lastTeamThatScored)
      return;
    this.StartFX();
  }

  private void SetColors(Color col)
  {
    this.flashMaterial.color = col;
    this.glowMaterial.color = col;
    this.goalParticles.main.startColor = (ParticleSystem.MinMaxGradient) col;
    foreach (ParticleSystem confettiParticle in this.confettiParticles)
      confettiParticle.main.startColor = new ParticleSystem.MinMaxGradient(Color.white, col);
  }

  [ContextMenu("Start FX")]
  public void StartFX()
  {
    this.flashAndGlowCounter = 0.0f;
    this.lifeTimeCounter = 0.0f;
    foreach (ParticleSystem confettiParticle in this.confettiParticles)
      confettiParticle.Emit(this.numConfettiParticles);
    this.goalParticles.Emit(this.numGoalParticles);
    this.fxParent.SetActive(true);
  }

  private void Update()
  {
    this.flashAndGlowCounter = Mathf.Clamp01(this.flashAndGlowCounter + Time.deltaTime / this.flashAndGlowDuration);
    this.flashMaterial.SetFloat("_Opacity", 1f - Mathf.Pow(this.flashAndGlowCounter, 2f));
    this.glowMaterial.SetFloat("_AnimationTime", Mathf.Pow(this.flashAndGlowCounter, 3f));
    this.lifeTimeCounter += Time.deltaTime;
    if ((double) this.lifeTimeCounter < (double) this.lifeTime)
      return;
    this.fxParent.SetActive(false);
  }
}
