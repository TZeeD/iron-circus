// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.VirtualMotionFloorFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class VirtualMotionFloorFX : MonoBehaviour, IVfx
  {
    [SerializeField]
    private ParticleSystem particles;

    public void SetOwner(GameEntity entity) => this.particles.main.startColor = (ParticleSystem.MinMaxGradient) (entity.playerTeam.value == Team.Alpha ? SingletonScriptableObject<ColorsConfig>.Instance.team1ColorMiddle : SingletonScriptableObject<ColorsConfig>.Instance.team2ColorMiddle);

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }
  }
}
