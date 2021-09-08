// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.TurretParabolaFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class TurretParabolaFX : MonoBehaviour, IVfx
  {
    private const float meshLength = 10f;
    private float duration = 1f;
    private float counter;
    private Material mat;
    private static readonly int animationTimeID = Shader.PropertyToID("_AnimationTime");

    private void Awake()
    {
      this.mat = this.GetComponentInChildren<MeshRenderer>().material;
      this.mat.SetFloat(TurretParabolaFX.animationTimeID, 0.0f);
    }

    private void Update()
    {
      this.counter = Mathf.Clamp01(this.counter + Time.deltaTime / this.duration);
      this.mat.SetFloat(TurretParabolaFX.animationTimeID, Mathf.Pow(this.counter, 0.5f));
      if ((double) this.counter != 1.0)
        return;
      VfxManager.ReturnToPool(this.gameObject);
    }

    public void SetOwner(GameEntity entity)
    {
    }

    public void SetArgs(object args)
    {
      TurretConfig.TurretFlightFXParams turretFlightFxParams = (TurretConfig.TurretFlightFXParams) args;
      this.duration = turretFlightFxParams.duration;
      this.transform.localScale = new Vector3(1f, 1f, turretFlightFxParams.distance / 10f);
    }

    public void SetSkillGraph(SkillGraph graph)
    {
    }
  }
}
