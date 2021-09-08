// Decompiled with JetBrains decompiler
// Type: SteelCircus.FX.Skills.ServitorBarrierRotationControls
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Game.Skills;
using Imi.SteelCircus.JitterUnity;
using Imi.SteelCircus.Utils.Extensions;
using Jitter.LinearMath;
using UnityEngine;

namespace SteelCircus.FX.Skills
{
  public class ServitorBarrierRotationControls : MonoBehaviour, IVfx
  {
    [SerializeField]
    private string rootName;
    [SerializeField]
    private string spineStartBoneName;
    [SerializeField]
    private string leftThighBoneName;
    [SerializeField]
    private string rightThighBoneName;
    [SerializeField]
    private string armBoneName;
    [SerializeField]
    private string neckParentBoneName;
    private Transform root;
    private Transform spineStartBone;
    private Transform leftThighBone;
    private Transform rightThighBone;
    private Transform armBone;
    private Transform neckParentBone;
    private float targetRotation;
    private float currentRotation;
    private float influence;
    private float influenceRiseDuration = 0.1f;
    private float influenceFallDuration = 0.5f;
    private float influenceFallDelay;
    [Range(0.0f, 1f)]
    public float smoothing = 0.05f;
    [SerializeField]
    private float minAngle = -90f;
    [Header("Limits")]
    [SerializeField]
    private float spineTargetRotationLimit = 110f;
    [SerializeField]
    private float spineRotationLimit = 90f;
    [SerializeField]
    private float spineRotationLimitSoftness = 10f;
    private GameEntity entity;
    private SkillVar<JVector> aimDirVar;
    private bool setupComplete;
    private SkillState skillState;
    private bool prevActive;

    private void GetTargetRotationFromAimDir() => this.targetRotation = Vector3.SignedAngle(this.entity.transform.Forward.ToVector3(), this.aimDirVar.Get().ToVector3(), Vector3.up);

    private void LateUpdate()
    {
      if (!this.setupComplete)
        return;
      if (this.prevActive && !this.skillState.IsActive)
      {
        this.influence = 1f;
        this.influenceFallDelay = 0.3f;
      }
      if (this.skillState.IsActive)
      {
        this.prevActive = true;
        this.influence = Mathf.Clamp01(this.influence + Time.deltaTime / this.influenceRiseDuration);
      }
      else
      {
        this.prevActive = false;
        if ((double) this.influenceFallDelay > 0.0)
          this.influenceFallDelay = Mathf.Clamp01(this.influenceFallDelay - Time.deltaTime);
        else
          this.influence = Mathf.Clamp01(this.influence - Time.deltaTime / this.influenceFallDuration);
      }
      this.GetTargetRotationFromAimDir();
      while ((double) this.targetRotation < (double) this.minAngle)
        this.targetRotation += 360f;
      while ((double) this.targetRotation > (double) this.minAngle + 360.0)
        this.targetRotation -= 360f;
      Quaternion rotation = this.neckParentBone.rotation;
      this.currentRotation = Mathf.Lerp(this.currentRotation, this.targetRotation, 1f - Mathf.Pow(this.smoothing, Time.deltaTime));
      Vector3 forward = this.root.forward;
      Vector3 right = this.armBone.right;
      forward.y = 0.0f;
      right.y = 0.0f;
      float num1 = Vector3.SignedAngle(forward, right, Vector3.up);
      float num2 = Mathf.Abs(this.currentRotation);
      float num3 = Mathf.Sign(this.currentRotation);
      float a = this.spineRotationLimit - this.spineRotationLimitSoftness;
      float num4 = ((double) num2 <= (double) a ? num2 : Mathf.Lerp(a, this.spineRotationLimit, Mathf.Clamp01((float) (((double) num2 - (double) a) / ((double) this.spineTargetRotationLimit - (double) a))))) * num3;
      float num5 = this.currentRotation - num4 - num1;
      float num6 = num4 * this.influence;
      float num7 = num5 * this.influence;
      this.spineStartBone.Rotate(Vector3.up * num6, Space.World);
      this.leftThighBone.Rotate(Vector3.up * -num6, Space.World);
      this.rightThighBone.Rotate(Vector3.up * -num6, Space.World);
      this.armBone.Rotate(Vector3.up * num7, Space.World);
      this.neckParentBone.rotation = rotation;
    }

    public void SetOwner(GameEntity entity)
    {
      this.setupComplete = true;
      this.entity = entity;
      Transform transform = entity.unityView.gameObject.transform;
      this.root = transform.FindDeepChild(this.rootName);
      this.spineStartBone = transform.FindDeepChild(this.spineStartBoneName);
      this.leftThighBone = transform.FindDeepChild(this.leftThighBoneName);
      this.rightThighBone = transform.FindDeepChild(this.rightThighBoneName);
      this.armBone = transform.FindDeepChild(this.armBoneName);
      this.neckParentBone = transform.FindDeepChild(this.neckParentBoneName);
    }

    public void SetArgs(object args) => this.skillState = (SkillState) args;

    public void SetSkillGraph(SkillGraph graph) => this.aimDirVar = graph.GetVar<JVector>("AimDir");
  }
}
