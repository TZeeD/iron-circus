// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.MuzzleFlashFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class MuzzleFlashFX : MonoBehaviour, IVfx
  {
    private Material mat;
    private Color col;
    public float fadeDuration = 0.2f;
    private float fadeCounter;
    public AnimationCurve scaleCurve = AnimationCurve.EaseInOut(0.0f, 1f, 1f, 0.0f);

    private void Awake() => this.mat = this.GetComponentInChildren<MeshRenderer>().material;

    private void Update()
    {
      this.fadeCounter = Mathf.Clamp01(this.fadeCounter + Time.deltaTime / this.fadeDuration);
      this.UpdateVisuals();
      if ((double) this.fadeCounter != 1.0)
        return;
      VfxManager.ReturnToPool(this.gameObject);
    }

    public void SetOwner(GameEntity entity)
    {
      this.col = SingletonScriptableObject<ColorsConfig>.Instance.LightColor(entity.playerTeam.value);
      this.UpdateVisuals();
    }

    private void UpdateVisuals()
    {
      this.mat.color = this.col * (1f - this.fadeCounter);
      this.mat.SetColor("_TintColor", this.col * (1f - this.fadeCounter));
      this.transform.localScale = Vector3.one * this.scaleCurve.Evaluate(this.fadeCounter);
    }

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }
  }
}
