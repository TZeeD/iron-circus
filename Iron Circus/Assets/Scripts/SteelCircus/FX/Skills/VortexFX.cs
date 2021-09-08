// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.VortexFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.Core;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.ScriptableObjects;
using Imi.Utils.Common;
using Jitter.LinearMath;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class VortexFX : MonoBehaviour, IVfx
  {
    public Transform[] marbles;
    public float parabolaHeight;
    public float marbleRadiansPerSecond = 6.28f;
    public float marbleYHoverFrequency = 1f;
    public float marbleYHoverCenterHeight = 1f;
    public float marbleYHoverAmplitude = 0.5f;
    public float marbleXZHoverFrequency = 2f;
    public float marbleXZHoverCenterHeight = 0.8f;
    public float marbleXZHoverAmplitude = 0.2f;
    public float marbleSpreadOutDuration = 0.25f;
    public GameObject maelstroemEffect;
    public ParticleSystem rings;
    public ParticleSystem sparks;
    public GameObject floorAoe;
    public Renderer floorAoeRenderer;
    public float floorAoeAlpha;
    public float floorAoeTilingAlpha;
    public float floorAoeTilingFadeDuration = 0.3f;
    private Material floorMaterial;
    [Readonly]
    public Vector3 startPos;
    [Readonly]
    public Vector3 implosionPosition;
    [Readonly]
    public float flightDuration;
    [Readonly]
    public float activationDuration;
    [Readonly]
    public float effectDuration;
    [Readonly]
    public float range;
    [Readonly]
    public float currentT;
    private GameEntity owner;
    private SkillGraph skillGraph;
    private VortexConfig config;
    private static readonly int _ColorOutlineFG = Shader.PropertyToID(nameof (_ColorOutlineFG));
    private static readonly int _ColorMiddle = Shader.PropertyToID(nameof (_ColorMiddle));
    private static readonly int _ColorDark = Shader.PropertyToID(nameof (_ColorDark));
    private static readonly int _TilingOpacity = Shader.PropertyToID(nameof (_TilingOpacity));

    public void SetSkillGraph(SkillGraph graph)
    {
      this.skillGraph = graph;
      this.config = (VortexConfig) this.skillGraph.GetConfig();
    }

    public void SetOwner(GameEntity entity)
    {
      this.owner = entity;
      this.startPos = entity.unityView.gameObject.transform.position;
      this.effectDuration = this.config.pullDuration;
      this.flightDuration = this.config.throwDuration;
      this.range = this.config.aoe.radius;
      this.activationDuration = this.config.activationDuration;
      this.implosionPosition = this.skillGraph.GetValue<JVector>("ImplosionPosition").ToVector3();
      ParticleSystem.MainModule main = this.rings.main;
      Team team = entity.playerTeam.value;
      main.startColor = (ParticleSystem.MinMaxGradient) StartupSetup.Colors.MiddleColor(team);
      this.sparks.shape.radius = this.range;
      this.floorAoeRenderer.transform.localScale = Vector3.one * (this.range * 2f);
      this.floorMaterial = this.floorAoeRenderer.material;
      this.floorMaterial.SetColor(VortexFX._ColorOutlineFG, SingletonScriptableObject<ColorsConfig>.Instance.DarkColor(team));
      this.floorMaterial.SetColor(VortexFX._ColorMiddle, SingletonScriptableObject<ColorsConfig>.Instance.MiddleColor(team));
      Color color = SingletonScriptableObject<ColorsConfig>.Instance.DarkColor(team);
      color.a = this.floorAoeAlpha;
      this.floorMaterial.SetColor(VortexFX._ColorDark, color);
      this.floorMaterial.SetFloat(VortexFX._TilingOpacity, 1f);
      this.floorAoeRenderer.enabled = false;
    }

    private void Update()
    {
      float currentT = this.currentT;
      this.currentT += Time.deltaTime;
      float t1 = Mathf.Clamp01(this.currentT / this.flightDuration);
      Vector3 vector3_1 = Vector3.Lerp(this.startPos, this.implosionPosition, t1);
      vector3_1.y = 0.0f;
      this.transform.position = vector3_1;
      float y = Mathf.Sin(t1 * 3.141593f) * this.parabolaHeight;
      Vector3 a = new Vector3(vector3_1.x, y, vector3_1.z);
      float t2 = Mathf.Min(Mathf.Clamp01((this.currentT - this.flightDuration) / this.marbleSpreadOutDuration), 1f - Mathf.Clamp01((this.currentT - (this.flightDuration + this.activationDuration + this.effectDuration - this.marbleSpreadOutDuration)) / this.marbleSpreadOutDuration));
      for (int index = 0; index < this.marbles.Length; ++index)
      {
        Transform marble = this.marbles[index];
        float f = (float) ((double) index * 3.14159274101257 * 2.0 / (double) this.marbles.Length + (double) this.marbleRadiansPerSecond * (double) this.currentT);
        float num1 = Mathf.Sin((float) ((double) index * 3.14159274101257 * 2.0 / (double) this.marbles.Length + (double) this.marbleYHoverFrequency * 3.14159274101257 * 2.0 * (double) this.currentT)) * this.marbleYHoverAmplitude + this.marbleYHoverCenterHeight;
        Vector3 b = new Vector3(Mathf.Sin(f), 0.0f, Mathf.Cos(f));
        float num2 = Mathf.Cos((float) ((double) index * 3.14159274101257 * 2.0 / (double) this.marbles.Length + (double) this.marbleXZHoverFrequency * 3.14159274101257 * 2.0 * (double) this.currentT));
        Vector3 vector3_2 = b * ((num2 * this.marbleXZHoverAmplitude + this.marbleXZHoverCenterHeight) * this.range);
        vector3_2.y = num1;
        b = vector3_2 + vector3_1;
        Vector3 vector3_3 = Vector3.Lerp(a, b, t2);
        marble.position = vector3_3;
      }
      if ((double) this.currentT > (double) this.flightDuration && (double) this.currentT < (double) this.flightDuration + (double) this.activationDuration)
      {
        if ((bool) (Object) this.maelstroemEffect && !this.maelstroemEffect.activeSelf)
        {
          this.maelstroemEffect.SetActive(true);
          this.floorAoeRenderer.enabled = true;
        }
      }
      else if ((double) this.currentT > (double) this.flightDuration + (double) this.activationDuration + (double) this.effectDuration)
      {
        if ((double) currentT <= (double) this.flightDuration + (double) this.activationDuration + (double) this.effectDuration)
        {
          this.rings.Stop();
          this.sparks.Stop();
          Object.Destroy((Object) this.floorAoe);
          for (int index = 0; index < this.marbles.Length; ++index)
            this.marbles[index].gameObject.SetActive(false);
        }
        if ((double) this.currentT > (double) this.flightDuration + (double) this.activationDuration + (double) this.effectDuration + 2.0)
          VfxManager.ReturnToPool(this.gameObject);
      }
      if ((double) this.currentT > (double) this.flightDuration + (double) this.activationDuration + (double) this.effectDuration)
        return;
      float num = Mathf.Lerp(1f, this.floorAoeTilingAlpha, Mathf.Min(Mathf.Clamp01((this.currentT - this.flightDuration) / this.floorAoeTilingFadeDuration), Mathf.Clamp01((float) (1.0 - ((double) this.currentT - ((double) (this.flightDuration + this.activationDuration + this.effectDuration) - (double) this.floorAoeTilingFadeDuration)) / (double) this.floorAoeTilingFadeDuration))));
      this.floorMaterial.SetFloat(VortexFX._TilingOpacity, num);
    }

    public void SetArgs(object args)
    {
    }
  }
}
