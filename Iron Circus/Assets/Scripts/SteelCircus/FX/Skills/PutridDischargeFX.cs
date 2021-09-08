// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.PutridDischargeFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.ScriptableObjects;
using Imi.SteelCircus.Utils.Extensions;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class PutridDischargeFX : MonoBehaviour, IVfxWithDeferredStop, IVfx
  {
    [SerializeField]
    private float buildUpDuration = 0.3f;
    [SerializeField]
    private float buildUpDelay;
    [SerializeField]
    private float breakDownDuration = 0.3f;
    [SerializeField]
    private MeshRenderer puddleRenderer;
    [SerializeField]
    private ParticleSystem particles;
    [SerializeField]
    private AreaOfEffect aoe;
    [SerializeField]
    private float fringeSize = 0.5f;
    private float buildUpCounter;
    private float breakDownCounter;
    private Material puddleMaterial;
    private float startTime;
    private float particleDuration;
    private static readonly int _BuildUp = Shader.PropertyToID(nameof (_BuildUp));
    private static readonly int _AlphaThreshold = Shader.PropertyToID(nameof (_AlphaThreshold));

    public void SetOwner(GameEntity entity)
    {
      Color color1 = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(entity.playerTeam.value);
      Color color2 = this.puddleRenderer.material.color;
      color1.a = color2.a;
      this.puddleRenderer.material.color = color1;
      this.puddleMaterial = this.puddleRenderer.material;
      Renderer component = this.particles.GetComponent<Renderer>();
      Color color3 = component.material.color;
      color1.a = color3.a;
      component.material.color = color1;
      this.puddleMaterial.SetFloat(PutridDischargeFX._BuildUp, 0.0f);
      this.puddleMaterial.SetFloat(PutridDischargeFX._AlphaThreshold, 1f);
      this.startTime = Time.time;
      this.buildUpCounter = -this.buildUpDelay;
    }

    public void SetArgs(object args)
    {
      this.aoe = (AreaOfEffect) args;
      Mesh mesh = this.puddleRenderer.GetComponent<MeshFilter>().mesh;
      Vector3[] vertices = mesh.vertices;
      Vector2 vector2_1 = new Vector2(0.0f, 1f).Rotate((float) (-(double) this.aoe.angle * 0.5));
      Vector2 vector2_2 = vector2_1 * this.aoe.deadZone;
      Vector2 vector2_3 = vector2_1 * this.aoe.radius;
      float num = this.aoe.radius - this.aoe.deadZone;
      vector2_2.y -= this.aoe.deadZone + num * 0.5f;
      vector2_3.y -= this.aoe.deadZone + num * 0.5f;
      vertices[0] = new Vector3(-vector2_2.x, 0.0f, vector2_2.y);
      vertices[1] = new Vector3(-vector2_3.x, 0.0f, vector2_3.y);
      vertices[2] = new Vector3(vector2_3.x, 0.0f, vector2_3.y);
      vertices[3] = new Vector3(vector2_2.x, 0.0f, vector2_2.y);
      vertices[0] = vertices[0] + new Vector3(-this.fringeSize, 0.0f, -this.fringeSize);
      vertices[1] = vertices[1] + new Vector3(-this.fringeSize, 0.0f, this.fringeSize);
      vertices[2] = vertices[2] + new Vector3(this.fringeSize, 0.0f, this.fringeSize);
      vertices[3] = vertices[3] + new Vector3(this.fringeSize, 0.0f, -this.fringeSize);
      mesh.vertices = vertices;
      mesh.RecalculateTangents();
      mesh.RecalculateBounds();
      this.puddleRenderer.GetComponent<MeshFilter>().mesh = mesh;
    }

    public void SetSkillGraph(SkillGraph graph)
    {
      float num = 1.5f;
      this.particleDuration = ((PutridDischargeConfig) graph.GetConfig()).duration - num + this.breakDownDuration;
    }

    public void OnStopRequested() => this.breakDownCounter = this.breakDownDuration;

    private void Update()
    {
      this.particles.emission.enabled = (double) Time.time < (double) this.startTime + (double) this.particleDuration && (double) this.buildUpCounter > 0.0;
      if ((double) this.buildUpCounter < (double) this.buildUpDuration)
      {
        this.buildUpCounter += Time.deltaTime;
        this.buildUpCounter = Mathf.Min(this.buildUpCounter, this.buildUpDuration);
        this.puddleMaterial.SetFloat(PutridDischargeFX._BuildUp, Mathf.Clamp01(this.buildUpCounter / this.buildUpDuration));
        this.puddleMaterial.SetFloat(PutridDischargeFX._AlphaThreshold, 0.01f);
      }
      if ((double) this.breakDownCounter == 0.0)
        return;
      this.breakDownCounter -= Time.deltaTime;
      this.breakDownCounter = Mathf.Max(this.breakDownCounter, 0.0f);
      this.puddleMaterial.SetFloat(PutridDischargeFX._AlphaThreshold, Mathf.Clamp01((float) (1.0 - (double) this.breakDownCounter / (double) this.breakDownDuration + 0.00999999977648258)));
      if ((double) this.breakDownCounter != 0.0)
        return;
      VfxManager.ReturnToPool(this.gameObject);
    }
  }
}
