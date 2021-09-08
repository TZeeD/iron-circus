// Decompiled with JetBrains decompiler
// Type: SteelCircus.Core.TimelineFloat
// Assembly: Assembly-CSharp, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 841B04D4-2E17-4B98-AC76-29D6D8A2480C
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\Assembly-CSharp.dll

namespace SteelCircus.Core
{
  public class TimelineFloat : Timeline<float>
  {
    protected override float Interpolate(float a, float b, float t) => (float) ((double) a * (1.0 - (double) t) + (double) b * (double) t);
  }
}
