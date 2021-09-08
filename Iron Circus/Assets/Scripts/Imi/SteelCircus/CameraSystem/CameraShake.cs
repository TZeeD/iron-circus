// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.CameraSystem.CameraShake
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections;
using UnityEngine;

namespace Imi.SteelCircus.CameraSystem
{
  public class CameraShake : MonoBehaviour
  {
    private const float MaxAngle = 10f;
    private IEnumerator currentShakeCoroutine;
    public float angle;
    public float strength;
    public float duration;
    public float maxSpeed;
    public float minSpeed;
    [Range(0.0f, 1f)]
    public float noisePercent;
    [Range(0.0f, 1f)]
    public float dampingPercent;
    [Range(0.0f, 1f)]
    public float rotationPercent;

    public void StartShake()
    {
      if (this.currentShakeCoroutine != null)
        this.StopCoroutine(this.currentShakeCoroutine);
      this.currentShakeCoroutine = this.Shake();
      this.StartCoroutine(this.currentShakeCoroutine);
    }

    private IEnumerator Shake()
    {
      CameraShake cameraShake = this;
      float completionPercent = 0.0f;
      float movePercent = 0.0f;
      float angle_radians = (float) ((double) cameraShake.angle * (Math.PI / 180.0) - 3.14159274101257);
      Vector3 previousWaypoint = Vector3.zero;
      Vector3 currentWaypoint = Vector3.zero;
      float moveDistance = 0.0f;
      float speed = 0.0f;
      Quaternion targetRotation = Quaternion.identity;
      Quaternion previousRotation = Quaternion.identity;
      do
      {
        if ((double) movePercent >= 1.0 || Mathf.Approximately(completionPercent, 0.0f))
        {
          float t = cameraShake.DampingCurve(completionPercent, cameraShake.dampingPercent);
          angle_radians += (float) (3.14159274101257 + ((double) UnityEngine.Random.value - 0.5) * 3.14159274101257 * (double) cameraShake.noisePercent);
          currentWaypoint = new Vector3(Mathf.Cos(angle_radians), Mathf.Sin(angle_radians)) * cameraShake.strength * t;
          previousWaypoint = cameraShake.transform.localPosition;
          moveDistance = Vector3.Distance(currentWaypoint, previousWaypoint);
          targetRotation = Quaternion.Euler(new Vector3(currentWaypoint.y, currentWaypoint.x).normalized * cameraShake.rotationPercent * t * 10f);
          previousRotation = cameraShake.transform.localRotation;
          speed = Mathf.Lerp(cameraShake.minSpeed, cameraShake.maxSpeed, t);
          movePercent = 0.0f;
        }
        completionPercent += Time.deltaTime / cameraShake.duration;
        movePercent += Time.deltaTime / moveDistance * speed;
        cameraShake.transform.localPosition = Vector3.Lerp(previousWaypoint, currentWaypoint, movePercent);
        cameraShake.transform.localRotation = Quaternion.Slerp(previousRotation, targetRotation, movePercent);
        yield return (object) null;
      }
      while ((double) moveDistance > 0.0);
    }

    private float DampingCurve(float x, float dampPercent)
    {
      x = Mathf.Clamp01(x);
      float p = Mathf.Lerp(2f, 0.25f, dampPercent);
      float num = 1f - Mathf.Pow(x, p);
      return num * num * num;
    }
  }
}
