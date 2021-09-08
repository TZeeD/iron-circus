// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Utils.MeshUtils
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using Imi.SharedWithServer.Config;
using System.Collections.Generic;
using UnityEngine;

namespace Imi.SteelCircus.Utils
{
  public static class MeshUtils
  {
    public static Mesh GetConeMesh(AreaOfEffect aoe, int arcResolution = 1)
    {
      Mesh mesh = new Mesh();
      List<Vector3> conePoints = DebugDrawUtils.GetConePoints(Vector3.zero, Vector3.forward, aoe.angle, aoe.radius, aoe.deadZone, arcResolution);
      mesh.vertices = conePoints.ToArray();
      int count = conePoints.Count;
      int length = (count - 2) / 2;
      int[,] numArray1 = new int[length, 4];
      for (int index = 0; index < length; ++index)
      {
        numArray1[index, 0] = MathUtils.Mod(-index, count);
        numArray1[index, 1] = 1 + index;
        numArray1[index, 2] = 2 + index;
        numArray1[index, 3] = count - index - 1;
      }
      int[] numArray2 = new int[numArray1.GetLength(0) * 2 * 3];
      for (int index1 = 0; index1 < numArray1.GetLength(0); ++index1)
      {
        int index2 = index1 * 6;
        numArray2[index2] = numArray1[index1, 3];
        numArray2[index2 + 1] = numArray1[index1, 1];
        numArray2[index2 + 2] = numArray1[index1, 0];
        numArray2[index2 + 3] = numArray1[index1, 3];
        numArray2[index2 + 4] = numArray1[index1, 2];
        numArray2[index2 + 5] = numArray1[index1, 1];
      }
      foreach (Vector3 up in new Vector3[conePoints.Count])
        up = Vector3.up;
      mesh.triangles = numArray2;
      return mesh;
    }
  }
}
