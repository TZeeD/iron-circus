// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.Floor.FloorEffectBase
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace SteelCircus.FX.Skills.Floor
{
  public class FloorEffectBase : MonoBehaviour, IVfx
  {
    [SerializeField]
    protected Transform[] scaleNodes;
    protected const float outlineWidth = 0.07f;
    protected static readonly int _ColorOutlineBG = Shader.PropertyToID(nameof (_ColorOutlineBG));
    protected static readonly int _ColorOutlineFG = Shader.PropertyToID(nameof (_ColorOutlineFG));
    protected static readonly int _ColorMiddle = Shader.PropertyToID(nameof (_ColorMiddle));
    protected static readonly int _ColorDark = Shader.PropertyToID(nameof (_ColorDark));
    protected static readonly int _ColorBuildupBG = Shader.PropertyToID(nameof (_ColorBuildupBG));
    protected static readonly int _BuildupBGTime = Shader.PropertyToID(nameof (_BuildupBGTime));
    protected float buildupDuration = 0.2f;
    protected float buildupCounter;
    protected Material[] materials;
    protected SkillGraph skillGraph;

    protected virtual void Awake()
    {
      this.GatherMaterials();
      this.buildupCounter = 0.0f;
    }

    protected void GatherMaterials()
    {
      Renderer[] componentsInChildren = this.GetComponentsInChildren<Renderer>(true);
      this.materials = new Material[componentsInChildren.Length];
      for (int index = 0; index < componentsInChildren.Length; ++index)
      {
        Renderer renderer = componentsInChildren[index];
        this.materials[index] = renderer.material;
      }
    }

    protected virtual void Update()
    {
      if ((double) this.buildupCounter >= 1.0)
        return;
      this.buildupCounter = Mathf.Clamp01(this.buildupCounter + Time.deltaTime / this.buildupDuration);
      this.SetPropertyIfExists(FloorEffectBase._BuildupBGTime, this.buildupCounter);
    }

    protected void SetPropertyIfExists(int propID, Color value)
    {
      foreach (Material material in this.materials)
      {
        if (material.HasProperty(propID))
          material.SetColor(propID, value);
      }
    }

    protected void SetPropertyIfExists(int propID, float value)
    {
      foreach (Material material in this.materials)
      {
        if (material.HasProperty(propID))
          material.SetFloat(propID, value);
      }
    }

    public virtual void SetOwner(GameEntity entity)
    {
      Team team = entity.playerTeam.value;
      ColorsConfig instance = SingletonScriptableObject<ColorsConfig>.Instance;
      this.SetPropertyIfExists(FloorEffectBase._ColorOutlineBG, instance.OutlineBGAoeColor(team));
      this.SetPropertyIfExists(FloorEffectBase._ColorOutlineFG, instance.OutlineFGAoeColor(team));
      this.SetPropertyIfExists(FloorEffectBase._ColorMiddle, instance.MiddleAoeColor(team));
      this.SetPropertyIfExists(FloorEffectBase._ColorDark, instance.DarkAoeColor(team));
      this.SetPropertyIfExists(FloorEffectBase._BuildupBGTime, 0.0f);
      this.SetPropertyIfExists(FloorEffectBase._ColorBuildupBG, instance.aoeColorDamage);
    }

    public virtual void SetSkillGraph(SkillGraph graph) => this.skillGraph = graph;

    public virtual void SetArgs(object args)
    {
    }
  }
}
