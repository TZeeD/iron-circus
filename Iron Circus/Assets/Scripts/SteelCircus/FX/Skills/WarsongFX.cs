// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.WarsongFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class WarsongFX : MonoBehaviour, IAoeVfx, IVfx
  {
    [SerializeField]
    private ParticleSystem particles;
    [SerializeField]
    private MeshRenderer[] waves;
    public float frequency = 1f;
    public AnimationCurve scaleCurve = AnimationCurve.Linear(0.0f, 1f / 1000f, 1f, 1f);
    public AnimationCurve fadeCurve = AnimationCurve.Linear(1f, 1f, 0.0f, 0.0f);
    public float rotationSpeed = 360f;
    public float alphaScale = 1f;
    private float counter;
    [SerializeField]
    private Color color = Color.blue;
    [SerializeField]
    private AreaOfEffect aoe;

    private void Update()
    {
      this.counter += Time.deltaTime * this.frequency;
      float length = (float) this.waves.Length;
      if ((double) length == 0.0)
        return;
      for (int index = 0; index < this.waves.Length; ++index)
      {
        float time = (float) (((double) this.counter + (double) index / (double) length) % 1.0);
        float num1 = this.scaleCurve.Evaluate(time);
        float num2 = this.fadeCurve.Evaluate(time) * this.alphaScale;
        MeshRenderer wave = this.waves[index];
        Color color1 = wave.material.color;
        Color color2 = this.color;
        color2.a *= num2;
        wave.material.color = color2;
        wave.material.SetFloat("_AlphaScale", num2);
        wave.transform.localScale = Vector3.one * num1 * this.aoe.radius * 2f;
        wave.transform.Rotate(0.0f, 0.0f, this.rotationSpeed * Time.deltaTime * Mathf.Sign((float) (index % 2)));
      }
    }

    public void SetAoe(AreaOfEffect aoe)
    {
      this.aoe = aoe;
      this.UpdateVfxForAoe();
    }

    private void UpdateVfxForAoe()
    {
      if ((Object) this.particles == (Object) null)
        return;
      this.particles.shape.radius = this.aoe.radius;
    }

    public void SetOwner(GameEntity entity) => this.color = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(entity.playerTeam.value);

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }
  }
}
