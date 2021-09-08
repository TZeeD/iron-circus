// Decompiled with JetBrains decompiler
// Type: RigUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

public class RigUtils
{
  public float maxAngle;
  [Range(-1f, 1f)]
  public float rotationAmount;
  public bool preview;
  public Transform target;
  public Transform root;
  public RigUtils.Axis rootForward;
  public RigUtils.Bone[] bones;
  private List<Quaternion> cachedRotations = new List<Quaternion>();
  private Vector3 upAxis;
  private Vector3 fwdAxis;
  private Vector3 rightAxis;
  private static List<Quaternion> rotationCache = new List<Quaternion>();

  public void Run()
  {
    if (this.bones == null)
      return;
    this.cachedRotations.Clear();
    for (int index = 0; index < this.bones.Length; ++index)
      this.cachedRotations.Add(this.bones[index].transform.rotation);
    for (int index = 0; index < this.bones.Length; ++index)
      this.bones[index].transform.rotation = Quaternion.AngleAxis(this.rotationAmount * this.maxAngle * ((float) (index + 1) / (float) this.bones.Length), Vector3.up) * this.cachedRotations[index];
  }

  public static void AddRotation(List<Transform> bones, float angle)
  {
    RigUtils.rotationCache.Clear();
    int count = bones.Count;
    for (int index = 0; index < count; ++index)
      RigUtils.rotationCache.Add(bones[index].transform.rotation);
    for (int index = 0; index < count; ++index)
      bones[index].transform.rotation = Quaternion.AngleAxis(angle * ((float) (index + 1) / (float) count), Vector3.up) * RigUtils.rotationCache[index];
  }

  public static void UpdateBoneRotations(RigUtils.Bone[] bones, Transform target)
  {
    if (bones == null)
      return;
    for (int index = 0; index < bones.Length; ++index)
    {
      Transform transform = bones[index].transform;
      Vector3 vector3_1 = transform.up;
      switch (bones[index].upAxis)
      {
        case RigUtils.Axis.Up:
          vector3_1 = transform.up;
          break;
        case RigUtils.Axis.Down:
          vector3_1 = -transform.up;
          break;
        case RigUtils.Axis.Forward:
          vector3_1 = transform.forward;
          break;
        case RigUtils.Axis.Back:
          vector3_1 = -transform.forward;
          break;
        case RigUtils.Axis.Right:
          vector3_1 = transform.right;
          break;
        case RigUtils.Axis.Left:
          vector3_1 = -transform.right;
          break;
      }
      Vector3 vector3_2 = Vector3.Normalize(target.position - transform.transform.position);
      Vector3 axis = Vector3.Normalize(Vector3.Cross(vector3_1, vector3_2));
      float angle = Mathf.Acos(Vector3.Dot(vector3_2, vector3_1)) * 57.29578f * ((float) (index + 1) / (float) bones.Length);
      transform.transform.rotation = Quaternion.AngleAxis(angle, axis) * transform.transform.rotation;
    }
  }

  public static void UpdateBoneRotations(Transform[] bones, float angle)
  {
    if (bones == null)
      return;
    for (int index = 0; index < bones.Length; ++index)
    {
      Transform transform = bones[index].transform;
      float angle1 = angle * (float) (index + 1) / (float) bones.Length;
      transform.transform.rotation = Quaternion.AngleAxis(angle1, Vector3.up) * transform.transform.rotation;
    }
  }

  public enum Axis
  {
    Up,
    Down,
    Forward,
    Back,
    Right,
    Left,
  }

  [Serializable]
  public struct Bone
  {
    public Transform transform;
    [FormerlySerializedAs("up")]
    [FormerlySerializedAs("forwardAxis")]
    public RigUtils.Axis upAxis;
  }
}
