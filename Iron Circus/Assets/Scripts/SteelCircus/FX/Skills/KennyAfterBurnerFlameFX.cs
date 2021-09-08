// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.KennyAfterBurnerFlameFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class KennyAfterBurnerFlameFX : MonoBehaviour
  {
    [SerializeField]
    private ParticleSystem glowParticles;
    [SerializeField]
    private ParticleSystem mainParticles;
    [SerializeField]
    private ParticleSystem sootParticles;

    public ParticleSystem GlowParticles => this.glowParticles;

    public ParticleSystem MainParticles => this.mainParticles;

    public ParticleSystem SootParticles => this.sootParticles;
  }
}
