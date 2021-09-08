// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.VictoryAnimation
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;
using UnityEngine.UI;

namespace SteelCircus.FX
{
  public class VictoryAnimation : MonoBehaviour
  {
    [SerializeField]
    private Color victoryGlowColor;
    [SerializeField]
    private Color defeatGlowColor;
    [SerializeField]
    private Color overtimeGlowColor;
    [SerializeField]
    private Color victoryParticlesColor;
    [SerializeField]
    private Color defeatParticlesColor;
    [SerializeField]
    private Color overtimeParticlesColor;
    [SerializeField]
    private Texture2D victoryGradient;
    [SerializeField]
    private Texture2D defeatGradient;
    [SerializeField]
    private Texture2D overtimrGradient;
    [SerializeField]
    private Image glow;
    [SerializeField]
    private ParticleSystem particles;
    [SerializeField]
    private Image background;

    public void SetupVictory()
    {
      this.glow.color = this.victoryGlowColor;
      this.particles.main.startColor = (ParticleSystem.MinMaxGradient) this.victoryParticlesColor;
      this.background.material.SetTexture("_ColorMap", (Texture) this.victoryGradient);
    }

    public void SetupDefeat()
    {
      this.glow.color = this.defeatGlowColor;
      this.particles.main.startColor = (ParticleSystem.MinMaxGradient) this.defeatParticlesColor;
      this.background.material.SetTexture("_ColorMap", (Texture) this.defeatGradient);
    }

    public void SetupOvertime()
    {
      this.glow.color = this.overtimeGlowColor;
      this.particles.main.startColor = (ParticleSystem.MinMaxGradient) this.overtimeParticlesColor;
      this.background.material.SetTexture("_ColorMap", (Texture) this.overtimrGradient);
    }
  }
}
