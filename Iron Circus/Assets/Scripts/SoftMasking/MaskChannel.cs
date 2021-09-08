// Decompiled with JetBrains decompiler
// Type: SoftMasking.MaskChannel
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

using UnityEngine;

namespace SoftMasking
{
  public static class MaskChannel
  {
    public static Color alpha = new Color(0.0f, 0.0f, 0.0f, 1f);
    public static Color red = new Color(1f, 0.0f, 0.0f, 0.0f);
    public static Color green = new Color(0.0f, 1f, 0.0f, 0.0f);
    public static Color blue = new Color(0.0f, 0.0f, 1f, 0.0f);
    public static Color gray = new Color(1f, 1f, 1f, 0.0f) / 3f;
  }
}
