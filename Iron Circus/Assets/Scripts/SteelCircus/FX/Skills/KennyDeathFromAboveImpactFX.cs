// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.KennyDeathFromAboveImpactFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.ScriptableObjects;
using SharedWithServer.ScEvents;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class KennyDeathFromAboveImpactFX : MonoBehaviour, IVfx
  {
    [SerializeField]
    private Renderer shockwaveRenderer;
    [SerializeField]
    private Transform shockwaveParent;
    [SerializeField]
    private Renderer shockwaveFloorRenderer;
    [SerializeField]
    private Transform shockwaveFloorParent;
    [SerializeField]
    private float totalDuration = 1f;
    [SerializeField]
    private float shockwaveDuration = 0.4f;
    [SerializeField]
    private float shockwaveFloorDuration = 0.3f;
    [SerializeField]
    private AnimationCurve shockwaveAlpha = AnimationCurve.Linear(0.0f, 1f, 1f, 0.0f);
    [SerializeField]
    private float shockwaveAnimPow = 0.5f;
    [SerializeField]
    private float shockwaveAnimDelay = 0.1f;
    private float counter;
    private Material shockwaveFloorMat;
    private Material shockwaveMat;
    protected static readonly int _AnimProgress = Shader.PropertyToID(nameof (_AnimProgress));
    protected static readonly int _AlphaScale = Shader.PropertyToID(nameof (_AlphaScale));

    public void SetOwner(GameEntity entity)
    {
      ColorsConfig instance = SingletonScriptableObject<ColorsConfig>.Instance;
      this.shockwaveParent.Rotate(0.0f, Random.Range(0.0f, 360f), 0.0f);
      this.shockwaveMat = this.shockwaveRenderer.material;
      this.shockwaveMat.color = instance.LightColor(entity.playerTeam.value);
      this.shockwaveFloorMat = this.shockwaveFloorRenderer.material;
      this.shockwaveFloorMat.SetFloat(KennyDeathFromAboveImpactFX._AnimProgress, 0.0f);
      this.shockwaveParent.localScale = Vector3.one * (1f / 1000f);
      Events.Global.FireEventCameraShake(entity.unityView.gameObject.transform, 0.5f);
    }

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }

    private void Update()
    {
      this.counter += Time.deltaTime;
      this.shockwaveFloorMat.SetFloat(KennyDeathFromAboveImpactFX._AnimProgress, Mathf.Clamp01(this.counter / this.shockwaveFloorDuration));
      float num = Mathf.Max(1f / 1000f, Mathf.Clamp01((this.counter - this.shockwaveAnimDelay) / this.shockwaveDuration));
      this.shockwaveParent.localScale = Vector3.one * Mathf.Pow(num, this.shockwaveAnimPow);
      this.shockwaveMat.SetFloat(KennyDeathFromAboveImpactFX._AlphaScale, this.shockwaveAlpha.Evaluate(num));
      if ((double) this.counter < (double) this.totalDuration)
        return;
      VfxManager.ReturnToPool(this.gameObject);
    }
  }
}
