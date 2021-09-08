// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.JitterUnity.JitterExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Jitter.LinearMath;
using UnityEngine;

namespace Imi.SteelCircus.JitterUnity
{
  public static class JitterExtensions
  {
    public static JVector ToJVector(this Vector3 vector) => new JVector(vector.x, vector.y, vector.z);

    public static Vector3 ToVector3(this JVector vector) => new Vector3(vector.X, vector.Y, vector.Z);

    public static Quaternion ToQuaternion(this JQuaternion rot) => new Quaternion(rot.X, rot.Y, rot.Z, rot.W);

    public static JQuaternion ToJQuaternion(this Quaternion rot) => new JQuaternion(rot.x, rot.y, rot.z, rot.w);

    public static JMatrix ToJMatrix(this Quaternion rot) => JMatrix.CreateFromQuaternion(rot.ToJQuaternion());

    public static Quaternion ToQuaternion(this JMatrix matrix) => JQuaternion.CreateFromMatrix(matrix).ToQuaternion();
  }
}
