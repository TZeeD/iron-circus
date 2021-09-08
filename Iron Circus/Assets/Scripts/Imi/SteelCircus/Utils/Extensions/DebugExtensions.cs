// Decompiled with JetBrains decompiler
// Type: Imi.SteelCircus.Utils.Extensions.DebugExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Imi.SteelCircus.Utils.Extensions
{
  public class DebugExtensions
  {
    public static void DebugPoint(
      Vector3 position,
      Color color,
      float scale = 1f,
      float duration = 0.0f,
      bool depthTest = true)
    {
      color = color == new Color() ? Color.white : color;
      Debug.DrawRay(position + Vector3.up * (scale * 0.5f), -Vector3.up * scale, color, duration, depthTest);
      Debug.DrawRay(position + Vector3.right * (scale * 0.5f), -Vector3.right * scale, color, duration, depthTest);
      Debug.DrawRay(position + Vector3.forward * (scale * 0.5f), -Vector3.forward * scale, color, duration, depthTest);
    }

    public static void GizmoPoint(Vector3 position, Color color, float scale = 1f)
    {
      Color color1 = Gizmos.color;
      Gizmos.color = color;
      Gizmos.DrawRay(position + Vector3.up * (scale * 0.5f), -Vector3.up * scale);
      Gizmos.DrawRay(position + Vector3.right * (scale * 0.5f), -Vector3.right * scale);
      Gizmos.DrawRay(position + Vector3.forward * (scale * 0.5f), -Vector3.forward * scale);
      Gizmos.color = color1;
    }
  }
}
