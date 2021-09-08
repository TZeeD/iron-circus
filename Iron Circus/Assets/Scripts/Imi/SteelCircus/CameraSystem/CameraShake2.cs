// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.CameraSystem.CameraShake2
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using SharedWithServer.ScEvents;
using System.Collections;
using UnityEngine;

namespace Imi.SteelCircus.CameraSystem
{
  public class CameraShake2 : MonoBehaviour
  {
    private Vector2 screenCenter;
    private float maxScreenOffset;
    private IEnumerator currentShakeCoroutine;
    [SerializeField]
    private float duration = 1f;
    [SerializeField]
    private float perlinFactor = 20f;
    [SerializeField]
    private float translationFactor = 2f;
    [SerializeField]
    private float rotationFactor = 2f;
    [SerializeField]
    private AnimationCurve dampeningCurve;
    [SerializeField]
    [Range(0.0f, 1f)]
    private float dampingPercent;
    [SerializeField]
    private bool allowTranslation = true;
    [SerializeField]
    private bool allowRotation = true;
    [SerializeField]
    [Range(0.0f, 1f)]
    private float translationPercent;
    [SerializeField]
    [Range(0.0f, 1f)]
    private float rotationPercent;
    private Camera cam;

    private void Awake()
    {
      Events.Global.OnEventCameraShake += new Events.EventCameraShake(this.OnCameraShakeEvent);
      this.screenCenter = new Vector2((float) Screen.width / 2f, (float) Screen.height / 2f);
      this.maxScreenOffset = this.screenCenter.magnitude;
      SCCamera componentInChildren = this.GetComponentInChildren<SCCamera>(true);
      if ((Object) componentInChildren != (Object) null)
        this.cam = componentInChildren.GetMain();
      else
        this.cam = this.GetComponentInChildren<Camera>(true);
    }

    private void OnDestroy() => Events.Global.OnEventCameraShake -= new Events.EventCameraShake(this.OnCameraShakeEvent);

    private void OnCameraShakeEvent(Transform referenceTransform, float strength)
    {
      if (!this.gameObject.activeInHierarchy)
        return;
      this.StartShake(referenceTransform, strength);
    }

    public void StartShake(Transform referenceTarget, float strength = 1f)
    {
      if (this.currentShakeCoroutine != null)
        this.StopCoroutine(this.currentShakeCoroutine);
      if (!this.gameObject.activeSelf)
        return;
      if ((Object) referenceTarget != (Object) null)
        this.StartCoroutine(this.GetCoroutine(new Vector3?(referenceTarget.position), strength));
      else
        this.StartCoroutine(this.GetCoroutine(new Vector3?(), strength));
    }

    private IEnumerator GetCoroutine(Vector3? worldPosition, float strength)
    {
      float num = 0.0f;
      if (worldPosition.HasValue)
        num = Vector3.Distance(this.cam.WorldToScreenPoint(worldPosition.Value), (Vector3) this.screenCenter);
      this.currentShakeCoroutine = this.Shake((1f - Mathf.Min(num / this.maxScreenOffset, 1f)) * strength);
      return this.currentShakeCoroutine;
    }

    private IEnumerator Shake(float strengthFactor)
    {
      CameraShake2 cameraShake2 = this;
      float completionPercent = 0.0f;
      float elapsed = 0.0f;
      while ((double) elapsed < (double) cameraShake2.duration)
      {
        float num1 = cameraShake2.dampeningCurve.Evaluate(Mathf.Clamp01(completionPercent)) * cameraShake2.dampingPercent;
        elapsed += Time.deltaTime;
        if (cameraShake2.allowTranslation)
        {
          double num2 = 2.0 * (double) Mathf.PerlinNoise(Time.time * cameraShake2.perlinFactor, 0.0f) - 1.0;
          float num3 = (float) (2.0 * (double) Mathf.PerlinNoise(0.0f, Time.time * cameraShake2.perlinFactor) - 1.0);
          float num4 = (float) (2.0 * (double) Mathf.PerlinNoise(1f, Time.time * cameraShake2.perlinFactor) - 1.0);
          double num5 = (double) num3;
          double num6 = (double) num4;
          Vector3 vector3 = new Vector3((float) num2, (float) num5, (float) num6) * strengthFactor * cameraShake2.translationFactor * num1;
          cameraShake2.transform.localPosition = vector3 * cameraShake2.translationPercent;
        }
        if (cameraShake2.allowRotation)
        {
          double num7 = 2.0 * (double) Mathf.PerlinNoise(Time.time * cameraShake2.perlinFactor, 0.0f) - 1.0;
          float num8 = (float) (2.0 * (double) Mathf.PerlinNoise(0.0f, Time.time * cameraShake2.perlinFactor) - 1.0);
          float num9 = (float) (2.0 * (double) Mathf.PerlinNoise(1f, Time.time * cameraShake2.perlinFactor) - 1.0);
          double num10 = (double) num8;
          double num11 = (double) num9;
          Vector3 vector3 = new Vector3((float) num7, (float) num10, (float) num11) * strengthFactor * cameraShake2.rotationFactor * num1;
          cameraShake2.transform.localRotation = Quaternion.Euler(vector3 * cameraShake2.rotationPercent);
        }
        completionPercent += Time.deltaTime / cameraShake2.duration;
        yield return (object) null;
      }
      cameraShake2.transform.localPosition = Vector3.zero;
      cameraShake2.transform.localRotation = Quaternion.identity;
    }
  }
}
