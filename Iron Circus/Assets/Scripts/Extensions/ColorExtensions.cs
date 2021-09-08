// Decompiled with JetBrains decompiler
// Type: Extensions.ColorExtensions
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace Extensions
{
  public static class ColorExtensions
  {
    public static Color WithAlpha(this Color color, float alpha) => new Color(color.r, color.g, color.b, alpha);
  }
}
