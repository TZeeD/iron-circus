// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.BarrierConnectionFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.Utils.Extensions;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class BarrierConnectionFX : MonoBehaviour, IVfx
  {
    [SerializeField]
    private float duration = 0.5f;
    public string gunBoneName = "j_gun_01";
    public Vector3 gunBoneOffset = new Vector3(0.0f, 0.87f, 0.0f);
    private Transform origin;
    private Material material;
    private int _ConnectorPos = Shader.PropertyToID(nameof (_ConnectorPos));
    private int _AnimTime = Shader.PropertyToID(nameof (_AnimTime));
    private float lifeTimeCounter;

    private void Awake() => this.material = this.GetComponentInChildren<Renderer>().material;

    private void Update()
    {
      this.material.SetVector(this._ConnectorPos, (Vector4) this.origin.TransformPoint(this.gunBoneOffset));
      this.lifeTimeCounter = Mathf.Clamp01(this.lifeTimeCounter + Time.deltaTime / this.duration);
      this.material.SetFloat(this._AnimTime, this.lifeTimeCounter);
      if ((double) this.lifeTimeCounter != 1.0)
        return;
      VfxManager.ReturnToPool(this.gameObject);
    }

    public void SetOwner(GameEntity entity) => this.origin = entity.unityView.gameObject.transform.FindDeepChild(this.gunBoneName);

    public void SetArgs(object args)
    {
    }

    public void SetSkillGraph(SkillGraph graph)
    {
      Vector3 vector3 = ((BarrierConfig) graph.GetConfig()).barrierDimensions.ToVector3();
      vector3.z = 1f;
      this.transform.localScale = vector3;
    }
  }
}
