// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.GoalAnimations.Base.GoalAnimationWithTeamColors
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace SteelCircus.FX.GoalAnimations.Base
{
  public abstract class GoalAnimationWithTeamColors : GoalAnimationBase
  {
    [SerializeField]
    protected Renderer[] teamColorRenderers;
    [SerializeField]
    protected ParticleSystem[] teamColorParticles;
    protected static readonly int _Color = Shader.PropertyToID(nameof (_Color));
    protected static readonly int _TextColor = Shader.PropertyToID("_FaceColor");

    protected override void SetScoringTeamInternal(Team team)
    {
      Color color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(team);
      foreach (Renderer teamColorRenderer in this.teamColorRenderers)
      {
        if (teamColorRenderer.material.HasProperty(GoalAnimationWithTeamColors._Color))
          teamColorRenderer.material.SetColor(GoalAnimationWithTeamColors._Color, color);
        if (teamColorRenderer.material.HasProperty(GoalAnimationWithTeamColors._TextColor))
          teamColorRenderer.material.SetColor(GoalAnimationWithTeamColors._TextColor, color);
      }
      foreach (ParticleSystem teamColorParticle in this.teamColorParticles)
        teamColorParticle.main.startColor = (ParticleSystem.MinMaxGradient) color;
    }
  }
}
