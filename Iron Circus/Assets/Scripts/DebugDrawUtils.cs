// Decompiled with JetBrains decompiler
// Type: DebugDrawUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System.Collections.Generic;
using UnityEngine;

public static class DebugDrawUtils
{
  public static List<Vector3> GetArcByForwardVector(
    Vector3 forward,
    float angle,
    Vector3 center = default (Vector3),
    int resolution = 10,
    bool flip = false,
    bool omitFirstLast = false)
  {
    Vector2 arcStartEndT = DebugDrawUtils.GetArcStartEndT(forward.normalized, angle);
    return DebugDrawUtils.GetArc(flip ? arcStartEndT.y : arcStartEndT.x, flip ? arcStartEndT.x : arcStartEndT.y, forward.magnitude, resolution, center, omitFirstLast);
  }

  public static Vector2 GetArcStartEndT(Vector3 forward, float angle)
  {
    Vector2 vector2 = new Vector2();
    float num1 = Mathf.Atan2(forward.x, forward.z) * 57.29578f;
    float num2 = angle / 2f;
    vector2.x = (float) (((double) num1 + (double) num2) / 360.0);
    vector2.y = (float) (((double) num1 - (double) num2) / 360.0);
    return vector2;
  }

  public static List<Vector3> GetArc(
    float startT,
    float endT,
    float radius,
    int res,
    Vector3 center = default (Vector3),
    bool omitFirstLast = false)
  {
    List<Vector3> vector3List = new List<Vector3>();
    float num1 = (Mathf.Max(startT, endT) - Mathf.Min(startT, endT)) / (float) (res - 1);
    float num2 = (double) startT > (double) endT ? -1f : 1f;
    for (int index = omitFirstLast ? 1 : 0; index < (omitFirstLast ? res - 1 : res); ++index)
      vector3List.Add(DebugDrawUtils.SampleCircle(startT + num1 * (float) index * num2, radius) + center);
    return vector3List;
  }

  public static Vector3 SampleCircle(float t, float r) => new Vector3(Mathf.Sin((float) ((double) t * 3.14159274101257 * 2.0)) * r, 0.0f, Mathf.Cos((float) ((double) t * 3.14159274101257 * 2.0)) * r);

  public static List<Vector3> GetConePoints(
    Vector3 position,
    Vector3 forward,
    float angle,
    float radius,
    float deadZone = 0.0f,
    int resolution = 10)
  {
    List<Vector3> vector3List = new List<Vector3>();
    float y = angle / 2f;
    vector3List.Add(position + Quaternion.Euler(0.0f, y, 0.0f) * forward * deadZone);
    vector3List.Add(position + Quaternion.Euler(0.0f, y, 0.0f) * forward * radius);
    if (resolution > 0)
      vector3List.AddRange((IEnumerable<Vector3>) DebugDrawUtils.GetArcByForwardVector(forward * radius, angle, position, resolution + 2, omitFirstLast: true));
    vector3List.Add(position + Quaternion.Euler(0.0f, -y, 0.0f) * forward * radius);
    vector3List.Add(position + Quaternion.Euler(0.0f, -y, 0.0f) * forward * deadZone);
    if (resolution > 0)
      vector3List.AddRange((IEnumerable<Vector3>) DebugDrawUtils.GetArcByForwardVector(forward * deadZone, angle, position, resolution + 2, true, true));
    return vector3List;
  }

  public static List<Vector3> GetCircle(float radius = 1f, Vector3 position = default (Vector3), int resolution = 10)
  {
    List<Vector3> vector3List = new List<Vector3>();
    float num = (float) (1.0 / ((double) resolution - 1.0));
    for (int index = 0; index < resolution; ++index)
      vector3List.Add(position + DebugDrawUtils.SampleCircle(num * (float) index, radius));
    return vector3List;
  }

  public static void DebugDrawSkillAoe(
    AreaOfEffect aoe,
    Vector3 position,
    Vector3 forward,
    LineRenderer lineRenderer = null,
    int resolution = 3,
    Color? color = null)
  {
    if (!color.HasValue)
      color = new Color?(Color.red);
    if (aoe.shape == AoeShape.Circle)
    {
      List<Vector3> circle = DebugDrawUtils.GetCircle(aoe.radius, position, resolution);
      if ((Object) lineRenderer != (Object) null)
      {
        lineRenderer.positionCount = circle.Count;
        lineRenderer.SetPositions(circle.ToArray());
      }
      else
      {
        for (int index = 0; index < circle.Count; ++index)
          Debug.DrawLine(circle[index], circle[(index + 1) % circle.Count], color.Value);
      }
    }
    else
    {
      if (aoe.shape != AoeShape.Cone)
        return;
      List<Vector3> conePoints = DebugDrawUtils.GetConePoints(position, forward, aoe.angle, aoe.radius, aoe.deadZone, resolution);
      if ((Object) lineRenderer != (Object) null)
      {
        lineRenderer.positionCount = conePoints.Count;
        lineRenderer.SetPositions(conePoints.ToArray());
      }
      else
      {
        for (int index = 1; index <= conePoints.Count; ++index)
          Debug.DrawLine(conePoints[index - 1], conePoints[index % conePoints.Count], color.Value);
      }
    }
  }
}
