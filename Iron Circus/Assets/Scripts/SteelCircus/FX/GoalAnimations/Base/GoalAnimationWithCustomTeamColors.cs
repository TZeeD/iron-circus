// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.GoalAnimations.Base.GoalAnimationWithCustomTeamColors
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using System;
using UnityEngine;

namespace SteelCircus.FX.GoalAnimations.Base
{
  public abstract class GoalAnimationWithCustomTeamColors : GoalAnimationBase
  {
    [SerializeField]
    public GoalAnimationWithCustomTeamColors.CustomTeamColor[] colors;
    protected static readonly int _Color = Shader.PropertyToID(nameof (_Color));
    protected static readonly int _TextColor = Shader.PropertyToID("_FaceColor");
    protected static readonly int _OutlineColor = Shader.PropertyToID(nameof (_OutlineColor));
    protected static readonly int _GlowColor = Shader.PropertyToID(nameof (_GlowColor));

    protected override void SetScoringTeamInternal(Team team)
    {
      foreach (GoalAnimationWithCustomTeamColors.CustomTeamColor color1 in this.colors)
      {
        Renderer[] teamColorRenderers = color1.teamColorRenderers;
        Color color2 = team == Team.Alpha ? color1.teamAlphaColor : color1.teamBetaColor;
        foreach (Renderer renderer in teamColorRenderers)
        {
          if ((color1.attributes & GoalAnimationWithCustomTeamColors.Attributes.MainColor) != (GoalAnimationWithCustomTeamColors.Attributes) 0 && renderer.material.HasProperty(GoalAnimationWithCustomTeamColors._Color))
            renderer.material.SetColor(GoalAnimationWithCustomTeamColors._Color, color2);
          if ((color1.attributes & GoalAnimationWithCustomTeamColors.Attributes.TextColor) != (GoalAnimationWithCustomTeamColors.Attributes) 0 && renderer.material.HasProperty(GoalAnimationWithCustomTeamColors._TextColor))
            renderer.material.SetColor(GoalAnimationWithCustomTeamColors._TextColor, color2);
          if ((color1.attributes & GoalAnimationWithCustomTeamColors.Attributes.OutlineColor) != (GoalAnimationWithCustomTeamColors.Attributes) 0 && renderer.material.HasProperty(GoalAnimationWithCustomTeamColors._OutlineColor))
            renderer.material.SetColor(GoalAnimationWithCustomTeamColors._OutlineColor, color2);
          if ((color1.attributes & GoalAnimationWithCustomTeamColors.Attributes.OutlineColor) != (GoalAnimationWithCustomTeamColors.Attributes) 0 && renderer.material.HasProperty(GoalAnimationWithCustomTeamColors._GlowColor))
            renderer.material.SetColor(GoalAnimationWithCustomTeamColors._GlowColor, color2);
        }
      }
    }

    [System.Flags]
    public enum Attributes
    {
      MainColor = 1,
      TextColor = 2,
      OutlineColor = 4,
      GlowColor = OutlineColor, // 0x00000004
    }

    [Serializable]
    public class CustomTeamColor
    {
      public Renderer[] teamColorRenderers;
      public Color teamAlphaColor = new Color(1f, 0.8f, 0.6f, 1f);
      public Color teamBetaColor = new Color(0.6f, 0.8f, 1f, 1f);
      public GoalAnimationWithCustomTeamColors.Attributes attributes = GoalAnimationWithCustomTeamColors.Attributes.MainColor;
    }
  }
}
