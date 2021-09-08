// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.HildegardShieldImpactFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class HildegardShieldImpactFX : MonoBehaviour, IVfx
  {
    [SerializeField]
    private MeshRenderer renderer;
    [SerializeField]
    private float duration = 0.5f;
    private float counter;
    private Material material;
    protected static readonly int _AnimTime = Shader.PropertyToID(nameof (_AnimTime));

    public void SetOwner(GameEntity entity)
    {
      ColorsConfig instance = SingletonScriptableObject<ColorsConfig>.Instance;
      this.renderer.transform.Rotate(0.0f, Random.Range(0.0f, 360f), 0.0f);
      this.material = this.renderer.material;
      this.material.color = instance.LightColor(entity.playerTeam.value);
      this.material.SetFloat(HildegardShieldImpactFX._AnimTime, 0.0f);
    }

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }

    private void Update()
    {
      this.counter += Time.deltaTime / this.duration;
      this.material.SetFloat(HildegardShieldImpactFX._AnimTime, this.counter);
      if ((double) this.counter < 1.0)
        return;
      VfxManager.ReturnToPool(this.gameObject);
    }
  }
}
