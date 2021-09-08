// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.HildegardShieldThrowFX
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas.Unity;
using Imi.SharedWithServer.ScEntitas;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.ScriptableObjects;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class HildegardShieldThrowFX : MonoBehaviour
  {
    [SerializeField]
    private Transform shieldModel;
    [SerializeField]
    private Transform trailParent;
    [SerializeField]
    private Renderer trailModel;
    [SerializeField]
    private Renderer floorCircle;
    [SerializeField]
    private Transform trailModelFloor;
    [SerializeField]
    private Transform glowModel;
    [SerializeField]
    private Vector3 rotationAxis;
    [SerializeField]
    private float trailExpandDuration = 0.2f;
    private float spinSpeed = 1f;
    private GameEntity entity;
    protected static readonly int _Color = Shader.PropertyToID(nameof (_Color));
    protected static readonly int _TrailLength = Shader.PropertyToID(nameof (_TrailLength));
    protected static readonly int _ColorOutlineFG = Shader.PropertyToID(nameof (_ColorOutlineFG));
    private Color trailColor;
    private Material trailMat;
    private float trailCounter;
    private Vector3 prevDirection;

    private void Start()
    {
      this.entity = (GameEntity) this.gameObject.GetEntityLink().entity;
      if (this.entity == null || !this.entity.hasProjectile)
      {
        Object.Destroy((Object) this.gameObject);
      }
      else
      {
        GameEntity entityWithPlayerId = Contexts.sharedInstance.game.GetFirstEntityWithPlayerId(this.entity.projectile.owner);
        if (entityWithPlayerId == null)
        {
          Object.Destroy((Object) this.gameObject);
        }
        else
        {
          this.spinSpeed = this.entity.projectile.spinSpeed;
          ColorsConfig instance = SingletonScriptableObject<ColorsConfig>.Instance;
          this.glowModel.GetComponent<ParticleSystemRenderer>().material.SetColor(HildegardShieldThrowFX._Color, instance.LightColor(entityWithPlayerId.playerTeam.value));
          this.trailModelFloor.GetComponent<Renderer>().material.SetColor(HildegardShieldThrowFX._Color, instance.DarkColor(entityWithPlayerId.playerTeam.value));
          this.trailColor = instance.LightColor(entityWithPlayerId.playerTeam.value);
          this.trailMat = this.trailModel.material;
          this.floorCircle.material.SetColor(HildegardShieldThrowFX._ColorOutlineFG, instance.DarkColor(entityWithPlayerId.playerTeam.value));
          this.UpdateTrail();
        }
      }
    }

    private void Update()
    {
      if (this.rotationAxis != Vector3.zero)
        this.shieldModel.Rotate(this.rotationAxis, this.spinSpeed * Time.deltaTime, Space.World);
      this.UpdateTrail();
    }

    private void UpdateTrail()
    {
      this.trailMat.SetColor(HildegardShieldThrowFX._Color, this.trailColor);
      Vector3 vector3 = this.entity.velocityOverride.value.ToVector3();
      if (this.prevDirection != vector3)
        this.trailCounter = 0.0f;
      this.prevDirection = vector3;
      this.trailCounter += Time.deltaTime / this.trailExpandDuration;
      this.trailMat.SetFloat(HildegardShieldThrowFX._TrailLength, Mathf.Clamp01(this.trailCounter));
      this.trailParent.rotation = Quaternion.LookRotation(vector3);
    }
  }
}
