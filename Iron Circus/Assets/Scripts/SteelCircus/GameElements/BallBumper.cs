// Decompiled with JetBrains decompiler
// Type: SteelCircus.GameElements.BallBumper
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Entitas;
using Imi.Diagnostics;
using Imi.SharedWithServer.EntitasShared.Components.Bumper;
using Imi.SharedWithServer.Game;
using Imi.SteelCircus.GameElements;
using Imi.SteelCircus.JitterUnity;
using Jitter.LinearMath;
using Rewired.ComponentControls.Effects;
using SharedWithServer.ScEvents;
using System.Collections;
using UnityEngine;

namespace SteelCircus.GameElements
{
  public class BallBumper : MonoBehaviour, IConvertableToEntitas
  {
    [SerializeField]
    private BumperType type;
    [SerializeField]
    private Transform model;
    private Vector3 ogScale;
    [SerializeField]
    private bool useLight;
    [SerializeField]
    private Light bumpLight;
    [SerializeField]
    private Animator animator;
    private float bumpLightIntensity;
    [SerializeField]
    private float bumpLightDuration;
    private float bumpLightCounter;
    [SerializeField]
    private AnimationCurve bumpScaleCurve;
    [SerializeField]
    private float bumpScaleDuration;
    [SerializeField]
    private RotateAroundAxis rotateWingsScript;
    [SerializeField]
    private float rotationAccelerationDuration;
    [SerializeField]
    private float rotationDecelerationDuration;
    [SerializeField]
    private float bumpRotationTopSpeed;
    private bool isBumping;
    [SerializeField]
    private BumperFloorUI floorUI;

    private void Start()
    {
      this.ogScale = this.model.localScale;
      this.bumpLightIntensity = this.bumpLight.intensity;
      Events.Global.OnEventBumperBallCollision += new Events.EventBumperBallCollision(this.OnCollision);
    }

    private void OnDestroy() => Events.Global.OnEventBumperBallCollision -= new Events.EventBumperBallCollision(this.OnCollision);

    public BumperFloorUI GetFloorUi() => this.floorUI;

    private void Update()
    {
      if ((double) this.bumpLightCounter == 0.0 || !this.useLight)
        return;
      this.bumpLightCounter -= Time.deltaTime;
      this.bumpLight.intensity = Mathf.Pow(this.bumpLightCounter, 0.5f) * this.bumpLightIntensity;
      if ((double) this.bumpLightCounter > 0.0)
        return;
      this.bumpLightCounter = 0.0f;
      this.bumpLight.enabled = false;
      this.bumpLight.intensity = this.bumpLightIntensity;
    }

    protected virtual void OnCollision(UniqueId id, JVector position, JVector normal)
    {
      if ((int) id.Value() != this.GetComponent<GameUniqueId>().GetId())
        return;
      GameEntity ballEntity = Contexts.sharedInstance.game.ballEntity;
      Vector3 from = (ballEntity.transform.position + JVector.Up * ballEntity.transform.position.Y).ToVector3() - this.transform.position;
      from.y = 0.0f;
      this.floorUI.OnHit(Vector3.SignedAngle(from, this.transform.forward, Vector3.up));
      if ((Object) this.animator != (Object) null)
        this.StartCoroutine(this.BumpOnlyOnceHack(0.35f));
      else
        Log.Warning(string.Format("No Animator set for Bumper: {0} {1}", (object) this.gameObject.name, (object) this));
      float volume = Mathf.Min(1f, (float) (0.300000011920929 + (double) ballEntity.velocityOverride.value.ToVector3().magnitude / 50.0));
      AudioController.Play("BallHitBumperBase", this.transform);
      AudioController.Play("BallHitBumperLayer", this.transform, volume);
      AudioController.Play("BumperRetraction", this.transform, volume);
      if (this.useLight)
      {
        this.bumpLight.enabled = true;
        this.bumpLightCounter = this.bumpLightDuration;
      }
      if (this.gameObject.activeInHierarchy)
        this.StartCoroutine(this.RotateAfterBump());
      Events.Global.FireEventCameraShake(this.transform);
    }

    protected IEnumerator ScaleEffect()
    {
      for (float i = 0.0f; (double) i < (double) this.bumpScaleDuration; i += Time.deltaTime)
      {
        this.model.localScale = this.bumpScaleCurve.Evaluate(i / this.bumpScaleDuration) * Vector3.one;
        yield return (object) null;
      }
      this.model.localScale = this.ogScale;
    }

    protected IEnumerator RotateAfterBump()
    {
      if ((Object) this.rotateWingsScript != (Object) null)
      {
        this.rotateWingsScript.speed = RotateAroundAxis.Speed.Fast;
        float i;
        for (i = 0.0f; (double) i < (double) this.rotationAccelerationDuration; i += Time.deltaTime)
        {
          this.rotateWingsScript.fastRotationSpeed = Mathf.Lerp(this.rotateWingsScript.fastRotationSpeed, this.bumpRotationTopSpeed, i / this.rotationAccelerationDuration);
          yield return (object) null;
        }
        for (i = 0.0f; (double) i < (double) this.rotationDecelerationDuration; i += Time.deltaTime)
        {
          this.rotateWingsScript.fastRotationSpeed = Mathf.Lerp(this.bumpRotationTopSpeed, this.rotateWingsScript.slowRotationSpeed, i / this.rotationDecelerationDuration);
          yield return (object) null;
        }
        this.rotateWingsScript.speed = RotateAroundAxis.Speed.Slow;
      }
    }

    private IEnumerator BumpOnlyOnceHack(float time)
    {
      if (!this.isBumping)
        this.animator.SetTrigger("Bump");
      this.isBumping = true;
      yield return (object) new WaitForSeconds(time);
      this.isBumping = false;
    }

    public IComponent ConvertToEntitasComponent() => (IComponent) new BumperComponent(this.type);

    public BumperType GetBumperType() => this.type;
  }
}
