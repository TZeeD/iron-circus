// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.VirtualMotionStrikeFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class VirtualMotionStrikeFX : MonoBehaviour, IAoeVfx, IVfx
  {
    [SerializeField]
    private ParticleSystem particles;
    [SerializeField]
    private AreaOfEffect aoe;

    public void SetAoe(AreaOfEffect aoe)
    {
      this.aoe = aoe;
      this.UpdateVfxForAoe();
    }

    private void UpdateVfxForAoe() => this.particles.shape.radius = this.aoe.radius;

    public void SetOwner(GameEntity entity) => this.particles.main.startColor = (ParticleSystem.MinMaxGradient) SingletonScriptableObject<ColorsConfig>.Instance.LightColor(entity.playerTeam.value);

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }
  }
}
