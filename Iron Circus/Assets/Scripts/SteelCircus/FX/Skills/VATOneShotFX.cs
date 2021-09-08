// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.VATOneShotFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.Game;
using Imi.SharedWithServer.Game.Skills;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class VATOneShotFX : MonoBehaviour, IVfx
  {
    protected static readonly int _VATTime = Shader.PropertyToID(nameof (_VATTime));
    [SerializeField]
    protected float duration = 1f;
    [SerializeField]
    protected float delay;
    [SerializeField]
    protected Color teamAlphaColor = Color.white;
    [SerializeField]
    protected Color teamBetaColor = Color.white;
    [SerializeField]
    protected AnimationCurve alphaScaleOverDuration = AnimationCurve.Linear(0.0f, 1f, 1f, 1f);
    [SerializeField]
    protected MeshRenderer vatRenderer;
    protected float startTime;
    protected Color color;

    protected void Update()
    {
      float time1 = Time.time;
      if ((double) time1 < (double) this.startTime + (double) this.duration)
      {
        float time2 = Mathf.Clamp01((time1 - this.startTime) / this.duration);
        this.vatRenderer.material.SetFloat(VATOneShotFX._VATTime, time2);
        Color color = this.color;
        color.a *= this.alphaScaleOverDuration.Evaluate(time2);
        this.vatRenderer.material.color = color;
      }
      else
        VfxManager.ReturnToPool(this.gameObject);
    }

    public void SetOwner(GameEntity entity)
    {
      this.color = entity.playerTeam.value == Team.Alpha ? this.teamAlphaColor : this.teamBetaColor;
      this.startTime = Time.time + this.delay;
      this.Update();
    }

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }
  }
}
