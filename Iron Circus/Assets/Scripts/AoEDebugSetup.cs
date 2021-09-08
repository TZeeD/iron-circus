// Decompiled with JetBrains decompiler
// Type: AoEDebugSetup
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using Imi.SteelCircus.JitterUnity;
using System;
using UnityEngine;

public class AoEDebugSetup : MonoBehaviour
{
  public Transform target;
  public float targetRadius;
  public Transform aimTarget;
  public AreaOfEffect aoe;
  public int circleRes = 20;

  private void OnDrawGizmos()
  {
    if ((UnityEngine.Object) this.target == (UnityEngine.Object) null || (UnityEngine.Object) this.aimTarget == (UnityEngine.Object) null)
      return;
    Vector3 position1 = this.target.position;
    position1.y = 0.0f;
    Vector3 position2 = this.transform.position;
    position2.y = 0.0f;
    Vector3 normalized1 = (this.aimTarget.position - position2).normalized;
    normalized1.y = 0.0f;
    normalized1.Normalize();
    if (this.aoe.shape == AoeShape.Cone)
    {
      Gizmos.color = !this.aoe.IsInRange2D(position2.ToJVector(), normalized1.ToJVector(), position1.ToJVector(), this.targetRadius) ? Color.white : Color.green;
      double num1 = (double) this.aoe.angle * (Math.PI / 180.0);
      float num2 = (float) Math.Cos(num1 / 2.0);
      float num3 = (float) Math.Sin(num1 / 2.0);
      Vector3 vector3_1 = new Vector3((float) ((double) normalized1.x * (double) num2 - (double) normalized1.z * (double) num3), 0.0f, (float) ((double) normalized1.x * (double) num3 + (double) normalized1.z * (double) num2)) * this.aoe.radius;
      Vector3 vector3_2 = new Vector3((float) ((double) normalized1.x * (double) num2 + (double) normalized1.z * (double) num3), 0.0f, (float) ((double) normalized1.x * -(double) num3 + (double) normalized1.z * (double) num2)) * this.aoe.radius;
      Gizmos.DrawLine(position2, position2 + vector3_1);
      Gizmos.DrawLine(position2, position2 + vector3_2);
      this.DrawCircleXZ(this.circleRes, position2, this.aoe.deadZone);
      this.DrawCircleXZ(this.circleRes, position2, this.aoe.radius);
      Vector3 rhs1 = position1 - position2;
      float magnitude = rhs1.magnitude;
      Vector3 rhs2 = rhs1 * (1f / magnitude);
      Vector3 lhs = Vector3.Cross(normalized1, rhs2);
      Vector3 rhs3 = Vector3.zero;
      rhs3 = (double) lhs.y <= 0.0 ? new Vector3((float) ((double) normalized1.x * (double) num2 - (double) normalized1.z * (double) num3), 0.0f, (float) ((double) normalized1.x * (double) num3 + (double) normalized1.z * (double) num2)) : new Vector3((float) ((double) normalized1.x * (double) num2 + (double) normalized1.z * (double) num3), 0.0f, (float) ((double) normalized1.x * -(double) num3 + (double) normalized1.z * (double) num2));
      Vector3 vector3_3 = Vector3.Cross(rhs3.normalized * this.aoe.radius, rhs1);
      float num4 = vector3_3.magnitude / this.aoe.radius;
      vector3_3 = Vector3.Cross(lhs, rhs3);
      Vector3 normalized2 = vector3_3.normalized;
      Vector3 from = position2 + rhs3 * (this.aoe.deadZone + (float) (((double) this.aoe.radius - (double) this.aoe.deadZone) * 0.5));
      Gizmos.DrawLine(from, from + normalized2 * num4);
    }
    this.DrawCircleXZ(this.circleRes, position1, this.targetRadius);
  }

  private void DrawCircleXZ(int circleRes, Vector3 pos, float radius)
  {
    Vector3 vector3_1 = new Vector3(radius, 0.0f, 0.0f);
    for (int index = 1; index <= circleRes; ++index)
    {
      float f = (float) ((double) index / (double) circleRes * 2.0 * 3.14159274101257);
      Vector3 vector3_2 = new Vector3(Mathf.Cos(f), 0.0f, Mathf.Sin(f)) * radius;
      Gizmos.DrawLine(pos + vector3_1, pos + vector3_2);
      vector3_1 = vector3_2;
    }
  }
}
