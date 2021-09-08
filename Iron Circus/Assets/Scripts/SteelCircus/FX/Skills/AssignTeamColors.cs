// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.AssignTeamColors
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class AssignTeamColors : MonoBehaviour, IVfx
  {
    [SerializeField]
    private AssignTeamColors.TeamColor color;
    [SerializeField]
    private Renderer[] renderers;
    [SerializeField]
    private ParticleSystem[] particleSystems;
    protected static readonly int _Color = Shader.PropertyToID(nameof (_Color));

    public void SetOwner(GameEntity entity)
    {
      ColorsConfig instance = SingletonScriptableObject<ColorsConfig>.Instance;
      Color color = Color.magenta;
      switch (this.color)
      {
        case AssignTeamColors.TeamColor.Dark:
          color = instance.DarkColor(entity.playerTeam.value);
          break;
        case AssignTeamColors.TeamColor.Middle:
          color = instance.MiddleColor(entity.playerTeam.value);
          break;
        case AssignTeamColors.TeamColor.Light:
          color = instance.LightColor(entity.playerTeam.value);
          break;
        case AssignTeamColors.TeamColor.MiddleHdr:
          color = instance.MiddleColorHdr(entity.playerTeam.value);
          break;
        case AssignTeamColors.TeamColor.DarkAoe:
          color = instance.DarkAoeColor(entity.playerTeam.value);
          break;
        case AssignTeamColors.TeamColor.MiddleAoe:
          color = instance.MiddleAoeColor(entity.playerTeam.value);
          break;
      }
      foreach (Renderer renderer in this.renderers)
        renderer.material.SetColor(AssignTeamColors._Color, color);
      foreach (ParticleSystem particleSystem in this.particleSystems)
        particleSystem.main.startColor = (ParticleSystem.MinMaxGradient) color;
    }

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }

    private enum TeamColor
    {
      Dark,
      Middle,
      Light,
      MiddleHdr,
      DarkAoe,
      MiddleAoe,
    }
  }
}
